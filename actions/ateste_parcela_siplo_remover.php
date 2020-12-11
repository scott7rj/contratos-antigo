<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";

try {

	$id_parcela_siplo = $_POST["id_parcela_siplo"];

	$ateste = new ateste();
	$msg = $ateste->removerParcelaSiplo($id_parcela_siplo);

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
