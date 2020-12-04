<?php
require_once "app_model.php";

final class Unidade extends AppModel {
	private $idUnidade;
	private $unidade;
	
    public function __construct() {
        parent::__construct();
    }
    /**
     * @return mixed
     */
    public function getIdUnidade()
    {
        return $this->idUnidade;
    }

    /**
     * @param mixed $idUnidade
     *
     * @return self
     */
    public function setIdUnidade($idUnidade)
    {
        $this->idUnidade = $idUnidade;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getUnidade()
    {
        return $this->unidade;
    }

    /**
     * @param mixed $unidade
     *
     * @return self
     */
    public function setUnidade($unidade)
    {
        $this->unidade = $unidade;

        return $this;
    }
}
