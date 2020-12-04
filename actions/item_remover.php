<?php
include_once "../classes/conexao.php";
include_once "../classes/item.php";

session_start();

try {

	$id_item 			= $_POST["id_item"];
	$usuario_alteracao	= $_SESSION['log_user'];

	$item = new item();
	$msg = $item->remover($id_item, $usuario_alteracao);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
