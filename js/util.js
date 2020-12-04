function removerCaracteresEspeciais(str) {
	str = str.trim();
	str = str.replace(/[&\\#,&¬¨ªº°´`^~@§|%()$.'":*?<>{}¹²³£¢+]/g,'');
	return str;
}
function removerAspas(str) {
	str = str.trim();
	str = str.replace(/['"]/g,'');
	return str;
}