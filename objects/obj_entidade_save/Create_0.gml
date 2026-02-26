// ID fixo baseado na posição
meu_id = string(x) + "_" + string(y) + "_" + string(room) ;

// Se já foi usado, se destroi
if (array_contains(global.saves_destruidos, meu_id))
{
    instance_destroy() ;
    exit ;
}