$("#select_empresa").on("change", function(ev) {
	ev.preventDefault();
	var id_empresa = $(this).find("option:selected").val();

	if(id_empresa == ""){
		$("#select_contrato").html("");
		$('#div_atestes_contrato').hide();
	} else
		montarListaContratos(id_empresa, "select");
});

$("#select_contrato").on("change", function(ev) {
	ev.preventDefault();
	var id_empresa	= $("#select_empresa").find("option:selected").val();
	var id_contrato	= $(this).find("option:selected").val();

	if(id_contrato == "")
		$('#div_atestes_contrato').hide();
	else
		montarListaPenalidades(id_empresa, id_contrato);
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

function montarListaPenalidades(id_empresa, id_contrato) {
	$.ajax({
		url: "actions/penalidade_lista_montar.php",
		data: {id_empresa: id_empresa, id_contrato:id_contrato},
		type: "POST",
		success: function(rst){
			$("#tbody_lista_atestes").html(rst);
		}
	});
}