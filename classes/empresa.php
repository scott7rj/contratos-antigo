<?php

class empresa {
	private $id_empresa;
	private $empresa;
	private $cnpj;
	private $endereco;
	private $cidade;
	private $uf;
	private $cep;
	private $observacao;

	function getId_empresa() {
		return $this->id_empresa;
	}
	function getEmpresa() {
		return $this->empresa;
	}
	function getCnpj() {
		return $this->cnpj;
	}
	function getEndereco() {
		return $this->endereco;
	}
	function getCidade() {
		return $this->cidade;
	}
	function getUf() {
		return $this->uf;
	}
	function getCep() {
		return $this->cep;
	}
	function getObservacao() {
		return $this->observacao;
	}

	function setId_empresa($id_empresa) {
		$this->id_empresa = $id_empresa;
	}
	function setEmpresa($empresa) {
		$this->empresa = $empresa;
	}
	function setCnpj($cnpj) {
		$this->cnpj = $cnpj;
	}
	function setEndereco($endereco) {
		$this->endereco = $endereco;
	}
	function setCidade($cidade) {
		$this->cidade = $cidade;
	}
	function setUf($uf) {
		$this->uf = $uf;
	}
	function setCep($cep) {
		$this->cep = $cep;
	}
	function setObservacao($observacao) {
		$this->observacao = $observacao;
	}

	public function selecionarEmpresas($ativa) {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_empresa_selecionar]($ativa)";
		$rst = conexao::execute($sql);

		while($array = odbc_fetch_array($rst)) {
			$empresa = new empresa();
			$empresa->setId_empresa($array["id_empresa"]);
			$empresa->setEmpresa(utf8_encode($array["empresa"]));
			$empresa->setCnpj(str_pad($array["cnpj"], 14, "0", STR_PAD_LEFT));
			$empresa->setEndereco(utf8_encode($array["endereco"]));
			$empresa->setCidade(utf8_encode($array["cidade"]));
			$empresa->setUf($array["uf"]);
			$empresa->setCep($array["cep"]);
			$lst[] = $empresa;
		}
		return $lst;
	}

	public function selecionarEmpresaPorId($id_empresa) {
		$lst = array();
		$sql = "SELECT * FROM [contratos].[fn_empresa_selecionar_por_id]($id_empresa)";
		$rst = conexao::execute($sql);

		while($array = odbc_fetch_array($rst)) {
			$empresa = new empresa();
			$empresa->setCnpj(str_pad($array["cnpj"], 14, "0", STR_PAD_LEFT));
			$empresa->setEmpresa(utf8_encode($array["empresa"]));
			$empresa->setEndereco(utf8_encode($array["endereco"]));
			$empresa->setCidade(utf8_encode($array["cidade"]));
			$empresa->setUf($array["uf"]);
			$empresa->setCep($array["cep"]);
			$empresa->setObservacao(utf8_encode($array["observacao"]));
			$lst[] = $empresa;
			break;
		}
		return $lst[0];
	}

	public function inserir($cnpj, $empresa, $endereco, $cidade, $uf, $cep, $observacao, $usuario_alteracao) {
		$sql = "EXEC [contratos].[empresa_inserir] @empresa = '$empresa', @cnpj = $cnpj,
				@endereco = '$endereco', @cidade = '$cidade', @uf = '$uf', @cep = $cep,
				@observacao = '$observacao', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function alterar($id_empresa, $cnpj, $empresa, $endereco, $cidade, $uf, $cep, $observacao, $usuario_alteracao) {
		$sql = "EXEC [empresa_alterar] @id_empresa = $id_empresa, @cnpj = $cnpj, @empresa = '$empresa',
				@endereco = '$endereco', @cidade = '$cidade', @uf = '$uf', @cep = $cep, @observacao =
				'$observacao', @usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function remover($id_empresa, $usuario_alteracao) {
		$sql = "EXEC [contratos].[empresa_remover] @id_empresa = $id_empresa,
				@usuario_alteracao = '$usuario_alteracao'";
		$rst = conexao::execute($sql);
		return odbc_result($rst, 1);
	}

	public function selecionaUfs() {
		$ufs = array( "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA",
					  "PB", "PR", "PE", "PI", "RJ", "RN", "RO", "RS", "RR", "SC", "SE", "SP", "TO" );
		return $ufs;
	}
}
