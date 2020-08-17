<ul class="pagination justify-content-center">
		<li class="page-item <%=primeira%>"><a class="page-link" href="?pagina=1">Primeira</a></li>
		<li class="page-item <%=primeira%>"><a class="page-link" href="?pagina=<%=pagina-1%>"><</a></li>
		
		<%
		for(int i=1; i<=paginas; i++) { 
		
		if (pagina == i)
			desativar = "disabled";
		else
			desativar = "";
		%>
			<li class="page-item <%=desativar%>"><a class="page-link" href="?pagina=<%=i%>"><%=i%></a></li>
		<% } %>
		
		<li class="page-item <%=ultima%>"><a class="page-link" href="?pagina=<%=pagina+1%>">></a></li>
		<li class="page-item <%=ultima%>"><a class="page-link" href="?pagina=<%=paginas%>">Última</a></li>
	</ul>