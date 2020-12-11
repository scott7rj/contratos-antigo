$("#select_empresa").on("change", function(ev) {
	ev.preventDefault();
	var id_empresa = $(this).find("option:selected").val();

	if(id_empresa == ""){
		$("#select_contrato").html("");
		$('#div_competencias').hide();
	} else
		montarListaContratos(id_empresa, "select");
});

$("#select_contrato").on("change", function(ev) {
	ev.preventDefault();
	var id_contrato	= $(this).find("option:selected").val();

	if(id_contrato == "")
		$('#div_competencias').hide();
	else {
		$('#div_competencias').show();
		montarListaCompetencias(id_contrato);
	}
});

function montarListaContratos(id_empresa, tag) {
	$.ajax({
		url: "actions/contrato_lista_montar.php",
		data: {id_empresa: id_empresa, tag:tag},
		type: "POST",
		success: function(rst){
			$("#select_contrato").html(rst);
		}
	});
}

function montarListaCompetencias(id_contrato) {
	$.ajax({
		url: "actions/ateste_competencias_lista_montar.php",
		data: {id_contrato:id_contrato},
		type: "POST",
		success: function(rst){
			if(rst.length == 0)
				$("#tbody_competencias").html("<tr><td colspan='4'>Não há competências</tr></tr>");
			else
				$("#tbody_competencias").html(rst);
		}
	});
}

$('.qtd').on("change", function(ev){
	ev.preventDefault();
	var tr_ateste = $(this).closest("tr");
	var id_ateste = tr_ateste.attr("id").replace("ateste", "");
	var item 	  = tr_ateste.find("td:nth-child(1)").text();
	var qtd 	  = $(this).val();

	$.SmartMessageBox({
		title : "Confirma alteração de quantidade do item " + item + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {

			$.ajax({
				url: "actions/ateste_alterar_quantidade.php",
				data: {id_ateste:id_ateste, qtd:qtd},
				type: "POST",
				success: function(rst){
					var rs = rst.split("_");
					var mensagem = rs[1];
					calculaTotal(id_ateste);

					alert(mensagem);
				},
			});
		}
	});
});

$('.valor').on("change", function(ev){
	ev.preventDefault();
	var tr_ateste = $(this).closest("tr");
	var id_ateste = tr_ateste.attr("id").replace("ateste", "");
	var item 	  = tr_ateste.find("td:nth-child(1)").text();
	var valor 	  = $(this).val();

	$.SmartMessageBox({
		title : "Confirma alteração de valor do item " + item + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {

			$.ajax({
				url: "actions/ateste_alterar_valor.php",
				data: {id_ateste:id_ateste, valor:valor},
				type: "POST",
				success: function(rst){
					var rs = rst.split("_");
					var mensagem = rs[1];
					calculaTotal(id_ateste);

					alert(mensagem);
				},
			});
		}
	});
});

$('.hmg').on("change", function(ev){
	var tr_ateste  = $(this).closest("tr");
	var id_ateste  = tr_ateste.attr("id").replace("ateste", "");
	var homologado = $(this).is(":checked");

	$.SmartMessageBox({
		title : "Confirma homologação ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {

			$.ajax({
				url: "actions/ateste_alterar_hmg.php",
				data: {id_ateste:id_ateste, homologado:homologado},
				type: "POST",
				success: function(rst){
					var rs = rst.split("_");
					var mensagem = rs[1];

					alert(mensagem);
				},
			});
		}
	});
});

function calculaTotal(id_ateste) {
	var qtd   = parseInt($("#ateste"+id_ateste).find("input[name='qtd']").val());
	var valor = parseFloat($("#ateste"+id_ateste).find("input[name='valor']").val().replace(".","").replace(",","."));
	var total = (qtd * valor).toFixed(2);
	alert(total);

	$("#ateste"+id_ateste).find("td:nth-child(5)").text(total).mask('000.000.000,00');
}

$("#form_ateste_pagamento").on("submit", function(ev) {
	ev.preventDefault();
	var dados = $(this).serialize();

	$.SmartMessageBox({
		title : "Confirma alteração do ateste de pagamento ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {

			$.ajax({
				url: "actions/ateste_alterar.php",
				data: dados,
				type: "POST",
				success: function(rst){
					var rs = rst.split("_");
					var mensagem = rs[1];

					alert(mensagem);
				},
			});
		}
	});
});

$("#form_nova_parcela_siplo").on("submit", function(ev) {
	ev.preventDefault();
	var dados = $(this).serialize();

	$.SmartMessageBox({
		title : "Confirma inserção de parcela SIPLO ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {

			$.ajax({
				url: "actions/ateste_parcela_siplo_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					var rs = rst.split("_");
					var inserido = parseInt(rs[0]);
					var mensagem = rs[1];

					if(inserido){
						$("#form_nova_parcela_siplo").trigger("reset");
						montarListaParcelasSiplo();
					}
					alert(mensagem);
				},
			});
		}
	});
});

function montarListaParcelasSiplo() {
	var id_ateste_pagamento = $("#form_nova_parcela_siplo").find("input[name=id_ateste_pagamento]").val();

	$.ajax({
		url: "actions/ateste_parcelas_siplo_lista_montar.php",
		data: {id_ateste_pagamento:id_ateste_pagamento},
		type: "POST",
		success: function(rst){
			$("#tbody_parcelas").html(rst);
		}
	});
}

function removerParcelaSiplo(id_parcela_siplo) {
	$.SmartMessageBox({
		title : "Confirma remoção da parcela SIPLO ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/ateste_parcela_siplo_remover.php",
				data: {id_parcela_siplo:id_parcela_siplo},
				type: "POST",
				success: function(rst){
					alert(rst);
					var rs = rst.split("_");
					var removido = parseInt(rs[0]);
					var mensagem = rs[1];

					if(removido)
						montarListaParcelasSiplo();

					alert(mensagem);
				},
			});
		}
	});
}

$('.qtd').mask('000000000');
$('.valor').mask('000.000.000,00', {reverse: true});
$('.valor_siplo').mask('000.000.000,00', {reverse: true});