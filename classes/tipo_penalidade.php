<?php

class tipo_penalidade {
	private $idTipoPenalidade;
	private $tipoPenalidade;
	private $ativo;
	private $checked;

	public function getIdTipoPenalidade(){
		return $this->idTipoPenalidade;
	}

	public function setIdTipoPenalidade($idTipoPenalidade){
		$this->idTipoPenalidade = $idTipoPenalidade;
	}

	public function getTipoPenalidade(){
		return $this->tipoPenalidade;
	}

	public function setTipoPenalidade($tipoPenalidade){
		$this->tipoPenalidade = $tipoPenalidade;
	}

	public function getAtivo(){
		return $this->ativo;
	}

	public function setAtivo($ativo){
		$this->ativo = $ativo;
	}

	public function getChecked(){
		return $this->checked;
	}

	public function setChecked($checked){
		$this->checked = $checked;
	}

	public function selecionarTiposPenalidade() {
		$sql = "SELECT * FROM [contratos].[fn_tipo_penalidade_selecionar](1)
				ORDER BY tipo_penalidade";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$tipo_penalidade = new tipo_penalidade();
			$tipo_penalidade->setIdTipoPenalidade($array["id_tipo_penalidade"]);
			$tipo_penalidade->setTipoPenalidade(utf8_encode($array["tipo_penalidade"]));
			array_push($lst, $tipo_penalidade);
		}
		return $lst;
	}

	public function selecionarTiposPenalidadePorIdContrato($id_contrato, $ativo) {
		$sql = "SELECT * FROM [contratos].[fn_tipo_penalidade_selecionar_por_id_contrato]($id_contrato, $ativo)
				--WHERE checked = 'checked'
				ORDER BY tipo_penalidade";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$tipo_penalidade = new tipo_penalidade();
			$tipo_penalidade->setIdTipoPenalidade($array["id_tipo_penalidade"]);
			$tipo_penalidade->setTipoPenalidade(utf8_encode($array["tipo_penalidade"]));
			$tipo_penalidade->setChecked($array["checked"]);
			array_push($lst, $tipo_penalidade);
		}
		return $lst;
	}

	public function inserir($tipo_penalidade, $usuario_alteracao) {
		$sql = "EXEC [contratos].[tipo_penalidade_inserir] @tipo_penalidade = '$tipo_penalidade',
				@usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_tipo_penalidade) {
		$sql = "EXEC [contratos].[tipo_penalidade_remover] @id_tipo_penalidade = $id_tipo_penalidade";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}
}
