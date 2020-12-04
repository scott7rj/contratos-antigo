<?php
require_once "../dao/unidade_dao.php";
require_once "../dao/funcao_dao.php";
require_once "../dao/perfil_dao.php";

final class ComboBuilder {

    /**
     * params 
     * $id       = id e name do componente html
     * $class    = class do componente
     * $hasEmptyOption = se o select contém option vazio
     * $width    = width do componente
     * $selected = valor que devera ser o selected no combo
     * 
     * exemplos de chamada:
     *      ComboBuilder::unidade('', '', '', false, '');
     *      ComboBuilder::unidade('comboMyCombo', 'myClass', '300px', true, '10');
     */

    public function buildHead($id, $class, $width) {
        $result = "<select";
        if ($id !== "")
            $result .= " id='{$id}' name='{$id}'";
        if ($class !== "")
            $result .= " class='{$class}'";
        if ($width !== "")
            $result .= " style='width:{$width};'";

        $result .= ">";

        return $result;
    }
    public function buildFoot() {
        $result = "</select>";
        return $result;
    }

    public static function unidade($id, $class, $width, $hasEmptyOption, $selected) {
        $result = (new self)->buildHead($id, $class, $width);
        if($hasEmptyOption) 
            $result .= "<option value=''></option>";
        try {
            $dao = new UnidadeDAO();
            $array = $dao->selecionarUnidades();
            foreach($array as $item) {
                if($selected === $item['id_unidade'])
                    $result .= "<option value='{$item['id_unidade']}' selected>{$item['unidade']}</option>";
                else
                    $result .= "<option value='{$item['id_unidade']}'>{$item['unidade']}</option>";
            }
        } catch(Exception $e) {
            throw new Exception("0_" . $e->getMessage());
        }
        $result .= (new self)->buildFoot();
        return $result;
    }

    public static function funcao($id, $class, $width, $hasEmptyOption, $selected) {
        $result = (new self)->buildHead($id, $class, $width);
        if($hasEmptyOption) 
            $result .= "<option value=''></option>";
        try {
            $dao = new FuncaoDAO();
            $array = $dao->selecionarFuncoes();
            foreach($array as $item) {
                if($selected === $item['id_funcao'])
                    $result .= "<option value='{$item['id_funcao']}' selected>{$item['funcao']}</option>";
                else
                    $result .= "<option value='{$item['id_funcao']}'>{$item['funcao']}</option>";
            }
        } catch(Exception $e) {
            throw new Exception("0_" . $e->getMessage());
        }
        $result .= (new self)->buildFoot();
        return $result;
    }

    public static function perfil($id, $class, $width, $hasEmptyOption, $selected) {
        $result = (new self)->buildHead($id, $class, $width);
        if($hasEmptyOption) 
            $result .= "<option value=''></option>";
        try {
            $dao = new PerfilDAO();
            $array = $dao->selecionarPerfis();
            foreach($array as $item) {
                if($selected === $item['id_perfil'])
                    $result .= "<option value='{$item['id_perfil']}' selected>{$item['perfil']}</option>";
                else
                    $result .= "<option value='{$item['id_perfil']}'>{$item['perfil']}</option>";
            }
        } catch(Exception $e) {
            throw new Exception("0_" . $e->getMessage());
        }
        $result .= (new self)->buildFoot();
        return $result;
    }
}