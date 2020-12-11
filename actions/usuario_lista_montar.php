<?php
include_once "../classes/conexao.php";
include_once "../dao/usuario_dao.php";

try {
	$dao = new UsuarioDAO();
	$lista = $dao->selecionarUsuarios();
	$result = "";
	foreach($lista as $obj) {
		$result .= "
		<tr>
			<td align='center'>{$obj->getIdUsuario()}</td>
			<td>{$obj->getNome()}</td>
			<td>{$obj->getPerfil()}</td>
			<td>{$obj->getUnidade()}</td>
			<td>{$obj->getFuncao()}</td>";
		$result .= "<td align='center'><a href='#' onclick=removerUsuario(" . "'" . $obj->getIdUsuario() ."'" . ")>x</a></td>";
		$result .= "</tr>";
	}
	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
