<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";

try {

	$id_empresa	 = $_POST["id_empresa"];
	$id_contrato = $_POST["id_contrato"];

	$ateste = new ateste();
	$atestes = $ateste->selecionarPorIdEmpresaIdContrato($id_empresa, $id_contrato);
	$result = "";

	foreach($atestes as $at) {
		$id_ateste = $at->getIdAteste();
		$nm_ateste = $at->getAteste();

		$result .= "<tr id='ateste{$id_ateste}'>
						<td>{$nm_ateste}</td>
						<td align='center'>
							<a href='#' onclick='removerAteste({$id_ateste})'>x</a>
						</td>
					</tr>";
	}

	echo $result;

} catch (Exception $e) {
	echo $e->getMessage();
}
