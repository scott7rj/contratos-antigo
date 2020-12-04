<?php
include_once "../classes/unidade.php";
include_once "../dao/unidade_dao.php";

$id = $_POST["id_unidade"];

$obj = new Unidade();
$obj->setIdUnidade($id);
$dao = new UnidadeDAO();
$msg = $dao->remover($obj);

echo $msg;
