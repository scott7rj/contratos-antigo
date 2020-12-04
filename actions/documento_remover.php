<?php
include_once "../classes/conexao.php";
include_once "../classes/documento.php";

	$id_documento = $_POST["id_documento"];
	$nm_documento = $_POST["nome_documento"];
	$diretorio 	  = '../documents/';

	unlink($diretorio.$nm_documento);

	$documento = new documento();
	$mensagem  = $documento->remover($id_documento);

	// Obs: Solução para o caso de o arquivo não existir.

	echo utf8_encode($mensagem);
