extends CharacterBody2D

class_name Item

@export var grabable:Button
@onready var collider = $CollisionShape2D
var onDesk = false
var stop = true

var soundPlayed = false

func _process(_delta: float) -> void:
	if grabable.drag and stop:
		stop = false
		z_index = 2
	
	if stop:
		return
	
	var disableCollider = onDesk and velocity == Vector2.ZERO
	collider.set_deferred("disabled", disableCollider)

func _physics_process(delta: float) -> void:
	if stop:
		return
	
	# Add the gravity.
	if not is_on_floor():
		applyGravity(delta)
		soundPlayed = false
	else:
		velocity = Vector2.ZERO
		
		if !soundPlayed and !grabable.drag:
			$ItemLand.pitch_scale = randf_range(0.8, 1.2)
			$ItemLand.play()
			soundPlayed = true

	move_and_slide()

func applyGravity(delta):
	if !onDesk and !grabable.drag:
		velocity += Vector2(0, 3500.0) * delta

func _on_table_identify_area_entered(area: Area2D) -> void:
	if area.is_in_group("Table"):
		onDesk = true

func _on_table_identify_area_exited(area: Area2D) -> void:
	if area.is_in_group("Table"):
		onDesk = false
