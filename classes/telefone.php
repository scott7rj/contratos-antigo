<?php

class telefone {
	private $id_telefone;
	private $telefone;
	private $tipo_contato;

	function getId_telefone() {
		return $this->id_telefone;
	}
	function getTelefone() {
		return $this->telefone;
	}
	function getTipo_contato() {
		return $this->tipo_contato;
	}

	function setId_telefone($id_telefone) {
		$this->id_telefone = $id_telefone;
	}
	function setTelefone($telefone) {
		$this->telefone = $telefone;
	}
	function setTipo_contato($tipo_contato) {
		$this->tipo_contato = $tipo_contato;
	}

	public function selecionarPorIdEmpresa($id_empresa) {
		$sql = "SELECT * FROM [contratos].[fn_telefone_selecionar_por_id_empresa]($id_empresa)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$telefone = new telefone();
			$telefone->setId_telefone($array["id_telefone"]);
			$telefone->setTelefone($array["telefone"]);
			$telefone->setTipo_contato(utf8_encode($array["tipo_contato"]));
			array_push($lst, $telefone);
		}
		return $lst;
	}

	public function inserir($id_empresa, $id_tipo_contato, $telefone, $usuario_alteracao) {
		$sql = "EXEC [contratos].[telefone_inserir] @id_empresa = $id_empresa, @id_tipo_contato = $id_tipo_contato,
				@telefone = '$telefone', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_telefone) {
		$sql = "EXEC [contratos].[telefone_remover] @id_telefone = $id_telefone";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
