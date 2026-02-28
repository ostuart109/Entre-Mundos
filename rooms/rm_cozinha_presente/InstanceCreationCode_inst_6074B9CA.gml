ativacao_por_toque = false; 

if global.usou_desentupidor
{
	dialogo = 
	{
		//Texto do dialogo
		texto	: ["Agora sim posso passar!"],
		//Sprite de quem ta falandos
		//sprite	: [spr_text_box, spr_text_box],
		//Velocidade do Texto
		txt_vel : 0.3 ,
		//Som do Texto
		sound	: [snd_speech]
	}
}
else
{
	destruir_npc = false;
	
	//Estrutura do dialogo
	dialogo = 
	{
		//Texto do dialogo
		texto	: ["Eu devo limpar essa bagunça primeiro"],
		//Sprite de quem ta falandos
		//sprite	: [spr_text_box, spr_text_box],
		//Velocidade do Texto
		txt_vel : 0.3 ,
		//Som do Texto
		sound	: [snd_speech]
	}
}