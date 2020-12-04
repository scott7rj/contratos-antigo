$("#novo_item").on("submit", function(ev) {
	ev.preventDefault();
	var form 		= $(this);
	var dados 		= form.serialize();
	var id_contrato	= form.find("input[name=id_contrato]").val();
	var item 		= form.find("input[name=item]").val();

	$.SmartMessageBox({
		title : "Confirma inserção do item " + item + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/item_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var inserido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(inserido){
						var id_item = emp[2];
						montarListaItens(id_contrato, "select");
						montarListaItens(id_contrato, "table");
						form.trigger("reset");
					}
					alert(mensagem);
				},
			});
		}
	});
});

function removerItem(id_item) {
	var item = $("#item"+id_item).find("td:first-child").text();

	$.SmartMessageBox({
		title : "Confirma remoção do item " + item + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/item_remover.php",
				data: {id_item:id_item},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						$("#item"+id_item).remove();
					alert(mensagem);
				},
			});
		}
	});
}

function montarListaItens(id_contrato, tag) {
	$.ajax({
		url: "actions/item_lista_montar.php",
		data: {id_contrato:id_contrato, tag:tag},
		type: "POST",
		success: function(rst){
			if(tag == "table")
				$("#itens_cadastrados").html(rst);
			else if(tag == "select")
				$("#select_itens").html(rst);
		}
	});
}