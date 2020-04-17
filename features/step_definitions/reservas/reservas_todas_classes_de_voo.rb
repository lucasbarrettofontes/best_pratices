Dado(/^preencho os detalhes do voo de acordo com o cenário de teste$/) do |tabela_detalhes_voo|
  @tabela_detalhes_voo = tabela_detalhes_voo
  @objeto_pesquisa_voo = PesquisaVoo.new
  @objeto_pesquisa_voo.inserir_detalhe_voo(@tabela_detalhes_voo)
  @objeto_pesquisa_voo.inserir_preferencias(@tabela_detalhes_voo)
  @objeto_pesquisa_voo.btn_continuar.click
end

Quando(/^seleciono pela compania e horario da partida "([^"]*)" e retorno "([^"]*)"$/) do |hora_partida, hora_retorno|
  @objeto_seleciona_voo = SelecionaVoo.new
  @hora_partida = hora_partida
  @hora_retorno = hora_retorno
  @compania = @tabela_detalhes_voo.hashes[0]['compania']
  @objeto_seleciona_voo.seleciona_partida_voo_com(@compania, @hora_partida)
  @objeto_seleciona_voo.seleciona_retorno_voo_com(@compania, @hora_retorno)
  @precos_voo = @objeto_seleciona_voo.pega_valor_preco_voo_com(@compania, @hora_partida, @hora_retorno)
  @objeto_seleciona_voo.btn_submiter.click
end

E(/^preencho agenda de voo com os dados do$/) do |tabela_agenda_voo|
  @objeto_agenda_voo = AgendaVoo.new
  @objeto_agenda_voo.preencher_passageiros(tabela_agenda_voo)
  @objeto_agenda_voo.preencher_cartao_de_credito(tabela_agenda_voo)
  @precos_tela_agendamento = @objeto_agenda_voo.retorna_preco_total_eou_taxas_voo(true, true)
  @objeto_agenda_voo.btn_compra_segura.click
end

E(/^preencho agenda de voo com os dados para gerar alert$/) do |tabela_agenda_voo|
  @objeto_agenda_voo = AgendaVoo.new
  @objeto_agenda_voo.preencher_passageiros(tabela_agenda_voo)
  @objeto_agenda_voo.preencher_cartao_de_credito(tabela_agenda_voo)
  @precos_tela_agendamento = @objeto_agenda_voo.retorna_preco_total_eou_taxas_voo(true, true)
  @objeto_agenda_voo.preencher_end_cobranca(tabela_agenda_voo)
  @objeto_agenda_voo.preencher_end_entrega(tabela_agenda_voo)
end

Então(/^valido se o foi gerado o registro do voo e a soma total da viagem$/) do
  @objeto_tela_confirmacao = ConfirmacaoVoo.new
  texto_confirmacao_voo = @objeto_tela_confirmacao.retorna_texto_label_confirmacao_voo
  preco_total_tela_seleciona_voo_mais_taxa = @precos_voo['preco_partida'].to_i + @precos_voo['preco_retorno'].to_i
  preco_total_tela_seleciona_voo_mais_taxa += @precos_tela_agendamento['taxa'].to_i
  # Validacoes
  expect(preco_total_tela_seleciona_voo_mais_taxa).to eql(@precos_tela_agendamento['preco_total'].to_i)
  expect(texto_confirmacao_voo).to include 'Flight Confirmation #'
end

Então(/^valido alert com mensagem da taxa extra para endereco de outro pais$/) do
  begin
    mensagem_alert = 'You have chosen a mailing location outside'\
    ' of the United States and its territories. An additional charge'\
    ' of $6.5 will be added as mailing charge.'
    expect(mensagem_alert).to eql(page.driver.browser.switch_to.alert.text)
  rescue StandardError => ex
    raise if ex.message.include? 'no alert open'
  end
end
