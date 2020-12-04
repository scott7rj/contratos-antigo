<?php
include_once "../classes/conexao.php";
include_once "../classes/empresa.php";
include_once "../classes/contrato.php";
include_once "../classes/tipo_contrato.php";
include_once "../classes/tipo_penalidade.php";
include_once "../classes/compromisso_siplo.php";
include_once "../classes/item.php";
include_once "../classes/subitem.php";
include_once "../classes/tipo_documento.php";
include_once "../classes/documento.php";
include_once "../util/db_util.php";
include_once "../util/mask.php";

	$log_user 		 = $_SESSION['log_user'];
	$id_contrato 	 = $_GET["id_contrato"];
	$id_empresa 	 = $_GET["id_empresa"];
	$existe_contrato = ($id_contrato == 0 ? 0 : 1);

	if($existe_contrato) {
		$cn = new contrato();
		$contrato = $cn->selecionarPorId($id_contrato);
		$nm_empresa 					 = $contrato->getEmpresa();
		$tipo_contrato 					 = $contrato->getTipoContrato();
		$numero_processo 				 = $contrato->getNumeroProcesso();
		$numero_ordem_servico 			 = $contrato->getNumeroOrdemServico();
		$data_assinatura 				 = $contrato->getDataAssinatura();
		$data_inicio_vigencia 			 = $contrato->getDataInicioVigencia();
		$data_fim_vigencia 				 = $contrato->getDataFimVigencia();
		$dia_pagamento 					 = $contrato->getDiaPagamento();
		$dia_pagamento_corridos 		 = $contrato->getDiaPagamentoCorridos();
		$valor_global_inicial 			 = $contrato->getValorGlobalIncial();
		$valor_global_atualizado 		 = $contrato->getValorGlobalAtualizado();
		$objeto_contratual 				 = $contrato->getObjetoContratual();
		$prazo_alerta_dias_pagamento	 = $contrato->getPrazoAlertaDiasPagamento();
		$prazo_alerta_dias_ateste 		 = $contrato->getPrazoAlertaDiasAteste();
		$prazo_alerta_dias_nota_fiscal	 = $contrato->getPrazoAlertaDiasNotaFiscal();
		$prazo_alerta_meses_fim_vigencia = $contrato->getPrazoAlertaMesesFimVigencia();
	} else {
		$nm_empresa 			 		 = "";
		$tipo_contrato 			 		 = "";
		$numero_processo 		 		 = "";
		$numero_ordem_servico 	 		 = "";
		$data_assinatura 		 		 = "";
		$data_inicio_vigencia 	 		 = "";
		$data_fim_vigencia 		 		 = "";
		$dia_pagamento 			 		 = "";
		$dia_pagamento_corridos	 		 = "";
		$valor_global_inicial	 		 = "";
		$valor_global_atualizado 		 = "";
		$objeto_contratual 		 		 = "";
		$prazo_alerta_dias_pagamento 	 = "";
		$prazo_alerta_dias_ateste 		 = "";
		$prazo_alerta_dias_nota_fiscal 	 = "";
		$prazo_alerta_meses_fim_vigencia = "";
	}

	$modal_title = ($existe_contrato ? "ALTERAR CONTRATO - " . $numero_processo : "INSERIR NOVO CONTRATO");
	$sub_title 	 = ($existe_contrato ? "ALTERAR" : "INSERIR");

	$emp = new empresa();
	$tpc = new tipo_contrato();
	$tpn = new tipo_penalidade();
	$cms = new compromisso_siplo();
	$itm = new item();
	$sit = new subitem();
	$tpd = new tipo_documento();
	$doc = new documento();

	$id_dominio_documento = "2";
	$empresas 			= $emp->selecionarEmpresas(1);
	$tipos_contrato		= $tpc->selecionarTiposContrato();
	$tipos_penalidade	= $tpn->selecionarTiposPenalidadePorIdContrato($id_contrato, 1);
	$compromissos_siplo	= $cms->selecionarCompromissosSiploPorIdContrato($id_contrato);
	$itens 				= $itm->selecionarPorIdContrato($id_contrato);
	$tipos_documento    = $tpd->selecionarTiposDocumentoPorIdDominioDocumento($id_dominio_documento);
	$documentos 	    = $doc->selecionarDocumentosPorIdContrato($id_contrato);
?>

<style type="text/css">
.smart-form .input input,
.smart-form .select select {
	height: 24px;
	padding: 2px 10px;
	font-size: 11px;
	line-height: 1.5;
	text-align: left;
}
.bt {
	width: 15%;
}
</style>

<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">X</button>
	<h4 class="modal-title"><b><?php echo $modal_title?></b></h4>
</div>
<div class="modal-body">

	<ul id="myTab1" class="nav nav-tabs bordered">
		<li id="dados_gerais" class="active">
			<a href="#t1" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-book text-primary"></i>&nbsp;Dados Gerais
			</a>
		</li>
		<li id="penalidades" class="" style="display: <?php echo ($existe_contrato ? "block" : "none");?>;">
			<a href="#t2" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-warning text-primary"></i>&nbsp;Penalidades
			</a>
		</li>
		<li id="siplos" class="" style="display: <?php echo ($existe_contrato ? "block" : "none");?>;">
			<a href="#t3" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-barcode text-primary"></i>&nbsp;Códigos SIPLO
			</a>
		</li>
		<li id="itens" class="" style="display: <?php echo ($existe_contrato ? "block" : "none");?>;">
			<a href="#t4" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-list-ol text-primary"></i>&nbsp;Itens do Contrato
			</a>
		</li>
		<li id="documentos" class="" style="display: <?php echo ($existe_contrato ? "block" : "none");?>;">
			<a href="#t5" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-file text-primary"></i>&nbsp;Documentos
			</a>
		</li>
	</ul>

	<div id="myTabContent1" class="tab-content padding-10">

		<div class="tab-pane fade in active" id="t1">
			<form id="form_contrato" class="smart-form">
				<input type="hidden" id="hd_id_empresa" name="id_empresa" value="<?php echo $id_empresa?>">
				<input type="hidden" id="hd_id_contrato" name="id_contrato" value="<?php echo $id_contrato?>">
				<input type="hidden" name="existe_contrato" value="<?php echo $existe_contrato?>">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<?php if($existe_contrato) { ?>
				<input type="hidden" name="numero_processo" value="<?php echo $numero_processo?>">
				<?php } ?>
				<fieldset>
					<div class="row">
						<section class="col col-3">
							<label class="label">Empresa do contrato</label>
							<?php if($existe_contrato) { ?>
							<label class="label"><b><?php echo $nm_empresa?></b></label>
							<?php } else { ?>
							<label class="select">
								<select class="input-xs" name="id_empresa" required>
									<option></option>
									<?php
										foreach ($empresas as $empresa) {
											$id_empresa = $empresa->getId_empresa();
											$nm_empresa = $empresa->getEmpresa();
									?>
									<option value="<?php echo $id_empresa?>">
										<?php echo $nm_empresa?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
							<?php } ?>
						</section>
						<section class="col col-3">
							<label class="label">Tipo de contrato</label>
							<?php if($existe_contrato) { ?>
							<label class="label"><b><?php echo $tipo_contrato?></b></label>
							<?php } else { ?>
							<label class="select">
								<select class="input-xs" name="id_tipo_contrato" required>
									<option></option>
									<?php
										foreach ($tipos_contrato as $tipo_contrato) {
											$id_tipo_contrato = $tipo_contrato->getIdTipoContrato();
											$nm_tipo_contrato = $tipo_contrato->getTipoContrato();
									?>
									<option value="<?php echo $id_tipo_contrato?>">
										<?php echo $nm_tipo_contrato?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
							<?php } ?>
						</section>
						<section class="col col-3">
							<label class="label">Número do processo</label>
							<?php if($existe_contrato) { ?>
							<label class="label"><b><?php echo $numero_processo?></b></label>
							<?php } else { ?>
							<label class="input">
								<input type="text" class="input-xs" id="txt_numero_processo" name="numero_processo" value="<?php echo $numero_processo?>" required>
							</label>
							<?php } ?>
						</section>
						<section class="col col-3">
							<label class="label">Número da ordem de serviço</label>
							<label class="input">
								<input type="text" class="input-xs" id="txt_numero_ordem_servico" name="numero_ordem_servico" value="<?php echo $numero_ordem_servico?>" oninput="this.value = this.value.replace(/[^0-9.]/g, ''); this.value = this.value.replace(/(\..*)\./g, '$1');" maxlength="14">
							</label>
						</section>
					</div>
					<div class="row">
						<section class="col col-2">
							<label class="label">Data da assinatura</label>
							<label class="input">
								<input type="text" class="input-xs data text-center" name="data_assinatura" value="<?php echo $data_assinatura?>" required>
							</label>
						</section>
						<section class="col col-2">
							<label class="label">Início da vigência</label>
							<label class="input">
								<input type="text" class="input-xs data text-center" name="data_inicio_vigencia" value="<?php echo $data_inicio_vigencia?>" required>
							</label>
						</section>
						<section class="col col-2">
							<label class="label">Fim da vigência</label>
							<label class="input">
								<input type="text" class="input-xs data text-center" name="data_fim_vigencia" value="<?php echo $data_fim_vigencia?>" required>
							</label>
						</section>
						<section class="col col-2">
							<label class="label">Dia do pagamento</label>
							<label class="select">
								<select class="input-xs" name="dia_pagamento" required>
									<option></option>
									<?php
										for ($i=1; $i < 29; $i++) {
											$selected = ($i == $dia_pagamento ? "selected" : "");
									?>
									<option value="<?php echo $i?>" <?php echo $selected?>>
										<?php echo $i?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
						</section>
						<section class="col col-4">
							<label class="label">Contando dias : </label>
							<div class="inline-group">
								<label class="radio" style="margin-right: 5px;">
									<input type="radio" name="dia_pagamento_corridos" value="1" <?php echo ($dia_pagamento_corridos == 1 ? "checked" : "") ?>>
									<i></i>Corridos</label>
								<label class="radio" style="margin-right: 0px;">
									<input type="radio" name="dia_pagamento_corridos" value="0" <?php echo ($dia_pagamento_corridos == 0 ? "checked" : "") ?>>
									<i></i>Úteis</label>
							</div>
						</section>
					</div>
					<div class="row">
						<section class="col col-3">
							<label class="label">Valor global inicial</label>
							<label class="input">
								<input type="text" class="input-xs valor text-center" name="valor_global_inicial" value="<?php echo $valor_global_inicial?>" required>
							</label>
						</section>
						<section class="col col-3">
							<label class="label">Valor global atualizado</label>
							<label class="input">
								<input type="text" class="input-xs valor text-center" name="valor_global_atualizado" value="<?php echo $valor_global_atualizado?>">
							</label>
						</section>
					</div>
					<div class="row">
						<section class="col col-12" style="width: 100%;">
							<label class="label">Objeto contratual</label>
							<label class="textarea">
								<textarea rows="2" class="custom-scroll" name="objeto_contratual" required><?php echo $objeto_contratual;?></textarea>
							</label>
						</section>
					</div>
				</fieldset>
				<fieldset>
					<div class="row">
						<section class="col col-1">
							<label class="select">
								<select class="input-xs" name="dias_alerta_pagamento" required>
									<option></option>
									<?php
										for ($i=1; $i < 29; $i++) {
											$selected = ($i == $prazo_alerta_dias_pagamento ? "selected" : "");
									?>
									<option value="<?php echo $i?>" <?php echo $selected?>>
										<?php echo $i?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
						</section>
						<section class="col col-5">
							<label class="label">Dias para alerta de pagamento</label>
						</section>
						<section class="col col-1">
							<label class="select">
								<select class="input-xs" name="dias_alerta_ateste" required>
									<option></option>
									<?php
										for ($i=1; $i < 29; $i++) {
											$selected = ($i == $prazo_alerta_dias_ateste ? "selected" : "");
									?>
									<option value="<?php echo $i?>" <?php echo $selected?>>
										<?php echo $i?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
						</section>
						<section class="col col-5">
							<label class="label">Dias para alerta de ateste</label>
						</section>
					</div>
					<div class="row">
						<section class="col col-1">
							<label class="select">
								<select class="input-xs" name="dias_alerta_nota_fiscal" required>
									<option></option>
									<?php
										for ($i=1; $i < 29; $i++) {
											$selected = ($i == $prazo_alerta_dias_nota_fiscal ? "selected" : "");
									?>
									<option value="<?php echo $i?>" <?php echo $selected?>>
										<?php echo $i?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
						</section>
						<section class="col col-5">
							<label class="label">Dias para alerta de recebimento de nota fiscal</label>
						</section>
						<section class="col col-1">
							<label class="select">
								<select class="input-xs" name="meses_alerta_fim_vigencia" required>
									<option></option>
									<?php
										for ($i=1; $i < 13; $i++) {
											$selected = ($i == $prazo_alerta_meses_fim_vigencia ? "selected" : "");
									?>
									<option value="<?php echo $i?>" <?php echo $selected?>>
										<?php echo $i?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
						</section>
						<section class="col col-5">
							<label class="label">Meses para alerta de fim de vigência do contrato</label>
						</section>
					</div>
				</fieldset>
				<fieldset id="buttons_contrato" class="text-right">
					<button type="button" class="btn btn-default btn-xs bt" data-dismiss="modal">CANCELAR</button>
					<button type="submit" class="btn btn-primary btn-xs bt"><?php echo $sub_title?></button>
				</fieldset>
			</form>
		</div>

		<div class="tab-pane fade" id="t2">
			<form class="smart-form" id="form_penalidades">
				<input type="hidden" name="id_contrato" value="<?php echo $id_contrato?>">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<section>
						<div class="row">
							<?php
								foreach ($tipos_penalidade as $tipo_penalidade) {
									$id_tipo_penalidade = $tipo_penalidade->getIdTipoPenalidade();
									$nm_tipo_penalidade = $tipo_penalidade->getTipoPenalidade();
									$checked 			= ($tipo_penalidade->getChecked() ? "checked" : "");
							?>
							<label class="checkbox">
								<input type="checkbox" name="id_tipo_penalidade" value="<?php echo $id_tipo_penalidade?>" <?php echo $checked?>>
								<i></i><?php echo $nm_tipo_penalidade?>
							</label>
							<?php
								}
							?>
						</div>
					</section>
				</fieldset>
				<fieldset id="insere_altera_penalidades" class="text-right">
					<button type="button" class="btn btn-default btn-xs bt" data-dismiss="modal">CANCELAR</button>
					<button type="submit" class="btn btn-primary btn-xs bt">SALVAR</button>
				</fieldset>
			</form>
		</div>

		<div class="tab-pane fade" id="t3">
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<form class="smart-form" id="form_siplo">
						<input type="hidden" name="id_contrato" value="<?php echo $id_contrato?>">
						<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
						<fieldset>
							<section class="col col-8">
								<label class="label">Compromisso SIPLO</label>
								<label class="input">
									<input type="text" class="input-xs siplo text-center" id="txt_compromisso_siplo" name="compromisso_siplo" maxlength="14" placeholder="NNNNNN/AAAA-MZ ou BR">
								</label>
							</section>
							<section class="col col-2">
								<br>
								<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
							</section>
						</fieldset>
					</form>
					<table class="table table-bordered">
						<thead>
							<th colspan="2">Compromissos SIPLO cadastrados</th>
						</thead>
						<tbody id="compromissos_siplo">
							<?php
								foreach ($compromissos_siplo as $cs) {
									$id_compromisso_siplo 	  = $cs->getIdCompromissoSiplo();
									$codigo_compromisso_siplo = mask($cs->getCompromissoSiplo(),"######/####-##");
							?>
							<tr id="cs<?php echo $id_compromisso_siplo?>">
								<td><?php echo $codigo_compromisso_siplo?></td>
								<td align="center">
									<a href='#' onclick='removerSIPLO(<?php echo $id_compromisso_siplo?>)'>x</a>
								</td>
							</tr>
							<?php } ?>
						</tbody>
					</table>
				</div>
				<div class="col-md-4"></div>
			</div>
		</div>

		<div class="tab-pane fade" id="t4">
			<div class="row">
				<div class="col-md-4">
					<form id="novo_item" class="smart-form">
						<input type="hidden" name="id_contrato" value="<?php echo $id_contrato?>">
						<section class="col col-10">
							<label class="label">Novo Item</label>
							<label class="input">
								<input type="text" class="input-xs" id="txt_item" name="item" maxlength="50" required> 
							</label>
						</section>
						<section class="col col-2">
							<br>
							<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
						</section>
					</form>
				</div>
			</div>
			<div class="row">
				<div class="col-md-10">
					<form id="novo_subitem" class="smart-form">
						<section class="col col-4">
							<label class="label">Novo Subitem</label>
							<label class="input">
								<input type="text" class="input-xs" id="txt_subitem" name="subitem" maxlength="50" required>
							</label>
						</section>
						<section class="col col-3">
							<label class="label">Item</label>
							<label class="select">
								<select id="select_itens" class="input-xs" name="id_item" required>
									<option></option>
									<?php
										foreach ($itens as $it) {
											$id_item = $it->getIdItem();
											$nm_item = $it->getItem();
									?>
									<option value="<?php echo $id_item?>">
										<?php echo $nm_item?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
						</section>
						<section class="col col-2">
							<label class="label">Quantidade</label>
							<label class="input">
								<input type="text" class="input-xs qtd" name="qtd" required>
							</label>
						</section>
						<section class="col col-2">
							<label class="label">Valor unitário</label>
							<label class="input">
								<input type="text" class="input-xs valor" name="valor_unitario" required>
							</label>
						</section>
						<section class="col col-1">
							<br>
							<button type="submit" class="btn btn-primary btn-xs">
								Inserir
							</button>
						</section>
					</form>
				</div>
			</div>
			<table class="table table-bordered">
				<thead>
					<th>Itens</th>
					<th>Subitens</th>
					<th class="text-center">X</th>
				</thead>
				<tbody id="itens_cadastrados">
					<!-- montarListaItens -->
				</tbody>
			</table>
		</div>

		<?php
			//parametros de include da tab documentos, que é comum a todos os dominios
			$id_tab = 't5';
			$id_dominio_hidden = $id_contrato;

			include 'documento_tab_inserir_alterar.php';
		?>

	</div>

</div>

<script src="js/jquery.mask.js"></script>
<script src="js/contrato.js"></script>
<script src="js/compromisso_siplo.js"></script>
<script src="js/item.js"></script>
<script src="js/subitem.js"></script>
<script src="js/documento.js"></script>

<script>
$(document).ready(function() {
	pageSetUp();
	montarListaItens(<?=$id_contrato?>, "table");
});

$('#txt_numero_processo').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_numero_processo').val());
	$('#txt_numero_processo').val(limpa.toUpperCase());
});
$('#txt_compromisso_siplo').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_compromisso_siplo').val());
	$('#txt_compromisso_siplo').val(limpa.toUpperCase());
});
$('#txt_item').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_item').val());
	$('#txt_item').val(limpa.toUpperCase());
});
$('#txt_subitem').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_subitem').val());
	$('#txt_subitem').val(limpa.toUpperCase());
});

</script>
