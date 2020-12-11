<?php
include_once "../classes/usuario.php";
include_once "../dao/usuario_dao.php";

$id = $_POST["id_usuario"];

$obj = new Usuario();
$obj->setIdUsuario($id);
$dao = new UsuarioDAO();
$msg = $dao->remover($obj);

echo utf8_encode($msg);
