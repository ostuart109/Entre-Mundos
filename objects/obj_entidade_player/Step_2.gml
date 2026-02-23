#region Usando Métodos

//Colisão
colisao() ;

// Usando os Estados
estado();

//Limita Velocidade diagonal
velh = clamp(velh, -max_vel, max_vel);
velv = clamp(velv, -max_vel, max_vel);

delay_tempo = clamp(delay_tempo, 0, delay_tempo_max );


#endregion
