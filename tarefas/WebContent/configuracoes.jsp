<%

//Declara a vari�vel para decidir qual p�gina ser� exibida entre a listagem de tarefas ou alterar a senha
String escolherJsp = (request.getParameter("p") == null) ? "listarTarefas" : request.getParameter("p");
		
//Declara a vari�vel para testar se o usu�rio est� logado ou n�o
boolean naoLogado = false;

if (session.getAttribute("email") == null || session.getAttribute("id") == null) {
	naoLogado = true;
	escolherJsp = "login";
}

%>