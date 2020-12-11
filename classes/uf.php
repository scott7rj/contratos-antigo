<?php

require_once "app_model.php";

final class Uf extends AppModel {
	private $uf;
	private $nome;
	
    public function __construct() {
        parent::__construct();
    }

    public function getUf() {
        return $this->uf;
    }

    public function setUf($uf) {
        $this->uf = $uf;
        return $this;
    }

    public function getNome() {
        return $this->nome;
    }

    public function setNome($nome) {
        $this->uf = $nome;
        return $this;
    }
}
