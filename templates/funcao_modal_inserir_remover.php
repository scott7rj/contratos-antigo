<?php
include_once "../classes/conexao.php";
include_once "../dao/funcao_dao.php";

$log_user = strtoupper(substr(getenv('LOGON_USER'),10));
$dao = new FuncaoDAO();
$lista = $dao->selecionarFuncoes();
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
	<h4 class="modal-title"><b>FUNÇÕES</b></h4>
</div>
<div class="modal-body">

	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-6">
			<form class="smart-form" id="frm_nova_funcao">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<div class="row">
						<label class="label">CÓDIGO DA FUNÇÃO</label>
						<label class="input">
							<input type="text" class="input-xs cleanChars" id="txt_id_funcao" name="idFuncao" size="4" maxlength="4" required>
						</label>
						<label class="label">FUNÇÃO</label>
						<label class="input">
							<input type="text" class="input-xs cleanChars" id="txt_funcao" name="funcao" maxlength="50" required>
						</label>
						<br>
						<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
					</div>
				</fieldset>
			</form>
			<table class="table table-bordered">
				<thead>
					<th colspan="3">Funções cadastradas</th>
				</thead>
				<tbody id="tbody_funcoes">
					<!-- montarListaFuncao() -->
				</tbody>
			</table>
		</div>
	</div>

</div>

<script src="js/funcao.js"></script>
<script>
$(document).ready(function() {
	pageSetUp();
	montarListaFuncao();
	$('#txt_id_funcao').mask('0000', {clearIfNotMatch: true});
});
</script>
