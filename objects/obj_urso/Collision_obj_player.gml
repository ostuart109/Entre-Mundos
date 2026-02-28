var _cx = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2;
var _cy = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2;

// Cria uma layer com profundidade bem alta (mais à frente)
var _layer = layer_create(-999, "layer_sequence_temp");
layer_sequence_create(_layer, _cx, _cy, sq_fim);

instance_destroy();