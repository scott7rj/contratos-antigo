<?php

class documento {
	private $id_documento;
	private $tipo_documento;
	private $nm_documento;
	private $data_validade;
	private $observacao;
	private $download;

	function getId_documento() {
		return $this->id_documento;
	}
	function getTipo_documento() {
		return $this->tipo_documento;
	}
	function getNm_documento() {
		return $this->nm_documento;
	}
	function getData_validade() {
		return $this->data_validade;
	}
	function getObservacao() {
		return $this->observacao;
	}
	function getDownload() {
		return $this->download;
	}

	function setId_documento($id_documento) {
		$this->id_documento = $id_documento;
	}
	function setTipo_documento($tipo_documento) {
		$this->tipo_documento = $tipo_documento;
	}
	function setNm_documento($nm_documento) {
		$this->nm_documento = $nm_documento;
	}
	function setData_validade($data_validade) {
		$this->data_validade = $data_validade;
	}
	function setObservacao($observacao) {
		$this->observacao = $observacao;
	}
	function setDownload($download) {
		$this->download = $download;
	}

	public function selecionarDocumentosPorIdEmpresa($id_empresa) {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_documento_selecionar_por_id_empresa]($id_empresa)";
		$rst = conexao::execute($sql);

		while($array = odbc_fetch_array($rst)) {
			$documento = new documento();
			$documento->setId_documento($array["id_documento"]);
			$documento->setTipo_documento(utf8_encode($array["tipo_documento"]));
			$documento->setNm_documento(utf8_encode($array["nome_documento"]));
			$documento->setData_validade($array["data_validade"]);
			$documento->setObservacao(utf8_encode($array["observacao"]));
			$documento->setDownload($array["download"]);
			$lst[] = $documento;
		}
		return $lst;
	}

	public function selecionarDocumentosPorIdContrato($id_contrato) {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_documento_selecionar_por_id_contrato]($id_contrato)";
		$rst = conexao::execute($sql);

		while($array = odbc_fetch_array($rst)) {
			$documento = new documento();
			$documento->setId_documento($array["id_documento"]);
			$documento->setTipo_documento(utf8_encode($array["tipo_documento"]));
			$documento->setNm_documento(utf8_encode($array["nome_documento"]));
			$documento->setData_validade($array["data_validade"]);
			$documento->setObservacao(utf8_encode($array["observacao"]));
			$documento->setDownload($array["download"]);
			$lst[] = $documento;
		}
		return $lst;
	}

	public function selecionarDocumentosPorIdAtestePagamento($id_ateste_pagamento) {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_documento_selecionar_por_id_ateste_pagamento]($id_ateste_pagamento)";
		$rst = conexao::execute($sql);

		while($array = odbc_fetch_array($rst)) {
			$documento = new documento();
			$documento->setId_documento($array["id_documento"]);
			$documento->setTipo_documento(utf8_encode($array["tipo_documento"]));
			$documento->setNm_documento(utf8_encode($array["nome_documento"]));
			$documento->setData_validade($array["data_validade"]);
			$documento->setObservacao(utf8_encode($array["observacao"]));
			$documento->setDownload($array["download"]);
			$lst[] = $documento;
		}
		return $lst;
	}

	public function inserir($id_tipo_documento, $id_dominio, $data_validade, $nome_documento, $observacao, $usuario_alteracao) {
		$sql = "EXEC [contratos].[documento_inserir] @id_tipo_documento = $id_tipo_documento,
				@id_dominio = $id_dominio, @data_validade = $data_validade,
				@nome_documento = '$nome_documento', @observacao = $observacao,
				@usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_documento) {
		$sql = "EXEC [contratos].[documento_remover] @id_documento = $id_documento";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
