<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_penalidade.php";

$log_user = strtoupper(substr(getenv('LOGON_USER'),10));
$tipoPenalidadeBO = new tipo_penalidade();
$tipos_penalidade = $tipoPenalidadeBO->selecionarTiposPenalidade();
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
	<h4 class="modal-title"><b>TIPOS DE PENALIDADE</b></h4>
</div>
<div class="modal-body">

	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-8">
			<form class="smart-form" id="frm_novo_tipo_penalidade">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<div class="row">
						<section class="col col-10">
							<label class="label">NOVO TIPO DE PENALIDADE</label>
							<label class="input">
								<input type="text" class="input-xs cleanChars" id="txt_tipo_penalidade" name="tipo_penalidade" required>
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
					<th colspan="2">Tipos de penalidade cadastrados</th>
				</thead>
				<tbody id="tbody_tipos_penalidade">
					<!-- montarListaTipoPenalidade() -->
				</tbody>
			</table>
		</div>
	</div>

</div>

<script src="js/tipo_penalidade.js"></script>
<script>
$(document).ready(function() {
	pageSetUp();
	montarListaTipoPenalidade();
});
</script>
