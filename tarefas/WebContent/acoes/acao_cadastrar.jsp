<%@page import="richard.tarefas.modelos.Usuario" %>
<%@page import="richard.tarefas.DAO.UsuarioDAO" %>
<%@page import="richard.tarefas.senhas.Senha" %>
<%

String nome = request.getParameter("nome");
String sobrenome = request.getParameter("sobrenome");
String email = request.getParameter("email");
String senha = request.getParameter("senha");
String criptografia = "SHA-224";

if (nome.isEmpty() || sobrenome.isEmpty() || email.isEmpty() || senha.isEmpty()
		|| nome==null || sobrenome==null || email==null || senha==null) {
	response.sendRedirect("../?erro=campoVazio");
} else {
	try {
		Senha senhaCrua = new Senha();
		String criptografada = senhaCrua.criptografar(senha, criptografia);
		
		Usuario usuario = new Usuario();
		UsuarioDAO usuarioDao = new UsuarioDAO();
		usuario.setNome(nome);
		usuario.setSobrenome(sobrenome);
		usuario.setEmail(email);
		usuario.setSenha(criptografada);
		usuarioDao.inserir(usuario);
		response.sendRedirect("../?erro=sucesso");
	} catch (Exception e) {
		throw new Exception("Erro ao cadastrar: "+ e);
	}
}	

%>