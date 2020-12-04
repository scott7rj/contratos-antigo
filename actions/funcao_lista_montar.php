<?php
include_once "../classes/conexao.php";
include_once "../dao/funcao_dao.php";

try {
	$dao = new FuncaoDAO();
	$lista = $dao->selecionarFuncoes();
	$result = "";
	foreach($lista as $obj) {
		$result .= "
		<tr>
			<td align='center'>{$obj->getIdFuncao()}</td>
			<td>{$obj->getFuncao()}</td>
			<td align='center'><a href='#' onclick='removerFuncao({$obj->getIdFuncao()})'>x</a></td>
		</tr>";
	}
	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
