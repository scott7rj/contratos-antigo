$("#novo_documento").on("submit", function(ev) {
	ev.preventDefault();
	var form_data = new FormData(this);
	var id_dominio 			= $(this).find("input[name=id_dominio]").val();
	var id_tipo_documento	= $(this).find("select option:selected").val();
	var nm_documento 		= $(this).find("input[name=documento]").val();
	var tipo_documento 		= $(this).find("select option:selected").text();
	var data_validade 		= $(this).find("input[name=validade]").val();

	$.ajax({
		url: "actions/documento_inserir.php",
		data: form_data,
		type: "POST",
		cache: false,
        contentType: false,
        processData: false,
		success: function(rst){
			var emp = rst.split("_");
			var inserido = parseInt(emp[0]);
			var mensagem = emp[1];

			if(inserido){
				var id_documento = emp[2];
				$("#docs").append("<tr id='doc"+id_documento+"'>"+
								  "<td><a href='documents/"+id_tipo_documento+id_dominio+nm_documento+"' download='"+nm_documento+"'>"+nm_documento+"</a></td>"+
								  "<td>"+tipo_documento+"</td>"+
								  "<td align='center'>"+data_validade+"</td>"+
								  "<td align='center'><a href='#' onclick='removerDoc("+id_documento+")'>x</a>" +
								  "</td></tr>");
			}
			alert(mensagem);
		},
		xhr: function() { // Custom XMLHttpRequest
            var myXhr = $.ajaxSettings.xhr();
            if (myXhr.upload) { // Avalia se tem suporte a propriedade upload
                myXhr.upload.addEventListener('progress', function() {
                    /* faz alguma coisa durante o progresso do upload */
                }, false);
            }
            return myXhr;
        }
	});
});

function removerDoc(id_documento) {
	var nome_documento = $("#doc"+id_documento).find("td:first-child").text();

	$.SmartMessageBox({
		title : "Confirma remoção do documento : " + nome_documento + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/documento_remover.php",
				data: {id_documento:id_documento, nome_documento:nome_documento},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						$("#doc"+id_documento).remove();
					alert(mensagem);
				},
			});
		}
	});
}

$("#id_tipo_documento").on("change", function(ev){
	ev.preventDefault();
	var possui_validade = parseInt($(this).find("option:selected").attr("possui_validade"));

	if(possui_validade) {
		$("#input_validade").css("display","block");
	} else {
		$("#input_validade").css("display","none");
		$(".data_validade").val("");
	}
});
