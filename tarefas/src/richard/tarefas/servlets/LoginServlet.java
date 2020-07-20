package richard.tarefas.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import richard.tarefas.DAO.UsuarioDAO;
import richard.tarefas.senhas.Senha;


@SuppressWarnings("serial")
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		
		if (req.getParameter("email")==null || req.getParameter("email").isEmpty() 
				|| req.getParameter("senha")==null || req.getParameter("senha").isEmpty()) {
				res.sendRedirect("./?erro=campoVazio");
			} else {
				
				String criptografia = "SHA-224";
				String email = req.getParameter("email");
				String senha = req.getParameter("senha");
				String busca = "todas";
				Senha senhaCrua = new Senha();
				String criptografada = "";
				
				try {
					criptografada = senhaCrua.criptografar(senha, criptografia);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				UsuarioDAO usuarioDao = new UsuarioDAO();
				int resultado = usuarioDao.login(email, criptografada);
				
				if (resultado!=0) {
					HttpSession sessao = req.getSession();
					sessao.setAttribute("id", resultado);
					sessao.setAttribute("email", email);
					sessao.setAttribute("busca", busca);
					res.sendRedirect("./");
				} else {
					res.sendRedirect("./?erro=usuarioNaoEncontrado");
				}
				
			}
	}
	
}
