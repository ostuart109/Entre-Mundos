
var _jogador = instance_nearest(x, y, obj_player);

if point_distance(x, y, _jogador.x, _jogador.y) < raio_deteccao {
    texto_visivel = true;
} else {
    texto_visivel = false;
}