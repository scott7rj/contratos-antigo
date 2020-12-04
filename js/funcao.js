function montarListaFuncao() {
	$.ajax({
			url: "actions/funcao_lista_montar.php",
			data: null,
			type: "GET",
			success: function(rst){
				$("#tbody_funcoes").html(rst);
			}
		});
}

$("#frm_nova_funcao").on("submit", function(ev) {
	ev.preventDefault();

	var dados = $(this).serialize();
	var funcao = $(this).find("input[name=funcao]").val();
	$.SmartMessageBox({
		title : "Confirma inserção da função : " + funcao,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/funcao_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					console.log(rst);
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido) {
						$("#frm_nova_funcao").trigger("reset");
						montarListaFuncao();
					}

					alert(mensagem);
				},
			});
		}
	});
});

function removerFuncao(id_funcao) {
	$.SmartMessageBox({
		title : "Confirma remoção da função ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/funcao_remover.php",
				data: {id_funcao: id_funcao},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						montarListaFuncao();

					alert(mensagem);
				},
			});
		}
	});
}

$('#txt_funcao').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_funcao').val());
	$('#txt_funcao').val(limpa.toUpperCase());
});
