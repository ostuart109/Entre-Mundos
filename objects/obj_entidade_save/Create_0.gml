// Se este NPC já foi destruído anteriormente, ele não deve existir
if (array_contains(global.saves_destruidos, string(id)))
{
	instance_destroy() ;
	exit ;
}

