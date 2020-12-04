function montarListaTipoPenalidade() {
	$.ajax({
			url: "actions/tipo_penalidade_lista_montar.php",
			data: null,
			type: "GET",
			success: function(rst){
				$("#tbody_tipos_penalidade").html(rst);
			}
		});
}

$("#frm_novo_tipo_penalidade").on("submit", function(ev) {
	ev.preventDefault();

	var dados = $(this).serialize();
	var tipo_penalidade = $(this).find("input[name=tipo_penalidade]").val();
	$.SmartMessageBox({
		title : "Confirma inserção do tipo de penalidade : " + tipo_penalidade,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/tipo_penalidade_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					console.log(rst);
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido) {
						$("#frm_novo_tipo_penalidade").trigger("reset");
						montarListaTipoPenalidade();
					}

					alert(mensagem);
				},
			});
		}
	});
});

function removerTipoPenalidade(id_tipo_penalidade) {
	$.SmartMessageBox({
		title : "Confirma remoção do tipo de penalidade ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/tipo_penalidade_remover.php",
				data: {id_tipo_penalidade: id_tipo_penalidade},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						montarListaTipoPenalidade();

					alert(mensagem);
				},
			});
		}
	});
}

$('#txt_tipo_penalidade').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_tipo_penalidade').val());
	$('#txt_tipo_penalidade').val(limpa.toUpperCase());
});
