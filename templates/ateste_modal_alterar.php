<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";
include_once "../classes/tipo_documento.php";
include_once "../classes/documento.php";

	$log_user 			  = $_SESSION['log_user'];
	$id_ateste_pagamento  = $_GET["id_ateste"];
	$existe_empresa 	  = ($id_empresa == 0 ? 0 : 1);
	$id_dominio_documento = "3";

	// Temporário ==========
	//$perfil = "Contratos";
	$perfil = "Operacional";
	// =====================

	$ats = new ateste();
	$tpd = new tipo_documento();
	$doc = new documento();

	$atestes 		  = $ats->selecionarPorIdAtestePagamento($id_ateste_pagamento);
	$tipos_documento  = $tpd->selecionarTiposDocumentoPorIdDominioDocumento($id_dominio_documento);
	$documentos 	  = $doc->selecionarDocumentosPorIdAtestePagamento($id_ateste_pagamento);

	$atp = $ats->selecionarPorId($id_ateste_pagamento);
	$empresa 		  = $atp->getEmpresa();
	$contrato 		  = $atp->getContrato();
	$competencia	  = $atp->getCompetencia();
	$observacao		  = $atp->getObservacao();
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
	<h4 class="modal-title"><b>ATESTE DE PAGAMENTO</b></h4>
</div>
<div class="modal-body">

	<ul id="myTab1" class="nav nav-tabs bordered">
		<li id="dados_gerais" class="active">
			<a href="#t1" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-building text-primary"></i> 
				Dados Gerais
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
			<hr>
			<div class="row">
				<div class="col-md-12">
					<table class="table table-bordered">
						<thead>
							<th>ITEM</th>
							<th>SUBITEM</th>
							<th>QUANTIDADE</th>
							<th>VALOR</th>
						</thead>
						<tbody id="tbody_atestes">
							<?php foreach ($atestes as $at): ?>
							<tr>
								<td><?php echo $at->getItem();?></td>
								<td><?php echo $at->getSubitem();?></td>
								<td>
									<?php
										if($perfil == "Contratos") {
											echo $at->getQtd();
										} else {
									?>
									<input type="text" name="qtd" maxlength="9">
									<?php
										}
									?>
								</td>
								<td>
									<?php
										if($perfil == "Contratos") {
											echo $at->getValor();
										} else {
									?>
									<input type="text" name="valor">
									<?php
										}
									?>
								</td>
							</tr>
							<?php endforeach ?>
						</tbody>
					</table>
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
});
</script>
