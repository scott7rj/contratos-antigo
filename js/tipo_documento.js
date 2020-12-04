function montarListaTipoDocumento() {
	$.ajax({
		url: "actions/tipo_documento_lista_montar.php",
		data: null,
		type: "GET",
		success: function(rst){
			$("#tbody_tipos_documento").html(rst);
		}
	});
}

$("#novo_tipo_documento").on("submit", function(ev) {
	ev.preventDefault();

	var dados		   	  = $(this).serialize();
	var tipo_documento 	  = $(this).find("input[name=tipo_documento]").val();
	var dominio_documento = $(this).find("select[name=id_dominio_documento] option:selected").text();
	var possui_validade   = $(this).find("select[name=possui_validade] option:selected").text();

	$.SmartMessageBox({
		title : "Confirma inserção do tipo de documento : " + tipo_documento,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/tipo_documento_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					console.log(rst);
					var rs = rst.split("_");
					var inserido = parseInt(rs[0]);
					var mensagem = rs[1];

					if(inserido){
						var id_tipo_documento = rs[2];
						montarListaTipoDocumento();
						//$("#tipos_documento").append("<tr id='td"+id_tipo_documento+"'>" +
						//							 	"<td>"+tipo_documento+"</td>" +
						//							 	"<td>"+dominio_documento+"</td>" +
						//							 	"<td>"+possui_validade+"</td>" +
						//							 	"<td align='center'>" +
						//							 	"<a href='#' onclick='removerTipoDocumento("+id_tipo_documento+")'>x</a></td>" +
						//							 "</tr>");
						$("#novo_tipo_documento").trigger("reset");
					}
					alert(mensagem);
				},
			});
		}
	});
});

function removerTipoDocumento(id_tipo_documento) {
	var tipo_documento = $("#td"+id_tipo_documento).find("td:first-child").text();

	$.SmartMessageBox({
		title : "Confirma remoção do tipo de documento : " + tipo_documento + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/tipo_documento_remover.php",
				data: {id_tipo_documento:id_tipo_documento},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						montarListaTipoDocumento();
					alert(mensagem);
				},
			});
		}
	});
}

$('#txt_tipo_documento').blur(function(){
	let limpa = removerCaracteresEspeciais($('#txt_tipo_documento').val());
	$('#txt_tipo_documento').val(limpa.toUpperCase());
});
