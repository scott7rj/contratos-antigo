<?php
include_once "../classes/conexao.php";
include_once "../classes/contrato.php";

try {

	$id_empresa	= $_POST["id_empresa"];
	$tag 		= $_POST["tag"];

	$contrato 	= new contrato();
	$contratos  = $contrato->selecionarPorIdEmpresa($id_empresa);
	$result = "";

	if($tag == "table") {

		if (sizeof($contratos) === 0) {
			$result .= "<tr><td align='center' colspan='6'>
							<b>Nenhum contrato encontrado para empresa selecionada.</b>
						</td></tr>";
		} else {
			foreach($contratos as $contrato) {
				$result .= "
				<tr>
					<td>{$contrato->getNumeroProcesso()}</td>
					<td>{$contrato->getDataInicioVigencia()}</td>
					<td>{$contrato->getDataFimVigencia()}</td>
					<td>{$contrato->getTipoContrato()}</td>
					<td align='center'>
						<a href='templates/contrato_modal_inserir_alterar.php?id_contrato={$contrato->getIdContrato()}&id_empresa={$id_empresa}' data-toggle='modal' data-target='#modal'>
							<i class='fa fa-edit'></i>
						</a>
					</td>
					<td align=center>
						<a href='#' onclick='removerContrato({$contrato->getIdContrato()})'>
							<i class='fa fa-times'></i>
						</a>
					</td>
				</tr>";
			}
		}
	} elseif($tag == "select") {

		foreach($contratos as $contrato) {
			$id_contrato = $contrato->getIdContrato();
			$nm_processo = $contrato->getNumeroProcesso();

			if($result == "")
				$result .= "<option></option>";

			$result .= "<option value='{$id_contrato}'>{$nm_processo}</option>";
		}
	}

	echo $result;

} catch (Exception $e) {
	echo $e->getMessage();
}

