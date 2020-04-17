#  Classe Tela de Pesquisa de Voo
class PesquisaVoo < SitePrism::Page
  #  Detalhes do Voo
  element :rdn_ida_e_volta, :xpath, '//input[@name="tripType" and @value="roundtrip"]'
  element :rdn_apenas_ida, :xpath, '//input[@name="tripType" and @value="oneway"]'
  elements :lista_passageiros, :xpath, '//select[@name="passCount"]'
  elements :lista_partindo_de, :xpath, '//select[@name="fromPort"]'
  elements :lista_mes_partida, :xpath, '//select[@name="fromMonth"]'
  elements :lista_dia_partida, :xpath, '//select[@name="fromDay"]'
  elements :lista_destino, :xpath, '//select[@name="toPort"]'
  elements :lista_mes_retorno, :xpath, '//select[@name="toMonth"]'
  elements :lista_dia_retorno, :xpath, '//select[@name="toDay"]'

  #  Preferencias
  element :rdn_classe_economica, :xpath, '//input[@name="servClass" and @value="Coach"]'
  element :rdn_classe_negocio, :xpath, '//input[@name="servClass" and @value="Business"]'
  element :rdn_primeira_classe, :xpath, '//input[@name="servClass" and @value="First"]'
  elements :lista_compania_aerea, :xpath, '//select[@name="airline"]'
  element :btn_continuar, :xpath, '//input[@name="findFlights"]'

  def inserir_detalhe_voo(tabela_detalhes_voo)
    #  preenchimento dos campos
    tabela_detalhes_voo.hashes[0]['tipo_voo'].nil? ? rdn_apenas_ida.set(true) : rdn_ida_e_volta.set(true)
    lista_passageiros[0].select(tabela_detalhes_voo.hashes[0]['passageiros'])
    lista_partindo_de[0].select(tabela_detalhes_voo.hashes[0]['partindo_de'])
    lista_mes_partida[0].select(tabela_detalhes_voo.hashes[0]['mes_partida'])
    lista_dia_partida[0].select(tabela_detalhes_voo.hashes[0]['dia_partida'])
    lista_destino[0].select(tabela_detalhes_voo.hashes[0]['destino'])
    lista_mes_retorno[0].select(tabela_detalhes_voo.hashes[0]['mes_retorno'])
    lista_dia_retorno[0].select(tabela_detalhes_voo.hashes[0]['dia_retorno'])
  end

  def inserir_preferencias(tabela_detalhes_voo)
    classe = tabela_detalhes_voo.hashes[0]['tipo_classe']
    compania = tabela_detalhes_voo.hashes[0]['compania']
    case classe
    when 'First class'
      rdn_primeira_classe.set(true)
    when 'Business class'
      rdn_classe_negocio.set(true)
    when 'Economy class'
      rdn_classe_economica.set(true)
    end
    lista_compania_aerea[0].select('Pangea Airlines')
  end
end
