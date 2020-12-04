$("#novo_email").on("submit", function(ev) {
	ev.preventDefault();
	var dados 	= $(this).serialize();
	var email 	= $(this).find("input[name=email]").val();
	var contato = $(this).find("select option:selected").text();

	if(emailValido(email)) {
		$.ajax({
			url: "actions/email_inserir.php",
			data: dados,
			type: "POST",
			success: function(rst){
				var emp = rst.split("_");
				var inserido = parseInt(emp[0]);
				var mensagem = emp[1];

				if(inserido){
					var id_email = emp[2];
					$("#emails").append("<tr id='email"+id_email+"'><td>"+email+"</td><td>"+contato+
										"</td><td align='center'>" +
										"<a href='#' onclick='removerEmail("+id_email+")'>x</a></td></tr>");
					$("#novo_email").trigger("reset");
				}
				alert(mensagem);
			},
		});
	} else {
		alert("Email inválido.");
	}
});

function removerEmail(id_email) {
	$.ajax({
		url: "actions/email_remover.php",
		data: {id_email:id_email},
		type: "POST",
		success: function(rst){
			var emp = rst.split("_");
			var removido = parseInt(emp[0]);
			var mensagem = emp[1];

			if(removido)
				$("#email"+id_email).remove();
			alert(mensagem);
		},
	});
}

function emailValido(email) {
  const re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(email);
}
