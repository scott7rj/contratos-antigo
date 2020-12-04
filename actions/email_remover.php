<?php
include_once "../classes/conexao.php";
include_once "../classes/email.php";

	$id_email = $_POST["id_email"];

	$email = new email();
	$msg = $email->remover($id_email);

	echo $msg;
