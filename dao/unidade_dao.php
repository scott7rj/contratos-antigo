<?php
require_once "../classes/conexao.php";
require_once "../classes/unidade.php";

final class UnidadeDAO {
	public function selecionarUnidades() {
		$sql = "SELECT * FROM [contratos].[fn_unidade_selecionar]()
				ORDER BY unidade";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$obj = new Unidade();
			$obj->setIdUnidade($array["id_unidade"]);
			$obj->setUnidade(utf8_encode($array["unidade"]));
			array_push($lst, $obj);
		}
		return $lst;
	}

	public function inserir($obj) {
		$sql = "EXEC [contratos].[unidade_inserir] @id_unidade = {$obj->getIdUnidade()},
				@unidade = '{$obj->getUnidade()}'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($obj) {
		$sql = "EXEC [contratos].[unidade_remover] @id_unidade = {$obj->getIdUnidade()}";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}
}