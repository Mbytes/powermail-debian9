<!-- {$smarty.template} -->
<div id="footer">
	<a target="_blank" href="http://technoinfotech.com/" target="_blank">TechnoInfotech</a>

    {if isset($smarty.session.sessid)}
        {if $smarty.session.sessid.username}
            &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;	
            {$PALANG.pFooter_logged_as|replace:"%s":$smarty.session.sessid.username}
        {/if}
    {/if}
	{if $CONF.show_footer_text == 'YES' && $CONF.footer_link}
		&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		<a href="{$CONF.footer_link}">{$CONF.footer_text}</a>
	{/if}
</div>
</div>
</div>
</body>
</html>
