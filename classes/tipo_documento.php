<?php

class tipo_documento {
	private $id_tipo_documento;
	private $nm_tipo_documento;
	private $possui_validade;
	private $id_dominio_documento;
	private $dominio_documento;

	function getId_tipo_documento() {
		return $this->id_tipo_documento;
	}
	function getNm_tipo_documento() {
		return $this->nm_tipo_documento;
	}
	function getPossui_validade() {
		return $this->possui_validade;
	}
	function getId_dominio_documento() {
		return $this->id_dominio_documento;
	}
	function getDominio_documento() {
		return $this->dominio_documento;
	}

	function setId_tipo_documento($id_tipo_documento) {
		$this->id_tipo_documento = $id_tipo_documento;
	}
	function setNm_tipo_documento($nm_tipo_documento) {
		$this->nm_tipo_documento = $nm_tipo_documento;
	}
	function setPossui_validade($possui_validade) {
		$this->possui_validade = $possui_validade;
	}
	function setId_dominio_documento($id_dominio_documento) {
		$this->id_dominio_documento = $id_dominio_documento;
	}
	function setDominio_documento($dominio_documento) {
		$this->dominio_documento = $dominio_documento;
	}

	public function selecionarTiposDocumento() {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_tipo_documento_selecionar](1)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$tipo_documento = new tipo_documento();
			$tipo_documento->setId_tipo_documento(utf8_encode($array["id_tipo_documento"]));
			$tipo_documento->setNm_tipo_documento(utf8_encode($array["tipo_documento"]));
			$tipo_documento->setPossui_validade($array["possui_validade"]);
			$tipo_documento->setDominio_documento($array["dominio_documento"]);
			array_push($lst, $tipo_documento);
		}
		return $lst;
	}

	public function selecionarTiposDocumentoPorIdDominioDocumento($id_dominio_documento) {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_tipo_documento_selecionar_por_id_dominio_documento]($id_dominio_documento)";
		$rst = conexao::execute($sql);

		while($array = odbc_fetch_array($rst)) {
			$tipo_documento = new tipo_documento();
			$tipo_documento->setId_tipo_documento(utf8_encode($array["id_tipo_documento"]));
			$tipo_documento->setNm_tipo_documento(utf8_encode($array["tipo_documento"]));
			$tipo_documento->setPossui_validade($array["possui_validade"]);
			$lst[] = $tipo_documento;
		}
		return $lst;
	}

	public function selecionarDominiosTipoDocumento() {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_dominio_documento_selecionar]()";
		$rst = conexao::execute($sql);

		while($array = odbc_fetch_array($rst)) {
			$tipo_documento = new tipo_documento();
			$tipo_documento->setId_dominio_documento($array["id_dominio_documento"]);
			$tipo_documento->setDominio_documento($array["dominio_documento"]);
			$lst[] = $tipo_documento;
		}
		return $lst;
	}

	public function inserir($tipo_documento, $possui_validade, $id_dominio_documento, $usuario_alteracao) {
		$sql = "EXEC [contratos].[tipo_documento_inserir] @tipo_documento = '$tipo_documento',
				@possui_validade = $possui_validade, @id_dominio_documento = $id_dominio_documento,
				@usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_tipo_documento) {
		$sql = "EXEC [contratos].[tipo_documento_remover] @id_tipo_documento = $id_tipo_documento";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
