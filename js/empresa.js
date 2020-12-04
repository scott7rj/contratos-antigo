$("#nova_empresa").on("submit", function(ev) {
	ev.preventDefault();
	var dados = $(this).serialize();
	var cnpj  = $(this).find("input[name=cnpj]").val();
	var nome  = $(this).find("input[name=empresa]").val();
	var endereco  = $(this).find("input[name=endereco]").val();

	if(CNPJvalido(cnpj)) {
		$.ajax({
			url: "actions/empresa_inserir.php",
			data: dados,
			type: "POST",
			success: function(rst){
				var emp = rst.split("_");
				var inserido   = emp[0];
				var mensagem   = emp[1];

				if(inserido) {
					var id_empresa = emp[2];
					$("#dados_gerais").attr("class","");
					$("#t1").attr("class","tab-pane fade");
					$("#contatos").css("display","block");
					$("#documentos").css("display","block");
					$("#contatos").attr("class","active");
					$("#t2").attr("class","tab-pane fade in active");
					$("#novo_telefone").find("input[name=id_empresa]").val(id_empresa);
					$("#novo_email").find("input[name=id_empresa]").val(id_empresa);
					$("#novo_documento").find("input[name=id_dominio]").val(id_empresa);
					$("#insere_nova_empresa").css("display","none");

					$("#empresas").append("<tr id='emp"+id_empresa+"'>" +
											"<td>"+cnpj+"</td>" +
											"<td>"+nome+"</td>" +
											"<td>"+endereco+"</td>" +
											"<td align='center'><a href='templates/empresa_modal_inserir_alterar.php?e="+id_empresa+"' data-toggle='modal' data-target='#modal'><i class='fa fa-edit'></i></a></td>" +
									   		"<td align='center'><a href='#' onclick='removerEmpresa("+id_empresa+")'><i class='fa fa-times'></i></a></td>" +
									   	  "</tr>");
				}
				alert(mensagem);
			},
		});
	} else {
		alert("CNPJ inválido");
	}
});

function removerEmpresa(id_empresa) {
	var razao_social = $("#emp"+id_empresa).find("td:nth-child(2)").text();
	var usuario_alteracao = $("#log_user").text();

	$.SmartMessageBox({
		title : "Confirma remoção da empresa : " + razao_social + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {

			$.ajax({
				url: "actions/empresa_remover.php",
				data: {id_empresa:id_empresa, usuario_alteracao:usuario_alteracao},
				type: "POST",
				success: function(rst){
					var rs = rst.split("_");
					var removido = parseInt(rs[0]);
					var mensagem = rs[1];

					if(removido)
						$("#emp"+id_empresa).remove();
					alert(mensagem);
				},
			});
		}
	});
}

function CNPJvalido(cnpj) {

	cnpj = cnpj.replace(/[^\d]+/g,'');

	tamanho = cnpj.length - 2
	numeros = cnpj.substring(0,tamanho);
	digitos = cnpj.substring(tamanho);
	soma = 0;
	pos = tamanho - 7;
	for (i = tamanho; i >= 1; i--) {
		soma += numeros.charAt(tamanho - i) * pos--;
		if (pos < 2)
			pos = 9;
	}
	resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
	if (resultado != digitos.charAt(0))
		return false;

	tamanho = tamanho + 1;
	numeros = cnpj.substring(0,tamanho);
	soma = 0;
	pos = tamanho - 7;
	for (i = tamanho; i >= 1; i--) {
		soma += numeros.charAt(tamanho - i) * pos--;
		if (pos < 2)
			pos = 9;
	}
	resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
	if (resultado != digitos.charAt(1))
		return false;

	return true;
}

$('.cnpj').mask('00.000.000/0000-00', {clearIfNotMatch: true});
$('.cep').mask('00000-000', {clearIfNotMatch: true});
$('.data_validade').mask('00/00/0000', {clearIfNotMatch: true});

$('.telefone').mask('00 0000-00009');
$('.telefone').blur(function(event) {
   if($(this).val().length == 13){ // Celular com 9 dígitos + 2 dígitos DDD e 2 da máscara
      $('.telefone').mask('00 00000-0009', {clearIfNotMatch: true});
   } else {
      $('.telefone').mask('00 0000-00009', {clearIfNotMatch: true});
   }
});
