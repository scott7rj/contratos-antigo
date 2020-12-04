<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_contato.php";

	$log_user = strtoupper(substr(getenv('LOGON_USER'),10));

	$tpc = new tipo_contato();
	$tipos_contato = $tpc->selecionarTiposContato();
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
	<h4 class="modal-title"><b>TIPOS DE CONTATO</b></h4>
</div>
<div class="modal-body">

	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">
			<form class="smart-form" id="novo_tipo_contato">
				<input type="hidden" name="usuario_alteracao" value="<?php echo $log_user?>">
				<fieldset>
					<div class="row">
						<section class="col col-10">
							<label class="label">NOVO TIPO DE CONTATO</label>
							<label class="input">
								<input type="text" class="input-xs" id="txt_tipo_contato" name="tipo_contato" id="txt_tipo_contato" required>
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
					<th colspan="2">Tipos de contato cadastrados</th>
				</thead>
				<tbody id="tbody_tipos_contato">
					<?php
						foreach ($tipos_contato as $tc) {
							$id_tipo_contato = $tc->getId_tipo_contato();
							$tipo_contato = $tc->getNm_tipo_contato();
					?>
					<tr><td><?php echo $tipo_contato?></td>
						<td align="center"><a href="#" onclick="removerTipoContato(<?php echo $id_tipo_contato ?>)">x</a></td>
					</tr>
					<?php } ?>
				</tbody>
			</table>
		</div>
	</div>

</div>

<script src="js/tipo_contato.js"></script>

<script>
$(document).ready(function() {
	pageSetUp();
	montarListaTipoContato();
});
</script>
