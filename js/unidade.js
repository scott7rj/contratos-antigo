function montarListaUnidade() {
	$.ajax({
			url: "actions/unidade_lista_montar.php",
			data: null,
			type: "GET",
			success: function(rst){
				$("#tbody_unidades").html(rst);
			}
		});
}

$("#frm_nova_unidade").on("submit", function(ev) {
	ev.preventDefault();

	var dados = $(this).serialize();
	var unidade = $(this).find("input[name=unidade]").val();
	$.SmartMessageBox({
		title : "Confirma inserção da unidade : " + unidade,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/unidade_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					console.log(rst);
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido) {
						$("#frm_nova_unidade").trigger("reset");
						montarListaUnidade();
					}

					alert(mensagem);
				},
			});
		}
	});
});

function removerUnidade(id_unidade) {
	$.SmartMessageBox({
		title : "Confirma remoção da unidade ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/unidade_remover.php",
				data: {id_unidade: id_unidade},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						montarListaUnidade();

					alert(mensagem);
				},
			});
		}
	});
}

$('#txt_unidade').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_unidade').val());
	$('#txt_unidade').val(limpa.toUpperCase());
});
