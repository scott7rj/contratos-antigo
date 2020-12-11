
<?php //require_once __DIR__."../dao/usuario_dao.php"; ?>
<!DOCTYPE html>
<html lang="pt-br" style="background: none;">

	<head>
		<?php include __DIR__.'../templates/head.html' ?>
	</head>

	<body class="smart-style-2">

		<?php
			include_once 'templates/header.php';
		?>

		<div id="main" role="main" style="margin-left: 0px;">

			<div id="content" style="padding-top: 100px;">

				<div class="col-xs-12 col-sm-12 col-md-5 col-lg-2 col-lg-offset-5" align="center">
					<div class="well no-padding">
						<form id="login_form" class="smart-form client-form" action="login.php"  method="post">
							<!-- <header><b>Login</b></header> -->
							<fieldset>
								<section>
									<label class="input">
										<i class="icon-append fa fa-user"></i>
										<input type="text" name="log_user" placeholder="USUÁRIO" required autofocus>
									</label>
								</section>

								<section>
									<label class="input">
										<i class="icon-append fa fa-lock"></i>
										<input type="password" name="password" placeholder="SENHA" required>
									</label>
								</section>

								<section class="text-center">
									<button class="btn bg-color-blueDark txt-color-white" style="width: 30%;">Entrar</button>
								</section>
							</fieldset>
						</form>
					</div>
					<div class="text-danger">
						<?php
							if(isset($_POST["password"])) {
								$log_user	= $_POST["log_user"];
								$password	= $_POST["password"];
								$acessoLdap	= conexao::acessoLdap($log_user, $password);

								if($acessoLdap == 1) {
									//recuperando o perfil do usuario
									$sql = "SELECT * FROM [contratos].[fn_usuario_selecionar_por_id]('$log_user')";
									$rst = conexao::execute($sql);
									$array = odbc_fetch_array($rst);
									if (sizeof($array) == 0) {
										$_SESSION["id_perfil"] = 0;
										$_SESSION["perfil"] = "SEM PERFIL";
									} else {
										foreach($array as $item) {
											$_SESSION["id_perfil"] = $item["id_perfil"];
											$_SESSION["perfil"] = $item["perfil"];
											break;
										}
									}
									header("location:index.php");
									exit();
								} else {
									echo utf8_decode($acessoLdap);
								}
							}
						?>
					</div>
				</div>

			</div>

		</div>

	</body>

</html>
