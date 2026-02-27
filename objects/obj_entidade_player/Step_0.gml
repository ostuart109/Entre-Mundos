#region Usando Métodos

//Colisão
//colisao() ;

//Animações Gemaplys
animacao() ;

viaja_tempo() ;

#endregion

// Sincronizando o sprite_index para que o image_index respeite a quantidade de frames de cada sprite
// Isso evita o "pulo" na animação quando trocamos de sprites com números de frames diferentes
// Sem isso, o image_index vai bugar todo
if (sprite_index != sprite)
{
    sprite_index = sprite;
    image_index = 0;
}

//Diminuindo o Delay de tempo
delay_tempo--;

//Zerando a velocidade se o dialogo estiver aberto
if global.dialogo_aberto == true
{
	velh = 0
	velv = 0

	//estado = estado_parado 	// Removido para permitir estado_dialogo
}
else
{



}

if (keyboard_check_released(ord("C")))
{
	room_goto(rm_corredor) ;
}


if (keyboard_check_released(ord("Q")))
{
	room_goto(rm_quarto) ;
}

if (keyboard_check_released(ord("G")))
{
	room_goto(rm_cozinha) ;
}

if (keyboard_check_released(ord("R")))
{
	room_goto(rm_quintal) ;
}