<?php

class item {
	private $id_item;
	private $item;

	function getIdItem() {
		return $this->id_item;
	}
	function getItem() {
		return $this->item;
	}

	function setIdItem($id_item) {
		$this->id_item = $id_item;
	}
	function setItem($item) {
		$this->item = $item;
	}

	public function selecionarPorIdContrato($id_contrato) {
		$sql = "SELECT * FROM [contratos].[fn_item_selecionar_por_id_contrato]($id_contrato)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$item = new item();
			$item->setIdItem($array["id_item"]);
			$item->setItem(utf8_encode($array["item"]));
			array_push($lst, $item);
		}
		return $lst;
	}

	public function inserir($id_contrato, $item, $usuario_alteracao) {
		$sql = "EXEC [contratos].[item_inserir] @id_contrato = $id_contrato,
				@item = '$item', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_item, $usuario_alteracao) {
		$sql = "EXEC [contratos].[item_remover] @id_item = $id_item, @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
