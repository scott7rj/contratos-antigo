<!DOCTYPE html>
<html lang="pt-br" style="background: none;">

	<head>
		<?php include __DIR__.'../templates/head.html' ?>
	</head>

	<body class="smart-style-2">

		<?php
			include_once 'templates/header.php';
			include_once 'classes/empresa.php';
			include_once 'util/mask.php';

			$empresa = new empresa();
			$empresas = $empresa->selecionarEmpresas(1);
		?>

		<div id="main" role="main" style="margin-left: 0px">

			<div id="content" style="padding-top: 20px">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<div class="col-md-10" style="font-size: 22px;font-weight: bold;">
						Manutenção de Empresas
					</div>
					<div class="col-md-2" style="padding-right: 0px;">
						<a class="btn btn-default pull-right" href="templates/empresa_modal_inserir_alterar.php?id_empresa=0" data-toggle="modal" data-target="#modal" style="margin-bottom: 10px;">
							<i class="fa fa-plus"></i>
							Nova Empresa
						</a>
					</div>
					<table class="table">
						<thead>
							<th>CNPJ</th>
							<th>RAZÃO SOCIAL</th>
							<th>ENDEREÇO</th>
							<th class="text-center">EDITAR</th>
							<th class="text-center">REMOVER</th>
						</thead>
						<tbody id="empresas">
							<?php
								for($e=0 ; $e < count($empresas) ; $e++) {
									$emp = $empresas[$e];
									$id_empresa   = $emp->getId_empresa();
									$cnpj 		  = mask($emp->getCnpj(), '##.###.###/####-##');
									$razao_social = $emp->getEmpresa();
									$endereco 	  = $emp->getEndereco();
							?>
							<tr id="emp<?php echo $id_empresa?>">
								<td><?php echo $cnpj?></td>
								<td><?php echo $razao_social?></td>
								<td><?php echo $endereco?></td>
								<td align="center">
									<a href="templates/empresa_modal_inserir_alterar.php?id_empresa=<?php echo $id_empresa?>" data-toggle="modal" data-target="#modal">
										<i class="fa fa-edit"></i>
									</a>
								</td>
								<td align="center">
									<a href="#" onclick="removerEmpresa(<?php echo $id_empresa?>)">
										<i class="fa fa-times"></i>
									</a>
								</td>
							</tr>
							<?php } ?>
						</tbody>
					</table>
				</div>
				<div class="col-md-1">
					<a class="pull-right" href="javascript:history.back()">
						<i class="fa fa-mail-reply"></i>&nbsp; Voltar
					</a>
				</div>
			</div>

		</div>

		<?php include __DIR__.'../templates/foot.html' ?>
		<script src="js/empresa.js"></script>

		<script>
		$(document).ready(function() {
			pageSetUp();
		});
		</script>

	</body>

</html>
