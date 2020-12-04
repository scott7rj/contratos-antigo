<?php
include_once "../classes/conexao.php";
include_once "../classes/subitem.php";
include_once "../util/db_util.php";

session_start();

try {

	$id_item 			= $_POST["id_item"];
	$nm_subitem			= strtoupper(DbUtil::removeAspasSimples(utf8_decode($_POST["subitem"])));
	$qtd 				= DbUtil::formataMonetarioParaDB($_POST["qtd"]);
	$valor_unitario		= DbUtil::formataMonetarioParaDB($_POST["valor_unitario"]);
	$usuario_alteracao	= $_SESSION['log_user'];

	$subitem = new subitem();
	$msg  = $subitem->inserir($id_item, $nm_subitem, $qtd, $valor_unitario, $usuario_alteracao);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}