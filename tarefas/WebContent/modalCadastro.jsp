<div class="modal fade" id="modalCadastro" tabindex="-1" role="dialog" aria-labelledby="modalCadastro" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header temaescuro text-light">
				<h5 class="modal-title" id="cadastrar">Cadastrar</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Cancelar">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="./acoes/acao_cadastrar.jsp" method="post">
				<div class="modal-body">
					<div class="form-group">
						<label for="nome">Nome:</label>
						<input type="text" class="form-control" id="nome" name="nome" maxlength="20" required>
					</div>
					<div class="form-group">
						<label for="sobrenome">Sobrenome:</label>
						<input type="text" class="form-control" id="sobrenome" name="sobrenome" maxlength="20" required>
					</div>
					<div class="form-group">
						<label for="email">E-mail:</label>
						<input class="form-control" type="email" id="email" name="email" maxlength="250" required>
					</div>
					<div class="form-group">
						<label for="senha">Senha:</label>
						<input class="form-control" type="password" id="senha" name="senha" maxlength="20" required>
					</div>
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Cancelar</button>
				<button type="submit" class="btn btn-outline-colorido" id="botao">Adicionar</button>
			</div>
			</form>
		</div>
	</div>
</div>