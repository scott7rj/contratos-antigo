<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_penalidade.php";

$id_tipo_penalidade = $_POST["id_tipo_penalidade"];

$tipoPenalidadeBO = new tipo_penalidade();
$msg = $tipoPenalidadeBO->remover($id_tipo_penalidade);

echo $msg;
