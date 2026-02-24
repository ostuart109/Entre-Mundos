#region Usando Métodos

//Colisão
//colisao() ;

//Animações Gemaplys
animacao() ;

viaja_tempo() ;

//Vida do Player
vida_player() ;

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

//Checa se o objeto do Portal ta sendo destruído
//if (keyboard_check(ord("T")))
//{
//	var _checa_portal	= instance_number(obj_portal) ;

//	show_message(_checa_portal) ;	
//}