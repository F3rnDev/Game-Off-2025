extends Button

var drag = false
var mouseOffset = Vector2(0,0)

@export var parentObj:Node = null
@onready var grabSprite:Sprite2D = get_parent()

func _ready() -> void:
	if parentObj == null:
		parentObj = get_parent()

func _process(_delta: float) -> void:
	if drag:
		var new_pos = get_global_mouse_position() - mouseOffset
		var viewport_size = get_viewport_rect().size
		
		var spriteSize = grabSprite.get_rect().size
		
		new_pos.x = clamp(new_pos.x, spriteSize.x*2, viewport_size.x - spriteSize.x*2)
		new_pos.y = clamp(new_pos.y, spriteSize.y*2, viewport_size.y - spriteSize.y*2)
		
		parentObj.global_position = new_pos

func _on_button_down() -> void:
	drag = true
	mouseOffset = get_global_mouse_position() - parentObj.global_position

func _on_button_up() -> void:
	drag = false
