package richard.tarefas.DAO;

import richard.tarefas.modelos.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;


public class UsuarioDAO {
	
	private Connection conexao;
	private PreparedStatement preparedStatement;
	private Statement statement;
	private ResultSet resultSet;
	
	public UsuarioDAO() {
		conexao = new Conectar().getConexao();
	}
	
	public void inserir(Usuario usuario) {
		String sql = "INSERT INTO "
				+ "usuarios (usuarios_nome, usuarios_sobrenome, usuarios_email, usuarios_senha) "
				+ "VALUES (?, ?, ?, ?)";
		try {
			preparedStatement = conexao.prepareStatement(sql);
			preparedStatement.setString(1, usuario.getNome());
			preparedStatement.setString(2, usuario.getSobrenome());
			preparedStatement.setString(3, usuario.getEmail());
			preparedStatement.setString(4, usuario.getSenha());
			preparedStatement.execute();
			preparedStatement.close();
			conexao.close();
		} catch (Exception e) {
			throw new RuntimeException("Erro ao inserir usuário: "+ e);
		}
	}
	
	public void alterar(Usuario usuario) {
		String sql = "UPDATE usuarios SET "
				+ "usuarios_nome = ? , "
				+ "usuarios_sobrenome = ? , "
				+ "usuarios_email = ? "
				+ "usuarios_senha = ? "
				+ "WHERE usuarios_id = ?";
		try {
			preparedStatement = conexao.prepareStatement(sql);
			preparedStatement.setString(1, usuario.getNome());
			preparedStatement.setString(2, usuario.getSobrenome());
			preparedStatement.setString(3, usuario.getEmail());
			preparedStatement.setString(4, usuario.getSenha());
			preparedStatement.execute();
			preparedStatement.close();
			conexao.close();
		} catch (Exception e) {
			throw new RuntimeException("Erro ao atualizar dados do usuário: "+ e);
		}
	}
	
	public int login(String email, String senha) {
		String sql = "SELECT usuarios_id FROM usuarios "
				+ "WHERE usuarios_email = '"+ email +"' "
				+ "AND usuarios_senha = '"+ senha +"' LIMIT 1";
		try {
			statement = conexao.createStatement();
			resultSet = statement.executeQuery(sql);
			if (resultSet.next()) {
				return resultSet.getInt("usuarios_id");
			} else {
				return 0;
			}
		} catch (Exception e) {
			throw new RuntimeException("Erro ao fazer login: "+ e);
		}
	}
	
	public boolean compararSenha(String senhaAntiga, int idUsuario) {
		boolean retorno = false;
		String sql = "SELECT usuarios_senha FROM usuarios WHERE usuarios_id='"+ idUsuario +"'";
		try {
			statement = conexao.createStatement();
			resultSet = statement.executeQuery(sql);
			while(resultSet.next()) {
				if (resultSet.getString("usuarios_senha").equals(senhaAntiga)) {
					retorno = true;
				}
			}
		} catch(Exception e) {
			throw new RuntimeException("Não foi possível conferir a senha atual: "+ e);
		}
		return retorno;
	}
	
	public void atualizarSenha(String senhaNova, int idUsuario) {
		String sql = "UPDATE usuarios SET usuarios_senha= ? WHERE usuarios_id='"+ idUsuario +"' LIMIT 1";
		try {
			preparedStatement = conexao.prepareStatement(sql);
			preparedStatement.setString(1, senhaNova);
			preparedStatement.execute();
			preparedStatement.close();
			conexao.close();
		} catch(Exception e) {
			throw new RuntimeException("Erro ao atualizar a senha: "+ e);
		}
	}
	
}
