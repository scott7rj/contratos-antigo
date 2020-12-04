<?php
require_once "../classes/conexao.php";
require_once "../classes/funcao.php";

final class FuncaoDAO {
	public function selecionarFuncoes() {
		$sql = "SELECT * FROM [contratos].[fn_funcao_selecionar]()
				ORDER BY funcao";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$obj = new Funcao();
			$obj->setIdFuncao($array["id_funcao"]);
			$obj->setFuncao(utf8_encode($array["funcao"]));
			array_push($lst, $obj);
		}
		return $lst;
	}

	public function inserir($obj) {
		$sql = "EXEC [contratos].[funcao_inserir] @id_funcao = {$obj->getIdFuncao()},
				@funcao = '{$obj->getFuncao()}'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($obj) {
		$sql = "EXEC [contratos].[funcao_remover] @id_funcao = {$obj->getIdFuncao()}";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}
}