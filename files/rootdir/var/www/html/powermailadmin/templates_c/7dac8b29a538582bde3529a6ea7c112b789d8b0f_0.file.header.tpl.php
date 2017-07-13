<?php
/* Smarty version 3.1.29, created on 2017-07-10 18:05:50
  from "/var/www/html/powermailadmin/templates/header.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_596374a67a89b6_89937448',
  'file_dependency' => 
  array (
    '7dac8b29a538582bde3529a6ea7c112b789d8b0f' => 
    array (
      0 => '/var/www/html/powermailadmin/templates/header.tpl',
      1 => 1499683465,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_596374a67a89b6_89937448 ($_smarty_tpl) {
?>
<!-- <?php echo basename($_smarty_tpl->source->filepath);?>
 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->tpl_vars['CONF']->value['theme_css'];?>
" />
<?php if ($_smarty_tpl->tpl_vars['CONF']->value['theme_custom_css']) {?>
		<link rel="stylesheet" type="text/css" href="<?php echo $_smarty_tpl->tpl_vars['CONF']->value['theme_custom_css'];?>
" />
<?php }?>
		<title>TechnoMail Admin - <?php echo $_SERVER['HTTP_HOST'];?>
</title>
	</head>
	<body class="lang-<?php echo $_SESSION['lang'];?>
 page-<?php echo $_smarty_tpl->tpl_vars['smarty_template']->value;?>
 <?php if (isset($_smarty_tpl->tpl_vars['table']->value)) {?>page-<?php echo $_smarty_tpl->tpl_vars['smarty_template']->value;?>
-<?php echo $_smarty_tpl->tpl_vars['table']->value;
}?>">
		<div id="bodybox">
		<div id="container">
		<div id="login_header">
		<a href='main.php'><img id="login_header_logo" src="<?php echo $_smarty_tpl->tpl_vars['CONF']->value['theme_logo'];?>
" alt="Logo" /></a>
<?php if ($_smarty_tpl->tpl_vars['CONF']->value['show_header_text'] === 'YES' && $_smarty_tpl->tpl_vars['CONF']->value['header_text']) {?>
		<h2><?php echo $_smarty_tpl->tpl_vars['CONF']->value['header_text'];?>
</h2>
<?php }?>
		</div>
<?php }
}
