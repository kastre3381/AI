<?php

use core\App;
use core\Utils;

App::getRouter()->setDefaultRoute('productList'); 
App::getRouter()->setLoginRoute('login'); 

// autentykacja
Utils::addRoute('login', 'AuthCtrl'); 
Utils::addRoute('register', 'AuthCtrl');
Utils::addRoute('logout', 'AuthCtrl'); 

// // sklep 
Utils::addRoute('productList', 'ProductCtrl');   // lista produktów
Utils::addRoute('productShow', 'ProductCtrl');   // szczegóły produktu

// koszyk (tylko zalogowani)
Utils::addRoute('cart', 'CartCtrl', ['user','admin']);          // wyświetlenie koszyka
Utils::addRoute('cartAdd', 'CartCtrl', ['user','admin']);       // dodanie do koszyka
Utils::addRoute('cartUpdate', 'CartCtrl', ['user','admin']);    // update koszyka   
Utils::addRoute('cartRemove', 'CartCtrl', ['user','admin']);    // usunięcie z koszyka
Utils::addRoute('checkout', 'CartCtrl', ['user','admin']);      // zamówienie

// wyświetlenie profilu
Utils::addRoute('profile', 'ProfileCtrl', ['user','admin']); 

//  admin
Utils::addRoute('adminProducts', 'AdminCtrl', ['admin']);       // wyswietlenie wszystkich produktów w profilu admina
Utils::addRoute('adminProductSave', 'AdminCtrl', ['admin']);    // zapisanie produktu 