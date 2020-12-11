<!DOCTYPE html>
<html lang="pt-br" style="background: none;">

	<head>
		<?php include __DIR__.'../templates/head.html' ?>
	</head>

	<body class="smart-style-2">

		<?php
			include_once 'templates/header.php';
		?>

		<style type="text/css">
			li {
				padding-bottom: 8px;
			}
		</style>

		<div id="main" role="main" style="margin-left: 0px">

			<div id="content" style="padding-top: 20px;font-size: 18px;">
				<div class="col-md-1"></div>
				<div class="col-md-10">
				<h1><b>PARÂMETROS</b></h1>
					<ul>
						<li>
							<a href="templates/tipo_contato_modal_inserir_remover.php" data-toggle="modal" data-target="#modal">
								<i class="fa fa-comments"></i> Tipos de contato
							</a>
						</li>
						<li>
							<a href="templates/tipo_documento_modal_inserir_remover.php" data-toggle="modal" data-target="#modal">
								<i class="fa fa-files-o"></i> Tipos de documento
							</a>
						</li>
						<li>
							<a href="templates/tipo_contrato_modal_inserir_remover.php" data-toggle="modal" data-target="#modal">
								<i class="fa fa-cubes"></i> Tipos de contrato
							</a>
						</li>
						<li>
							<a href="templates/tipo_penalidade_modal_inserir_remover.php" data-toggle="modal" data-target="#modal">
								<i class="fa fa-flag"></i> Tipos de penalidade
							</a>
						</li>
						<li>
							<a href="templates/unidade_modal_inserir_remover.php" data-toggle="modal" data-target="#modal">
								<i class="fa fa-building"></i> Unidades
							</a>
						</li>
						<li>
							<a href="templates/funcao_modal_inserir_remover.php" data-toggle="modal" data-target="#modal">
								<i class="fa fa-briefcase"></i> Funções
							</a>
						</li>
						<li>
							<a href="templates/perfil_modal_inserir_remover.php" data-toggle="modal" data-target="#modal">
								<i class="fa fa-group"></i> Perfis
							</a>
						</li>
						<li>
							<a href="templates/usuario_modal_inserir_remover.php" data-toggle="modal" data-target="#modal">
								<i class="fa fa-user"></i> Usuários
							</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="col-md-1">
				<a class="pull-right" href="javascript:history.back()">
					<i class="fa fa-mail-reply"></i>&nbsp; Voltar
				</a>
			</div>
		</div>

		<?php include __DIR__.'../templates/foot.html' ?>

		<script>
		$(document).ready(function() {
			pageSetUp();
		});
		</script>

	</body>

</html>
