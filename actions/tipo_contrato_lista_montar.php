<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_contrato.php";

try {
	$tipoContratoBO = new tipo_contrato();
	$tiposContrato = $tipoContratoBO->selecionarTiposContrato();
	$result = "";

	foreach($tiposContrato as $tipoContrato) {
		$result .= "
		<tr>
			<td>{$tipoContrato->getTipoContrato()}</td>
			<td align='center'><a href='#' onclick='removerTipoContrato({$tipoContrato->getIdTipoContrato()})'>x</a></td>
		</tr>";
	}
	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
