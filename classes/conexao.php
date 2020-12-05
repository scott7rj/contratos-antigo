<?php

final class conexao {

	public static function execute($sql) {

		$dsn  = "DRIVER={SQL Server};SERVER=OPTIPLEX\SQLEXPRESS;DATABASE=DB7289_CONTRATOS_DES";
		$user = "s728901";
		$pass = "P@55_01#";

		$con = odbc_connect($dsn, $user, $pass) or die('Falha na conexao: '.odbc_error());
		$rst = odbc_exec($con, $sql) or die($sql.": ".odbc_error());
		return $rst;
	}

	public function acessoLdap($log_user, $password) {

		$ldap_connect = ldap_connect('ldap://ldapcluster.corecaixa:489');
		ldap_set_option( $ldap_connect, LDAP_OPT_PROTOCOL_VERSION, 3);
		ldap_set_option( $ldap_connect, LDAP_OPT_REFERRALS, 0);

		$ldapbind = @ldap_bind($ldap_connect, "uid=".$log_user.',ou=People,o=caixa', $password);

		if($ldapbind) {
			$search_filter = sprintf('(uid=%s)', $log_user );
			$search_handle = ldap_search($ldap_connect, 'ou=People,o=caixa', $search_filter);

			if(!$search_handle) {
				return "Servidor de AutenticaÃ§Ã£o IndisponÃ­vel (LDAP: erro na consulta).";
			} else {
				$ldap_resultado = ldap_get_entries($ldap_connect, $search_handle);

				if($ldap_resultado['count'] == 0 ) {
					return "Impedido";
				} else {

					$ldap_user	= $ldap_resultado[0];
					$id_unidade	= $ldap_user['nu-lotacaofisica'][0];

					if(($id_unidade == 7289) OR ($id_unidade == 7688)) {
						$_SESSION["id_unidade"]	= $id_unidade;
						$_SESSION["log_user"]	= strtoupper($ldap_user["co-usuario"][0]);
						$_SESSION["nome"]		= $ldap_user["no-usuario"][0];
						$_SESSION["id_funcao"]	= $ldap_user["nu-funcao"][0];
						$_SESSION["funcao"]		= $ldap_user["title"][0];
						$_SESSION["sg_unidade"]	= $ldap_user["sg-unidade"][0];
						$_SESSION["nm_unidade"]	= $ldap_user["no-lotacaofisica"][0];
						return 1;
					} else {
						return "Unidade $id_unidade nÃ£o possui acesso ao sistema.";
					}
				}
			}

		} else {
			return "Acesso Negado<br>UsuÃ¡rio ou senha incorretos.";
		}
	}
}
