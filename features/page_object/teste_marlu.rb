#  Classe Login
class Marlu < SitePrism::Page
  set_url 'http://www.automationpractice.com/'

  element :input_email, '#email_create'
  element :btn_submit, '#SubmitCreate'
  element :btn_sign, '//a[@class="login"]'

  element :lista, '#uniform-days'

  def preencher_campo_email_e_submeter()
    # btn_sign.click
    input_email.set("testiculo123@hotmail.com")
    btn_submit.click
  end

  def listar_alguem(alguem)
    lista.select(alguem)
  end
end
