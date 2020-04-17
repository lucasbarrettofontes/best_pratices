#  Classe Tela de Confirmacao
class ConfirmacaoVoo < SitePrism::Page
  # Label confirmacao
  elements :lbl_confirmacao, :xpath, '//td[@class="frame_header_info"]/table//font/b'

  def retorna_texto_label_confirmacao_voo
    return lbl_confirmacao[0].text
  end
end
