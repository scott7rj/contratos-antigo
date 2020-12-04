<?php

class tipo_contato {
	private $id_tipo_contato;
	private $nm_tipo_contato;

	function getId_tipo_contato() {
		return $this->id_tipo_contato;
	}
	function getNm_tipo_contato() {
		return $this->nm_tipo_contato;
	}

	function setId_tipo_contato($id_tipo_contato) {
		$this->id_tipo_contato = $id_tipo_contato;
	}
	function setNm_tipo_contato($nm_tipo_contato) {
		$this->nm_tipo_contato = $nm_tipo_contato;
	}

	public function selecionarTiposContato() {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_tipo_contato_selecionar](1)";
		$rst = conexao::execute($sql);
		while($array = odbc_fetch_array($rst)) {
			$tipo_contato = new tipo_contato();
			$tipo_contato->setId_tipo_contato(utf8_encode($array["id_tipo_contato"]));
			$tipo_contato->setNm_tipo_contato(utf8_encode($array["tipo_contato"]));
			array_push($lst, $tipo_contato);
		}
		return $lst;
	}

	public function inserir($tipo_contato, $usuario_alteracao) {
		$sql = "EXEC [contratos].[tipo_contato_inserir] @tipo_contato = '$tipo_contato',
				@usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_tipo_contato) {
		$sql = "EXEC [contratos].[tipo_contato_remover] @id_tipo_contato = $id_tipo_contato";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
