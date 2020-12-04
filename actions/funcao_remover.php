<?php
include_once "../classes/funcao.php";
include_once "../dao/funcao_dao.php";

$id = $_POST["id_funcao"];

$obj = new Funcao();
$obj->setIdFuncao($id);
$dao = new FuncaoDAO();
$msg = $dao->remover($obj);

echo $msg;
