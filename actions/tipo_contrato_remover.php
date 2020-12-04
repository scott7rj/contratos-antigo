<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_contrato.php";

$id_tipo_contrato = $_POST["id_tipo_contrato"];

$tipoContratoBO = new tipo_contrato();
$msg = $tipoContratoBO->remover($id_tipo_contrato);

echo $msg;
