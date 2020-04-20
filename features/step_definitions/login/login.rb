
Dado(/^que eu esteja logado no sistema de Reserva de Voo com usuario default$/) do
  usuario = $massa_default_login['usuario']
  senha = $massa_default_login['senha']
  
  # visit ('http://newtours.demoaut.com/mercurysignon.php')
  @login = Login.new
  @login.load
  @login.login_sistema_reserva_de_voo(usuario, senha)
end
