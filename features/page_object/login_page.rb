#  Classe Login
class Login < SitePrism::Page
  set_url 'http://newtours.demoaut.com/mercurysignon.php'

  element :input_usuario, :xpath, '//input[@name="userName"]'
  element :input_senha, :xpath, '//input[@name="password"]'
  element :btn_submeter, :xpath, '//form[@name="register"]//input[@type="image"]'

  def login_sistema_reserva_de_voo(usuario, senha)
    input_usuario.set(usuario)
    input_senha.set(senha)
    btn_submeter.click
  end
end
