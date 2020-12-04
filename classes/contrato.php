<?php

class contrato {

	private $idContrato;
	private $idEmpresa;
	private $Empresa;
	private $dataAssinatura;
	private $dataInicioVigencia;
	private $dataFimVigencia;
	private $idTipoContrato;
	private $tipoContrato;
	private $valorGlobalIncial;
	private $valorGlobalAtualizado;
	private $objetoContratual;
	private $compromissoSiplo;
	private $numeroProcesso;
	private $numeroOrdemServico;
	private $diaPagamento;
	private $diaPagamentoCorridos;
	private $prazoAlertaDiasPagamento;
	private $prazoAlertaDiasAteste;
	private $prazoAlertaDiasNotaFiscal;
	private $prazoAlertaMesesFimVigencia;

	public function getIdContrato(){
		return $this->idContrato;
	}

	public function setIdContrato($idContrato){
		$this->idContrato = $idContrato;
	}

	public function getIdEmpresa(){
		return $this->idEmpresa;
	}

	public function setIdEmpresa($idEmpresa){
		$this->idEmpresa = $idEmpresa;
	}

	public function getEmpresa(){
		return $this->Empresa;
	}

	public function setEmpresa($Empresa){
		$this->Empresa = $Empresa;
	}

	public function getDataAssinatura(){
		return $this->dataAssinatura;
	}

	public function setDataAssinatura($dataAssinatura){
		$this->dataAssinatura = $dataAssinatura;
	}

	public function getDataInicioVigencia(){
		return $this->dataInicioVigencia;
	}

	public function setDataInicioVigencia($dataInicioVigencia){
		$this->dataInicioVigencia = $dataInicioVigencia;
	}

	public function getDataFimVigencia(){
		return $this->dataFimVigencia;
	}

	public function setDataFimVigencia($dataFimVigencia){
		$this->dataFimVigencia = $dataFimVigencia;
	}

	public function getIdTipoContrato(){
		return $this->idTipoContrato;
	}

	public function setIdTipoContrato($idTipoContrato){
		$this->idTipoContrato = $idTipoContrato;
	}

	public function getTipoContrato(){
		return $this->tipoContrato;
	}

	public function setTipoContrato($tipoContrato){
		$this->tipoContrato = $tipoContrato;
	}

	public function getValorGlobalIncial(){
		return $this->valorGlobalIncial;
	}

	public function setValorGlobalIncial($valorGlobalIncial){
		$this->valorGlobalIncial = $valorGlobalIncial;
	}

	public function getValorGlobalAtualizado(){
		return $this->valorGlobalAtualizado;
	}

	public function setValorGlobalAtualizado($valorGlobalAtualizado){
		$this->valorGlobalAtualizado = $valorGlobalAtualizado;
	}

	public function getObjetoContratual(){
		return $this->objetoContratual;
	}

	public function setObjetoContratual($objetoContratual){
		$this->objetoContratual = $objetoContratual;
	}

	public function getCompromissoSiplo(){
		return $this->compromissoSiplo;
	}

	public function setCompromissoSiplo($compromissoSiplo){
		$this->compromissoSiplo = $compromissoSiplo;
	}

	public function getNumeroProcesso(){
		return $this->numeroProcesso;
	}

	public function setNumeroProcesso($numeroProcesso){
		$this->numeroProcesso = $numeroProcesso;
	}
	public function getNumeroOrdemServico(){
		return $this->numeroOrdemServico;
	}

	public function setNumeroOrdemServico($numeroOrdemServico){
		$this->numeroOrdemServico = $numeroOrdemServico;
	}

	public function getDiaPagamento(){
		return $this->diaPagamento;
	}

	public function setDiaPagamento($diaPagamento){
		$this->diaPagamento = $diaPagamento;
	}

	public function getDiaPagamentoCorridos(){
		return $this->diaPagamentoCorridos;
	}

	public function setDiaPagamentoCorridos($diaPagamentoCorridos){
		$this->diaPagamentoCorridos = $diaPagamentoCorridos;
	}

	public function getPrazoAlertaDiasPagamento(){
		return $this->prazoAlertaDiasPagamento;
	}

	public function setPrazoAlertaDiasPagamento($prazoAlertaDiasPagamento){
		$this->prazoAlertaDiasPagamento = $prazoAlertaDiasPagamento;
	}

	public function getPrazoAlertaDiasAteste(){
		return $this->prazoAlertaDiasAteste;
	}

	public function setPrazoAlertaDiasAteste($prazoAlertaDiasAteste){
		$this->prazoAlertaDiasAteste = $prazoAlertaDiasAteste;
	}

	public function getPrazoAlertaDiasNotaFiscal(){
		return $this->prazoAlertaDiasNotaFiscal;
	}

	public function setPrazoAlertaDiasNotaFiscal($prazoAlertaDiasNotaFiscal){
		$this->prazoAlertaDiasNotaFiscal = $prazoAlertaDiasNotaFiscal;
	}

	public function getPrazoAlertaMesesFimVigencia(){
		return $this->prazoAlertaMesesFimVigencia;
	}

	public function setPrazoAlertaMesesFimVigencia($prazoAlertaMesesFimVigencia){
		$this->prazoAlertaMesesFimVigencia = $prazoAlertaMesesFimVigencia;
	}

	/*
	public function selecionar($ativo) {
		$sql = "SELECT * FROM [contratos].[fn_contrato_selecionar_por_id_empresa]($id_empresa)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$contrato = new contrato();

			$contrato->setIdContrato($array["id_contrato"]);
			$contrato->setDataInicioVigencia($array["data_inicio_vigencia"]);
			$contrato->setDataFimVigencia($array["data_fim_vigencia"]);
			$contrato->setNumeroProcesso($array["numero_processo"]);
			$contrato->setIdTipoContrato($array["id_tipo_contrato"]);
			$contrato->setTipoContrato(utf8_encode($array["tipo_contrato"]));
			array_push($lst, $contrato);
		}
		return $lst;
	}
	*/

	public function selecionarPorId($id_contrato) {
		$sql = "SELECT * FROM [contratos].[fn_contrato_selecionar_por_id]($id_contrato)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$contrato = new contrato();
			$contrato->setEmpresa(utf8_encode($array["empresa"]));
			$contrato->setTipoContrato(utf8_encode($array["tipo_contrato"]));
			$contrato->setNumeroProcesso($array["numero_processo"]);
			$contrato->setNumeroOrdemServico($array["numero_ordem_servico"]);
			$contrato->setDataAssinatura($array["data_assinatura"]);
			$contrato->setDataInicioVigencia($array["data_inicio_vigencia"]);
			$contrato->setDataFimVigencia($array["data_fim_vigencia"]);
			$contrato->setDiaPagamento($array["dia_pagamento"]);
			$contrato->setDiaPagamentoCorridos($array["dia_pagamento_corridos"]);
			$contrato->setValorGlobalIncial($array["valor_global_inicial"]);
			$contrato->setValorGlobalAtualizado($array["valor_global_atualizado"]);
			$contrato->setObjetoContratual(utf8_encode($array["objeto_contratual"]));
			$contrato->setPrazoAlertaDiasPagamento($array["prazo_alerta_dias_pagamento"]);
			$contrato->setPrazoAlertaDiasAteste($array["prazo_alerta_dias_ateste"]);
			$contrato->setPrazoAlertaDiasNotaFiscal($array["prazo_alerta_dias_nota_fiscal"]);
			$contrato->setPrazoAlertaMesesFimVigencia($array["prazo_alerta_meses_fim_vigencia"]);
			array_push($lst, $contrato);
		}
		return $lst[0];
	}

	public function selecionarPorIdEmpresa($id_empresa) {
		$sql = "SELECT * FROM [contratos].[fn_contrato_selecionar_por_id_empresa]($id_empresa)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$contrato = new contrato();

			$contrato->setIdContrato($array["id_contrato"]);
			$contrato->setDataInicioVigencia($array["data_inicio_vigencia"]);
			$contrato->setDataFimVigencia($array["data_fim_vigencia"]);
			$contrato->setNumeroProcesso($array["numero_processo"]);
			$contrato->setIdTipoContrato($array["id_tipo_contrato"]);
			$contrato->setTipoContrato(utf8_encode($array["tipo_contrato"]));
			array_push($lst, $contrato);
		}
		return $lst;
	}

	public function inserir($id_empresa, $id_tipo_contrato, $numero_processo, $numero_ordem_servico,
							$data_assinatura, $data_inicio_vigencia, $data_fim_vigencia,
							$valor_global_inicial, $valor_global_atualizado, $objeto_contratual,
							$dia_pagamento, $dia_pagamento_corridos, $prazo_alerta_dias_pagamento,
							$prazo_alerta_dias_ateste, $prazo_alerta_dias_nota_fiscal,
							$prazo_alerta_meses_fim_vigencia, $usuario_alteracao) {
		$sql = "EXEC [contratos].[contrato_inserir]
					  @id_empresa = $id_empresa
					, @id_tipo_contrato = $id_tipo_contrato
					, @numero_processo = '$numero_processo'
					, @numero_ordem_servico = $numero_ordem_servico
					, @data_assinatura = $data_assinatura
					, @data_inicio_vigencia = $data_inicio_vigencia
					, @data_fim_vigencia = $data_fim_vigencia
					, @valor_global_inicial = $valor_global_inicial
					, @valor_global_atualizado = $valor_global_atualizado
					, @objeto_contratual = '$objeto_contratual'
					, @dia_pagamento = $dia_pagamento
					, @dia_pagamento_corridos = $dia_pagamento_corridos
					, @prazo_alerta_dias_pagamento = $prazo_alerta_dias_pagamento
					, @prazo_alerta_dias_ateste = $prazo_alerta_dias_ateste
					, @prazo_alerta_dias_nota_fiscal = $prazo_alerta_dias_nota_fiscal
					, @prazo_alerta_meses_fim_vigencia = $prazo_alerta_meses_fim_vigencia
					, @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function alterar($id_contrato, $numero_processo, $numero_ordem_servico, $data_assinatura,
							$data_inicio_vigencia, $data_fim_vigencia, $valor_global_inicial,
							$valor_global_atualizado, $objeto_contratual, $dia_pagamento,
							$dia_pagamento_corridos, $prazo_alerta_dias_pagamento,
							$prazo_alerta_dias_ateste, $prazo_alerta_dias_nota_fiscal,
							$prazo_alerta_meses_fim_vigencia, $usuario_alteracao) {
		$sql = "EXEC [contratos].[contrato_alterar]
					  @id_contrato = $id_contrato
					, @numero_processo = '$numero_processo'
					, @numero_ordem_servico = $numero_ordem_servico
					, @data_assinatura = $data_assinatura
					, @data_inicio_vigencia = $data_inicio_vigencia
					, @data_fim_vigencia = $data_fim_vigencia
					, @valor_global_inicial = $valor_global_inicial
					, @valor_global_atualizado = $valor_global_atualizado
					, @objeto_contratual = '$objeto_contratual'
					, @dia_pagamento = $dia_pagamento
					, @dia_pagamento_corridos = $dia_pagamento_corridos
					, @prazo_alerta_dias_pagamento = $prazo_alerta_dias_pagamento
					, @prazo_alerta_dias_ateste = $prazo_alerta_dias_ateste
					, @prazo_alerta_dias_nota_fiscal = $prazo_alerta_dias_nota_fiscal
					, @prazo_alerta_meses_fim_vigencia = $prazo_alerta_meses_fim_vigencia
					, @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function alterarAlertas($id_contrato) {
		$sql = "";
		$rst = conexao::execute($sql);
		//return odbc_result($rst, 1);
		return "1_Contrato alterado com sucesso.";
	}

	public function inserirTipoPenalidade($id_contrato, $id_tipo_penalidade) {
		$sql = "EXEC [contratos].[contrato_tipo_penalidade_inserir] @id_contrato = $id_contrato,
				@id_tipo_penalidade = $id_tipo_penalidade";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function removerTiposPenalidade($id_contrato) {
		$sql = "EXEC [contratos].[contrato_tipo_penalidade_remover] @id_contrato = $id_contrato";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}
}