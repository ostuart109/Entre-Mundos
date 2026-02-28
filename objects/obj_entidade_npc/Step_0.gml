if (place_meeting(obj_player.x, obj_player.y, inst_9523B54) && !tocou_som)
{
    audio_play_sound(snd_saves, 10, 0);
    tocou_som = true;
}