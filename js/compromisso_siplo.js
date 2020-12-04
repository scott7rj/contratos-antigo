$("#form_siplo").on("submit", function(ev) {
	ev.preventDefault();
	var dados = $(this).serialize();
	var compromisso_siplo = $(this).find("input[name=compromisso_siplo]").val().toUpperCase();

	$.SmartMessageBox({
		title : "Confirma inserção do compromisso SIPLO : " + compromisso_siplo,
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {
			$.ajax({
				url: "actions/compromisso_siplo_inserir.php",
				data: dados,
				type: "POST",
				success: function(rst){
					var rs = rst.split("_");
					var inserido = parseInt(rs[0]);
					var mensagem = rs[1];

					if(inserido){
						var id_compromisso_siplo = rs[2];
						$("#compromissos_siplo").append("<tr id='cs"+id_compromisso_siplo+"'>" +
													 	"<td>"+compromisso_siplo+"</td>" +
													 	"<td align='center'>" +
													 	"<a href='#' onclick='removerSIPLO("+id_compromisso_siplo+")'>x</a></td>" +
														"</tr>");
						$("#form_siplo").trigger("reset");
					}
					alert(mensagem);
				},
			});
		}
	});
});

function removerSIPLO(id_compromisso_siplo) {
	var codigo_siplo = $("#cs"+id_compromisso_siplo).find("td:first-child").text();

	$.SmartMessageBox({
		title : "Confirma remoção do compromisso SIPLO : " + codigo_siplo + " ?",
		buttons : '[Não][Sim]'
	}, function(opcao) {
		if (opcao === "Sim") {

			$.ajax({
				url: "actions/compromisso_siplo_remover.php",
				data: {id_compromisso_siplo:id_compromisso_siplo},
				type: "POST",
				success: function(rst){
					var emp = rst.split("_");
					var removido = parseInt(emp[0]);
					var mensagem = emp[1];

					if(removido)
						$("#cs"+id_compromisso_siplo).remove();
					alert(mensagem);
				},
			});
		}
	});
}
/*
$('.siplo').mask('NNNNNN/NNNN-LL', {clearIfNotMatch: true, 'translation': {
		K: {pattern: /(M|B]/},
		L: {pattern: //},
		N: {pattern: /[0-9]/}
	}
});
*/

var e = document.getElementById('txt_compromisso_siplo');
e.addEventListener('keyup', (event) => {
	for (var j=0; j<e.value.length; j++) {
		console.log('j '+j + ' e.value[j] ' + e.value[j]);
		if (j == 0) {
			if (e.value[j] != '0' && e.value[j] != '1' && e.value[j] != '2' && e.value[j] != '3' && e.value[j] != '4' && e.value[j] != '5' && e.value[j] != '6' && e.value[j] != '7' && e.value[j] != '8' && e.value[j] != '9') {
				e.value = '';
			}
		} 
		if (j> 0 && j<6) {
			if (e.value[j] != '0' && e.value[j] != '1' && e.value[j] != '2' && e.value[j] != '3' && e.value[j] != '4' && e.value[j] != '5' && e.value[j] != '6' && e.value[j] != '7' && e.value[j] != '8' && e.value[j] != '9') {
				e.value = e.value.substring(0, j);
			}
		} 
		if (j == 6) {
			if (e.value[j] !== '/') {
				e.value = e.value.substring(0, j);
			}
		}
		if (j == 7) {
			if (e.value[j] !== '1' && e.value[j] !== '2') {
				e.value = e.value.substring(0, j);
			}
		}
		if (j >7 && j < 11) {
			if (e.value[j] != '0' && e.value[j] != '1' && e.value[j] != '2' && e.value[j] != '3' && e.value[j] != '4' && e.value[j] != '5' && e.value[j] != '6' && e.value[j] != '7' && e.value[j] != '8' && e.value[j] != '9') {
				e.value = e.value.substring(0, j);
			}
		}
		if (j == 11) {
			if (e.value[j] !== '-') {
				e.value = e.value.substring(0, j);
			}
		} 
		if (j == 12) {
			console.log('caracter 12: '+ e.value[j]);
			if (e.value[j] != 'M' && e.value[j] != 'B' && e.value[j] != 'm' && e.value[j] != 'b') {
				e.value = e.value.substring(0, j);
			}
		} 
		if (j == 13) {
			if ( (e.value[12] == 'M' || e.value[12] == 'm') && (e.value[13] != 'Z' && e.value[13] != 'z') ) {
				e.value = e.value.substring(0, j);
			}
			if ( (e.value[12] == 'B' || e.value[12] == 'b') && (e.value[13] != 'R' && e.value[13] != 'r') ) {
				e.value = e.value.substring(0, j);
			}
			
		}
	}
});