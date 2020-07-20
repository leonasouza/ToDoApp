package richard.tarefas.senhas;

import richard.tarefas.DAO.UsuarioDAO;
import java.security.MessageDigest;

public class Senha {

	public String criptografar(String senha, String algoritmo) throws Exception {
		String senhaFinal = "";
		try {
			MessageDigest messageDigest = MessageDigest.getInstance(algoritmo);
			messageDigest.update(senha.getBytes("UTF-8"));
			byte[] digestedBytes = messageDigest.digest();
			StringBuilder sb = new StringBuilder();
			for (byte b : digestedBytes) {
				sb.append(String.format("%02X", 0xFF & b));
			}
			
			senhaFinal = sb.toString().toLowerCase();
		} catch (Exception e) {
			throw new Exception("Erro ao criptografar senha");
		}
		return senhaFinal;
	}
	
	public boolean confirmar(String senhaAntiga, int idUsuario) {
		boolean retorno = false;
		
		try {
			UsuarioDAO usuarioDao = new UsuarioDAO();
			if (usuarioDao.compararSenha(senhaAntiga, idUsuario))
				retorno = true;
		} catch(Exception e) {
			throw new RuntimeException("Erro ao conferir a senha atual");
		}
		return retorno;
	}
	
}