#region Usando Métodos

//Libera a porta se já desentupiu
libera_porta() ;

#endregion

if (place_meeting(obj_player.x, obj_player.y, inst_9523B54) and !tocou_som)
{ 
    tocou_som = true;
	
	if (tocou_som)
	{
		audio_play_sound(snd_saves, 10, 0);
	}
}



