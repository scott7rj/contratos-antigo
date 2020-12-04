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