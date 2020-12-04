<?php

class subitem {
	private $id_subitem;
	private $subitem;
	private $qtd;
	private $valor_unitario;

	function getIdSubitem() {
		return $this->id_subitem;
	}
	function getSubitem() {
		return $this->subitem;
	}
	function getQtd() {
		return $this->qtd;
	}
	function getValorUnitario() {
		return $this->valor_unitario;
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
	function setValorUnitario($valor_unitario) {
		$this->valor_unitario = $valor_unitario;
	}

	public function selecionarPorIdItem($id_item) {
		$sql = "SELECT * FROM [contratos].[fn_subitem_selecionar_por_id_item]($id_item)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$subitem = new subitem();
			$subitem->setIdSubitem($array["id_subitem"]);
			$subitem->setSubitem(utf8_encode($array["subitem"]));
			$subitem->setQtd($array["qtd"]);
			$subitem->setValorUnitario($array["valor_unitario"]);
			array_push($lst, $subitem);
		}
		return $lst;
	}

	public function inserir($id_item, $subitem, $qtd, $valor_unitario, $usuario_alteracao) {
		$sql = "EXEC [contratos].[subitem_inserir] @id_item = $id_item, @subitem = '$subitem', @qtd = $qtd,
				@valor_unitario = '$valor_unitario', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_subitem, $usuario_alteracao) {
		$sql = "EXEC [contratos].[subitem_remover] @id_subitem = $id_subitem, @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
