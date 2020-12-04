var tag = "table";

$("#select_empresa").on("change", function(ev) {
	ev.preventDefault();
	var id_empresa = $(this).find("option:selected").val();

	if(id_empresa == "")
		$('#div_contratos_empresa').hide();
	else
		montarListaContrato(id_empresa, tag);
});

function montarListaContrato(id_empresa, tag) {
	$.ajax({
		url: "actions/contrato_lista_montar.php",
		data: {id_empresa: id_empresa, tag:tag},
		type: "POST",
		success: function(rst){
			$("#tbody_lista_contrato").html(rst);
			$('#div_contratos_empresa').show();
		}
	});
}

$("#form_contrato").on("submit", function(ev) {
	ev.preventDefault();
	var radio = $(this).find("input[type=radio]:checked").val();
	var id_empresa = $(this).find("select[name=id_empresa] option:selected").val();
	if(typeof id_empresa === 'undefined')
		id_empresa = $('#hd_id_empresa').val();

	if(typeof radio === 'undefined') {
		$(this).find(".radio").attr("class", "radio state-error");
	} else {
		var dados = $(this).serialize();
		var existe_contrato = $(this).find("input[name=existe_contrato]").val();
		var complemento 	= (existe_contrato == 0 ? "inserção de novo" : "alteração do");

		$.SmartMessageBox({
			title : "Confirma " + complemento + " contrato ?",
			buttons : '[Não][Sim]'
		}, function(opcao) {
			if (opcao === "Sim") {

				$.ajax({
					url: "actions/contrato_inserir_alterar.php",
					data: dados,
					type: "POST",
					success: function(rst){
						var rs = rst.split("_");
						var inserido = parseInt(rs[0]);
						var mensagem = rs[1];

						if(inserido){
							var id_contrato = rs[2];
							$("li").show();
							$("#dados_gerais").attr("class", "");
							$("#penalidades").attr("class", "active");
							$("#t1").attr("class","tab-pane fade");
							$("#t2").attr("class","tab-pane fade in active");
							$("input[name=id_contrato]").val(id_contrato);
							$(this).find(".radio").attr("class", "radio");
							//$("#buttons_contrato").hide();
							$("#select_empresa option[value='"+id_empresa+"']").prop('selected', true);
							montarListaContrato(id_empresa, tag);
						}
						alert(mensagem);
					},
				});
			}
		});
	}
});

$("#form_penalidades").on("submit", function(ev) {
	ev.preventDefault();
	var dados = $(this).serialize();

	var id_contrato = $(this).find("input[name=id_contrato]").val();
	var ids_tipo_penalidade = [];

	$(this).find("input[name='id_tipo_penalidade']:checked").each(function(){
		ids_tipo_penalidade.push(this.value);
	});

	$.ajax({
		url: "actions/contrato_tipo_penalidade_inserir.php",
		data: {id_contrato:id_contrato, ids_tipo_penalidade:ids_tipo_penalidade},
		type: "POST",
		success: function(rst){
			var rs = rst.split("_");
			var inserido = parseInt(rs[0]);
			var mensagem = rs[1];

			if(inserido)
				alert(mensagem);
		},
	});

});

function removerContrato(id_contrato) {
	var id_empresa  = $('#id_empresa').val();
	var usuario_alteracao = $("#log_user").text();

	$.SmartMessageBox({
		title : "Confirma remoção do contrato ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {

			$.ajax({
				url: "actions/contrato_remover.php",
				data: {id_contrato:id_contrato, usuario_alteracao:usuario_alteracao},
				type: "POST",
				success: function(rst){
					var rs = rst.split("_");
					var removido = parseInt(rs[0]);
					var mensagem = rs[1];

					if(removido)
						montarListaContrato(id_empresa, tag);
					alert(mensagem);
				},
			});
		}
	});
}

$('.data').focusout(function(ev) {
	var data = $(this).val();
	if (!ehDataValida(data))
		$(this).val('');
});

function ehDataValida(data) {

	if(!/^\d{2}\/\d{2}\/\d{4}$/.test(data))
		return false;

	var parts = data.split("/");
	var day   = parseInt(parts[0], 10);
	var month = parseInt(parts[1], 10);
	var year  = parseInt(parts[2], 10);

	if(year < 2016 || year > 3000 || month == 0 || month > 12)
		return false;

	var monthLength = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

	if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
		monthLength[1] = 29;

	return day > 0 && day <= monthLength[month - 1];
}

$(".radio").on("click", function(ev){
	$(".radio").attr("class", "radio");
});

$('.data').mask('00/00/0000', {clearIfNotMatch: true});
$('.valor').mask('000.000.000.000,00', {reverse: true});