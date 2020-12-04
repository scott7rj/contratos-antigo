function montarListaPerfil() {
	$.ajax({
			url: "actions/perfil_lista_montar.php",
			data: null,
			type: "GET",
			success: function(rst){
				$("#tbody_perfis").html(rst);
			}
		});
}

$("#frm_novo_perfil").on("submit", function(ev) {
	ev.preventDefault();

	var dados = $(this).serialize();
	var perfil = $(this).find("input[name=perfil]").val();
	$.SmartMessageBox({
		title : "Confirma inserção do perfil : " + perfil,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/perfil_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					console.log(rst);
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido) {
						$("#frm_novo_perfil").trigger("reset");
						montarListaPerfil();
					}

					alert(mensagem);
				},
			});
		}
	});
});

function removerPerfil(id_perfil) {
	$.SmartMessageBox({
		title : "Confirma remoção do perfil ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/perfil_remover.php",
				data: {id_perfil: id_perfil},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						montarListaPerfil();

					alert(mensagem);
				},
			});
		}
	});
}

$('#txt_perfil').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_perfil').val());
	$('#txt_perfil').val(limpa.toUpperCase());
});
