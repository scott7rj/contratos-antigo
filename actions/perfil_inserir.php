<?php
include_once "../classes/conexao.php";
include_once "../classes/perfil.php";
include_once "../dao/perfil_dao.php";

$perfil	= strtoupper(utf8_decode($_POST["perfil"]));
$obj = new Perfil();
$obj->setPerfil($perfil);
$dao = new PerfilDAO();
$msg = $dao->inserir($obj);

echo utf8_encode($msg);
