<?php
include_once "../classes/conexao.php";
include_once "../classes/contrato.php";
include_once "../util/db_util.php";

try {

	$existe_contrato				 = $_POST["existe_contrato"];
	$numero_processo 				 = DbUtil::removeAspasSimples($_POST["numero_processo"]);
	$numero_ordem_servico			 = $_POST["numero_ordem_servico"];
	$data_assinatura				 = DbUtil::formataDataPtBrParaDB($_POST["data_assinatura"]);
	$data_inicio_vigencia			 = DbUtil::formataDataPtBrParaDB($_POST["data_inicio_vigencia"]);
	$data_fim_vigencia				 = DbUtil::formataDataPtBrParaDB($_POST["data_fim_vigencia"]);
	$dia_pagamento					 = $_POST["dia_pagamento"];
	$dia_pagamento_corridos			 = $_POST["dia_pagamento_corridos"];
	$valor_global_inicial			 = DbUtil::formataMonetarioParaDB($_POST["valor_global_inicial"]);
	$valor_global_atualizado		 = DbUtil::formataMonetarioParaDB($_POST["valor_global_atualizado"]);
	$valor_global_atualizado		 = DbUtil::formataCampoParaDB($valor_global_atualizado, 1);
	$objeto_contratual				 = DbUtil::removeAspasSimples(utf8_decode($_POST["objeto_contratual"]));
	$prazo_alerta_dias_pagamento	 = $_POST["dias_alerta_pagamento"];
	$prazo_alerta_dias_ateste		 = $_POST["dias_alerta_ateste"];
	$prazo_alerta_dias_nota_fiscal	 = $_POST["dias_alerta_nota_fiscal"];
	$prazo_alerta_meses_fim_vigencia = $_POST["meses_alerta_fim_vigencia"];
	$usuario_alteracao 				 = $_POST["usuario_alteracao"];

	$contrato = new contrato();

	if($existe_contrato) {
		$id_contrato = $_POST["id_contrato"];

		$msg = $contrato->alterar($id_contrato, $numero_processo, $numero_ordem_servico, $data_assinatura,
								  $data_inicio_vigencia, $data_fim_vigencia, $valor_global_inicial,
								  $valor_global_atualizado, $objeto_contratual, $dia_pagamento,
								  $dia_pagamento_corridos, $prazo_alerta_dias_pagamento,
								  $prazo_alerta_dias_ateste, $prazo_alerta_dias_nota_fiscal,
								  $prazo_alerta_meses_fim_vigencia, $usuario_alteracao);
	} else {
		$id_empresa 	  = $_POST["id_empresa"];
		$id_tipo_contrato = $_POST["id_tipo_contrato"];

		$msg = $contrato->inserir($id_empresa, $id_tipo_contrato, $numero_processo, $numero_ordem_servico,
								  $data_assinatura, $data_inicio_vigencia, $data_fim_vigencia,
								  $valor_global_inicial, $valor_global_atualizado,
								  $objeto_contratual, $dia_pagamento, $dia_pagamento_corridos,
                            	  $prazo_alerta_dias_pagamento, $prazo_alerta_dias_ateste,
                            	  $prazo_alerta_dias_nota_fiscal, $prazo_alerta_meses_fim_vigencia,
                            	  $usuario_alteracao);
	}

	echo utf8_encode($msg);

} catch (Exception $e) {
	echo "0_".$e->getMessage();
}
