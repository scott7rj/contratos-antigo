<?php
include_once "../classes/conexao.php";
include_once "../dao/perfil_dao.php";

try {
	$dao = new PerfilDAO();
	$lista = $dao->selecionarPerfis();
	$result = "";
	foreach($lista as $obj) {
		$result .= "
		<tr>
			<td>{$obj->getPerfil()}</td>
			<td align='center'><a href='#' onclick='removerPerfil({$obj->getIdPerfil()})'>x</a></td>
		</tr>";
	}
	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
