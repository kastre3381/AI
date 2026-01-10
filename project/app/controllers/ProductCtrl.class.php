<?php
namespace app\controllers;

use core\App;
use core\ParamUtils;
use core\Utils;

class ProductCtrl {

  private bool $hideZeroQuantity = true;

  public function action_productList() {
    $q = trim((string)ParamUtils::getFromGet('q', false)); 

    $where = [];

    if ($this->hideZeroQuantity) {
      $where['quantity[>]'] = 0;
    }

    if ($q !== '') {
      $where['name[~]'] = $q;
    }

    $where['ORDER'] = [
      'quantity' => 'DESC',
      'name' => 'ASC'
    ];

    $products = App::getDB()->select('products', [
      'id_product',
      'name',
      'description',
      'quantity',
      'price',
      'image_url'
    ], $where);

    App::getSmarty()->assign('products', $products);
    App::getSmarty()->assign('q', $q);
    $this->assignCommon();
    App::getSmarty()->display('ProductListView.tpl');
  }

  public function action_productShow() {
    $id = ParamUtils::getFromGet('id', true, 'Brak id produktu');

    if (!ctype_digit((string)$id)) {
      Utils::addErrorMessage('Niepoprawne id produktu.');
      App::getRouter()->redirectTo('productList');
      return;
    }

    $product = App::getDB()->get('products', [
      'id_product',
      'name',
      'description',
      'quantity',
      'price',
      'image_url'
    ], [
      'id_product' => (int)$id
    ]);

    if (!$product) {
      Utils::addErrorMessage('Nie znaleziono produktu.');
      App::getRouter()->redirectTo('productList');
      return;
    }

    if ($this->hideZeroQuantity && (int)$product['quantity'] <= 0) {
      Utils::addErrorMessage('Produkt jest niedostępny.');
      App::getRouter()->redirectTo('productList');
      return;
    }

    App::getSmarty()->assign('product', $product);
    $this->assignCommon();
    App::getSmarty()->display('ProductShowView.tpl');
  }

  private function assignCommon() {
    $user = \core\SessionUtils::load('user', true); 
    App::getSmarty()->assign('isLogged', $user !== null);
    App::getSmarty()->assign('currentUser', $user); 
  } 

}
