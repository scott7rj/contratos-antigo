<?php
require_once "../classes/conexao.php";
require_once "../classes/perfil.php";

final class PerfilDAO {
	public function selecionarPerfis() {
		$sql = "SELECT * FROM [contratos].[fn_perfil_selecionar]()
				ORDER BY perfil";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$obj = new Perfil();
			$obj->setIdPerfil($array["id_perfil"]);
			$obj->setPerfil(utf8_encode($array["perfil"]));
			array_push($lst, $obj);
		}
		return $lst;
	}

	public function inserir($obj) {
		$sql = "EXEC [contratos].[perfil_inserir] @perfil = '{$obj->getPerfil()}'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($obj) {
		$sql = "EXEC [contratos].[perfil_remover] @id_perfil = {$obj->getIdPerfil()}";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}
}