shader_type canvas_item;

uniform float time;
uniform float amplitude : hint_range(0.0, 100.0) = 20.0;
uniform float frequency : hint_range(0.0, 20.0) = 5.0;
uniform float speed : hint_range(0.0, 200.0) = 60.0;
uniform float THICKness: hint_range(0.001, 1.0) = 0.005;
uniform vec3 waveColor : source_color;

void fragment() {
	float x = UV.x * 10.0; // controla quantas ondas cabem na tela
	float wave = sin(x * frequency + time * speed * 0.05) * amplitude / 100.0;
	float y = UV.y - 0.5 + wave;
	
	float alpha = smoothstep(THICKness, 0.0, abs(y));
	
	COLOR = vec4(waveColor, alpha);
}