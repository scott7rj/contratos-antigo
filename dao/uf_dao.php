<?php
require_once "../classes/conexao.php";
require_once "../classes/uf.php";

final class UfDAO {
	public function selecionarUfs() {
		$sql = "SELECT * FROM [contratos].[fn_uf_selecionar]()";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$obj = new Uf();
			$obj->setUf($array["uf"]);
			$obj->setNome(utf8_encode($array["nome"]));
			array_push($lst, $obj);
		}
		return $lst;
	}
}