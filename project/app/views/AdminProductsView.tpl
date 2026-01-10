{include file="Header.tpl"}

<h1 class="h1">Panel admina – produkty</h1>

<div class="card" style="margin-bottom:14px;">
  <form class="row" method="get" action="{$conf->app_url}adminProducts" style="justify-content:space-between;">
    <div class="field" style="flex:1; min-width:240px;">
      <div class="label">Szukaj po nazwie</div>
      <input class="input" name="q" value="{$q|escape}" placeholder="Np. telewizor...">
    </div>
    <div class="row" style="margin-top:18px;">
      <button class="btn btn-primary" type="submit">Szukaj</button>
      {if $q}
        <a class="btn" href="{$conf->app_url}adminProducts">Wyczyść</a>
      {/if}
    </div>
  </form>
</div>

<div class="row" style="align-items:flex-start; gap:14px; flex-wrap:wrap;">
  <div class="card" style="flex:1; min-width:320px;">
    <h2 class="h2" style="margin-top:0;">
      {if $editProduct}Edytuj produkt #{$editProduct.id_product}{else}Dodaj nowy produkt{/if}
    </h2>

    <form class="form" method="post" action="{$conf->app_url}adminProductSave">
      {if $editProduct}
        <input type="hidden" name="id_product" value="{$editProduct.id_product}">
      {/if}

      <div class="field">
        <div class="label">Nazwa</div>
        <input class="input" name="name" value="{if $editProduct}{$editProduct.name|escape}{/if}" required>
      </div>

      <div class="field">
        <div class="label">Opis</div>
        <textarea class="input" name="description" rows="6" required>{if $editProduct}{$editProduct.description|escape}{/if}</textarea>
      </div>

      <div class="field">
        <div class="label">URL obrazka (opcjonalnie)</div>
        <input class="input" name="image_url" value="{if $editProduct}{$editProduct.image_url|escape}{/if}" placeholder="https://...">
      </div>

      <div class="row">
        <div class="field" style="flex:1;">
          <div class="label">Ilość (0 = “usunięty”)</div>
          <input class="input" type="number" name="quantity" min="0" value="{if $editProduct}{$editProduct.quantity}{else}0{/if}" required>
        </div>
        <div class="field" style="flex:1;">
          <div class="label">Cena (PLN)</div>
          <input class="input" name="price" value="{if $editProduct}{$editProduct.price}{/if}" placeholder="np. 1999.99" required>
        </div>
      </div>

      <div class="row" style="justify-content:space-between;">
        <button class="btn btn-primary" type="submit">
          {if $editProduct}Zapisz zmiany{else}Dodaj produkt{/if}
        </button>

        {if $editProduct}
          <a class="btn" href="{$conf->app_url}adminProducts">Nowy produkt</a>
        {/if}
      </div>

      {if $editProduct}
        <div class="hr"></div>
        <div class="row" style="justify-content:flex-end;">
          <button class="btn btn-danger" type="submit" name="delete" value="1"
                  onclick="return confirm('Na pewno “usunąć” produkt? Ustawi to ilość na 0.')">
            Usuń (quantity=0)
          </button>
        </div>
      {/if}
    </form>
  </div>

  <div class="card" style="flex:1; min-width:340px;">
    <h2 class="h2" style="margin-top:0;">Produkty w sklepie</h2>

    {if $products|@count == 0}
      <p class="muted">Brak produktów.</p>
    {else}
      <table class="table">
        <tr>
          <th>ID</th>
          <th>Produkt</th>
          <th>Cena</th>
          <th>Ilość</th>
          <th></th>
        </tr>

        {foreach $products as $p}
          <tr>
            <td>{$p.id_product}</td>
            <td>
              <div class="cart-item">
                <div class="thumb">
                  {if $p.image_url}
                    <img src="{$p.image_url|escape}" alt="">
                  {/if}
                </div>
                <div>
                  <div><b>{$p.name|escape}</b></div>
                  {if $p.quantity > 0}
                    <div class="muted" style="font-size:13px;">Dostępne: {$p.quantity}</div>
                  {else}
                    <div class="muted" style="font-size:13px;">Niedostępny (0)</div>
                  {/if}
                </div>
              </div>
            </td>
            <td><b>{$p.price} PLN</b></td>
            <td>{$p.quantity}</td>
            <td>
              <a class="btn" href="{$conf->app_url}adminProducts?id={$p.id_product}">Edytuj</a>
            </td>
          </tr>
        {/foreach}
      </table>
    {/if}
  </div>
</div>

{include file="Footer.tpl"}
