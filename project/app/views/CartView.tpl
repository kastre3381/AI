{include file="Header.tpl"}

<h1 class="h1">Koszyk</h1>

{if $items|@count == 0}
  <div class="card">
    <p>Koszyk jest pusty.</p>
    <a class="btn btn-primary" href="{$conf->app_url}productList">Przejdź do produktów</a>
  </div>
{else}

<div class="card">
  <form method="post" action="{$conf->app_url}cartUpdate">
    <table class="table">
      <tr>
        <th>Produkt</th>
        <th>Cena</th>
        <th>Ilość</th>
        <th>Suma</th>
        <th></th>
      </tr>

      {foreach $items as $it}
        <tr>
          <td>
            <div class="cart-item">
              <div class="thumb">
                {if $it.image_url}
                  <img src="{$it.image_url|escape}" alt="">
                {/if}
              </div>
              <div>
                <div><b>{$it.name|escape}</b></div>
                <div class="muted" style="font-size:13px;">Dostępne: {$it.stock}</div>
              </div>
            </div>
          </td>
          <td><span class="price">{$it.price} PLN</span></td>
          <td>
            <input class="input" type="number"
                   name="qty[{$it.id_product}]"
                   value="{$it.qty}" min="0" max="{$it.stock}"
                   style="width:110px;">
          </td>
          <td><b>{$it.line_total} PLN</b></td>
          <td>
            <a class="btn btn-danger" href="{$conf->app_url}cartRemove/{$it.id_product}">Usuń</a>
          </td>
        </tr>
      {/foreach}
    </table>

    <div class="row" style="margin-top:12px; justify-content:space-between;">
      <button class="btn" type="submit">Aktualizuj koszyk</button>
      <a class="btn" href="{$conf->app_url}productList">Kontynuuj zakupy</a>
    </div>
  </form>
</div>

<div class="card" style="margin-top:14px;">
  <div class="kpi">
    <div class="muted">Razem do zapłaty</div>
    <strong>{$total} PLN</strong>
  </div>
  <div class="row" style="margin-top:12px; justify-content:flex-end;">
    <a class="btn btn-primary" href="{$conf->app_url}checkout">Kup teraz</a>
  </div>
</div>

{/if}

{include file="Footer.tpl"}
