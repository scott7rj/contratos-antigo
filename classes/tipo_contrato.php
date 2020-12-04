<?php

class tipo_contrato {
	private $idTipoContrato;
	private $tipoContrato;
	private $ativo;

    public function getIdTipoContrato(){
        return $this->idTipoContrato;
    }

    public function setIdTipoContrato($idTipoContrato){
        $this->idTipoContrato = $idTipoContrato;
    }

    public function getTipoContrato(){
        return $this->tipoContrato;
    }

    public function setTipoContrato($tipoContrato){
        $this->tipoContrato = $tipoContrato;
    }

    public function getAtivo(){
        return $this->ativo;
    }

    public function setAtivo($ativo){
        $this->ativo = $ativo;
    }

    public function selecionarTiposContrato() {
        $sql = "SELECT * FROM [contratos].[fn_tipo_contrato_selecionar](1)";
        $rst = conexao::execute($sql);
        $lst = array();
        while($array = odbc_fetch_array($rst)) {
            $tipo_contrato = new tipo_contrato();
            $tipo_contrato->setIdTipoContrato(utf8_encode($array["id_tipo_contrato"]));
            $tipo_contrato->setTipoContrato(utf8_encode($array["tipo_contrato"]));
            array_push($lst, $tipo_contrato);
        }
        return $lst;
    }

    public function inserir($tipo_contrato, $usuario_alteracao) {
        $sql = "EXEC [contratos].[tipo_contrato_inserir] @tipo_contrato = '$tipo_contrato',
                @usuario_alteracao = '$usuario_alteracao'";
        $rst = conexao::execute($sql);
        return odbc_result($rst, 1);
    }

    public function remover($id_tipo_contrato) {
        $sql = "EXEC [contratos].[tipo_contrato_remover] @id_tipo_contrato = $id_tipo_contrato";
        $rst = conexao::execute($sql);
        return odbc_result($rst, 1);
    }
}
