

ativacao_por_toque = false; 


if global.tem_desentupidor
{

//Estrutura do dialogo
dialogo = 
{
	//Texto do dialogo
	texto	: ["Vou desentupir essa bagaça"],
	//Sprite de quem ta falandos
	//sprite	: [spr_text_box, spr_text_box],
	//Velocidade do Texto
	txt_vel : 0.3 ,
	//Som do Texto
	sound	: [snd_speech, snd_speech]
}


global.usou_desentupidor = true

}
else
{
destruir_npc = false;
//Estrutura do dialogo
dialogo = 
{
	//Texto do dialogo
	texto	: ["Ela parece entupida até aqui."],
	//Sprite de quem ta falandos
	//sprite	: [spr_text_box, spr_text_box],
	//Velocidade do Texto
	txt_vel : 0.3 ,
	//Som do Texto
	sound	: [snd_speech, snd_speech]
}




}





