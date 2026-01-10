{include file="Header.tpl"}

<h1 class="h1">Rejestracja</h1>

<div class="card">
  <form class="form" method="post" action="{$conf->app_url}register">
    <div class="row">
      <div class="field" style="flex:1;">
        <div class="label">Imię</div>
        <input class="input" name="name" required>
      </div>
      <div class="field" style="flex:1;">
        <div class="label">Nazwisko</div>
        <input class="input" name="surname" required>
      </div>
    </div>

    <div class="field">
      <div class="label">Email</div>
      <input class="input" type="email" name="email" required>
    </div>

    <div class="field">
      <div class="label">Data urodzenia</div>
      <input class="input" type="date" name="birth_date" required>
    </div>

    <div class="row">
      <div class="field" style="flex:1;">
        <div class="label">Hasło</div>
        <input class="input" type="password" name="password" required>
      </div>
      <div class="field" style="flex:1;">
        <div class="label">Powtórz hasło</div>
        <input class="input" type="password" name="password2" required>
      </div>
    </div>

    <div class="row" style="justify-content:space-between;">
      <button class="btn btn-primary" type="submit">Utwórz konto</button>
      <a class="btn" href="{$conf->app_url}login">Mam już konto</a>
    </div>
  </form>
</div>

{include file="Footer.tpl"}
