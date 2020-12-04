<?php
include_once "../classes/conexao.php";
include_once "../classes/documento.php";
include_once "../util/db_util.php";

	$id_dominio			= $_POST["id_dominio"]; // Nome genérico. Pode receber id_empresa, id_contrato,
												// id_ateste ou id_penalidade.
	$id_tipo_documento	= $_POST["id_tipo_documento"]; // Caracteriza o id_domínio do documento.
	$usuario_alteracao	= $_POST["usuario_alteracao"];
	$val_ptbr			= $_POST["validade"];
	$data_validade		= ($val_ptbr == "" ? "NULL" : dbUtil::formataDataPtBrParaDB($val_ptbr));
	$observacao 		= dbUtil::formataCampoParaDB(utf8_decode($_POST["observacao"]), 1);
	$documento			= $_FILES["documento"];
	$nome_documento		= utf8_decode(basename($documento[name]));
	$tamanho			= $documento[size]; // tamanho máximo do documento ???
	$extensao			= pathinfo($documento[name], PATHINFO_EXTENSION);

	$diretorio 		= '../documents/';
	$upload_origem	= $documento[tmp_name];
	$upload_destino = $diretorio.$id_tipo_documento.$id_dominio.$nome_documento;
	$mensagem 		= "Aguardando mensagem...";

	if($extensao <> "7z" && $extensao <> "zip" && $extensao && "rar") {
		$mensagem = "0_O documento deve estar compactado.";
	} elseif($tamanho > 5*1048576) {
		$mensagem = "0_Tamanho deve ser menor que 5mb.";
	} elseif(move_uploaded_file($upload_origem, $upload_destino)) {
		$doc = new documento();
		$mensagem = $doc->inserir($id_tipo_documento, $id_dominio, $data_validade,
								  $nome_documento, $observacao, $usuario_alteracao);
		// Obs: Solução para inserir arquivo no banco.
	} else {
		$mensagem = "0_Erro no upload do documento.";
	}

	echo utf8_encode($mensagem);
