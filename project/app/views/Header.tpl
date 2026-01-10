<!DOCTYPE html>
<html lang="pl">
<head>
  <meta charset="UTF-8">
  <title>ElektroExpert</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="{$conf->app_url}/css/styles.css">
</head>
<body>

<header class="site-header">
  <div class="container header-inner">
    <div class="brand">
      <div class="brand-badge"></div>
      <a href="{$conf->app_url}productList">ElektroExpert</a>
    </div>

    <nav class="nav">
      {if $isLogged}
        <a class="btn" href="{$conf->app_url}cart">Koszyk</a>
        {if $currentUser && $currentUser.type == 1}
          <a class="btn" href="{$conf->app_url}adminProducts">Panel admina</a>
        {/if}
        <a class="btn" href="{$conf->app_url}profile">Mój profil</a>
        <a class="btn btn-danger" href="{$conf->app_url}logout">Wyloguj</a>
      {else}
        <a class="btn" href="{$conf->app_url}login">Logowanie</a>
        <a class="btn btn-primary" href="{$conf->app_url}register">Rejestracja</a>
      {/if}
    </nav>
  </div>
</header>

<main>
  <div class="container">
    {include file="Messages.tpl"}
