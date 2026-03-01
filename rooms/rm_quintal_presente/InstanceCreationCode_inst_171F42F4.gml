ativacao_por_toque = false
destruir_npc = false

if global.pegou_chave_porao == true
{
	destruir_npc = true
	ativacao_por_toque = true
	
	dialogo = 
	{
		//Texto do dialogo
		texto	: ["Chegou a hora..."],
		//Sprite de quem ta falandos
		//sprite	: [spr_text_box, spr_text_box],
		//Velocidade do Texto
		txt_vel : 0.3 ,
		//Som do Texto
		sound	: [snd_speech, snd_speech, snd_speech, snd_speech, snd_speech, snd_speech]
	}
}

if global.pegou_chave_porao == false
{
	dialogo = 
	{
		//Texto do dialogo
		texto	: ["O Porão...", "O papai encheu de tralhas quando ainda era vivo...", "Quando nos mudamos", "Tudo o que tinha aqui foi doado ou jogado fora", "Bem...", "Eu espero que tenha alguma chance dele ainda estar aqui...", "Preciso de uma chave para entrar..."],
		//Sprite de quem ta falandos
		//sprite	: [spr_text_box, spr_text_box],
		//Velocidade do Texto
		txt_vel : 0.3 ,
		//Som do Texto
		sound	: [snd_speech, snd_speech, snd_speech, snd_speech, snd_speech, snd_speech, snd_speech]
	}
}