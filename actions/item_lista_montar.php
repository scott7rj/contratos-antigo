<?php
include_once "../classes/conexao.php";
include_once "../classes/item.php";
include_once "../classes/subitem.php";

try {

	$id_contrato = $_POST["id_contrato"];
	$tag 		 = $_POST["tag"];

	$item = new item();
	$subitem = new subitem();
	$itens = $item->selecionarPorIdContrato($id_contrato);
	$result = "";

	foreach($itens as $it) {
		$id_item 		= $it->getIdItem();
		$nm_item 		= $it->getItem();

		if($tag == "table") {
			$result .= "<tr id='item{$id_item}'>
							<td>{$nm_item}</td>
							<td>
								<table class='table table-bordered' style='margin-bottom: 0px;'>
									<tbody id='subitens{$id_item}'>";
			$subitens = $subitem->selecionarPorIdItem($id_item);

			foreach($subitens as $si) {
				$id_subitem 	= $si->getIdSubitem();
				$nm_subitem 	= $si->getSubitem();
				$qtd			= $si->getQtd();
				$valor_unitario	= number_format($si->getValorUnitario(),2,",",".");

				$result .= "<tr id='subitem{$id_subitem}'>
								<td>{$nm_subitem}</td>
								<td><div class='qtd'>{$qtd}</div></td>
								<td><div class='valor'>{$valor_unitario}</div></td>
								<td align='center'>
									<a href='#' onclick='removerSubitem({$id_subitem})'>x</a>
								</td>
							</tr>";
			}

			$result .= "</tbody></table></td>
							<td align='center'>
								<a href='#' onclick='removerItem({$id_item})'>x</a>
							</td>
						</tr>";
		} elseif($tag == "select") {
			if($result == "")
				$result .= "<option></option>";

			$result .= "<option value='{$id_item}'>{$nm_item}</option>";
		}
	}

	echo $result;

} catch (Exception $e) {
	echo $e->getMessage();
}
