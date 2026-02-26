if (instance_exists(obj_player))
{
    if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, obj_player, false, true))
    {
        // Salva o ID no array
        array_push(global.saves_destruidos, meu_id) ;
        
        // Salva o jogo
        obj_hud.salva_jogo(global.save) ;
        
        // Se destroi
        instance_destroy() ;
    }
}