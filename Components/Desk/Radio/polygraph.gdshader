shader_type canvas_item;

uniform float time;
uniform float amplitude : hint_range(0.0, 100.0) = 20.0;
uniform float frequency : hint_range(0.0, 20.0) = 5.0;
uniform float speed : hint_range(0.0, 200.0) = 60.0;
uniform float THICKness: hint_range(0.001, 1.0) = 0.005;
uniform vec3 waveColor : source_color;

uniform float pixel_steps : hint_range(1.0, 200.0) = 40.0;

void fragment() {
	float x = UV.x * 10.0;
	float wave = sin(x * frequency + time * speed * 0.05) * amplitude / 100.0;

	// Pixelização
	wave = floor(wave * pixel_steps) / pixel_steps;

	float y = UV.y - 0.5 + wave;

	// ---- LINHA DURA (sem suavização) ----
	float alpha = (abs(y) < THICKness) ? 1.0 : 0.0;

	COLOR = vec4(waveColor, alpha);
}
