<?php

class email {
	private $id_email;
	private $email;
	private $tipo_contato;

	function getId_email() {
		return $this->id_email;
	}
	function getEmail() {
		return $this->email;
	}
	function getTipo_contato() {
		return $this->tipo_contato;
	}

	function setId_email($id_email) {
		$this->id_email = $id_email;
	}
	function setEmail($email) {
		$this->email = $email;
	}
	function setTipo_contato($tipo_contato) {
		$this->tipo_contato = $tipo_contato;
	}

	public function selecionarPorIdEmpresa($id_empresa) {
		$sql = "SELECT * FROM [contratos].[fn_email_selecionar_por_id_empresa]($id_empresa)";
		$rst = conexao::execute($sql);
		$lst = array();
		while($array = odbc_fetch_array($rst)) {
			$email = new email();
			$email->setId_email($array["id_email"]);
			$email->setEmail($array["email"]);
			$email->setTipo_contato(utf8_encode($array["tipo_contato"]));
			array_push($lst, $email);
		}
		return $lst;
	}

	public function inserir($id_empresa, $id_tipo_contato, $email, $usuario_alteracao) {
		$sql = "EXEC [contratos].[email_inserir] @id_empresa = $id_empresa, @id_tipo_contato = $id_tipo_contato,
				@email = '$email', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_email) {
		$sql = "EXEC [contratos].[email_remover] @id_email = $id_email";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

}
