<%

if (request.getParameter("erro")!=null) {
	
	switch (request.getParameter("erro")) {
	
		case "sucesso":
			out.print("Opera��o realizada com sucesso");
			break;
		case "1":
			out.print("Confira se os campos foram preenchidos");
			break;
		case "campoVazio":
			out.print("Voc� n�o preencheu um ou mais campos obrigat�rios");
			break;
		case "usuarioNaoEncontrado":
			out.print("Usu�rio n�o encontrado");
			break;
		case "senhasDiferentes":
			out.print("Por favor, digite novamente a nova senha");
			break;
		case "atualizada":
			out.print("Senha atualizada");
			break;
		case "salvarTarefa":
			out.print("Ocorreu um erro ao adicionar a tarefa");
			break;
		case "alterarTarefa":
			out.print("Ocorreu um erro ao atualizar a tarefa");
			break;
		default:
			out.print("");
			break;
	}
	
}

%>