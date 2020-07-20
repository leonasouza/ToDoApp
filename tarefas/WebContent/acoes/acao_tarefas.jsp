<%@page import="richard.tarefas.modelos.Tarefa" %>
<%@page import="richard.tarefas.DAO.TarefasDAO" %>
<%@page import="java.sql.Date" %>
<%@page import="java.sql.Time" %>
<%

request.setCharacterEncoding("UTF-8");
String titulo = request.getParameter("titulo");
String descricao = request.getParameter("descricao");
String data = request.getParameter("data");
String hora = request.getParameter("hora");
String acao = request.getParameter("acao");
boolean terminada = Boolean.parseBoolean(request.getParameter("terminada"));
int idUsuario = (int) session.getAttribute("id");
int idTarefa = Integer.parseInt(request.getParameter("idTarefa"));
boolean continuar = true;

if (titulo==null || descricao==null || titulo.isEmpty() || titulo.isEmpty()) {
	continuar = false;
}
	
switch (acao) {
	case "salvar":
		if (continuar) {
			try {
				Tarefa tarefa = new Tarefa();
				TarefasDAO tarefaDao = new TarefasDAO();
				tarefa.setTitulo(titulo);
				tarefa.setDescricao(descricao);
				tarefa.setDia(data);
				tarefa.setHora(hora);
				tarefa.setTerminada(terminada);
				tarefaDao.adicionar(tarefa, idUsuario);
				response.sendRedirect("../");
			} catch (Exception e) {
				throw new Exception("Erro ao inserir tarefa: "+ e);
			}
		} else {
			response.sendRedirect("../?erro=salvarTarefa");
		}
		break;
		
	case "alterar":
		if (continuar) {
			try {
				Tarefa tarefa = new Tarefa();
				TarefasDAO tarefaDao = new TarefasDAO();
				tarefa.setId(idTarefa);
				tarefa.setTitulo(titulo);
				tarefa.setDescricao(descricao);
				tarefa.setDia(data);
				tarefa.setHora(hora);
				tarefa.setTerminada(terminada);
				tarefaDao.alterar(tarefa, idTarefa, idUsuario);
				//response.sendRedirect("../adicionarTarefa.jsp?editar=sim&id="+idTarefa);
				response.sendRedirect("../");
			} catch (Exception e) {
				throw new Exception("Erro ao alterar: "+ e);
			}
		} else {
			response.sendRedirect("../?erro=alterarTarefa");
		}
		break;
		
	case "concluir":
		try {
			boolean permissao = false;
			TarefasDAO tarefaDao = new TarefasDAO();
			permissao = tarefaDao.permissao(idTarefa, idUsuario);
			if (permissao) {
				tarefaDao.concluir(idTarefa, idUsuario);
				response.sendRedirect("../");
			}
		} catch (Exception e) {
			throw new RuntimeException("Erro ao atualizar: "+ e);
		}
		break;
		
	case "pendente":
		try {
			TarefasDAO tarefaDao = new TarefasDAO();
			boolean permissao = tarefaDao.permissao(idTarefa, idUsuario);
			if (permissao) {
				tarefaDao.pendente(idTarefa, idUsuario);
				response.sendRedirect("../");
			}
		} catch (Exception e) {
			throw new RuntimeException("Erro ao atualizar: "+ e);
		}
		break;
		
	case "excluir":
		try {
			TarefasDAO tarefaDao = new TarefasDAO();
			boolean permissao = tarefaDao.permissao(idTarefa, idUsuario);
			if (permissao) {
				tarefaDao.excluir(idTarefa, idUsuario);
				response.sendRedirect("../");	
			}
		} catch (Exception e) {
			throw new RuntimeException("Erro ao excluir: "+ e);
		}
		break;	
	
}

%>