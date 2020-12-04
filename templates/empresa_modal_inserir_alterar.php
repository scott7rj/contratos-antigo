<?php
include_once "../classes/conexao.php";
include_once "../classes/empresa.php";
include_once "../classes/telefone.php";
include_once "../classes/email.php";
include_once "../classes/tipo_contato.php";
include_once "../classes/tipo_documento.php";
include_once "../classes/documento.php";

	$log_user 		= $_SESSION['log_user'];
	$id_empresa 	= $_GET["id_empresa"];
	$existe_empresa	= ($id_empresa == 0 ? 0 : 1);

	$empresa = new empresa();

	if($existe_empresa) {
		$emp = $empresa->selecionarEmpresaPorId($id_empresa);
		$cnpj 			= $emp->getCnpj();
		$razao_social 	= $emp->getEmpresa();
		$endereco 		= $emp->getEndereco();
		$cidade 		= $emp->getCidade();
		$uf_empresa		= $emp->getUf();
		$cep 			= $emp->getCep();
		$observacao 	= $emp->getObservacao();
	} else {
		$cnpj 			= "";
		$razao_social 	= "";
		$endereco 		= "";
		$cidade 		= "";
		$uf_empresa		= "";
		$cep 			= "";
		$observacao 	= "";
	}

	$modal_title = ($existe_empresa ? "ALTERAR EMPRESA - ".$razao_social : "INSERIR NOVA EMPRESA");
	$sub_title 	 = ($existe_empresa ? "ALTERAR" : "INSERIR");

	$ufs = $empresa->selecionaUfs();

	$tel = new telefone();
	$eml = new email();
	$tpc = new tipo_contato();
	$tpd = new tipo_documento();
	$doc = new documento();

	$id_dominio_documento = "1";
	$telefones 	   	 = $tel->selecionarPorIdEmpresa($id_empresa);
	$emails 	   	 = $eml->selecionarPorIdEmpresa($id_empresa);
	$tipos_contato 	 = $tpc->selecionarTiposContato();
	$tipos_documento = $tpd->selecionarTiposDocumentoPorIdDominioDocumento($id_dominio_documento);
	$documentos 	 = $doc->selecionarDocumentosPorIdEmpresa($id_empresa);
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
				<i class="fa fa-fw fa-lg fa-building text-primary"></i> 
				Dados Gerais
			</a>
		</li>
		<li id="contatos" class="" style="display: <?php echo ($existe_empresa ? "block" : "none");?>;">
			<a href="#t2" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-group text-primary"></i> 
				Contatos
			</a>
		</li>
		<li id="documentos" class="" style="display: <?php echo ($existe_empresa ? "block" : "none");?>;">
			<a href="#t3" data-toggle="tab">
				<i class="fa fa-fw fa-lg fa-file text-primary"></i> 
				Documentos
			</a>
		</li>
	</ul>

	<div id="myTabContent1" class="tab-content padding-10">

		<div class="tab-pane fade in active" id="t1">
			<h4 class="modal-title">
				<b><?php echo $sub_title?> DADOS DA EMPRESA</b>
			</h4>
			<form id="nova_empresa" class="smart-form">
				<input type="hidden" name="id_empresa" value="<?php echo $id_empresa?>">
				<input type="hidden" name="existe_empresa" value="<?php echo $existe_empresa?>">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<div class="row">
						<section class="col col-2">
							<label class="label">CNPJ</label>
							<label class="input">
								<input type="text" placeholder="99.999.999/9999-99" class="cnpj input-xs" name="cnpj" value="<?php echo $cnpj?>" required>
							</label>
						</section>
						<section class="col col-10">
							<label class="label">RAZÃO SOCIAL</label>
							<label class="input">
								<input type="text" class="input-xs" id="txt_empresa" name="empresa" value="<?php echo $razao_social?>" required>
							</label>
						</section>
					</div>
					<div class="row">
						<section class="col col-5">
							<label class="label">ENDEREÇO</label>
							<label class="input">
								<input type="text" class="input-xs" id="txt_endereco" name="endereco" value="<?php echo $endereco?>" required>
							</label>
						</section>
						<section class="col col-4">
							<label class="label">CIDADE</label>
							<label class="input">
								<input type="text" class="input-xs" id="txt_cidade" name="cidade" value="<?php echo $cidade?>" required>
							</label>
						</section>
						<section class="col col-1">
							<label class="label">UF</label>
							<label class="select">
								<select class="input-xs" name="uf" required>
									<option></option>
									<?php
										foreach ($ufs as $uf) {
											$selected = ($uf_empresa == $uf ? "selected" : "");
									?>
									<option value="<?php echo $uf?>" <?php echo $selected?>>
										<?php echo $uf?>
									</option>
									<?php
										}
									?>
								</select> <i></i>
							</label>
						</section>
						<section class="col col-2">
							<label class="label">CEP</label>
							<label class="input">
								<input type="text" placeholder="99999-999" class="cep input-xs" name="cep" value="<?php echo $cep?>" required>
							</label>
						</section>
					</div>
					<div class="row">
						<section class="col col-12" style="width: 100%;">
							<label class="label">OBSERVAÇÕES</label>
							<label class="textarea">
								<textarea rows="2" class="custom-scroll" id="txt_observacao" name="observacao"><?php echo $observacao;?></textarea>
							</label>
						</section>
					</div>
				</fieldset>
				<fieldset id="insere_nova_empresa" class="text-right">
					<button type="button" class="btn btn-default btn-xs bt" data-dismiss="modal">CANCELAR</button>
					<button type="submit" class="btn btn-primary btn-xs bt"><?php echo $sub_title?></button>
				</fieldset>
			</form>
		</div>

		<div class="tab-pane fade" id="t2">
			<h4 class="modal-title">
				<b><?php echo $sub_title?> CONTATOS DA NOVA EMPRESA</b>
			</h4>
			<div class="row">
			<div class="col-md-6">
				<form class="smart-form" id="novo_telefone">
					<input type="hidden" name="id_empresa" value="<?php echo $id_empresa?>">
					<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
					<fieldset>
						<div class="row">
							<section class="col col-5">
								<label class="label">TELEFONE</label>
								<label class="input">
									<input type="text" class="telefone input-xs" name="telefone" required>
								</label>
							</section>
							<section class="col col-5">
								<label class="label">TIPO DE CONTATO</label>
								<label class="select">
									<select class="input-xs" name="id_tipo_contato" required>
										<option></option>
										<?php
											foreach ($tipos_contato as $tc) {
												$id_tipo_contato = $tc->getId_tipo_contato();
												$tipo_contato 	 = $tc->getNm_tipo_contato();
										?>
										<option value="<?php echo $id_tipo_contato?>">
											<?php echo $tipo_contato?>
										</option>
										<?php
											}
										?>
									</select> <i></i>
								</label>
							</section>
							<section class="col col-2">
								<br>
								<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
							</section>
						</div>
					</fieldset>
				</form>
				<table class="table table-bordered">
					<thead>
						<th colspan="3">Telefones cadastrados</th>
					</thead>
					<tbody id="telefones">
						<?php
							foreach ($telefones as $tl) {
								$id_telefone  = $tl->getId_telefone();
								$telefone 	  = $tl->getTelefone();
								$tipo_contato = $tl->getTipo_contato();
						?>
						<tr id="telefone<?php echo $id_telefone?>">
							<td><div class="telefone"><?php echo $telefone?></div></td>
							<td><?php echo $tipo_contato?></td>
							<td align="center">
								<a href='#' onclick='removerTelefone(<?php echo $id_telefone?>)'>x</a>
							</td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</div>
			<div class="col-md-6">
				<form class="smart-form" id="novo_email">
					<input type="hidden" name="id_empresa" value="<?php echo $id_empresa?>">
					<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
					<fieldset>
						<div class="row">
							<section class="col col-5">
								<label class="label">EMAIL</label>
								<label class="input">
									<input type="text"¨id="txt_email" name="email" required>
								</label>
							</section>
							<section class="col col-5">
								<label class="label">TIPO DE CONTATO</label>
								<label class="select">
									<select class="input-xs" name="id_tipo_contato" required>
										<option></option>
										<?php
											foreach ($tipos_contato as $tc) {
												$id_tipo_contato = $tc->getId_tipo_contato();
												$tipo_contato 	 = $tc->getNm_tipo_contato();
										?>
										<option value="<?php echo $id_tipo_contato?>">
											<?php echo $tipo_contato?>
										</option>
										<?php
											}
										?>
									</select> <i></i>
								</label>
							</section>
							<section class="col col-2">
								<br>
								<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
							</section>
						</div>
					</fieldset>
				</form>
				<table class="table table-bordered">
					<thead>
						<th colspan="3">Emails cadastrados</th>
					</thead>
					<tbody id="emails">
						<?php
							foreach ($emails as $em) {
								$id_email 	  = $em->getId_email();
								$email 		  = $em->getEmail();
								$tipo_contato = $em->getTipo_contato();
						?>
						<tr id="email<?php echo $id_email?>">
							<td><?php echo $email?></td>
							<td><?php echo $tipo_contato?></td>
							<td align="center">
								<a href='#' onclick='removerEmail(<?php echo $id_email?>)'>x</a>
							</td>
						</tr>
						<?php } ?>
					</tbody>
				</table>
			</div>
			</div>
		</div>

		<?php
			//parametros de include da tab documentos, que é comum a todos os dominios
			$id_tab = 't3';
			$id_dominio_hidden = $id_empresa;

			include 'documento_tab_inserir_alterar.php';
		?>

	</div>

</div>

<script src="js/jquery.mask.js"></script>
<script src="js/empresa.js"></script>
<script src="js/telefone.js"></script>
<script src="js/email.js"></script>
<script src="js/documento.js"></script>

<script>
$(document).ready(function() {
	pageSetUp();
});

$('#txt_empresa').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_empresa').val());
	$('#txt_empresa').val(limpa.toUpperCase());
});
$('#txt_endereco').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_endereco').val());
	$('#txt_endereco').val(limpa.toUpperCase());
});
$('#txt_cidade').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_cidade').val());
	$('#txt_cidade').val(limpa.toUpperCase());
});
$('#txt_email').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_email').val());
	$('#txt_email').val(limpa.toUpperCase());
});
$('#txt_observacao').blur(function(){
	let limpa = removerAspas($('#txt_observacao').val());
	$('#txt_observacao').val(limpa);
});

</script>
