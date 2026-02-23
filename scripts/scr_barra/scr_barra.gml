/// barra_recarga(x, y, largura, altura, atual, maximo, cor, opacidade)
function barra_recarga(_x, _y, _largura, _altura, _atual, _maximo, _cor, _opacidade) {
    var _preenchimento = 1 - (_atual / _maximo);
    
    draw_set_alpha(_opacidade);
    
    // Fundo
    draw_set_color(c_dkgray);
    draw_rectangle(_x, _y, _x + _largura, _y + _altura, false);
    
    // Preenchimento
    draw_set_color(_cor);
    draw_rectangle(_x, _y, _x + (_largura * _preenchimento), _y + _altura, false);
    
    // Borda
    draw_set_color(c_white);
    draw_rectangle(_x, _y, _x + _largura, _y + _altura, true);
    
    draw_set_alpha(1); // Reseta a opacidade
    draw_set_color(c_white);
}