<?php

class ateste {
	private $id_ateste;
	private $id_item;
	private $item;
	private $id_subitem;
	private $subitem;
	private $qtd;
	private $valor;
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
	function getSubitem() {
		return $this->subitem;
	}
	function getQtd() {
		return $this->qtd;
	}
	function getValor() {
		return $this->valor;
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
	function setSubitem($subitem) {
		$this->subitem = $subitem;
	}
	function setQtd($qtd) {
		$this->qtd = $qtd;
	}
	function setValor($valor) {
		$this->valor = $valor;
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

	public function selecionarPorIdAtestePagamento($id_ateste_pagamento) {
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
			array_push($lst, $ateste);
		}
		return $lst;
	}

	public function inserir($id_contrato, $ateste, $usuario_alteracao) {
		$sql = "EXEC [contratos].[ateste_inserir] @id_contrato = $id_contrato,
				@ateste = '$ateste', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_ateste, $usuario_alteracao) {
		$sql = "EXEC [contratos].[ateste_remover] @id_ateste = $id_ateste, @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
