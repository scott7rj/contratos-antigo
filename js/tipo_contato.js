function montarListaTipoContato() {
	$.ajax({
			url: "actions/tipo_contato_lista_montar.php",
			data: null,
			type: "GET",
			success: function(rst){
				$("#tbody_tipos_contato").html(rst);
			}
		});
}

$("#novo_tipo_contato").on("submit", function(ev) {
	ev.preventDefault();

	var dados		 = $(this).serialize();
	var tipo_contato = $(this).find("input[name=tipo_contato]").val();

	$.SmartMessageBox({
		title : "Confirma inserção do tipo de contato : " + tipo_contato,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/tipo_contato_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido)
						montarListaTipoContato();

					alert(mensagem);
					$('#txt_tipo_contato').val('');
				},
			});
		}
	});
});

function removerTipoContato(id_tipo_contato) {
	$.SmartMessageBox({
		title : "Confirma remoção do tipo de contato ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/tipo_contato_remover.php",
				data: {id_tipo_contato: id_tipo_contato},
				type: "POST",
				success: function(rst){
					console.log(rst);
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						montarListaTipoContato();

					alert(mensagem);
				},
			});
		}
	});
}

$('#txt_tipo_contato').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_tipo_contato').val());
	$('#txt_tipo_contato').val(limpa.toUpperCase());
});
