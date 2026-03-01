ativacao_por_toque = false
destruir_npc = false

if global.lembrou_senha == true
{

//Estrutura do dialogo
dialogo = 
{
	//Texto do dialogo
	texto	: ["Uma chave?...", "Espera...", "Essa é a chave do porão!"], 
	//Sprite de quem ta falandos
	//sprite	: [spr_text_box, spr_text_box],
	//Velocidade do Texto
	txt_vel : 0.3 ,
	//Som do Texto
	sound	: [snd_speech, snd_speech, snd_speech]



}
	
}
else
{

//Estrutura do dialogo
dialogo = 
{
	//Texto do dialogo
	texto	: ["O cofre...", "Meu pai colocou ele no meu quarto, mas eu nunca soube o que tinha dentro", "Se eu soubesse a senha..."], 
	//Sprite de quem ta falandos
	//sprite	: [spr_text_box, spr_text_box],
	//Velocidade do Texto
	txt_vel : 0.3 ,
	//Som do Texto
	sound	: [snd_speech, snd_speech, snd_speech]
}

}