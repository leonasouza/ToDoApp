<div class="modal fade" id="modalTarefa" tabindex="-1" role="dialog" aria-labelledby="modalTarefa" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header temaclaro text-light">
				<h5 class="modal-title" id="adicionar"></h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Cancelar">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<form action="./acoes/acao_tarefas.jsp" method="post">
			<input type="hidden" id="acao" name="acao" value="salvar">
			<input type="hidden" id="tarefaid" name="idTarefa" value="0"> 
				<div class="modal-body">
					<div class="form-group">
						<label for="titulo">Título:</label>
						<input type="text" class="form-control" id="titulo" name="titulo" value="">
					</div>
					<div class="form-group">
						<label for="descricao">Descrição:</label>
						<textarea class="form-control" id="descricao" name="descricao" rows="3"></textarea>
					</div>
					<div class="form-group">
						<label for="data">Data:</label>
						<input class="form-control" type="date" id="data" name="data" value="" required>
						<label for="hora">Hora:</label>
						<input class="form-control" type="time" id="hora" name="hora" value="" required>
					</div>
					<div class="form-group">
						<label for="concluida">Concluída?</label>
						<select class="custom-select" name="terminada" id="terminada">
							<option value="false">Não</option>
							<option value="true">Sim</option>
						</select>
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

<script type="text/javascript">
	$('#modalTarefa').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget) // Button that triggered the modal
		var updateid = button.data('tarefaid')
		var updatetitulo = button.data('tarefatitulo')
		var updatedescricao = button.data('tarefadescricao')
		var updatedata = button.data('tarefadata')
		var updatehora = button.data('tarefahora')
		var updateterminada = button.data('tarefaterminada')
		
		var modal = $(this)
		if (!updateid) {
			modal.find('.modal-title').text('Adicionar tarefa')
			modal.find('#acao').val('salvar')
			modal.find('#botao').text('Adicionar')
		} else {
			modal.find('.modal-title').text('Alterar tarefa')
			modal.find('#acao').val('alterar')
			modal.find('#tarefaid').val(updateid)
			modal.find('#botao').text('Alterar')
		}
		modal.find('#titulo').val(updatetitulo)
		modal.find('#descricao').val(updatedescricao)
		modal.find('#data').val(updatedata)
		modal.find('#hora').val(updatehora)
		if (updateterminada) {
			$('#terminada option:contains(Sim)').prop({selected: true});
		} else {
			$('#terminada option:contains(Não)').prop({selected: true});
		}		
	})
</script>