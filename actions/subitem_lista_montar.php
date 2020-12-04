<?php
include_once "../classes/conexao.php";
include_once "../classes/subitem.php";

try {

	$id_item = $_POST["id_item"];

	$subitem = new subitem();
	$subitens = $subitem->selecionarPorIdItem($id_item);
	$result = "";

	foreach($subitens as $si) {
		$id_subitem		= $si->getIdSubitem();
		$nm_subitem		= $si->getSubitem();
		$qtd			= $si->getQtd();
		$valor_unitario	= $si->getValorUnitario();

		$result .= "
		<tr id='subitem{$id_subitem}'>
			<td>{$nm_subitem}</td>
			<td>{$qtd}</td>
			<td>{$valor_unitario}</td>
			<td align='center'>
				<a href='#' onclick='removerSubitem({$id_subitem})'>x</a>
			</td>
		</tr>";
	}

	echo $result;

} catch (Exception $e) {
	echo $e->getMessage();
}
