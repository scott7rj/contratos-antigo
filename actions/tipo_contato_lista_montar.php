<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_contato.php";

try {
	$tipoContatoBO = new tipo_contato();
	$tiposContato = $tipoContatoBO->selecionarTiposContato();
	$result = "";
	foreach($tiposContato as $tipoContato) {
		$result .= "
		<tr>
			<td>{$tipoContato->getNm_tipo_contato()}</td>
			<td align='center'><a href='#' onclick='removerTipoContato({$tipoContato->getId_tipo_contato()})'>x</a></td>
		</tr>";
	}
	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
