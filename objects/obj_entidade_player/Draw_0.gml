//====================== Animações =======================
	
//Desenhando sprites do personagem
	
//vou desenhar a sprite que estou usando
//sprite    - A sprite que estou usando
//xscale    - A escala que estou me movendo
draw_sprite_ext(sprite, image_index, x, y, xscale, image_yscale, image_angle, image_blend, image_alpha) ;

//========================================================

#region Usando Métodos

//Desenhando o Atual Estado do Player
desenha_estado() ;

//========================================================

#endregion

//Fazendo a barra sumir (Que aberração eu criei? Mas funciona né)
if delay_tempo == 0
opacidade_barra -= 0.02;

//Mudando a barra pra Yellow na metade
if delay_tempo < delay_tempo_max / 2
cor_barra = c_yellow 

//Mudando a barra para aqua lá no finalzinho
if delay_tempo < delay_tempo_max / 20
cor_barra = c_aqua



//Desenhando a barra
barra_recarga(x - 30, y - 60, 64, 4, delay_tempo, delay_tempo_max, cor_barra, opacidade_barra);
