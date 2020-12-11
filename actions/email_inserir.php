<?php
include_once "../classes/conexao.php";
include_once "../classes/email.php";

	$id_empresa			= $_POST["id_empresa"];
	$id_tipo_contato	= $_POST["id_tipo_contato"];
	$nm_email			= $_POST["email"];
	$usuario_alteracao	= $_SESSION['log_user'];

	$email = new email();
	$msg = $email->inserir($id_empresa, $id_tipo_contato, $nm_email, $usuario_alteracao);

	echo $msg;
