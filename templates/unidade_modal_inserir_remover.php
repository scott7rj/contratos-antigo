<?php
include_once "../classes/conexao.php";
include_once "../dao/unidade_dao.php";

$log_user = strtoupper(substr(getenv('LOGON_USER'),10));
$log_user = 'C110611';

$dao = new UnidadeDAO();
$lista = $dao->selecionarUnidades();
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
	<h4 class="modal-title"><b>UNIDADES</b></h4>
</div>
<div class="modal-body">

	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-6">
			<form class="smart-form" id="frm_nova_unidade">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<div class="row">
						<label class="label">CÓDIGO DA UNIDADE</label>
						<label class="input">
							<input type="text" class="input-xs cleanChars" id="txt_id_unidade" name="idUnidade" size="4" maxlength="4" required>
						</label>
						<label class="label">UNIDADE</label>
						<label class="input">
							<input type="text" class="input-xs cleanChars" id="txt_unidade" name="unidade" maxlength="50" required>
						</label>
						<br>
						<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
					</div>
				</fieldset>
			</form>
			<table class="table table-bordered">
				<thead>
					<th colspan="3">Unidades cadastradas</th>
				</thead>
				<tbody id="tbody_unidades">
					<!-- montarListaUnidade() -->
				</tbody>
			</table>
		</div>
	</div>

</div>

<script src="js/unidade.js"></script>
<script>
$(document).ready(function() {
	pageSetUp();
	montarListaUnidade();
	$('#txt_id_unidade').mask('0000', {clearIfNotMatch: true});

});
</script>
