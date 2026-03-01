ativacao_por_toque = false
destruir_npc = false


	
dialogo = 
{
	//Texto do dialogo
	texto	: ["...", "Sinto a sua falta."],
	//Sprite de quem ta falandos
	//sprite	: [spr_text_box, spr_text_box],
	//Velocidade do Texto
	txt_vel : 0.3 ,
	//Som do Texto
	sound	: [snd_speech, snd_speech, snd_speech, snd_speech, snd_speech, snd_speech]
}



if global.interagiu_cofre == true
{

	dialogo = 
	{
		//Texto do dialogo
		texto	: ["...", "Sinto a sua falta." ,"Agora eu me lembrei, a senha do cofre era essa."],
		//Sprite de quem ta falandos
		//sprite	: [spr_text_box, spr_text_box],
		//Velocidade do Texto
		txt_vel : 0.3 ,
		//Som do Texto
		sound	: [snd_speech, snd_speech, snd_speech, snd_speech, snd_speech, snd_speech]
	}

}