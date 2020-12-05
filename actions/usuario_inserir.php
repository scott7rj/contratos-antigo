<?php
require_once "../classes/usuario.php";
require_once "../dao/usuario_dao.php";

$msg = "0_vazio";
try {

	$idUsuario	= $_POST["idUsuario"];
	$usuario	= strtoupper(utf8_decode($_POST["usuario"]));
	$idPerfil	= $_POST["sel_id_perfil"];
	$idUnidade	= $_POST["sel_id_unidade"];
	$idFuncao	= $_POST["sel_id_funcao"];
	$usuarioAlteracao	= $_POST["usuario_alteracao"];

	$obj = new Usuario();

	$obj->setIdUsuario($idUsuario);
	$obj->setNome($usuario);
	$obj->setUsuarioAlteracao($usuarioAlteracao);
	$obj->getPerfil()->setIdPerfil($idPerfil);
	$obj->getUnidade()->setIdUnidade($idUnidade);
	$obj->getFuncao()->setIdFuncao($idFuncao);

	$dao = new UsuarioDAO();
	$msg = $dao->inserir($obj);

} catch (Exception $e) {
	$msg = "0_".$e->getMessage();
}

echo utf8_encode($msg);
