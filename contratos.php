<!DOCTYPE html>
<html lang="pt-br" style="background: none;">

	<head>
		<?php include __DIR__.'../templates/head.html' ?>
	</head>

	<body class="smart-style-2">
		<?php
			include_once 'templates/header.php';
			include_once 'classes/empresa.php';

			$emp = new empresa();
			$empresas = $emp->selecionarEmpresas(1);
		?>

		<div id="main" role="main" style="margin-left: 0px; border: 1px solid transparent;">

			<div id="content" style="padding-top: 20px">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<div class="col-md-10" style="font-size: 22px;font-weight: bold;">
						Manutenção de Contratos
						<form id="form_seleciona_empresa" class="smart-form">
							<fieldset style="padding-top: 0px;padding-left: 0px;">
								<section class="col col-4" style="padding-left: 0px;">
									<label class="label">SELECIONE A EMPRESA : </label>
									<label class="select">
										<select id="select_empresa" class="input-xs">
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
								</section>
							</fieldset>
						</form>
					</div>
					<div class="col-md-2">
						<a class="btn btn-default pull-right" href="templates/contrato_modal_inserir_alterar.php?id_contrato=0" data-toggle="modal" data-target="#modal" style="margin-bottom: 4px;">
							<i class="fa fa-plus"></i>
							Novo Contrato
						</a>
					</div>

					<div id="div_contratos_empresa" class="col-md-12" style="display: none;">
						<table id="table_lista_contrato" class="table table-bordered" style="margin:0; padding:0;">
							<thead>
								<th>Nº PROCESSO</th>
								<th>DATA INÍCIO</th>
								<th>DATA FIM</th>
								<th>TIPO</th>
								<th class="text-center" style="width: 7%;">EDITAR</th>
								<th class="text-center" style="width: 7%;">REMOVER</th>
							</thead>
							<tbody id="tbody_lista_contrato">
								<!-- js:montarListaContrato(id_empresa) -->
							</tbody>
						</table>
					</div>

				</div>
				<div class="col-md-1">
					<a class="pull-right" href="index.php">
						<i class="fa fa-mail-reply"></i>&nbsp; Voltar
					</a>
				</div>
			</div>

		</div>

		<?php include __DIR__.'../templates/foot.html' ?>
		<script src="js/contrato.js"></script>

		<script>
		$(document).ready(function() {
			pageSetUp();
			$('#select_empresa').focus();
		});
		</script>

	</body>

</html>
