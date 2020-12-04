<?php
	session_start();

	if (isset($_SESSION['log_user']))
		$log_user = $_SESSION['log_user'];
	else
		$log_user = '';

	$url = basename($_SERVER['PHP_SELF'],'.php');

	if($url <> "login") {
		if(!empty($log_user)) {
			$nome 		= $_SESSION['nome'];
			$id_funcao	= $_SESSION['id_funcao'];
			$funcao 	= $_SESSION['funcao'];
			$id_unidade	= $_SESSION['id_unidade'];
			$sg_unidade	= $_SESSION['sg_unidade'];
			$nm_unidade	= $_SESSION['nm_unidade'];
		} else {
			header("location:login.php");
			exit();
		}
	}

	if($log_user == "C137703") {
		ini_set('display_errors',1);
		ini_set('display_startup_erros',1);
		error_reporting(E_ALL);
	}

	include_once 'classes/conexao.php';
?>

<header id="header">
	<div id="log_user" style="display: none;"><?php echo $log_user?></div>

	<span id="logo">
		<a href="index.php" style="color: #fff">PORTAL DE CONTROLE E GESTÃO DE CONTRATOS</a>
	</span>

	<?php if($url <> "login") { ?>
	<ul class="header-dropdown-list hidden-xs">
		<li>
			<a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: #fff;">
				<span> <?php echo "Bem vindo ".strstr($nome, ' ', true); ?> </span><br>
				<span> <?php echo $id_unidade." - ".$sg_unidade; ?> </span>
				<span class="pull-right"><i class="fa fa-angle-down"></i></span>
			</a>
			<ul class="dropdown-menu pull-right">
				<li>
					<a href="parametros.php">
						<i class="fa fa-cogs"></i>&nbsp; Parâmetros
					</a>
				</li>
				<li class="divider"></li>
				<li>
					<a href="actions/usuario_logout.php">
						<i class="fa fa-power-off"></i>&nbsp; Sair
					</a>
				</li>
			</ul>
		</li>
	</ul>
	<?php } ?>

	<div>
		<div style="padding: 5px 10px 0px 0px;float: right">
			<img src="images/cartoes.png">
		</div>
	</div>

</header>

<div class="modal fade" id="modal" aria-hidden="true">
	<div class="modal-dialog" style="top: 3%;width: 960px;">
		<div class="modal-content"></div>
	</div>
</div>
