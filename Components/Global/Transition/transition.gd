extends CanvasLayer

var sceneToChange = null
var curTransition = null

func _ready() -> void:
	visible = false

func transitionToScene(path, transition):
	sceneToChange = path
	curTransition = getTransition(transition)
	fadeIn()

func getTransition(trans):
	for child in get_children():
		child.visible = false
	
	match trans:
		"day":
			$DayTransition.visible = true
			$DayTransition/Label.text = "Day " + str(GameManager.day)
			return $DayTransition/AnimationPlayer
		"result":
			$ResultScreenTransition.visible = true
			return $ResultScreenTransition/AnimationPlayer
	
	return null

func fadeIn():
	if curTransition.is_playing():
		return
	
	visible = true
	curTransition.play("fadeIn")

func fadeOut():
	get_tree().change_scene_to_file(sceneToChange)
	
	curTransition.play("fadeOut")

func _on_transition_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fadeIn":
		fadeOut()
	elif anim_name == "fadeOut":
		sceneToChange = null
		curTransition = null
		visible = false
