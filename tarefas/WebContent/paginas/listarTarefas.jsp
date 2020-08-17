<div class="col-xl-5 col-lg-8 col-md-8 col-sm-12">
	<%
	TarefasDAO tarefaDao = new TarefasDAO();
	
	//Transforma em variável string qual tipo de tarefas serão exibidas
	String sqlBusca = (String) session.getAttribute("busca");
	
	//Variáveis de paginação
	int pagina = request.getParameter("pagina") == null ? 1 : Integer.parseInt(request.getParameter("pagina"));
	int limite = 4; //limite de tarefas por página
	int offset = limite * pagina - limite;
	int paginas = tarefaDao.contarPaginas(sqlBusca, (int) session.getAttribute("id"));
	
	//Variável para desabilitar links de paginação caso a página esteja sendo exibida
	String desativar = "";

	if (paginas % limite != 0)
		paginas = (paginas / limite) + 1;
	else 
		paginas = paginas / limite;

	String primeira = (pagina == 1) ? "disabled" : "";
	String ultima = (pagina == paginas) ? "disabled" : "";
	
	//Começa a listagem de tarefas
	ArrayList<Tarefa> listaDeTarefas = tarefaDao.listarTarefas((int) session.getAttribute("id"), sqlBusca, limite, offset);
	
	if (listaDeTarefas.size() == 0) {
	out.println(
			"<a href=\"#modalTarefa\" data-target=\"#modalTarefa\" data-toggle=\"modal\"><h1 class=\"display1 text-center\">Adicione uma tarefa</h1></a>");
	} else {
		for (int i = 0; i < listaDeTarefas.size(); i++) {		
	%>

	<div class="card mb-2">
		<h5 class="card-header temaclaro text-light">
		    <%=listaDeTarefas.get(i).getTitulo()%>
	  	</h5>
	  	<div class="card-body text-justify">
		    <p class="card-title"><%=listaDeTarefas.get(i).getDescricao()%></p>
		    <p class="card-text">
				<strong>Data:</strong> <%=listaDeTarefas.get(i).getDiaFormatado()%>
	    		<strong>às:</strong> <%=listaDeTarefas.get(i).getHora()%>h
				<br>
				<strong>Concluída?</strong>
				<%
				if (listaDeTarefas.get(i).isTerminada())
					out.println("sim");
				else
					out.println("não");
				%>
	    	</p>
	    	<div class="d-flex justify-content-center">
	    		<form 
	    			action="./acoes/acao_tarefas.jsp" 
	    			method="post" id="formularioExcluir" 
	    			onsubmit="return confirm('Deseja realmente excluir essa tarefa?')"
	    		>
					<input type="hidden" name="acao" value="excluir">
					<input type="hidden" name="idTarefa" value="<%=listaDeTarefas.get(i).getId()%>">
					<button class="btn btn-outline-danger btn-sm" type="submit">Excluir tarefa</button>
				</form>
				
				<button 
		    		type="button"
	    			class="btn btn-outline-colorido ml-3 btn-sm"
	    			data-toggle="modal"
	    			data-target="#modalTarefa"
	    			data-tarefaid="<%=listaDeTarefas.get(i).getId()%>"
	    			data-tarefatitulo="<%=listaDeTarefas.get(i).getTitulo()%>"
	    			data-tarefadescricao="<%=listaDeTarefas.get(i).getDescricao()%>"
	    			data-tarefadata="<%=listaDeTarefas.get(i).getDia()%>"
	    			data-tarefahora="<%=listaDeTarefas.get(i).getHora()%>"
	    			data-tarefaterminada="<%=listaDeTarefas.get(i).isTerminada()%>"
	    		>
			    	Alterar tarefa
		    	</button>
			
				<%
				String botaoAcao = "";
				String botaoCss = "";
				String botaoTexto = "";
				
				if (!listaDeTarefas.get(i).isTerminada()) {
					botaoAcao = "concluir";
					botaoCss = "btn btn-colorido";
					botaoTexto = "Marcar como concluída";
				} else {
					botaoAcao = "pendente";
					botaoCss = "btn btn-outline-colorido";
					botaoTexto = "Marcar como Pendente";
				}
				%>
			
				<form action="./acoes/acao_tarefas.jsp" method="post">
					<input type="hidden" name="idTarefa" value="<%=listaDeTarefas.get(i).getId()%>">
					<input type="hidden" name="idUsuario" value="<%=session.getAttribute("id")%>">
					<input type="hidden" name="acao" value="<%=botaoAcao%>">
					<button type="submit" class="<%=botaoCss%> ml-3 btn-sm"><%=botaoTexto%></button>
				</form>
	
			</div>
		</div>
	</div>
	
	<%
		}
	}
	%>
	<%@include file="paginacao.jsp"%>
</div>