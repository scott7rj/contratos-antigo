function montarListaTipoContrato() {
	$.ajax({
			url: "actions/tipo_contrato_lista_montar.php",
			data: null,
			type: "GET",
			success: function(rst){
				$("#tbody_tipos_contrato").html(rst);
			}
		});
}

$("#frm_novo_tipo_contrato").on("submit", function(ev) {
	ev.preventDefault();

	var dados		 = $(this).serialize();
	var tipo_contrato = $(this).find("input[name=tipo_contrato]").val();

	$.SmartMessageBox({
		title : "Confirma inserção do tipo de contrato : " + tipo_contrato,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/tipo_contrato_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido) {
						$("#frm_novo_tipo_contrato").trigger("reset");
						montarListaTipoContrato();
					}
					alert(mensagem);
				},
			});
		}
	});
});

function removerTipoContrato(id_tipo_contrato) {
	$.SmartMessageBox({
		title : "Confirma remoção do tipo de contrato?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/tipo_contrato_remover.php",
				data: {id_tipo_contrato: id_tipo_contrato},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido) 
						montarListaTipoContrato();
				
					alert(mensagem);
					
				},
			});
		}
	});
}

$('#txt_tipo_contrato').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_tipo_contrato').val());
	$('#txt_tipo_contrato').val(limpa.toUpperCase());
});
