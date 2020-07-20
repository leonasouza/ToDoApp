<div class="col-xl-3 col-lg-6 col-md-6 col-sm-12">
	<div class="card mb-2">
		<h5 class="card-header temaclaro text-light">Alterar senha</h5>
		<div class="card-body text-justify">
			<form action="./acoes/acao_alterarSenha.jsp" method="post">
				<div class="form-group">
					<label for="senhaAtual">Digite sua senha atual:</label>
					<input class="form-control" type="password" id="senhaAtual" name="senhaAtual" maxlength="20" required>
				</div>
				<div class="form-group">
					<label for="senhaNova">Digite sua nova senha:</label>
					<input class="form-control" type="password" id="senhaNova" name="senhaNova" maxlength="20" required>
				</div>
				<div class="form-group">
					<label for="senhaConfirmada">Confirme sua nova senha:</label>
					<input class="form-control" type="password" id="senhaConfirmada" name="senhaConfirmada" maxlength="20" required>
				</div>
				<div class="modal-footer">
					<a href="./" type="button" class="btn btn-outline-secondary">Cancelar</a>
					<button type="submit" class="btn btn-outline-colorido" id="botao">Alterar senha</button>
				</div>
			</form>
		</div>
	</div>
</div>