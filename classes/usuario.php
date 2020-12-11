
<?php
require_once "app_model.php";
require_once "perfil.php";
require_once "unidade.php";
require_once "funcao.php";

final class Usuario extends AppModel {
	private $idUsuario;
	private $nome;
    private $idPerfil;
	private $perfil;
    private $idFuncao;
	private $funcao;
    private $idUnidade;
	private $unidade;

	public function __construct() {
		parent::__construct();
	}


    /**
     * @return mixed
     */
    public function getIdUsuario()
    {
        return $this->idUsuario;
    }

    /**
     * @param mixed $idUsuario
     *
     * @return self
     */
    public function setIdUsuario($idUsuario)
    {
        $this->idUsuario = $idUsuario;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getNome()
    {
        return $this->nome;
    }

    /**
     * @param mixed $nome
     *
     * @return self
     */
    public function setNome($nome)
    {
        $this->nome = $nome;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getIdPerfil()
    {
        return $this->idPerfil;
    }

    /**
     * @param mixed $idPerfil
     *
     * @return self
     */
    public function setIdPerfil($idPerfil)
    {
        $this->idPerfil = $idPerfil;

        return $this;
    }

    /**
     * @return mixed
     */
    public function getPerfil()
    {
        return $this->perfil;
    }

    /**
     * @param mixed $perfil
     *
     * @return self
     */
    public function setPerfil($perfil)
    {
        $this->perfil = $perfil;

        return $this;
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