shader_type canvas_item;

uniform float circle_size = 0.5;
uniform float pixelation : hint_range(1.0, 300.0) = 80.0;

void fragment() {
    // --- Pixeliza o UV ---
    vec2 pixel_uv = floor(UV * pixelation) / pixelation;

    // --- Mesmo cálculo de antes, mas usando UV pixelizado ---
    float d = distance(vec2(0.5, 0.5), pixel_uv);

    if (d < circle_size) {
        COLOR.a = 0.0;
    }
}
