<?php
include_once "../classes/unidade.php";
include_once "../dao/unidade_dao.php";

$idUnidade	= $_POST["idUnidade"];
$unidade	= strtoupper(utf8_decode($_POST["unidade"]));
$obj = new Unidade();
$obj->setIdUnidade($idUnidade);
$obj->setUnidade($unidade);
$dao = new UnidadeDAO();
$msg = $dao->inserir($obj);

echo utf8_encode($msg);
