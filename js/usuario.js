function montarListaUsuario() {
	$.ajax({
			url: "actions/usuario_lista_montar.php",
			data: null,
			type: "GET",
			success: function(rst){
				$("#tbody_usuarios").html(rst);
			}
		});
}

$("#frm_novo_usuario").on("submit", function(ev) {
	ev.preventDefault();

	var dados = $(this).serialize();
	var usuario = $("#txt_id_usuario").val();
	$.SmartMessageBox({
		title : "Confirma inserção da usuario : " + usuario,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/usuario_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					console.log(rst);
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido) {
						$("#frm_novo_usuario").trigger("reset");
						montarListaUsuario();
					}

					alert(mensagem);
				},
			});
		}
	});
});

function removerUsuario(id_usuario) {
	$.SmartMessageBox({
		title : "Confirma remoção do usuário ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/usuario_remover.php",
				data: {id_usuario: id_usuario},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						montarListaUsuario();

					alert(mensagem);
				},
			});
		}
	});
}
