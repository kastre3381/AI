{include file="Header.tpl"}

<h1 class="h1">Mój profil</h1>

<div class="grid" style="grid-template-columns: 1fr; gap:14px;">
  <div class="card">
    <div class="kpi">
      <div>
        <div class="muted">Użytkownik</div>
        <strong>{$account.name|escape} {$account.surname|escape}</strong>
      </div>
      <div>
        <div class="muted">Email</div>
        <strong style="font-size:16px;">{$account.email|escape}</strong>
      </div>
    </div>

    <div class="hr"></div>

    <div class="row" style="justify-content:space-between;">
      <div>
        <div class="muted">Data urodzenia</div>
        <div><b>{$account.birth_date}</b></div>
      </div>
      <div>
        <div class="muted">Konto od</div>
        <div><b>{$account.created_at}</b></div>
      </div>
      <div>
        <div class="muted">Łącznie wydano</div>
        <div><b>{$totalSpent} PLN</b></div>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="row" style="justify-content:space-between;">
      <h2 class="h2" style="margin:0;">Historia zamówień</h2>
      <a class="btn" href="{$conf->app_url}productList">Przejdź do produktów</a>
    </div>

    {if $orders|@count == 0}
      <p class="muted" style="margin-top:12px;">Nie złożyłaś jeszcze żadnego zamówienia.</p>
    {else}
      {foreach $orders as $o}
        <div class="card" style="margin-top:12px; background: rgba(11,19,36,.45);">
          <div class="row" style="justify-content:space-between; align-items:center;">
            <div>
              <div class="muted">Zamówienie</div>
              <div><b>#{$o.id_order}</b></div>
            </div>
            <div>
              <div class="muted">Data</div>
              <div><b>{$o.order_date}</b></div>
            </div>
          </div>

          <div style="margin-top:10px;">
            <table class="table">
              <tr>
                <th>Produkt</th>
                <th>Ilość</th>
                <th>Cena</th>
                <th>Suma</th>
              </tr>

              {foreach $itemsByOrder[$o.id_order] as $it}
                <tr>
                  <td>{$it.name|escape}</td>
                  <td>{$it.qty}</td>
                  <td>{$it.price} PLN</td>
                  <td><b>{$it.line_total} PLN</b></td>
                </tr>
              {/foreach}
            </table>
          </div>
        </div>
      {/foreach}
    {/if}
  </div>
</div>

{include file="Footer.tpl"}
