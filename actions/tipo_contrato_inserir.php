<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_contrato.php";

$tipo_contrato	= strtoupper(utf8_decode($_POST["tipo_contrato"]));
$usuario_alteracao	= $_POST["usuario_alteracao"];

$tipoContratoBO = new tipo_contrato();
$msg = $tipoContratoBO->inserir($tipo_contrato, $usuario_alteracao);

echo utf8_encode($msg);
