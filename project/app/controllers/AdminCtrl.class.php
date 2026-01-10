<?php
namespace app\controllers;

use core\App;
use core\ParamUtils;
use core\SessionUtils;
use core\Utils;

class AdminCtrl {

  private function assignCommon(): void {
    $user = SessionUtils::load('user', true);
    App::getSmarty()->assign('isLogged', $user !== null);
    App::getSmarty()->assign('currentUser', $user);
  }

  public function action_adminProducts() {
    $this->assignCommon();

    $q = trim((string)ParamUtils::getFromGet('q', false));

    $where = [];
    if ($q !== '') {
      $where['name[~]'] = $q;
    }
    $where['ORDER'] = ['id_product' => 'DESC'];

    $products = App::getDB()->select('products', [
      'id_product','name','description','image_url','quantity','price'
    ], $where);

    $editId = ParamUtils::getFromGet('id', false);
    $editProduct = null;

    if ($editId !== null && ctype_digit((string)$editId)) {
      $editProduct = App::getDB()->get('products', [
        'id_product','name','description','image_url','quantity','price'
      ], ['id_product' => (int)$editId]);
    }

    App::getSmarty()->assign('q', $q);
    App::getSmarty()->assign('products', $products);
    App::getSmarty()->assign('editProduct', $editProduct);

    App::getSmarty()->display('AdminProductsView.tpl');
  }

  public function action_adminProductSave() {
    $id = ParamUtils::getFromPost('id_product', false); 

    $delete = ParamUtils::getFromPost('delete', false);
    if ($delete === '1') {
      if ($id !== null && ctype_digit((string)$id) && (int)$id > 0) {
        App::getDB()->update('products', ['quantity' => 0], ['id_product' => (int)$id]);
        Utils::addInfoMessage('Produkt został “usunięty” (ilość ustawiona na 0).');
      }
      App::getRouter()->redirectTo('adminProducts');
      return;
    }


    $name = trim((string)ParamUtils::getFromPost('name', true, 'Podaj nazwę produktu'));
    $description = trim((string)ParamUtils::getFromPost('description', true, 'Podaj opis produktu'));
    $imageUrl = trim((string)ParamUtils::getFromPost('image_url', false));
    $quantity = (int)ParamUtils::getFromPost('quantity', true, 'Podaj ilość');
    $priceRaw = str_replace(',', '.', trim((string)ParamUtils::getFromPost('price', true, 'Podaj cenę')));

    if ($name === '' || mb_strlen($name) < 2) {
      Utils::addErrorMessage('Nazwa jest za krótka.');
      App::getRouter()->redirectTo('adminProducts');
      return;
    }
    if ($quantity < 0) $quantity = 0;

    if (!is_numeric($priceRaw) || (float)$priceRaw < 0) {
      Utils::addErrorMessage('Niepoprawna cena.');
      App::getRouter()->redirectTo('adminProducts');
      return;
    }
    $price = (float)$priceRaw;

    if ($imageUrl !== '' && !filter_var($imageUrl, FILTER_VALIDATE_URL)) {
      Utils::addErrorMessage('Niepoprawny URL obrazka.');
      App::getRouter()->redirectTo('adminProducts');
      return;
    }

    if ($id !== null && ctype_digit((string)$id) && (int)$id > 0) {
      App::getDB()->update('products', [
        'name' => $name,
        'description' => $description,
        'image_url' => ($imageUrl === '' ? null : $imageUrl),
        'quantity' => $quantity,
        'price' => $price
      ], [
        'id_product' => (int)$id
      ]);

      Utils::addInfoMessage('Zapisano zmiany produktu.');
      App::getRouter()->redirectTo('adminProducts');
      return;
    } else {
      App::getDB()->insert('products', [
        'name' => $name,
        'description' => $description,
        'image_url' => ($imageUrl === '' ? null : $imageUrl),
        'quantity' => $quantity,
        'price' => $price
      ]);

      Utils::addInfoMessage('Dodano nowy produkt.');
      App::getRouter()->redirectTo('adminProducts');
      return;
    }
  }
}
