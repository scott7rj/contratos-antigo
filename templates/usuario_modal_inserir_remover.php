<?php
require_once "../classes/conexao.php";
require_once "../dao/usuario_dao.php";
require_once "../util/combo_builder.php";

$log_user = strtoupper(substr(getenv('LOGON_USER'),10));
$log_user = 'C110611';

$dao = new UsuarioDAO();
$lista = $dao->selecionarUsuarios();
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
	<h4 class="modal-title"><b>USUÁRIOS</b></h4>
</div>
<div class="modal-body">

	<div class="row">
		<div class="col-md-2"></div>
		<div class="col-md-6">
			<form class="smart-form" id="frm_novo_usuario">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<div class="row">
						<label class="label">MATRÍCULA</label>
						<label class="input">
							<input type="text" class="input-xs cleanChars" id="txt_id_usuario" name="idUsuario" size="4" maxlength="7" required>
						</label>
						<label class="label">NOME</label>
						<label class="input">
							<input type="text" class="input-xs cleanChars" id="txt_usuario" name="usuario" maxlength="100" required>
						</label>
						<label class="label">UNIDADE</label>
						<label class="select">
							<?= ComboBuilder::unidade('sel_id_unidade', 'input-xs', '300px', false, '') ?>
						</label>
						<label class="label">FUNÇÃO</label>
						<label class="select">
							<?= ComboBuilder::funcao('sel_id_funcao', 'input-xs', '300px', false, '') ?>
						</label>
						<label class="label">PERFIL</label>
						<label class="select">
							<?= ComboBuilder::perfil('sel_id_perfil', 'input-xs', '300px', false, '') ?>
						</label>
						<br>
						<button type="submit" class="btn btn-primary btn-xs">Inserir</button>
					</div>
				</fieldset>
			</form>
			<table class="table table-bordered">
				<thead>
					<th colspan="6">Usuários cadastrados</th>
				</thead>
				<tbody id="tbody_usuarios">
					<!-- montarListaUsuario() -->
				</tbody>
			</table>
		</div>
	</div>

</div>

<script src="js/usuario.js"></script>
<script>
$(document).ready(function() {
	pageSetUp();
	montarListaUsuario();
});

$('#txt_id_usuario').blur(function(){
	document.getElementById('txt_id_usuario').value = document.getElementById('txt_id_usuario').value.toUpperCase();
});

$('#txt_usuario').blur(function(){
	document.getElementById('txt_usuario').value = document.getElementById('txt_usuario').value.toUpperCase();
});


</script>
