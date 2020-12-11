<?php
require_once "../classes/conexao.php";
require_once "../classes/usuario.php";

final class UsuarioDAO {

	public function selecionarUsuarioPorId($idUsuario) {
		$sql = "SELECT * FROM [contratos].[fn_usuario_selecionar_por_id]($idUsuario)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$obj = new Usuario();
			$obj->setIdUnidade($array["id_unidade"]);
			$obj->setUnidade(utf8_encode($array["unidade"]));

			$obj->setIdPerfil($array["id_perfil"]);
			$obj->setPerfil(utf8_encode($array["perfil"]));

			$obj->setIdFuncao($array["id_funcao"]);
			$obj->setFuncao(utf8_encode($array["funcao"]));

			array_push($lst, $obj);
			break;
		}
		return $lst;
	}

	public function selecionarUsuarios() {
		$sql = "SELECT * FROM [contratos].[fn_usuario_selecionar]()";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$obj = new Usuario();
			$obj->setIdUsuario($array["id_usuario"]);
			$obj->setNome(utf8_encode($array["nome"]));
			$obj->setIdPerfil($array["id_perfil"]);
			$obj->setPerfil($array["perfil"]);
			$obj->setIdUnidade($array["id_unidade"]);
			$obj->setUnidade($array["unidade"]);
			$obj->setIdFuncao($array["id_funcao"]);
			$obj->setFuncao($array["funcao"]);
			array_push($lst, $obj);
		}
		return $lst;
	}

	public function inserir($obj) {
		try {
			$sql = "EXEC [contratos].[usuario_inserir] @id_usuario = '{$obj->getIdUsuario()}',
					@nome = '{$obj->getNome()}',
					@id_perfil = {$obj->getIdPerfil()},
					@id_unidade = {$obj->getIdUnidade()},
					@id_funcao = {$obj->getIdFuncao()},
					@usuario_alteracao = '{$obj->getUsuarioAlteracao()}'";
			$rst = conexao::execute($sql);
			return odbc_result($rst, 1);
		} catch (Exception $e) {
			return "0_".$e->getMessage();
		}
	}

	public function remover($obj) {
		$sql = "EXEC [contratos].[usuario_remover] @id_usuario = '{$obj->getIdUsuario()}'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}
}