<?php
/* Smarty version 3.1.29, created on 2017-07-10 18:05:50
  from "/var/www/html/powermailadmin/templates/footer.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_596374a68865f2_96002591',
  'file_dependency' => 
  array (
    '71e856f6ad0e9099f093d5f1fb77b2f4dbe06417' => 
    array (
      0 => '/var/www/html/powermailadmin/templates/footer.tpl',
      1 => 1499683465,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_596374a68865f2_96002591 ($_smarty_tpl) {
if (!is_callable('smarty_modifier_replace')) require_once '/var/www/html/powermailadmin/smarty/libs/plugins/modifier.replace.php';
?>
<!-- <?php echo basename($_smarty_tpl->source->filepath);?>
 -->
<div id="footer">
	<a target="_blank" href="http://technoinfotech.com/" target="_blank">TechnoInfotech</a>

    <?php if (isset($_SESSION['sessid'])) {?>
        <?php if ($_SESSION['sessid']['username']) {?>
            &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;	
            <?php echo smarty_modifier_replace($_smarty_tpl->tpl_vars['PALANG']->value['pFooter_logged_as'],"%s",$_SESSION['sessid']['username']);?>

        <?php }?>
    <?php }?>
	<?php if ($_smarty_tpl->tpl_vars['CONF']->value['show_footer_text'] == 'YES' && $_smarty_tpl->tpl_vars['CONF']->value['footer_link']) {?>
		&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
		<a href="<?php echo $_smarty_tpl->tpl_vars['CONF']->value['footer_link'];?>
"><?php echo $_smarty_tpl->tpl_vars['CONF']->value['footer_text'];?>
</a>
	<?php }?>
</div>
</div>
</div>
</body>
</html>
<?php }
}
