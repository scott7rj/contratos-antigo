<?php
include_once "../classes/conexao.php";
include_once "../classes/tipo_documento.php";

try {
	$tipoDocumentoBO = new tipo_documento();
	$tiposDocumento = $tipoDocumentoBO->selecionarTiposDocumento();
	$result = "";

	foreach($tiposDocumento as $tipoDocumento) {
		$validade = $tipoDocumento->getPossui_validade() ? "SIM" : "NÃO";
		$result .= "
		<tr>
			<td>{$tipoDocumento->getNm_tipo_documento()}</td>
			<td>{$tipoDocumento->getDominio_documento()}</td>
			<td>{$validade}</td>
			<td align='center'>
				<a href='#' onclick='removerTipoDocumento({$tipoDocumento->getId_tipo_documento()})'>x</a>
			</td>
		</tr>";
	}

	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
