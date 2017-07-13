<?php
/* Smarty version 3.1.29, created on 2017-07-10 18:05:50
  from "/var/www/html/powermailadmin/templates/login.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_596374a68513a0_52298197',
  'file_dependency' => 
  array (
    '1b8d4b488ad4cc4cc25b711b55ff448242560852' => 
    array (
      0 => '/var/www/html/powermailadmin/templates/login.tpl',
      1 => 1499683465,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_596374a68513a0_52298197 ($_smarty_tpl) {
?>
<div id="login">
<form name="frmLogin" method="post" action="">
<table id="login_table" cellspacing="10" height=100<?php echo '%>';?>
	<tr>
		<th colspan="2">
<?php if ($_smarty_tpl->tpl_vars['logintype']->value == 'admin') {
echo $_smarty_tpl->tpl_vars['PALANG']->value['pLogin_welcome'];?>

<?php } else {
echo $_smarty_tpl->tpl_vars['PALANG']->value['pUsersLogin_welcome'];?>

<?php }?>
	</th>
	</tr>
	<tr>
		<td class="label"><label><?php echo $_smarty_tpl->tpl_vars['PALANG']->value['pLogin_username'];?>
:</label></td>
		<td><input class="flat" type="text" name="fUsername" /></td>
	</tr>
	<tr>
		<td class="label"><label><?php echo $_smarty_tpl->tpl_vars['PALANG']->value['password'];?>
:</label></td>
		<td><input class="flat" type="password" name="fPassword" /></td>
	</tr>
<!--	<tr>
		<td class="label"><label><?php echo $_smarty_tpl->tpl_vars['PALANG']->value['pLogin_language'];?>
:</label></td>
		<td><?php echo $_smarty_tpl->tpl_vars['language_selector']->value;?>
</td>
	</tr> -->
	<tr>
		<td class="label">&nbsp;</td>
		<td><input class="button" type="submit" name="submit" value="<?php echo $_smarty_tpl->tpl_vars['PALANG']->value['pLogin_button'];?>
" /></td>
	</tr>
<?php if ($_smarty_tpl->tpl_vars['logintype']->value == 'admin') {?>
<!--	<tr>
		<td colspan="2"><a href="users/"><?php echo $_smarty_tpl->tpl_vars['PALANG']->value['pLogin_login_users'];?>
</a></td>
	</tr> -->
<?php }?>
</table>
</form>

<?php echo '<script'; ?>
 type="text/javascript">
<!--
	document.frmLogin.fUsername.focus();
// -->
<?php echo '</script'; ?>
>

</div>

<?php }
}
