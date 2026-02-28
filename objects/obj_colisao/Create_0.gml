#region Criando Métodos

//Libera a porta se já desentupiu
libera_porta = function()
{
	// Step do objeto parede
	if (global.usou_desentupidor)
	{
		//Destruindo o objeto parede da porta do passado
	    instance_destroy(inst_553EF3C3);
		
		//Destruindo o objeto parede da porta do presente
		instance_destroy(inst_2F1BA97E);
	}
}

#endregion