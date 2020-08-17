<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="richard.tarefas.DAO.Conectar" %>
<%@ page import="richard.tarefas.modelos.Tarefa" %>
<%@ page import="richard.tarefas.DAO.TarefasDAO" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="./elementos/header.jsp"></jsp:include>
	<title>Tarefas a fazer</title>
</head>

<%@include file="configuracoes.jsp"%>

<body class="d-flex flex-column text-muted">
	<div id="conteudo">
		<!-- navbar -->
		<%@include file="./elementos/navbar.jsp"%>
		<!-- páginas -->
		<div class="container-fluid">
			<div class="row justify-content-center">
				<%@include file="erros.jsp"%>
			</div>
			<div class="row d-flex justify-content-center">
			
			
			
				<% if(escolherJsp == "login") { %>
					<%@include file="./paginas/login.jsp"%>
				<% } else if(escolherJsp == "listarTarefas") { %>
					<%@include file="./paginas/listarTarefas.jsp"%>
				<% } else if(escolherJsp == "alterarSenha") { %>
					<%@include file="./paginas/alterarSenha.jsp"%>
				<% } %>
				
				
				
			</div>
		</div>
		<!-- fim de páginas -->
	</div>
	<%@include file="modalCadastro.jsp"%>
	<%@include file="modalTarefa.jsp"%>
	<jsp:include page="./elementos/footer.jsp"></jsp:include>
</body>

</html>