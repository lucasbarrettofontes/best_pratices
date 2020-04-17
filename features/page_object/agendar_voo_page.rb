# Page selecionar voo
class AgendaVoo < SitePrism::Page
  # table sumario
  elements :tbl_sumario, :xpath, '//form[@name="bookflight"]//tbody/tr[2]//table'

  # Passageiro
  element :input_primeiro_nome, :xpath, '//input[@name="passFirst0"]'
  element :input_ultimo_nome, :xpath, '//input[@name="passLast0"]'
  elements :lista_refeicao, :xpath, '//select[@name="pass.0.meal"]'

  # Cartao de credito
  elements :lista_bandeira_cartao, :xpath, '//select[@name="creditCard"]'
  element :input_numero_cartao, :xpath, '//input[@name="creditnumber"]'
  elements :lista_mes_expiracao, :xpath, '//select[@name="cc_exp_dt_mn"]'
  elements :lista_ano_expiracao, :xpath, '//select[@name="cc_exp_dt_yr"]'
  element :input_cartao_credito_primeiro_nome, :xpath, '//input[@name="cc_frst_name"]'
  element :input_cartao_credito_meio_nome, :xpath, '//input[@name="cc_mid_name"]'
  element :input_cartao_credito_ultimo_nome, :xpath, '//input[@name="cc_last_name"]'

  # endereco de cobranca
  element :input_cobranca_end_entrega1, :xpath, '//input[@name="billAddress1"]'
  element :input_cobranca_end_entrega2, :xpath, '//input[@name="billAddress2"]'
  element :input_cobranca_cidade, :xpath, '//input[@name="billCity"]'
  element :input_cobranca_estado, :xpath, '//input[@name="billState"]'
  element :input_cobranca_cep, :xpath, '//input[@name="billZip"]'
  elements :lista_cobranca_pais, :xpath, '//select[@name="billCountry"]'

  # endereco de entrega
  element :input_entrega_end_entrega1, :xpath, '//input[@name="delAddress1"]'
  element :input_entrega_end_entrega2, :xpath, '//input[@name="delAddress2"]'
  element :input_entrega_cidade, :xpath, '//input[@name="delCity"]'
  element :input_entrega_estado, :xpath, '//input[@name="delState"]'
  element :input_entrega_cep, :xpath, '//input[@name="delZip"]'
  elements :lista_entrega_pais, :xpath, '//select[@name="delCountry"]'

  # Botao compra  segura
  element :btn_compra_segura, :xpath, '//input[@name="buyFlights"]'

  # metodo booleano, caso nao queira pegar valor total ou taxa passar false
  def retorna_preco_total_eou_taxas_voo(taxa, preco_total)
    precos = Hash.new {}
    if taxa
      posicao_taxa = tbl_sumario[0].text.index('Taxes:') + 'Taxes:'.to_s.length
      precos['taxa'] = tbl_sumario[0].text[posicao_taxa..posicao_taxa + 5].gsub(/[^0-9]/, '')
    end
    if preco_total
      posicao_preco_total = tbl_sumario[0].text.index('including taxes):') + 'including taxes):'.to_s.length
      precos['preco_total'] = tbl_sumario[0].text[posicao_preco_total..posicao_preco_total + 5].gsub(/[^0-9]/, '')
    end
    return precos
  end

  def preencher_passageiros(tabela_agenda_voo)
    # Preenchimento de campos
    input_primeiro_nome.set(tabela_agenda_voo.hashes[0]['primeiro_nome'])
    input_ultimo_nome.set(tabela_agenda_voo.hashes[0]['ultimo_nome'])
    lista_refeicao[0].select(tabela_agenda_voo.hashes[0]['refeicao'])
  end

  def preencher_cartao_de_credito(tabela_agenda_voo)
    # Preenchimento de campos
    lista_bandeira_cartao[0].select(tabela_agenda_voo.hashes[0]['bandeira_cartao'])
    input_numero_cartao.set(tabela_agenda_voo.hashes[0]['numero_cartao'])
    lista_mes_expiracao[0].select(tabela_agenda_voo.hashes[0]['mes_expiracao'])
    lista_ano_expiracao[0].select(tabela_agenda_voo.hashes[0]['ano_expiracao'])
    input_cartao_credito_primeiro_nome.set(tabela_agenda_voo.hashes[0]['cartao_primeiro_nome'])
    input_cartao_credito_meio_nome.set(tabela_agenda_voo.hashes[0]['cartao_meio_nome'])
    input_cartao_credito_ultimo_nome.set(tabela_agenda_voo.hashes[0]['cartao_ultimo_nome'])
  end

  def preencher_end_cobranca(tabela_agenda_voo)
    # Preenchimento de campos
    input_cobranca_end_entrega1.set(tabela_agenda_voo.hashes[0]['cobranca_end_entrega1'])
    input_cobranca_end_entrega2.set(tabela_agenda_voo.hashes[0]['cobranca_end_entrega2'])
    input_cobranca_cidade.set(tabela_agenda_voo.hashes[0]['cobranca_cidade'])
    input_cobranca_estado.set(tabela_agenda_voo.hashes[0]['cobranca_estado'])
    input_cobranca_cep.set(tabela_agenda_voo.hashes[0]['cobranca_cep'])
    lista_cobranca_pais[0].select(tabela_agenda_voo.hashes[0]['cobranca_pais'])
  end

  def preencher_end_entrega(tabela_agenda_voo)
    # Preenchimento de campos
    input_entrega_end_entrega1.set(tabela_agenda_voo.hashes[0]['entrega_end_entrega1'])
    input_entrega_end_entrega2.set(tabela_agenda_voo.hashes[0]['entrega_end_entrega2'])
    input_entrega_cidade.set(tabela_agenda_voo.hashes[0]['entrega_cidade'])
    input_entrega_estado.set(tabela_agenda_voo.hashes[0]['entrega_estado'])
    input_entrega_cep.set(tabela_agenda_voo.hashes[0]['entrega_cep'])
    lista_entrega_pais[0].select(tabela_agenda_voo.hashes[0]['entrega_pais'])
  end
end
