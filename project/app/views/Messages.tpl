{if $msgs && ($msgs->isError() || $msgs->isInfo())}
  <div class="messages">
    {foreach $msgs->getMessages() as $m}
      {assign var=t value=$m->type|default:''}
      {assign var=txt value=$m->text|default:$m->message|default:''}

      <div class="msg
        {if $t == 'error' || $t == 'ERROR' || $t == 1 || $t == '1'}msg-error
        {elseif $t == 'info' || $t == 'INFO' || $t == 0 || $t == '0'}msg-info
        {else}msg-info{/if}">
        {if $t == 'error' || $t == 'ERROR' || $t == 1 || $t == '1'}<b>Błąd:</b> {/if}
        {if $t == 'info'  || $t == 'INFO'  || $t == 0 || $t == '0'}<b>Info:</b> {/if}
        {$txt|escape}
      </div>
    {/foreach}
  </div>
{/if}
