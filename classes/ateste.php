<?php

class ateste {
	private $id_ateste;
	private $id_item;
	private $item;
	private $id_subitem;
	private $id_parcela_siplo;
	private $subitem;
	private $qtd;
	private $valor;
	private $homologado;
	private $empresa;
	private $contrato;
	private $competencia;
	private $observacao;

	function getIdAteste() {
		return $this->id_ateste;
	}
	function getIdItem() {
		return $this->id_item;
	}
	function getItem() {
		return $this->item;
	}
	function getIdSubitem() {
		return $this->id_subitem;
	}
	function getIdParcelaSiplo() {
		return $this->id_parcela_siplo;
	}
	function getSubitem() {
		return $this->subitem;
	}
	function getQtd() {
		return $this->qtd;
	}
	function getValor() {
		return $this->valor;
	}
	function getHomologado() {
		return $this->homologado;
	}
	function getEmpresa() {
		return $this->empresa;
	}
	function getContrato() {
		return $this->contrato;
	}
	function getCompetencia() {
		return $this->competencia;
	}
	function getObservacao() {
		return $this->observacao;
	}

	function setIdAteste($id_ateste) {
		$this->id_ateste = $id_ateste;
	}
	function setAteste($ateste) {
		$this->ateste = $ateste;
	}
	function setIdItem($id_item) {
		$this->id_item = $id_item;
	}
	function setItem($item) {
		$this->item = $item;
	}
	function setIdSubitem($id_subitem) {
		$this->id_subitem = $id_subitem;
	}
	function setIdParcelaSiplo($id_parcela_siplo) {
		$this->id_parcela_siplo = $id_parcela_siplo;
	}
	function setSubitem($subitem) {
		$this->subitem = $subitem;
	}
	function setQtd($qtd) {
		$this->qtd = $qtd;
	}
	function setValor($valor) {
		$this->valor = $valor;
	}
	function setHomologado($homologado) {
		$this->homologado = $homologado;
	}
	function setEmpresa($empresa) {
		$this->empresa = $empresa;
	}
	function setContrato($contrato) {
		$this->contrato = $contrato;
	}
	function setCompetencia($competencia) {
		$this->competencia = $competencia;
	}
	function setObservacao($observacao) {
		$this->observacao = $observacao;
	}

	public function selecionarCompetenciasPorIdContrato($id_contrato) {
		$sql = "SELECT *
				FROM [contratos].[fn_ateste_pagamento_selecionar_competencias_por_id_contrato]($id_contrato)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$ateste = new ateste();
			$ateste->setIdAteste($array["id_ateste_pagamento"]);
			$ateste->setCompetencia($array["competencia"]);
			array_push($lst, $ateste);
		}
		return $lst;
	}

	public function selecionarPorId($id_ateste_pagamento) {
		$sql = "SELECT *
				FROM [contratos].[fn_ateste_pagamento_selecionar_por_id]($id_ateste_pagamento)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$ateste = new ateste();
			$ateste->setEmpresa($array["empresa"]);
			$ateste->setContrato($array["contrato"]);
			$ateste->setCompetencia($array["competencia"]);
			$ateste->setObservacao($array["observacao"]);
			array_push($lst, $ateste);
		}
		return $lst[0];
	}

	public function selecionarAtestesPorIdAtestePagamento($id_ateste_pagamento) {
		$sql = "SELECT *
				FROM [contratos].[fn_ateste_selecionar_por_id_ateste_pagamento]($id_ateste_pagamento)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$ateste = new ateste();
			$ateste->setIdAteste($array["id_ateste"]);
			$ateste->setIdItem($array["id_item"]);
			$ateste->setItem(utf8_encode($array["item"]));
			$ateste->setIdSubitem($array["id_subitem"]);
			$ateste->setSubitem(utf8_encode($array["subitem"]));
			$ateste->setQtd($array["qtd"]);
			$ateste->setValor($array["valor"]);
			$ateste->setHomologado($array["atestado_gestor_operacional"]);
			array_push($lst, $ateste);
		}
		return $lst;
	}

	public function selecionarParcelasSiploPorIdAtestePagamento($id_ateste_pagamento) {
		$sql = "SELECT *
				FROM [contratos].[fn_parcela_siplo_selecionar_por_id_ateste_pagamento]($id_ateste_pagamento)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$ateste = new ateste();
			$ateste->setIdParcelaSiplo($array["id_parcela_siplo"]);
			$ateste->setValor($array["valor"]);
			$ateste->setObservacao(utf8_encode($array["descricao"]));
			array_push($lst, $ateste);
		}
		return $lst;
	}

	public function alterarQuantidade($id_ateste, $qtd, $usuario_alteracao) {
		$sql = "EXEC [contratos].[ateste_alterar_quantidade] @id_ateste = $id_ateste,
				@qtd = '$qtd', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function alterarValor($id_ateste, $valor, $usuario_alteracao) {
		$sql = "EXEC [contratos].[ateste_alterar_valor] @id_ateste = $id_ateste,
				@valor = '$valor', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function alterarHomologacao($id_ateste, $homologado, $usuario_alteracao) {
		$sql = "EXEC [contratos].[ateste_alterar_atestado_gestor_operacional] @id_ateste = $id_ateste,
				@atestado_gestor_operacional = $homologado, @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function alterar($id_ateste_pagamento, $observacao, $usuario_alteracao) {
		$sql = "EXEC [contratos].[ateste_pagamento_alterar] @id_ateste_pagamento = $id_ateste_pagamento,
				@observacao = 'observacao', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function inserirParcelaSiplo($id_ateste_pagamento, $descricao, $valor, $usuario_alteracao) {
		$sql = "EXEC [contratos].[parcela_siplo_inserir] @id_ateste_pagamento = $id_ateste_pagamento,
				@descricao = '$descricao', @valor = '$valor', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function removerParcelaSiplo($id_parcela_siplo) {
		$sql = "EXEC [contratos].[parcela_siplo_remover] @id_parcela_siplo = $id_parcela_siplo";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
