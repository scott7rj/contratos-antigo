<?php
include_once "../classes/conexao.php";
include_once "../dao/unidade_dao.php";

try {
	$dao = new UnidadeDAO();
	$lista = $dao->selecionarUnidades();
	$result = "";
	foreach($lista as $obj) {
		$result .= "
		<tr>
			<td align='center'>{$obj->getIdUnidade()}</td>
			<td>{$obj->getUnidade()}</td>
			<td align='center'><a href='#' onclick='removerUnidade({$obj->getIdUnidade()})'>x</a></td>
		</tr>";
	}
	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
