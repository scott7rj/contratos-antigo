<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";
include_once "../classes/tipo_documento.php";
include_once "../classes/documento.php";
include_once "../util/mask.php";

	// Testes de perfil =========================
	// 1 = Operacional, 2 = Gestor, 3 = Contratos
	$id_perfil 			  = $_GET["p"];
	// ==========================================

	$log_user 			  = $_SESSION['log_user'];
	$id_ateste_pagamento  = $_GET["id_ateste"];
	$existe_empresa 	  = ($id_empresa == 0 ? 0 : 1);
	$id_dominio_documento = "3";

	$ats = new ateste();
	$tpd = new tipo_documento();
	$doc = new documento();

	$atestes 		 = $ats->selecionarAtestesPorIdAtestePagamento($id_ateste_pagamento);
	$parcelas_siplo	 = $ats->selecionarParcelasSiploPorIdAtestePagamento($id_ateste_pagamento);
	$tipos_documento = $tpd->selecionarTiposDocumentoPorIdDominioDocumento($id_dominio_documento);
	$documentos 	 = $doc->selecionarDocumentosPorIdAtestePagamento($id_ateste_pagamento);

	$atp = $ats->selecionarPorId($id_ateste_pagamento);
	$empresa 		  = $atp->getEmpresa();
	$contrato 		  = $atp->getContrato();
	$competencia	  = $atp->getCompetencia();
	$observacao		  = $atp->getObservacao();
?>

<style type="text/css">
input {
	text-align: center;
	width: 100%;
}
.smart-form section {
	margin-bottom: 5px;
}
.bt {
	width: 15%;
}
</style>

<div class="modal-header">
	<button type="button" class="close" data-dismiss="modal" aria-label="Close">X</button>
	<h4 class="modal-title"><b>ATESTE DE PAGAMENTO</b></h4>
</div>
<div class="modal-body">

	<div class="row" style="margin-bottom: 10px;">
		<div class="col-md-4">
			Empresa
			<br><b><?php echo $empresa?></b>
		</div>
		<div class="col-md-3">
			Contrato
			<br><b><?php echo $contrato?></b>
		</div>
		<div class="col-md-3">
			Competência
			<br><b><?php echo $competencia?></b>
		</div>
	</div>

	<ul id="myTab1" class="nav nav-tabs bordered">
		<li id="valores" class="active">
			<a href="#t1" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-dollar text-primary"></i> 
				Valores
			</a>
		</li>
		<li id="documentos" class="">
			<a href="#t2" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-file text-primary"></i> 
				Documentos
			</a>
		</li>
	</ul>

	<div id="myTabContent1" class="tab-content padding-10">

		<div class="tab-pane fade in active" id="t1">
			<div class="row">

			<div class="col-md-12">
				<table class="table table-bordered">
					<thead>
						<th style="width: 32%">ITEM</th>
						<th style="width: 32%">SUBITEM</th>
						<th style="width: 14%" class="text-center">QUANTIDADE</th>
						<th style="width: 14%" class="text-center">VALOR</th>
						<th style="width: 08%" class="text-center">HMG</th>
					</thead>
					<tbody id="tbody_atestes">
						<?php
							foreach ($atestes as $at) {
								$id_ateste 	= $at->getIdAteste();
								$item		= $at->getItem();
								$subitem 	= $at->getSubitem();
								$qtd 		= $at->getQtd();
								$valor 		= $at->getValor();
								$homologado	= $at->getHomologado();
						?>
						<tr id="ateste<?php echo $id_ateste?>">
							<td><?php echo $item?></td>
							<td><?php echo $subitem?></td>
							<td align="center">
								<?php if($id_perfil == 3) { ?>
								<div class="qtd"><?= $qtd?></div>
								<?php } else { ?>
								<input type="text" class="qtd" name="qtd" value="<?= $qtd?>">
								<?php } ?>
							</td>
							<td align="center">
								<?php if($id_perfil == 3) { ?>
								<div class="valor"><?= $valor?></div>
								<?php } else { ?>
								<input type="text" class="valor" name="valor" value="<?= $valor?>">
								<?php } ?>
							</td>
							<td align="center">
								<?php
									if($id_perfil <> 2)
										echo ($homologado ? "Sim" : "Não");
									else {
								?>
								<form class="smart-form">
									<label class="toggle">
										<input type="checkbox" class="hmg" name="homologado" <?php echo ($homologado ? "checked" : "")?>>
										<i data-swchon-text="SIM" data-swchoff-text="NÃO"></i>
									</label>
								</form>
								<?php } ?>
							</td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</div>

			<?php if($id_perfil == 3) { ?>
			<div class="col-md-12">
				<div class="col-md-4">
					Parcelas SIPLO
				</div>
				<div class="col-md-8" style="padding-right: 0px;">
					<form class="smart-form" id="form_nova_parcela_siplo">
						<input type="hidden" name="id_ateste_pagamento" value="<?php echo $id_ateste_pagamento?>">
						<section class="col col-2">
							<label class="label">Nova parcela : </label>
						</section>
						<section class="col col-5">
							<label class="input">
								<input type="text" class="input-xs" name="descricao" placeholder="Descrição" required>
							</label>
						</section>
						<section class="col col-3">
							<label class="input">
								<input type="text" class="input-xs valor_siplo" name="valor" placeholder="Valor" required>
							</label>
						</section>
						<section class="col col-2">
							<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
						</section>
					</form>
				</div>
				<table class="table table-bordered">
					<thead>
						<th style="width: 78%;">DESCRIÇÃO</th>
						<th class="text-center" style="width: 14%;">VALOR</th>
						<th class="text-center" style="width: 8%;">X</th>
					</thead>
					<tbody id="tbody_parcelas">
					</tbody>
				</table>
			</div>
			<?php } ?>

			<div class="col-md-12">
				<form id="form_observacao" class="smart-form">
					<input type="hidden" name="id_ateste_pagamento" value="<?php echo $id_ateste_pagamento?>">
					<fieldset style="padding-top: 0px;">
						<section class="col col-12" style="width: 100%;">
							<label class="label">Observações</label>
							<label class="textarea">
								<textarea rows="2" class="custom-scroll" name="observacao"><?php echo $observacao?></textarea>
							</label>
						</section>
					</fieldset>
				</form>
			</div>

			</div>
		</div>

		<?php
			//parametros de include da tab documentos, que é comum a todos os dominios
			$id_tab = 't2';
			$id_dominio_hidden = $id_ateste_pagamento;

			include 'documento_tab_inserir_alterar.php';
		?>

	</div>

</div>

<script src="js/jquery.mask.js"></script>
<script src="js/ateste.js"></script>
<script src="js/documento.js"></script>

<script>
$(document).ready(function() {
	pageSetUp();

	montarListaParcelasSiplo();
});
</script>
