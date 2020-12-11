<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";

try {

	$id_contrato = $_POST["id_contrato"];

	$ateste = new ateste();
	$competencias = $ateste->selecionarCompetenciasPorIdContrato($id_contrato);
	$result = "";

	foreach($competencias as $cm) {
		$id_ateste 	 = $cm->getIdAteste();
		$competencia = $cm->getCompetencia();

		/*
		$result .= "<tr id='ateste{$id_ateste}'>
						<td align='center'>
							<a href='templates/ateste_modal_alterar.php?id_ateste={$id_ateste}' data-toggle='modal' data-target='#modal'>{$competencia}</a>
						</td>
					</tr>";
		*/


		// Result para testes de perfil (Original comentado acima)
		$result .= "<tr id='ateste{$id_ateste}'>
						<td align='center'>
							<a href='templates/ateste_modal_alterar2.php?id_ateste={$id_ateste}&p=1' data-toggle='modal' data-target='#modal'>{$competencia} - Operacional</a>
						</td>
						<td align='center'>
							<a href='templates/ateste_modal_alterar2.php?id_ateste={$id_ateste}&p=2' data-toggle='modal' data-target='#modal'>{$competencia} - Gestor</a>
						</td>
						<td align='center'>
							<a href='templates/ateste_modal_alterar2.php?id_ateste={$id_ateste}&p=3' data-toggle='modal' data-target='#modal'>{$competencia} - Contratos</a>
						</td>
					</tr>";
	}

	echo $result;

} catch (Exception $e) {
	echo $e->getMessage();
}