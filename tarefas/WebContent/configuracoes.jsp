<%

//Declara a variável para decidir qual página será exibida entre a listagem de tarefas ou alterar a senha
String escolherJsp = (request.getParameter("p") == null) ? "listarTarefas" : request.getParameter("p");
		
//Declara a variável para testar se o usuário está logado ou não
boolean naoLogado = false;

if (session.getAttribute("email") == null || session.getAttribute("id") == null) {
	naoLogado = true;
	escolherJsp = "login";
}

%>