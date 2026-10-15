shader_type canvas_item;

uniform float alpha : hint_range(0.0, 1.0) = 1.0;
uniform float inner_radius : hint_range(0.0, 1.0) = 0.2;
uniform float outer_radius : hint_range(0.0, 1.0) = 0.8;
uniform vec4 vignette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    // Calcula a distância do centro da tela (0.5, 0.5)
    float dist = distance(UV, vec2(0.5));
    
    // Suaviza a transição entre o raio interno e externo
    float vignette = smoothstep(inner_radius, outer_radius, dist);
    
    // Aplica a cor da vinheta baseada no cálculo e na transparência global
    COLOR = vec4(vignette_color.rgb, vignette * alpha * vignette_color.a);
}
