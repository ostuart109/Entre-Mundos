#region Criando Métodos
tocou_som = false;
//Libera a cozinha se já desentupiu
libera_porta = function()
{
	// Step do objeto parede
	if (global.usou_desentupidor)
	{
		//Destruindo o objeto parede da porta do passado
	    instance_destroy(inst_553EF3C3);
		
		//Destruindo o objeto parede da porta do presente
		instance_destroy(inst_2F1BA97E);
		
		//Destruindo o objeto de colisão da agua eletrica
		instance_destroy(inst_1D526791);
		
		//Destruindo dialogo da poça
		instance_destroy(inst_1CE3715E); 
	}
	
	if global.pegou_chave_porao
	{
	
	//Destruindo a barreira do porão
	instance_destroy(inst_5FF36675)
	
	
	}
	
}



#endregion