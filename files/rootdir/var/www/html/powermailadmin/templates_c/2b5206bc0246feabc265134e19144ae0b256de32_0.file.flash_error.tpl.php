<?php
/* Smarty version 3.1.29, created on 2017-07-10 18:05:50
  from "/var/www/html/powermailadmin/templates/flash_error.tpl" */

if ($_smarty_tpl->smarty->ext->_validateCompiled->decodeProperties($_smarty_tpl, array (
  'has_nocache_code' => false,
  'version' => '3.1.29',
  'unifunc' => 'content_596374a680ce45_40099217',
  'file_dependency' => 
  array (
    '2b5206bc0246feabc265134e19144ae0b256de32' => 
    array (
      0 => '/var/www/html/powermailadmin/templates/flash_error.tpl',
      1 => 1499683465,
      2 => 'file',
    ),
  ),
  'includes' => 
  array (
  ),
),false)) {
function content_596374a680ce45_40099217 ($_smarty_tpl) {
?>
<!-- <?php echo basename($_smarty_tpl->source->filepath);?>
 -->
<br clear="all"/><br />
<?php if (isset($_SESSION['flash'])) {
if (isset($_SESSION['flash']['info'])) {?><ul class="flash-info"><?php
$_from = $_SESSION['flash']['info'];
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_msg_0_saved_item = isset($_smarty_tpl->tpl_vars['msg']) ? $_smarty_tpl->tpl_vars['msg'] : false;
$_smarty_tpl->tpl_vars['msg'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['msg']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['msg']->value) {
$_smarty_tpl->tpl_vars['msg']->_loop = true;
$__foreach_msg_0_saved_local_item = $_smarty_tpl->tpl_vars['msg'];
?><li><?php echo htmlspecialchars($_smarty_tpl->tpl_vars['msg']->value, ENT_QUOTES, 'UTF-8', true);?>
</li><?php
$_smarty_tpl->tpl_vars['msg'] = $__foreach_msg_0_saved_local_item;
}
if ($__foreach_msg_0_saved_item) {
$_smarty_tpl->tpl_vars['msg'] = $__foreach_msg_0_saved_item;
}
?></ul><?php }
if (isset($_SESSION['flash']['error'])) {?><ul class="flash-error"><?php
$_from = $_SESSION['flash']['error'];
if (!is_array($_from) && !is_object($_from)) {
settype($_from, 'array');
}
$__foreach_msg_1_saved_item = isset($_smarty_tpl->tpl_vars['msg']) ? $_smarty_tpl->tpl_vars['msg'] : false;
$_smarty_tpl->tpl_vars['msg'] = new Smarty_Variable();
$_smarty_tpl->tpl_vars['msg']->_loop = false;
foreach ($_from as $_smarty_tpl->tpl_vars['msg']->value) {
$_smarty_tpl->tpl_vars['msg']->_loop = true;
$__foreach_msg_1_saved_local_item = $_smarty_tpl->tpl_vars['msg'];
?><li><?php echo htmlspecialchars($_smarty_tpl->tpl_vars['msg']->value, ENT_QUOTES, 'UTF-8', true);?>
</li><?php
$_smarty_tpl->tpl_vars['msg'] = $__foreach_msg_1_saved_local_item;
}
if ($__foreach_msg_1_saved_item) {
$_smarty_tpl->tpl_vars['msg'] = $__foreach_msg_1_saved_item;
}
?></ul><?php }
}
}
}
