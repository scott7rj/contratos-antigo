<!DOCTYPE html>
<html lang="pt-br" style="background: none;">

	<head>
		<?php include __DIR__.'../templates/head.html' ?>
		<style type="text/css">
			li {
				margin-bottom: 8px;
			}
		</style>
	</head>

	<body class="smart-style-2">

		<?php
			include_once 'templates/header.php';
		?>

		<div id="main" role="main" style="margin-left: 0px">

			<div id="content" style="padding-top: 20px;font-size: 18px;">
				<div style="padding-left: 30px;color: green;">
					<h2><b>AMBIENTE DE DESENVOLVIMENTO</b></h2>
				</div>
				<ul>
					<li>
						<a href="empresas.php">
							<i class="fa fa-building"></i> Manutenção de Empresas
						</a>
					</li>
					<li>
						<a href="contratos.php">
							<i class="fa fa-list-alt"></i> Manutenção de Contratos
						</a>
					</li>
					<li>
						<a href="atestes.php">
							<i class="fa fa-files-o"></i> Manutenção de Atestes
						</a>
					</li>
					<li>
						<a href="penalidades.php">
							<i class="fa fa-exclamation-circle"></i> Manutenção de Penalidades
						</a>
					</li>
				</ul>
			</div>

		</div>

		<script src="js/jquery-2.1.1.min.js"></script>
		<script src="js/jquery-ui-1.10.3.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/app.config.js"></script>
		<script src="js/app.min.js"></script>

		<script>
		$(document).ready(function() {
			pageSetUp();
		});
		</script>

	</body>

</html>
