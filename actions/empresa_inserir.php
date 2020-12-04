<?php
include_once "../classes/conexao.php";
include_once "../classes/empresa.php";
include_once "../util/db_util.php";

try {

	$existe_empresa		= $_POST["existe_empresa"];
	$cnpj				= str_replace("-","", str_replace("/","", str_replace(".", "", $_POST["cnpj"])));
	$nm_empresa			= DbUtil::removeAspasSimples(strtoupper(utf8_decode($_POST["empresa"])));
	$endereco			= DbUtil::removeAspasSimples(utf8_decode(strtoupper($_POST["endereco"])));
	$cidade				= DbUtil::removeAspasSimples(utf8_decode(strtoupper($_POST["cidade"])));
	$uf					= $_POST["uf"];
	$cep				= str_replace("-","", $_POST["cep"]);
	$observacao 		= DbUtil::removeAspasSimples(utf8_decode($_POST["observacao"]));
	$usuario_alteracao	= $_POST["usuario_alteracao"];

	$empresa = new empresa();

	if($existe_empresa) {
		$id_empresa = $_POST["id_empresa"];
		$msg = $empresa->alterar($id_empresa, $cnpj, $nm_empresa, $endereco, $cidade,
								 $uf, $cep, $observacao, $usuario_alteracao);
	} else {
		$msg = $empresa->inserir($cnpj, $nm_empresa, $endereco, $cidade, $uf, $cep,
								 $observacao, $usuario_alteracao);
	}

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
