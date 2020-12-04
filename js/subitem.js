$("#novo_subitem").on("submit", function(ev) {
	ev.preventDefault();
	var form 	= $(this);
	var dados 	= form.serialize();
	var id_contrato = $('#hd_id_contrato').val();
	var id_item = form.find("option:selected").val();
	var subitem = form.find("input[name=subitem]").val();

	$.SmartMessageBox({
		title : "Confirma inserção do subitem " + subitem + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/subitem_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido){
						montarListaItens(id_contrato, "select");
						montarListaItens(id_contrato, "table");
						//montarListaSubItens(id_item);
						form.trigger("reset");
					}
					alert(mensagem);
				},
			});
		}
	});
});

function removerSubitem(id_subitem) {
	var subitem = $("#subitem"+id_subitem).find("td:first-child").text();

	$.SmartMessageBox({
		title : "Confirma remoção do subitem " + subitem + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/subitem_remover.php",
				data: {id_subitem:id_subitem},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						$("#subitem"+id_subitem).remove();
					alert(mensagem);
				},
			});
		}
	});
}

function montarListaSubItens(id_item) {
	$.ajax({
		url: "actions/subitem_lista_montar.php",
		data: {id_item:id_item},
		type: "POST",
		success: function(rst){
			$("#subitens"+id_item).html(rst);
		}
	});
}

$('.qtd').mask('000.000.000', {reverse:true});
