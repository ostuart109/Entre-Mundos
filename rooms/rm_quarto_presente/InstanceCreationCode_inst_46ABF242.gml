
ativacao_por_toque = false;
destruir_npc = false

if global.visitou_cozinha == true
{
	destruir_npc = true
	//Estrutura do dialogo
	dialogo = 
	{
		//Texto do dialogo
		texto	: ["Achei o bendito."],
		//Sprite de quem ta falandos
		//sprite	: [spr_text_box, spr_text_box],
		//Velocidade do Texto
		txt_vel : 0.3 ,
		//Som do Texto
		sound	: [snd_speech, snd_speech]
	}

}

if global.visitou_cozinha == false
{

destruir_npc = false 
//Estrutura do dialogo
dialogo = 
{
	//Texto do dialogo
	texto	: ["Um desentupidor, espero não precisar de um."],
	//Sprite de quem ta falandos
	//sprite	: [spr_text_box, spr_text_box],
	//Velocidade do Texto
	txt_vel : 0.3 ,
	//Som do Texto
	sound	: [snd_speech, snd_speech]
}



}