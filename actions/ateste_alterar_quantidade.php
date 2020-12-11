<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";

session_start();

try {

	$id_ateste 			= $_POST["id_ateste"];
	$qtd 				= $_POST["qtd"];
	$usuario_alteracao	= $_SESSION['log_user'];

	$ateste = new ateste();
	$msg = $ateste->alterarQuantidade($id_ateste, $qtd, $usuario_alteracao);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
