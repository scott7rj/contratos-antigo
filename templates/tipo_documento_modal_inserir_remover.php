<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_documento.php";

	$log_user = strtoupper(substr(getenv('LOGON_USER'),10));

	$tpd = new tipo_documento();
	$tipos_documento = $tpd->selecionarTiposDocumento();
	$dominios_tipo_documento = $tpd->selecionarDominiosTipoDocumento();
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
	<h4 class="modal-title"><b>TIPOS DE DOCUMENTO</b></h4>
</div>
<div class="modal-body">

	<div class="row">
		<form class="smart-form" id="novo_tipo_documento">
			<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
			<fieldset>
				<div class="row">
					<section class="col col-5">
						<label class="label">NOVO TIPO DE DOCUMENTO</label>
						<label class="input">
							<input type="text" class="input-xs" id="txt_tipo_documento" name="tipo_documento" maxlength="50" required>
						</label>
					</section>
					<section class="col col-3">
						<label class="label">DOMÍNIO</label>
						<label class="select">
							<select class="input-xs" name="id_dominio_documento" required>
								<option></option>
								<?php
									foreach ($dominios_tipo_documento as $dt) {
										$id_dominio_documento = $dt->getId_dominio_documento();
										$nm_dominio_documento = $dt->getDominio_documento();
								?>
								<option value="<?php echo $id_dominio_documento?>"><?php echo $nm_dominio_documento?></option>
								<?php
									}
								?>
							</select> <i></i>
						</label>
					</section>
					<section class="col col-3">
						<label class="label">POSSUI VALIDADE</label>
						<label class="select">
							<select class="input-xs" name="possui_validade" required>
								<option></option>
								<option value="0">NÃO</option>
								<option value="1">SIM</option>
							</select> <i></i>
						</label>
					</section>
					<section class="col col-1">
						<br>
						<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
					</section>
				</div>
			</fieldset>
		</form>
		<table class="table table-bordered">
			<thead>
				<th colspan="4">Tipos de documento cadastrados</th>
			</thead>
			<tbody id="tbody_tipos_documento">
				
			</tbody>
		</table>
	</div>

</div>

<script src="js/tipo_documento.js"></script>

<script>
$(document).ready(function() {
	pageSetUp();
	montarListaTipoDocumento();
});
</script>
