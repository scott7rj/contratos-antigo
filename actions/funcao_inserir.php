<?php
include_once "../classes/conexao.php";
include_once "../classes/funcao.php";
include_once "../dao/funcao_dao.php";

$idFuncao	= $_POST["idFuncao"];
$funcao	= strtoupper(utf8_decode($_POST["funcao"]));
$obj = new Funcao();
$obj->setIdFuncao($idFuncao);
$obj->setFuncao($funcao);
$dao = new FuncaoDAO();
$msg = $dao->inserir($obj);

echo utf8_encode($msg);
