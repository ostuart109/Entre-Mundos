#region Usando Métodos

//Colisão
//colisao() ;

//transição
if tp_cooldown > 0 tp_cooldown--;

if transition == 1
{
    trans_alpha += 0.05;
    if trans_alpha >= 1
    {
        trans_alpha = 1;
        transition  = 2;
        x = next_x;
        y = next_y;
        room_goto(next_room);
    }
}

if transition == 2
{
    trans_alpha -= 0.05;
    if trans_alpha <= 0
    {
        trans_alpha = 0;
        transition  = 0;
    }
}



//profundidade
depth = -(y + sprite_height - sprite_yoffset);


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


//Fazendo o nome da room desaparecer
if room_name_timer > 0
{
    room_name_timer--;
    if room_name_timer < 60 // último segundo faz fade out
        room_name_alpha = room_name_timer / 60;
}