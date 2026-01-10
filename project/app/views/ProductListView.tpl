{include file="Header.tpl"}

<h1 class="h1">Produkty</h1>

<div class="card" style="margin-bottom:14px;">
  <form class="row" method="get" action="{$conf->app_url}productList" style="justify-content:space-between;">
    <div class="field" style="flex:1; min-width:240px;">
      <div class="label">Szukaj</div>
      <input class="input" name="q" value="{$q|escape}" placeholder="Np. telewizor, laptop...">
    </div>
    <div class="row" style="margin-top:18px;">
      <button class="btn btn-primary" type="submit">Szukaj</button>
      {if $q}
        <a class="btn" href="{$conf->app_url}productList">Wyczyść</a>
      {/if}
    </div>
  </form>
</div>

{if $products|@count == 0}
  <div class="card">
    <p>Brak produktów{if $q} dla frazy <b>{$q|escape}</b>{/if}.</p>
    {if $q}
      <a class="btn btn-primary" href="{$conf->app_url}productList">Pokaż wszystkie</a>
    {/if}
  </div>
{else}
  <div class="grid">
    {foreach $products as $p}
      <div class="card product-card">
        <div class="product-img">
          {if $p.image_url}
            <img src="{$p.image_url|escape}" alt="{$p.name|escape}">
          {else}
            <span class="muted">brak zdjęcia</span>
          {/if}
        </div>

        <h3 class="product-title">{$p.name|escape}</h3>

        <div class="product-meta">
          <span class="price">{$p.price} PLN</span>
          {if $p.quantity > 0}
            <span class="badge">Dostępne: {$p.quantity}</span>
          {else}
            <span class="badge">Brak w magazynie</span>
          {/if}
        </div>

        <div class="row" style="justify-content:space-between; margin-top:4px;">
          <a class="btn btn-primary" href="{$conf->app_url}productShow/{$p.id_product}">Szczegóły</a>
          {if $isLogged && $p.quantity > 0}
            <a class="btn" href="{$conf->app_url}cartAdd/{$p.id_product}">+ Do koszyka</a>
          {/if}
        </div>
      </div>
    {/foreach}
  </div>
{/if}

{include file="Footer.tpl"}
