<?php
include_once "../classes/conexao.php";
include_once "../classes/ateste.php";

try {

	$id_ateste_pagamento = $_POST["id_ateste_pagamento"];

	$ateste = new ateste();
	$parcelas_siplo = $ateste->selecionarParcelasSiploPorIdAtestePagamento($id_ateste_pagamento);
	$result = "";

	foreach($parcelas_siplo as $ps) {
		$id_parcela_siplo = $ps->getIdParcelaSiplo();
		$descricao 		  = $ps->getObservacao();
		$valor 			  = $ps->getValor();

		$result .= "<tr id='ps{$id_parcela_siplo}'>
						<td>{$descricao}</td>
						<td align='center'><div class='valor'>{$valor}</div></td>
						<td align='center'>
							<a href='#' onclick='removerParcelaSiplo({$id_parcela_siplo})'>X</a>
						</td>
					</tr>";
	}

	echo $result;

} catch (Exception $e) {
	echo $e->getMessage();
}