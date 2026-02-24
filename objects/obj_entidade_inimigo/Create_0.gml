#region Variáveis

// Dano
dano       = 1;

// Tempo para tomar dano (em frames)
t_dano     = game_get_speed(gamespeed_fps) * 3;

// Temporizador inicia em 0 (dá dano imediatamente ao tocar)
tempo_dano = 0;

#endregion

#region Iniciando Métodos

//Dano inimigo
inimigo_dano = function()
{
if (place_meeting(x, y, obj_player))
    {
        // Só dá dano se o temporizador chegou a 0
        if (tempo_dano <= 0)
        {
            global.vida -= dano;
            
            // Reinicia o temporizador
            tempo_dano = t_dano;
        }
    }
}

#endregion