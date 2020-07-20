<%@page import="richard.tarefas.DAO.Conectar" %>
<%@page import="richard.tarefas.DAO.UsuarioDAO" %>
<%@page import="richard.tarefas.modelos.Usuario" %>
<%@page import="richard.tarefas.senhas.Senha" %>
<%

String criptografia = "SHA-224";

if (request.getParameter("email")==null || request.getParameter("email").isEmpty() 
	|| request.getParameter("senha")==null || request.getParameter("senha").isEmpty()) {
	response.sendRedirect("../?erro=campoVazio");
} else {
	String email = request.getParameter("email");
	String senha = request.getParameter("senha");
	String busca = "todas";
	Senha senhaCrua = new Senha();
	String criptografada = senhaCrua.criptografar(senha, criptografia);
	UsuarioDAO usuarioDao = new UsuarioDAO();
	int resultado = usuarioDao.login(email, criptografada);
	
	if (resultado!=0) {
		session.setAttribute("id", resultado);
		session.setAttribute("email", email);
		session.setAttribute("busca",busca);
		response.sendRedirect("../");
	} else {
		response.sendRedirect("../?erro=usuarioNaoEncontrado");
	}
	
}

%>