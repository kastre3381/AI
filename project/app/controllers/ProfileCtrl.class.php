<?php
namespace app\controllers;

use core\App;
use core\SessionUtils;

class ProfileCtrl {

  private function assignCommon(): array {
    $user = SessionUtils::load('user', true);
    App::getSmarty()->assign('isLogged', $user !== null);
    App::getSmarty()->assign('currentUser', $user);
    return $user;
  }

  public function action_profile() {
    $user = $this->assignCommon();

    if (!$user || !isset($user['id_user'])) {
      App::getRouter()->redirectTo('login');
      return;
    }

    $userId = (int)$user['id_user'];

    $account = App::getDB()->get('users', [
      'id_user',
      'name',
      'surname',
      'email',
      'birth_date',
      'created_at'
    ], [
      'id_user' => $userId
    ]);

    $orders = App::getDB()->select('orders', [
      'id_order',
      'order_date'
    ], [
      'id_user' => $userId,
      'ORDER' => ['order_date' => 'DESC']
    ]);

    $orderIds = array_column($orders, 'id_order');

    $itemsByOrder = [];
    $totalSpent = 0.0;

    if (!empty($orderIds)) {

      $items = App::getDB()->select('order_items', [
        '[><]products' => ['id_products' => 'id_product']
      ], [
        'order_items.id_orders',
        'products.name',
        'order_items.quantity',
        'order_items.price'
      ], [
        'order_items.id_orders' => $orderIds,
        'ORDER' => ['order_items.id_orders' => 'DESC']
      ]);

      foreach ($items as $it) {
        $oid = (int)$it['id_orders'];
        $line = (float)$it['price'] * (int)$it['quantity'];

        $itemsByOrder[$oid][] = [
          'name' => $it['name'],
          'qty' => (int)$it['quantity'],
          'price' => (float)$it['price'],
          'line_total' => $line
        ];

        $totalSpent += $line;
      }
    }

    App::getSmarty()->assign('account', $account);
    App::getSmarty()->assign('orders', $orders);
    App::getSmarty()->assign('itemsByOrder', $itemsByOrder);
    App::getSmarty()->assign('totalSpent', $totalSpent);

    App::getSmarty()->display('ProfileView.tpl');
  }
}
