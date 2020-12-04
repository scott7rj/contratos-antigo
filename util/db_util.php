<?php
final class DbUtil {


	//Converte variável vazia ou com string "NULL" para formato de banco de dados SQL Server (NULL ou com '')
	public static function formataCampoParaDB($var, $insere_aspas) {

		if(is_null($var) OR strlen(trim($var)) === 0)
			$ret = "NULL";
		else
			if($insere_aspas)
				$ret = "'".trim($var)."'";
			else
				$ret = trim($var);

		return $ret;
	}

	// Converte data pt-br para formato de banco de dados SQL Server
	public static function formataDataPtBrParaDB($data) {
		$data_db = "'".substr($data, 6, 4)."-".substr($data, 3, 2)."-".substr($data, 0, 2)."'";
		return $data_db;
	}

	public static function somenteNumeros($var) {
		$num = preg_replace("/[^0-9]/", "", $var);
		return $num;
	}

	public static function formataMonetarioParaDB($var) {
		$num = str_replace(",", ".",str_replace(".", "", $var));
		return $num;
	}

	public static function removeAspasSimples($var) {
		$sem_aspas = str_replace("'", "", $var);
		return $sem_aspas;
	}

}