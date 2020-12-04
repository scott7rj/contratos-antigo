<?php
abstract class AppModel {

    protected $usuario_alteracao;
    protected $ultima_alteracao;

    public function __construct() {
    	
    }

    /**
     * @return mixed
     */
    public function getUsuarioAlteracao()
    {
        return $this->usuario_alteracao;
    }

    /**
     * @param mixed $usuario_alteracao
     *
     * @return self
     */
    public function setUsuarioAlteracao($usuario_alteracao)
    {
        $this->usuario_alteracao = $usuario_alteracao;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getUltimaAlteracao()
    {
        return $this->ultima_alteracao;
    }

    /**
     * @param mixed $ultima_alteracao
     *
     * @return self
     */
    public function setUltimaAlteracao($ultima_alteracao)
    {
        $this->ultima_alteracao = $ultima_alteracao;

        return $this;
    }
}