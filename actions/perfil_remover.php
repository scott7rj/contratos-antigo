<?php
include_once "../classes/perfil.php";
include_once "../dao/perfil_dao.php";

$id = $_POST["id_perfil"];

$obj = new Perfil();
$obj->setIdPerfil($id);
$dao = new PerfilDAO();
$msg = $dao->remover($obj);

echo $msg;
