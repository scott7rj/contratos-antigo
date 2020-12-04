<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_penalidade.php";

$tipo_penalidade	= strtoupper(utf8_decode($_POST["tipo_penalidade"]));
$usuario_alteracao	= $_POST["usuario_alteracao"];

$tipoPenalidadeBO = new tipo_penalidade();
$msg = $tipoPenalidadeBO->inserir($tipo_penalidade, $usuario_alteracao);

echo utf8_encode($msg);
