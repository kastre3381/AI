<?php
namespace app\controllers;

use core\App;
use core\ParamUtils;
use core\SessionUtils;
use core\Utils;

class CartCtrl {

  private function getCart(): array {
    $cart = SessionUtils::load('cart', true);
    return is_array($cart) ? $cart : [];
  }

  private function saveCart(array $cart): void {
    foreach ($cart as $pid => $qty) {
      if ($qty <= 0) unset($cart[$pid]);
    }
    SessionUtils::store('cart', $cart);
  }

  private function getUserId(): int {
    $user = SessionUtils::load('user', true);
    if (!$user || !isset($user['id_user'])) {
      App::getRouter()->redirectTo('login');
      exit;
    }
    return (int)$user['id_user'];
  }

  private function assignCommon(): void {
    $user = SessionUtils::load('user', true);
    App::getSmarty()->assign('isLogged', $user !== null);
    App::getSmarty()->assign('currentUser', $user);
  }

  public function action_cart() {
    $this->assignCommon();

    $cart = $this->getCart();
    if (empty($cart)) {
      App::getSmarty()->assign('items', []);
      App::getSmarty()->assign('total', 0);
      App::getSmarty()->display('CartView.tpl');
      return;
    }

    $ids = array_map('intval', array_keys($cart));

    $products = App::getDB()->select('products', [
      'id_product',
      'name',
      'image_url',
      'price',
      'quantity'
    ], [
      'id_product' => $ids
    ]);

    $map = [];
    foreach ($products as $p) {
      $map[(int)$p['id_product']] = $p;
    }

    $items = [];
    $total = 0.0;

    foreach ($cart as $pid => $qtyInCart) {
      $pid = (int)$pid;
      if (!isset($map[$pid])) {
        continue;
      }

      $p = $map[$pid];
      $stock = (int)$p['quantity'];

      $qty = min((int)$qtyInCart, max($stock, 0));
      if ($qty <= 0) continue;

      $line = (float)$p['price'] * $qty;
      $total += $line;

      $items[] = [
        'id_product' => $pid,
        'name' => $p['name'],
        'image_url' => $p['image_url'],
        'price' => (float)$p['price'],
        'stock' => $stock,
        'qty' => $qty,
        'line_total' => $line
      ];
    }

    $newCart = [];
    foreach ($items as $it) $newCart[$it['id_product']] = $it['qty'];
    $this->saveCart($newCart);

    App::getSmarty()->assign('items', $items);
    App::getSmarty()->assign('total', $total);
    App::getSmarty()->display('CartView.tpl');
  }

  public function action_cartAdd() {
    $id = ParamUtils::getFromGet('id', true, 'Brak id produktu');
    if (!ctype_digit((string)$id)) {
      Utils::addErrorMessage('Niepoprawne id produktu.');
      App::getRouter()->redirectTo('productList');
      return;
    }
    $pid = (int)$id;

    $qty = ParamUtils::getFromPost('qty', false);
    $qty = ($qty === null || $qty === '') ? 1 : (int)$qty;
    if ($qty <= 0) $qty = 1;

    $p = App::getDB()->get('products', [
      'id_product','name','quantity'
    ], ['id_product' => $pid]);

    if (!$p) {
      Utils::addErrorMessage('Nie znaleziono produktu.');
      App::getRouter()->redirectTo('productList');
      return;
    }

    $stock = (int)$p['quantity'];
    if ($stock <= 0) {
      Utils::addErrorMessage('Produkt jest niedostępny.');
      App::getRouter()->redirectTo('productShow', ['id' => $pid]);
      return;
    }

    $cart = $this->getCart();
    $current = isset($cart[$pid]) ? (int)$cart[$pid] : 0;

    $newQty = min($current + $qty, $stock);
    $cart[$pid] = $newQty;
    $this->saveCart($cart);

    Utils::addInfoMessage('Dodano do koszyka.');
    App::getRouter()->redirectTo('cart');
  }

  public function action_cartUpdate() {
    $posted = $_POST['qty'] ?? null;
    if (!is_array($posted)) {
      App::getRouter()->redirectTo('cart');
      return;
    }

    $cart = $this->getCart();

    $ids = array_map('intval', array_keys($posted));
    if (!empty($ids)) {
      $stocks = App::getDB()->select('products', ['id_product','quantity'], ['id_product' => $ids]);
      $stockMap = [];
      foreach ($stocks as $s) $stockMap[(int)$s['id_product']] = (int)$s['quantity'];

      foreach ($posted as $pid => $qty) {
        if (!ctype_digit((string)$pid)) continue;
        $pid = (int)$pid;
        $qty = (int)$qty;

        if ($qty <= 0) {
          unset($cart[$pid]);
          continue;
        }

        $stock = $stockMap[$pid] ?? 0;
        $cart[$pid] = min($qty, max($stock, 0));
      }
    }

    $this->saveCart($cart);
    Utils::addInfoMessage('Zaktualizowano koszyk.');
    App::getRouter()->redirectTo('cart');
  }

  public function action_cartRemove() {
    $id = ParamUtils::getFromGet('id', true, 'Brak id produktu');
    if (ctype_digit((string)$id)) {
      $pid = (int)$id;
      $cart = $this->getCart();
      unset($cart[$pid]);
      $this->saveCart($cart);
      Utils::addInfoMessage('Usunięto z koszyka.');
    }
    App::getRouter()->redirectTo('cart');
  }

  public function action_checkout() {
    $userId = $this->getUserId();

    $cart = $this->getCart();
    if (empty($cart)) {
      Utils::addErrorMessage('Koszyk jest pusty.');
      App::getRouter()->redirectTo('cart');
      return;
    }

    $ids = array_map('intval', array_keys($cart));

    $products = App::getDB()->select('products', [
      'id_product','price','quantity','name'
    ], [
      'id_product' => $ids
    ]);

    $map = [];
    foreach ($products as $p) $map[(int)$p['id_product']] = $p;

    $itemsToBuy = [];
    foreach ($cart as $pid => $qty) {
      $pid = (int)$pid;
      $qty = (int)$qty;

      if (!isset($map[$pid])) {
        Utils::addErrorMessage('W koszyku jest produkt, który już nie istnieje.');
        App::getRouter()->redirectTo('cart');
        return;
      }

      $stock = (int)$map[$pid]['quantity'];
      if ($qty <= 0 || $qty > $stock) {
        Utils::addErrorMessage('Brak wystarczającej ilości produktu: '.$map[$pid]['name']);
        App::getRouter()->redirectTo('cart');
        return;
      }

      $itemsToBuy[] = [
        'id_product' => $pid,
        'qty' => $qty,
        'price' => (float)$map[$pid]['price']
      ];
    }

    $db = App::getDB();
    $pdo = $db->pdo; 

    try {
      $pdo->beginTransaction();

      $db->insert('orders', [
        'id_user' => $userId,
        'order_date' => date('Y-m-d')
      ]);
      $orderId = (int)$db->id();

      foreach ($itemsToBuy as $it) {
        $db->insert('order_items', [
          'id_products' => $it['id_product'],
          'id_orders'   => $orderId,
          'price'       => $it['price'],  
          'quantity'    => $it['qty']
        ]);

        $db->update('products', [
          'quantity[-]' => $it['qty']
        ], [
          'id_product' => $it['id_product']
        ]);
      }

      $pdo->commit();

      SessionUtils::store('cart', []);

      Utils::addInfoMessage('Zakup zrealizowany.');
      App::getRouter()->redirectTo('productList');

    } catch (\Throwable $e) {
      if ($pdo->inTransaction()) $pdo->rollBack();
      Utils::addErrorMessage('Nie udało się sfinalizować zakupu: '.$e->getMessage());
      App::getRouter()->redirectTo('cart');
    }
  }
}
