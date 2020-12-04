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
					<div class="col-md-12" style="font-size: 22px;font-weight: bold;">
						Manutenção de Atestes
						<form id="form_seleciona_empresa_contrato" class="smart-form">
							<fieldset style="padding-top: 0px;padding-left: 0px;">
								<section class="col col-3" style="padding-left: 0px;">
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
								<section class="col col-3" style="padding-left: 0px;">
									<label class="label">SELECIONE O CONTRATO / NºPROCESSO : </label>
									<label class="select">
										<select id="select_contrato" class="input-xs">
											<!-- js:montarListaContratos(id_empresa) -->
										</select> <i></i>
									</label>
								</section>
							</fieldset>
						</form>
					</div>

					<div id="div_competencias" class="col-md-12" style="display: none;width: 20%;">
						<table class="table table-bordered" style="margin:0; padding:0;">
							<thead>
								<th>COMPETÊNCIA</th>
							</thead>
							<tbody id="tbody_competencias">
								<!-- js:montarListaCompetencias -->
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

		<script src="js/jquery-2.1.1.min.js"></script>
		<script src="js/jquery-ui-1.10.3.min.js"></script>
		<script src="js/jquery.mask.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/notification.min.js"></script>
		<script src="js/app.config.js"></script>
		<script src="js/app.min.js"></script>
		<script src="js/ateste.js"></script>

		<script>
		$(document).ready(function() {
			pageSetUp();
		});
		</script>

	</body>

</html>
