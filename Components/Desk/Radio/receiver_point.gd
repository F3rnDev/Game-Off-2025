extends TextureRect

@onready var plateMarker = $PlateMarker

@onready var plateSprite = preload("res://Components/UI/Radio/ReceiverPointPlate.tscn")
var plateInstance = null

var receiver:Receiver
var desiredAngle = randf_range(0.0, TAU)

# Called when the node enters the scene tree for the first time.
func setReceiver(recvr:Receiver):
	receiver = recvr
	texture = recvr.district.image

func killReceiver():
	$AnimationPlayer.play("kill")
	$Area2D.queue_free()

func _on_mouse_entered() -> void:
	plateInstance = plateSprite.instantiate()
	
	var subVierportContainer = get_parent().get_parent().get_parent().get_parent()
	plateInstance.global_position = subVierportContainer.global_position + plateMarker.global_position
	
	get_tree().current_scene.find_child("CanvasLayer").add_child(plateInstance)
	plateInstance.setPlate(receiver.licensePlate)

func _on_mouse_exited() -> void:
	plateInstance.queue_free()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "kill":
		queue_free()
