# Page selecionar voo
class SelecionaVoo < SitePrism::Page
  elements :tbl_partida, :xpath, '//form[@name="results"]/table[1]/tbody//tr'
  elements :tbl_retorno, :xpath, '//form[@name="results"]/table[2]/tbody//tr'
  elements :tbl_partida_retorno, :xpath, '//form[@name="results"]/table'
  element :btn_submiter, :xpath, '//input[@name="reserveFlights"]'

  def seleciona_partida_voo_com(compania, hora_partida)
    return nil if hora_partida.nil?
    tbl_partida.each do |tr|
      if tr.text.include? hora_partida and tr.text.include? compania
        tr.all('input').each { |ipt| ipt.set(true) }
        break
      end
    end
  end

  def seleciona_retorno_voo_com(compania, hora_retorno)
    return nil if hora_retorno.nil?
    tbl_retorno.each do |tr|
      if tr.text.include? hora_retorno and tr.text.include? compania
        tr.all('input').each { |ipt| ipt.set(true) }
        break
      end
    end
  end

  # paga valor de partida e de retorno, caso nao queira pegar o valor de um horario ou partida
  # ou retorno, passar o parametro vazio. Se ambos parametros tiverem vazios, retorna nil
  # TODO: Metodo um pouco conplexo, tentar melhorar
  def pega_valor_preco_voo_com(compania, hora_partida, hora_retorno)
    if hora_partida != '' || hora_retorno != '' # retorna nil caso nao tenha preenchido variaveis
      precos_encontrados = Hash.new {}
      tbl_partida_retorno.each do |tr|
        if hora_partida != '' and tr.text.include? hora_partida and tr.text.include? compania
          posicao_preco_no_texto = tr.text.index(hora_partida) + hora_partida.length # Pega somente valor no texto cortado
          precos_encontrados['preco_partida'] = tr.text[posicao_preco_no_texto..posicao_preco_no_texto + 22].gsub(/[^0-9]/, '')
        elsif hora_retorno != '' and tr.text.include? hora_retorno and tr.text.include? compania
          posicao_preco_no_texto = tr.text.index(hora_retorno) + hora_retorno.length + 1
          precos_encontrados['preco_retorno'] = tr.text[posicao_preco_no_texto..posicao_preco_no_texto + 22].gsub(/[^0-9]/, '')
        end
      end
    end
    return precos_encontrados
  end
end
