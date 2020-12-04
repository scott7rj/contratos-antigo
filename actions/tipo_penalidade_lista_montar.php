<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_penalidade.php";

try {
	$tipoPenalidadeBO = new tipo_penalidade();
	$tiposPenalidade = $tipoPenalidadeBO->selecionarTiposPenalidade();
	$result = "";
	foreach($tiposPenalidade as $tipoPenalidade) {
		$result .= "
		<tr>
			<td>{$tipoPenalidade->getTipoPenalidade()}</td>
			<td align='center'><a href='#' onclick='removerTipoPenalidade({$tipoPenalidade->getIdTipoPenalidade()})'>x</a></td>
		</tr>";
	}
	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
