package richard.tarefas.DAO;
import java.sql.Connection;
import java.sql.DriverManager;

public class Conectar {
			
	public Connection getConexao() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection("jdbc:mysql://localhost/todoapp?useTimezone=true&serverTimezone=UTC","root","1234");
		} catch(Exception e) {
			throw new RuntimeException("Erro ao conectar: "+ e);
		}
	}
	
}
