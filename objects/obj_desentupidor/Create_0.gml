#region Iniciando Métodos

//Desentupindo a pia
desentope_pia = function()
{
	if keyboard_check_pressed(vk_space) and global.visitou_cozinha == true
	{
		global.tem_desentupidor = true
		instance_destroy();
	}
}

#endregion