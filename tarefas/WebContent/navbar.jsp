		<nav class="navbar navbar-expand-lg navbar-dark temaescuro mb-2">
			<div class="mx-auto d-sm-flex">
				<a class="navbar-brand" href="./todas"> 
					<i class="fas fa-tasks"></i> Lista de Tarefas
				</a>
				<%
					//Verifica se está logado e exibe opções para usuários logados
					if (!naoLogado) {
				%>
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    				<span class="navbar-toggler-icon"></span>
  				</button>
  				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link" href="#modalTarefa" data-target="#modalTarefa" data-toggle="modal">Adicionar</a></li>
						<li class="nav-item"><a class="nav-link" href="./todas">Ver todas</a>
						<li class="nav-item"><a class="nav-link" href="./pendentes">Pendentes</a></li>
						<li class="nav-item"><a class="nav-link" href="./concluidas">Concluídas</a></li>
						<li class="nav-item"><a class="nav-link" href="./alterarSenha">Alterar senha</a>
						<li class="nav-item"><a class="nav-link" href="./logout">Logout</a></li>
					</ul>
				</div>
				<%
					} // fim if (!bloquear)
				%>
			</div>
		</nav>