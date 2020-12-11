<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";

session_start();

try {

	$id_ateste 			= $_POST["id_ateste"];
	$homologado			= $_POST["homologado"];
	$usuario_alteracao	= $_SESSION['log_user'];

	$ateste = new ateste();
	$msg = $ateste->alterarHomologacao($id_ateste, $homologado, $usuario_alteracao);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
