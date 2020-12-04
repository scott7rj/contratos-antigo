<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_contrato.php";

$log_user = strtoupper(substr(getenv('LOGON_USER'),10));
$tipoContratoBO = new tipo_contrato();
$tipos_contrato = $tipoContratoBO->selecionarTiposContrato();

?>

<style type="text/css">
.smart-form .input input {
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
	<h4 class="modal-title"><b>TIPOS DE CONTRATO</b></h4>
</div>
<div class="modal-body">

	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<form class="smart-form" id="frm_novo_tipo_contrato">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<div class="row">
						<section class="col col-10">
							<label class="label">NOVO TIPO DE CONTRATO</label>
							<label class="input">
								<input type="text" class="input-xs" id="txt_tipo_contrato" name="tipo_contrato" maxlength="50" required>
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
					<th colspan="2">Tipos de contrato cadastrados</th>
				</thead>
				<tbody id="tbody_tipos_contrato">
					<!-- montarListaTipoContrato() -->
				</tbody>
			</table>
		</div>
	</div>

</div>
<script src="js/tipo_contrato.js"></script>
<script>
$(document).ready(function() {
	pageSetUp();
	montarListaTipoContrato();
});
</script>
