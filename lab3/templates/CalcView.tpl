{extends file="main.tpl"}

{block name=content}

<h2>Kalkulator kredytowy</h2>

<form action="{$conf->app_url}/credit_calc.php" method="post">
    <label for="id_price">Kwota kredytu: </label>
    <input id="id_price" type="text" name="price" value="{$form->price|escape}" /><br />

    <label for="id_time">Okres spłaty kredytu (w latach): </label>
    <input id="id_time" type="text" name="time" value="{$form->time|escape}" /><br />

    <label for="id_percentage">Oprocentowanie (>=0%): </label>
    <input id="id_percentage" type="text" name="percentage" value="{$form->percentage|escape}" /><br />

    <input type="submit" value="Oblicz miesięczną ratę" />
</form>

{* Wyświetlenie błędów *}
{if $msgs->isError()}
    <ol style="margin:20px; padding:10px 10px 10px 30px; border-radius:5px; background-color:#f88; width:300px;">
        {foreach from=$msgs->getErrors() item=e}
            <li>{$e|escape}</li>
        {/foreach}
    </ol>
{/if}

{* Informacje *}
{if $msgs->getInfos()}
    <ul style="margin:20px; padding:10px; border-radius:5px; background-color:#dfd; width:300px;">
        {foreach from=$msgs->getInfos() item=i}
            <li>{$i|escape}</li>
        {/foreach}
    </ul>
{/if}

{* Wynik *}
{if $result->monthlyPayment}
    <div style="margin:20px; padding:10px; border-radius:5px; background-color:#ff0; width:300px;">
        Całkowita miesięczna kwota: {$result->monthlyPayment} zł
    </div>
{/if}

{/block}
