{include file="Header.tpl"}

<h1 class="h1">Logowanie</h1>

<div class="card">
  <form class="form" method="post" action="{$conf->app_url}login">
    <div class="field">
      <div class="label">Email</div>
      <input class="input" type="email" name="email" required>
    </div>

    <div class="field">
      <div class="label">Hasło</div>
      <input class="input" type="password" name="password" required>
    </div>

    <div class="row" style="justify-content:space-between;">
      <button class="btn btn-primary" type="submit">Zaloguj</button>
      <a class="btn" href="{$conf->app_url}register">Rejestracja</a>
    </div>
  </form>
</div>

{include file="Footer.tpl"}
