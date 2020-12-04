<?php
include_once "../classes/conexao.php";
include_once "../classes/contrato.php";

	$id_contrato 		 = $_POST["id_contrato"];
	$ids_tipo_penalidade = $_POST["ids_tipo_penalidade"];

	$contrato = new contrato();
	$removido = $contrato->removerTiposPenalidade($id_contrato);

	if($removido) {
		foreach ($ids_tipo_penalidade as $id_tipo_penalidade) {
			$contrato->inserirTipoPenalidade($id_contrato, $id_tipo_penalidade);
		}
	}

	echo utf8_encode("1_Tipos de penalidade inseridos/alterados com sucesso.");