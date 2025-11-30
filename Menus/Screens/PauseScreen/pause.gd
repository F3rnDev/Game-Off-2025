extends Control

@onready var backMenuBtn = %Confirm
@onready var playBtn = %Resume
@export var fullscreenBtn: CheckButton

# Volume #
@onready var masterPercent = %PercentMaster
@onready var musicPercent = %PercentMusic
@onready var sfxPercent = %PercentSFX

@onready var sliderMaster = %SliderMaster
@onready var sliderMusic = %SliderMusic
@onready var sliderSFX = %SliderSFX

func _ready() -> void:
	visible = false
	
	# Buttons
	
	masterPercent.text = str(roundi(Audio.volumeMaster*100)) + "%"
	musicPercent.text = str(roundi(Audio.volumeMusic*100)) + "%"
	sfxPercent.text = str(roundi(Audio.volumeSFX*100)) + "%"
	
	sliderMaster.value = Audio.volumeMaster
	sliderMusic.value = Audio.volumeMusic
	sliderSFX.value = Audio.volumeSFX
	
	if Audio.isFullscreen == true:
		fullscreenBtn.set_pressed_no_signal(true)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		togglePause(!visible)

func togglePause(pause=true):
	visible = pause
	get_tree().paused = pause
	
	if pause:
		$AnimationPlayer.play("Appear")
		Audio.playMusic()
	else:
		Audio.stopMusic()

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Audio.isFullscreen = true
	else:
		Audio.isFullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	#== Sliders ==#
func _on_slider_master_value_changed(value: float) -> void:
	Audio.AudioMaster(value)
	masterPercent.text = str(roundi(Audio.volumeMaster*100)) + "%"
	

func _on_slider_music_value_changed(value: float) -> void:
	Audio.AudioMusic(value)
	musicPercent.text = str(roundi(Audio.volumeMusic*100)) + "%"
	

func _on_slider_sfx_value_changed(value: float) -> void:
	#Audio.playUIMove()
	Audio.AudioSfx(value)
	sfxPercent.text = str(roundi(Audio.volumeSFX*100)) + "%"

	#== Buttons ==#
func _on_confirm_pressed() -> void:
	Audio.playUIAccept()
	get_tree().paused = false
	Transition.transitionToScene("res://Menus/Screens/MenuScreen/menu_screen.tscn", "result")

func pressBtnSfx():
	Audio.playUIAccept()
