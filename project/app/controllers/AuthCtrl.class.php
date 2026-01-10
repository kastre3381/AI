<?php
namespace app\controllers;

use core\App;
use core\Utils;
use core\ParamUtils;
use core\SessionUtils;
use core\RoleUtils;

class AuthCtrl {

  public function action_login() {
    if (!isset($_POST['email'])) {
      $this->generateViewLogin();
      return;
    }

    $email = trim((string)ParamUtils::getFromPost('email', true, 'Podaj email'));
    $pass  = (string)ParamUtils::getFromPost('password', true, 'Podaj hasło');

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      Utils::addErrorMessage('Niepoprawny format email.');
      $this->generateViewLogin();
      return;
    }

    $user = App::getDB()->get('users', '*', ['email' => $email]);

    if (!$user || !password_verify($pass, $user['password'])) {
      Utils::addErrorMessage('Błędny email lub hasło.');
      $this->generateViewLogin();
      return;
    }

    $role = ((int)$user['type'] === 1) ? 'admin' : 'user';
    RoleUtils::addRole($role); 

    SessionUtils::store('user', [
      'id_user' => (int)$user['id_user'],
      'name'    => $user['name'],
      'surname' => $user['surname'],
      'email'   => $user['email'],
      'type'    => (int)$user['type'],
      'role'    => $role,
    ]);

    Utils::addInfoMessage('Zalogowano.');
    App::getRouter()->redirectTo('productList');
  }

  public function action_register() {
    if (!isset($_POST['email'])) {
      $this->generateViewRegister();
      return;
    }

    $name      = trim((string)ParamUtils::getFromPost('name', true, 'Podaj imię'));
    $surname   = trim((string)ParamUtils::getFromPost('surname', true, 'Podaj nazwisko'));
    $email     = trim((string)ParamUtils::getFromPost('email', true, 'Podaj email'));
    $birthDate = trim((string)ParamUtils::getFromPost('birth_date', true, 'Podaj datę urodzenia'));
    $pass1     = (string)ParamUtils::getFromPost('password', true, 'Podaj hasło');
    $pass2     = (string)ParamUtils::getFromPost('password2', true, 'Powtórz hasło');

    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      Utils::addErrorMessage('Niepoprawny format email.');
      $this->generateViewRegister(); return;
    }
    if ($pass1 !== $pass2) {
      Utils::addErrorMessage('Hasła nie są takie same.');
      $this->generateViewRegister(); return;
    }
    if (mb_strlen($pass1) < 6) {
      Utils::addErrorMessage('Hasło musi mieć min. 6 znaków.');
      $this->generateViewRegister(); return;
    }
    
    $dt = \DateTime::createFromFormat('Y-m-d', $birthDate);
    if (!$dt || $dt->format('Y-m-d') !== $birthDate) {
      Utils::addErrorMessage('Data urodzenia musi być w formacie RRRR-MM-DD.');
      $this->generateViewRegister(); return;
    }

    $exists = App::getDB()->has('users', ['email' => $email]);
    if ($exists) {
      Utils::addErrorMessage('Konto z takim emailem już istnieje.');
      $this->generateViewRegister(); return;
    }

    App::getDB()->insert('users', [
      'name'          => $name,
      'surname'       => $surname,
      'email'         => $email,
      'password'      => password_hash($pass1, PASSWORD_DEFAULT),
      'birth_date'    => $birthDate,
      'type'          => 0,
      'created_at'    => date('Y-m-d'),
    ]);

    Utils::addInfoMessage('Konto utworzone. Zaloguj się.');
    App::getRouter()->redirectTo('login');
  }

  public function action_logout() {
    session_destroy();
    App::getRouter()->redirectTo('productList');
  }

  private function generateViewLogin() {
    App::getSmarty()->display('LoginView.tpl');
  }

  private function generateViewRegister() {
    App::getSmarty()->display('RegisterView.tpl');
  }
}
