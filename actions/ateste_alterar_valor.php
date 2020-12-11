<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";
include_once "../util/db_util.php";

session_start();

try {

	$id_ateste 			= $_POST["id_ateste"];
	$valor 				= DbUtil::formataMonetarioParaDB($_POST["valor"]);
	$usuario_alteracao	= $_SESSION['log_user'];

	$ateste = new ateste();
	$msg = $ateste->alterarValor($id_ateste, $valor, $usuario_alteracao);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
