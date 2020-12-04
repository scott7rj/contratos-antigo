$("#novo_telefone").on("submit", function(ev) {
	ev.preventDefault();
	var dados		= $(this).serialize();
	var telefone 	= $(this).find("input[name=telefone]").val();
	var contato 	= $(this).find("select option:selected").text();

	$.ajax({
		url: "actions/telefone_inserir.php",
		data: dados,
		type: "POST",
		success: function(rst){
			var emp = rst.split("_");
			var inserido = parseInt(emp[0]);
			var mensagem = emp[1];

			if(inserido){
				var id_telefone = emp[2];
				$("#telefones").append("<tr id='telefone"+id_telefone+"'><td>"+telefone+"</td><td>"+contato+
									   "</td><td align='center'>" +
									   "<a href='#' onclick='removerTelefone("+id_telefone+")'>x</a></td></tr>");
				$("#novo_telefone").trigger("reset");
			}
			alert(mensagem);
		},
	});
});

function removerTelefone(id_telefone) {
	$.ajax({
		url: "actions/telefone_remover.php",
		data: {id_telefone: id_telefone},
		type: "POST",
		success: function(rst){
			var emp = rst.split("_");
			var removido = parseInt(emp[0]);
			var mensagem = emp[1];

			if(removido)
				$("#telefone"+id_telefone).remove();
			alert(mensagem);
		},
	});
}
