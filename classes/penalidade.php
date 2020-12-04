<?php

class penalidade {
	private $id_penalidade;
	private $penalidade;

	function getIdPenalidade() {
		return $this->id_penalidade;
	}
	function getPenalidade() {
		return $this->penalidade;
	}

	function setIdPenalidade($id_penalidade) {
		$this->id_penalidade = $id_penalidade;
	}
	function setPenalidade($penalidade) {
		$this->penalidade = $penalidade;
	}

	public function selecionarPorIdEmpresaIdContrato($id_empresa, $id_contrato) {
		$sql = "SELECT * FROM [contratos].[fn_penalidade_selecionar_por_id_empresa_id_contrato]($id_empresa, $id_contrato)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$penalidade = new penalidade();
			$penalidade->setIdPenalidade($array["id_penalidade"]);
			$penalidade->setPenalidade(utf8_encode($array["penalidade"]));
			array_push($lst, $penalidade);
		}
		return $lst;
	}

	public function inserir($id_contrato, $penalidade, $usuario_alteracao) {
		$sql = "EXEC [contratos].[penalidade_inserir] @id_contrato = $id_contrato,
				@penalidade = '$penalidade', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_penalidade, $usuario_alteracao) {
		$sql = "EXEC [contratos].[penalidade_remover] @id_penalidade = $id_penalidade, @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
