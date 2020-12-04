<?php
include_once "../classes/conexao.php";
include_once "../classes/item.php";
include_once "../util/db_util.php";

session_start();

try {

	$id_contrato		= $_POST["id_contrato"];
	$nm_item			= strtoupper(DbUtil::removeAspasSimples(utf8_decode($_POST["item"])));
	$usuario_alteracao	= $_SESSION['log_user'];

	$item = new item();
	$msg  = $item->inserir($id_contrato, $nm_item, $usuario_alteracao);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}