<?php
include_once "../classes/conexao.php";
include_once "../dao/perfil_dao.php";

$log_user = strtoupper(substr(getenv('LOGON_USER'),10));
$dao = new PerfilDAO();
$lista = $dao->selecionarPerfis();
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
	<h4 class="modal-title"><b>PERFIS</b></h4>
</div>
<div class="modal-body">

	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-6">
			<form class="smart-form" id="frm_novo_perfil">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<div class="row">
						<label class="label">PERFIL</label>
						<label class="input">
							<input type="text" class="input-xs cleanChars" id="txt_perfil" name="perfil" maxlength="50" required>
						</label>
						<br>
						<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
					</div>
				</fieldset>
			</form>
			<table class="table table-bordered">
				<thead>
					<th colspan="2">Perfis cadastrados</th>
				</thead>
				<tbody id="tbody_perfis">
					<!-- montarListaPerfil() -->
				</tbody>
			</table>
		</div>
	</div>

</div>

<script src="js/perfil.js"></script>
<script>
$(document).ready(function() {
	pageSetUp();
	montarListaPerfil();

});
</script>
