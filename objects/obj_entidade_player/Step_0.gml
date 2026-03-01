#region Usando Métodos

//transição de room
transicao_room() ;

//Profundidade do player
profundidade() ;

//Animações Gemaplys
animacao() ;

//Viajando no tempo
viaja_tempo() ;

//Evitando pulo
evita_pulo() ;

//Diminuindo o Delay de tempo
delay_tempo--;

//Zerando a velocidade se o dialogo estiver aberto
dialogo_aberto() ;

//Mostrando o nome da room
nome_da_room() ;

#endregion

//Fazendo ele só limpar a a agua da pia ao colidir com ela
if (global.tem_desentupidor and place_meeting(x, y, inst_632F6F81)) {
    global.usou_desentupidor = true;
}

//Fazendo ele lembrar a senha após inspecionar o cofre e ver a lapide
if (global.interagiu_cofre and place_meeting(x, y, inst_4F09BD94)) {
    global.lembrou_senha = true;
}

show_debug_message(global.interagiu_cofre)