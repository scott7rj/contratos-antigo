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
			<td>{$obj->getPerfil()->getPerfil()}</td>
			<td>{$obj->getUnidade()->getUnidade()}</td>
			<td>{$obj->getFuncao()->getFuncao()}</td>
			<td align='center'><a href='#' onclick='removerUnidade({$obj->getIdUsuario()})'>x</a></td>
		</tr>";
	}
	echo $result;
} catch (Exception $e) {
	echo $e->getMessage();
}
