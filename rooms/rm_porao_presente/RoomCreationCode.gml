#region Usando Funções

//Criando o player numa camada
scr_player_layer() ;

// Creation Code da room
global.room_name = "Porão - Presente";

// Para qualquer música que estiver tocando ao entrar no porão
// (o porão começa em silêncio por padrão)
if (instance_exists(obj_hud))
{
    // Se a música do porão ainda não foi ativada, garante silêncio
    if (!global.musica_porao_tocando)
    {
        if (obj_hud.current_music != -1)
        {
            audio_stop_sound(obj_hud.current_music);
            obj_hud.current_music = -1;
        }
    }
}

#endregion

