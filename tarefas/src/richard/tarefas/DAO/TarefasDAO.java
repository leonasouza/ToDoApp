package richard.tarefas.DAO;

import richard.tarefas.modelos.Tarefa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;

public class TarefasDAO {
	
	private Connection conexao;
	private PreparedStatement preparedStatement;
	private Statement statement;
	private ResultSet resultSet;
	private ArrayList<Tarefa> listaDeTarefas = new ArrayList<>(); 
	private ArrayList<Tarefa> dadosDaTarefa = new ArrayList<>();
	private boolean permissao = false;
	
	public TarefasDAO() {
		conexao = new Conectar().getConexao();
	}
	
	public void adicionar(Tarefa tarefa, int id) {
		String sql = "INSERT INTO "
				+ "tarefas (tarefas_titulo, tarefas_descricao, tarefas_dia, tarefas_hora, tarefas_terminada, tarefas_usuario)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		try {
			preparedStatement = conexao.prepareStatement(sql);
			preparedStatement.setString(1, tarefa.getTitulo());
			preparedStatement.setString(2, tarefa.getDescricao());
			preparedStatement.setString(3, tarefa.getDia());
			preparedStatement.setString(4, tarefa.getHora());
			preparedStatement.setBoolean(5, tarefa.isTerminada());
			preparedStatement.setInt(6, id);
			preparedStatement.execute();
			preparedStatement.close();
		} catch (Exception e) {
			throw new RuntimeException("Erro ao adicionar tarefa: "+ e);
		}
	}
	
	public void alterar(Tarefa tarefa, int idTarefa, int idUsuario) {
		String sql = "UPDATE tarefas "
				+ "SET tarefas_titulo = ? , tarefas_descricao = ? , tarefas_dia = ? , tarefas_hora = ? , tarefas_terminada = ? "
				+ "WHERE tarefas_id = ? AND tarefas_usuario = ? LIMIT 1";
		try {
			preparedStatement = conexao.prepareStatement(sql);
			preparedStatement.setString(1, tarefa.getTitulo());
			preparedStatement.setString(2, tarefa.getDescricao());
			preparedStatement.setString(3, tarefa.getDia());
			preparedStatement.setString(4, tarefa.getHora());
			preparedStatement.setBoolean(5, tarefa.isTerminada());
			preparedStatement.setInt(6, tarefa.getId());
			preparedStatement.setInt(7, idUsuario);
			preparedStatement.execute();
			preparedStatement.close();
		} catch (Exception e) {
			throw new RuntimeException("Erro ao alterar tarefa: "+ e);
		}
	}
	
	public void excluir(int idTarefa, int idUsuario) {
		String sql = "DELETE FROM tarefas WHERE tarefas_id = '"+ idTarefa +"' AND tarefas_usuario = '"+ idUsuario +"' LIMIT 1";
		try {
			statement = conexao.createStatement();
			statement.execute(sql);
			statement.close();
		} catch (Exception e) {
			throw new RuntimeException("Erro ao excluir tarefa: "+ e);
		}
	}
	
	public void concluir(int idTarefa, int idUsuario) {
		String sql = "UPDATE tarefas SET tarefas_terminada='1' WHERE tarefas_id='"+ idTarefa +"' AND tarefas_usuario='"+ idUsuario +"' LIMIT 1";
		try {
			statement = conexao.createStatement();
			statement.execute(sql);
			statement.close();
		} catch(Exception e) {
			throw new RuntimeException("Erro ao marcar como concluída: "+ e);
		}
	}
	
	public void pendente(int idTarefa, int idUsuario) {
		String sql = "UPDATE tarefas SET tarefas_terminada='0' WHERE tarefas_id='"+ idTarefa +"' AND tarefas_usuario='"+ idUsuario +"' LIMIT 1";
		try {
			statement = conexao.createStatement();
			statement.execute(sql);
			statement.close();
		} catch(Exception e) {
			throw new RuntimeException("Erro ao marcar como pendente: "+ e);
		}
	}
	
	public ArrayList<Tarefa> listarTarefas(int idUsuario, String sql, int limite, int offset) {
		StringBuilder consulta = new StringBuilder();
		consulta.append("SELECT * FROM tarefas ")
		.append("WHERE tarefas_usuario='"+ idUsuario +"' ");
		
		if (sql == "pendentes")
			consulta.append("AND tarefas_terminada='0' ");
		else if (sql == "concluidas")
			consulta.append("AND tarefas_terminada='1' ");
			 
			consulta.append("ORDER BY tarefas_dia, tarefas_hora ASC ")
			.append("LIMIT "+ limite +" OFFSET "+ offset);
		
		try {
			statement = conexao.createStatement();
			resultSet = statement.executeQuery(consulta.toString());
			while (resultSet.next()) {
				Tarefa tarefa = new Tarefa();
				tarefa.setId(resultSet.getInt("tarefas_id"));
				tarefa.setTitulo(resultSet.getString("tarefas_titulo"));
				tarefa.setDescricao(resultSet.getString("tarefas_descricao"));
				tarefa.setTerminada(resultSet.getBoolean("tarefas_terminada"));
				tarefa.setDia(resultSet.getString("tarefas_dia"));
				
				DateFormat formatarData = new SimpleDateFormat("yyyy-MM-dd");
				Date data = formatarData.parse(resultSet.getString("tarefas_dia"));
				DateFormat dataFormatada = new SimpleDateFormat("dd/MM/yyyy");
				tarefa.setDiaFormatado(dataFormatada.format(data));
					
				DateFormat formatarHora = new SimpleDateFormat("HH:mm:ss");
				Date hora = formatarHora.parse(resultSet.getString("tarefas_hora"));
				DateFormat horaFormatada = new SimpleDateFormat("HH:mm");
				tarefa.setHora(horaFormatada.format(hora));
				
				listaDeTarefas.add(tarefa);
			}
			statement.close();
			return listaDeTarefas;
		} catch (Exception e) {
			throw new RuntimeException("Erro ao listar tarefas: "+ e);
		}
	}
	
	
	public ArrayList<Tarefa> dadosDeUmaTarefa(int id) {
		String sql = "SELECT * FROM tarefas WHERE tarefas_id='"+ id +"'";
		try {
			statement = conexao.createStatement();
			resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
				Tarefa tarefa = new Tarefa();
				tarefa.setId(id);
				tarefa.setTitulo(resultSet.getString("tarefas_titulo"));
				tarefa.setDescricao(resultSet.getString("tarefas_descricao"));
				tarefa.setDia(resultSet.getString("tarefas_dia"));
				tarefa.setHora(resultSet.getString("tarefas_hora"));
				tarefa.setTerminada(resultSet.getBoolean("tarefas_terminada"));
				dadosDaTarefa.add(tarefa);
			}
			statement.close();
			return dadosDaTarefa;
		} catch (Exception e) {
			throw new RuntimeException("Erro ao buscar dados: "+ e);
		}
	}
	
	public boolean permissao(int idTarefa, int idUsuario) {
		String sqlConferir = "SELECT tarefas_usuario FROM tarefas WHERE tarefas_id = '"+ idTarefa +"'";
		try {
			statement = conexao.createStatement();
			resultSet = statement.executeQuery(sqlConferir);
			while (resultSet.next()) {
				if (resultSet.getInt("tarefas_usuario")==idUsuario) {
					permissao = true;
				}
			}
			statement.close();
		} catch (Exception e) {
			throw new RuntimeException("Erro ao conferir as permissões: "+ e);
		}
		return permissao;
	}
	
	public int contarPaginas(String sql, int idUsuario) {
		int contagem = 0;
		switch (sql) {
		case "todas":
			sql = "SELECT COUNT(*) FROM tarefas " 
				+"WHERE tarefas_usuario='"+ idUsuario +"' ";
			break;
			
		case "pendentes":
			sql = "SELECT COUNT(*) FROM tarefas "
				+"WHERE tarefas_usuario='"+ idUsuario +"' "
				+"AND tarefas_terminada='0' ";
			break;
			
		case "concluidas":
			sql = "SELECT COUNT(*) FROM tarefas "
				+"WHERE tarefas_usuario='"+ idUsuario +"' "
				+"AND tarefas_terminada='1' ";
			break;
		}
		
		try {
			statement = conexao.createStatement();
			resultSet = statement.executeQuery(sql);
			resultSet.next();
			contagem = resultSet.getInt(1);
			statement.close();
		} catch (Exception e) {
			throw new RuntimeException("Erro ao contar as entradas existentes: "+ e);
		}
		return contagem;
	}

}
