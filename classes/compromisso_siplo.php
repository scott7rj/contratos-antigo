<?php

class compromisso_siplo {
	private $idCompromissoSiplo;
	private $compromissoSiplo;

	function getIdCompromissoSiplo() {
		return $this->idCompromissoSiplo;
	}
	function setIdCompromissoSiplo($idCompromissoSiplo) {
		$this->idCompromissoSiplo = $idCompromissoSiplo;
	}

	function getCompromissoSiplo() {
		return $this->compromissoSiplo;
	}
	function setCompromissoSiplo($compromissoSiplo) {
		$this->compromissoSiplo = $compromissoSiplo;
	}

	public function selecionarCompromissosSiploPorIdContrato($id_contrato) {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_compromisso_siplo_selecionar_por_id_contrato]($id_contrato)";
		$rst = conexao::execute($sql);

		while($array = odbc_fetch_array($rst)) {
			$compromisso_siplo = new compromisso_siplo();
			$compromisso_siplo->setIdCompromissoSiplo($array["id_compromisso_siplo"]);
			$compromisso_siplo->setCompromissoSiplo($array["compromisso_siplo"]);
			array_push($lst, $compromisso_siplo);
		}
		return $lst;
	}

	public function inserir($id_contrato, $compromisso_siplo, $usuario_alteracao) {
		$sql = "EXEC [contratos].[compromisso_siplo_inserir] @compromisso_siplo = '$compromisso_siplo',
				@id_contrato = $id_contrato, @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_compromisso_siplo) {
		$sql = "EXEC [contratos].[compromisso_siplo_remover] @id_compromisso_siplo = $id_compromisso_siplo";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
