<?php
require_once "app_model.php";

final class Funcao extends AppModel {
	private $idFuncao;
	private $funcao;
	
    public function __construct() {
        parent::__construct();
    }


    /**
     * @return mixed
     */
    public function getIdFuncao()
    {
        return $this->idFuncao;
    }

    /**
     * @param mixed $idFuncao
     *
     * @return self
     */
    public function setIdFuncao($idFuncao)
    {
        $this->idFuncao = $idFuncao;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getFuncao()
    {
        return $this->funcao;
    }

    /**
     * @param mixed $funcao
     *
     * @return self
     */
    public function setFuncao($funcao)
    {
        $this->funcao = $funcao;

        return $this;
    }
}
