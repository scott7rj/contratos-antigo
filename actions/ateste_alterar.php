<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";
include_once "../util/db_util.php";

session_start();

try {

	$id_ateste_pagamento = $_POST["id_ateste_pagamento"];
	$observacao 		 = DbUtil::removeAspasSimples(utf8_decode($_POST["observacao"]));
	$usuario_alteracao	 = $_SESSION['log_user'];

	$ateste = new ateste();
	$msg = $ateste->alterar($id_ateste_pagamento, $observacao, $usuario_alteracao);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
