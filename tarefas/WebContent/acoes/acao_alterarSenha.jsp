<%@page import="richard.tarefas.modelos.Usuario" %>
<%@page import="richard.tarefas.DAO.UsuarioDAO" %>
<%@page import="richard.tarefas.senhas.Senha" %>
<%
String senhaAtual = request.getParameter("senhaAtual");
String senhaNova = request.getParameter("senhaNova");
String senhaConfirmada = request.getParameter("senhaConfirmada");
String criptografia = "SHA-224";
int idUsuario = (int)session.getAttribute("id");

if (senhaAtual.isEmpty() || senhaNova.isEmpty() || senhaConfirmada.isEmpty() 
		|| senhaAtual==null || senhaNova==null || senhaConfirmada==null) {
	response.sendRedirect("../?erro=campoVazio");
} else {
	if (!senhaNova.equals(senhaConfirmada)) {
		response.sendRedirect("../alterarSenha?erro=senhasDiferentes");
	} else {
		Senha senhaCrua = new Senha();
		String antigaCriptografada = senhaCrua.criptografar(senhaAtual, criptografia);
		String novaCriptografada = senhaCrua.criptografar(senhaNova, criptografia);
		try {
			boolean confirmacao = senhaCrua.confirmar(antigaCriptografada, idUsuario);
			if (confirmacao) {
				UsuarioDAO usuarioDao = new UsuarioDAO();
				usuarioDao.atualizarSenha(novaCriptografada, idUsuario);
				response.sendRedirect("../?erro=atualizada");
			} else {
				response.sendRedirect("../alterarSenha?erro=senhaAtualErrada");
			}
		} catch (Exception e) {
			throw new Exception("Não foi possível confirmar a senha atual: " + e);
		}
	}
}
%>