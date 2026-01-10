{include file="Header.tpl"}

<div class="row" style="justify-content:space-between; align-items:flex-start;">
  <div style="flex:1; min-width:280px;">
    <h1 class="h1" style="margin-top:0;">{$product.name|escape}</h1>
    <div class="muted">ID produktu: {$product.id_product}</div>
  </div>

  <div class="card" style="min-width:260px;">
    <div class="kpi">
      <div class="muted">Cena</div>
      <strong>{$product.price} PLN</strong>
    </div>
    <div style="margin-top:8px;">
      {if $product.quantity > 0}
        <span class="badge">Dostępne: {$product.quantity}</span>
      {else}
        <span class="badge">Brak w magazynie</span>
      {/if}
    </div>
  </div>
</div>

<div class="row" style="gap:14px; align-items:flex-start; margin-top:14px;">
  <div class="card" style="flex:1; min-width:280px;">
    <div class="product-img" style="aspect-ratio: 16 / 10;">
      {if $product.image_url}
        <img src="{$product.image_url|escape}" alt="{$product.name|escape}">
      {else}
        <span class="muted">brak zdjęcia</span>
      {/if}
    </div>

    <h2 class="h2">Opis</h2>
    <p class="muted" style="line-height:1.55;">{$product.description|escape|nl2br}</p>
  </div>

  <div class="card" style="width:min(360px, 100%);">
    <h2 class="h2" style="margin-top:0;">Zakup</h2>

    {if $isLogged && $product.quantity > 0}
      <form class="form" method="post" action="{$conf->app_url}cartAdd/{$product.id_product}">
        <div class="field">
          <div class="label">Ilość</div>
          <input class="input" type="number" name="qty" value="1" min="1" max="{$product.quantity}">
          <div class="muted" style="font-size:13px;">Maksymalnie {$product.quantity} szt.</div>
        </div>

        <button class="btn btn-primary" type="submit">Dodaj do koszyka</button>
        <a class="btn" href="{$conf->app_url}cart">Przejdź do koszyka</a>
      </form>
    {elseif !$isLogged}
      <p class="muted">Aby dodać produkt do koszyka, musisz się zalogować.</p>
      <div class="row">
        <a class="btn btn-primary" href="{$conf->app_url}login">Logowanie</a>
        <a class="btn" href="{$conf->app_url}register">Rejestracja</a>
      </div>
    {else}
      <p class="muted">Ten produkt jest aktualnie niedostępny.</p>
      <a class="btn" href="{$conf->app_url}productList">Wróć do listy</a>
    {/if}
  </div>
</div>

<div style="margin-top:14px;">
  <a class="btn" href="{$conf->app_url}productList">← Wróć do listy</a>
</div>

{include file="Footer.tpl"}
