
//Teleportando
if place_meeting(x, y, obj_player) && obj_player.tp_cooldown <= 0
{
    obj_player.tp_cooldown = 30;
    obj_player.next_room   = dest_room;
    obj_player.next_x      = dest_x;
    obj_player.next_y      = dest_y;
    obj_player.transition  = 1;
	
	audio_play_sound(som, 5, 0, 0.3) ;
}