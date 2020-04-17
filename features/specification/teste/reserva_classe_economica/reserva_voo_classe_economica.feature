# language: pt
@reserva_voo_classe_economica_1
@sprint_3
@reserva_voo
@classe_economica
Funcionalidade: Reserva Voo Internacional Classe Economica
 Como usuário do sistema
 Posso solicitar o agendamento de voo Internacional
 Para Validar o funcionamento da reserva de Voo na Classe Economica

Contexto: Acessando o Sistema De Reserva de Voo
  Dado que eu esteja logado no sistema de Reserva de Voo com usuario default

@validar_valores_totais_voo_classe_economica
Cenario: Validar os valores totais do Voo e a geracao do mesmo
  Dado preencho os detalhes do voo de acordo com o cenário de teste
  |   tipo_voo     | passageiros | partindo_de | mes_partida       | dia_partida | destino | mes_retorno       | dia_retorno | tipo_classe      | compania           |
  |  ida_e_volta   |    	1      |  Frankfurt  |		December       |	 18        |	Paris  |     February		   |		 21      |  Economy class   | Blue Skies Airlines|
  Quando seleciono pela compania e horario da partida "7:10" e retorno "14:30"
  E preencho agenda de voo com os dados do
  |   primeiro_nome     | ultimo_nome | refeicao | bandeira_cartao   | numero_cartao       | mes_expiracao | ano_expiracao | cartao_primeiro_nome | cartao_meio_nome       | cartao_ultimo_nome  | cobranca_end_entrega1  | cobranca_end_entrega2   | cobranca_cidade | cobranca_estado |cobranca_cep | cobranca_pais | entrega_end_entrega1 | entrega_end_entrega2   | entrega_cidade  | entrega_estado |entrega_cep  | entrega_pais  |
  |  teste workshop DB  | ultimonome  |  Hindu   |		Visa           |	0493857723873805   |	     10      |     2010		   |	 Automacao_Ruby     |    Workshop_DBserver   | Ultimo_dos_ultimos  | cobranca Endereco res  | cobranca Endereco res_2 |      Cotia      |                 |             |               | entrega Endereco res | entrega Endereco res_2 |     Osasco      |                |             |               |
  Então valido se o foi gerado o registro do voo e a soma total da viagem


@validar_alert_endereco_fora_pais_classe_economica
Cenario: Validar alert quando endereco for fora do Pais
  Dado preencho os detalhes do voo de acordo com o cenário de teste
  |   tipo_voo     | passageiros | partindo_de | mes_partida       | dia_partida | destino | mes_retorno       | dia_retorno | tipo_classe      | compania       |
  |  ida_e_volta   |    	1      |  Frankfurt  |		December       |	 18        |	Paris  |     February		   |		 21      |  Economy class   |Unified Airlines|
  Quando seleciono pela compania e horario da partida "11:24" e retorno "18:44"
  E preencho agenda de voo com os dados para gerar alert
  |   primeiro_nome     | ultimo_nome | refeicao | bandeira_cartao   | numero_cartao       | mes_expiracao | ano_expiracao | cartao_primeiro_nome | cartao_meio_nome       | cartao_ultimo_nome  | cobranca_end_entrega1  | cobranca_end_entrega2   | cobranca_cidade | cobranca_estado |cobranca_cep | cobranca_pais | entrega_end_entrega1 | entrega_end_entrega2   | entrega_cidade  | entrega_estado |entrega_cep  | entrega_pais  |
  |  teste workshop DB  | ultimonome  |  Hindu   |		Visa           |	0493857723873805   |	     10      |     2010		   |	 Automacao_Ruby     |    Workshop_DBserver   | Ultimo_dos_ultimos  | cobranca Endereco res  | cobranca Endereco res_2 |      Cotia      |         SP      |   0533100   |   AUSTRALIA   | entrega Endereco res | entrega Endereco res_2 |     Osasco      |        SP      |   0533100   |   ARGENTINA   |
  Então valido alert com mensagem da taxa extra para endereco de outro pais
