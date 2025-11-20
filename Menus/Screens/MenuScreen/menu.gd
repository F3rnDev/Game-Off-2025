extends Control

@onready var quitBtn = %Confirm
@onready var playBtn = %Play

@onready var fullscreenBtn: CheckButton = $ArchiveOpenSettings/Panel/MarginContainer/Content/ScreenSection/Margin/ContentScreen/ScreenOptions/FullscreenOption/CheckButton

# Volume #
@onready var masterPercent = %PercentMaster
@onready var musicPercent = %PercentMusic
@onready var sfxPercent = %PercentSFX

@onready var sliderMaster = %SliderMaster
@onready var sliderMusic = %SliderMusic
@onready var sliderSFX = %SliderSFX

func _ready() -> void:
	# Buttons
	playBtn.pressed.connect(play)
	quitBtn.pressed.connect(quit_game)
	
	# Values volume
	masterPercent.text = str(roundi(Audio.volumeMaster*100)) + "%"
	musicPercent.text = str(roundi(Audio.volumeMusic*100)) + "%"
	sfxPercent.text = str(roundi(Audio.volumeSFX*100)) + "%"
	
	sliderMaster.value = Audio.volumeMaster
	sliderMusic.value = Audio.volumeMusic
	sliderSFX.value = Audio.volumeSFX
	
	if Audio.isFullscreen == true:
		fullscreenBtn.set_pressed_no_signal(true)

func play():
	#get_tree().change_scene_to_file("res://node_2d.tscn")
	print("Mudar cena para cena de jogo - Script menu")

func quit_game():
	get_tree().quit()

func _on_fullscreen_toggled(toggled_on: bool) -> void:
	if toggled_on == true and Audio.isFullscreen == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Audio.isFullscreen = true
	else:
		Audio.isFullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	#== Sliders ==#
func _on_slider_master_value_changed(value: float) -> void:
	Audio.AudioMaster(value)
	masterPercent.text = str(roundi(value*100)) + "%"

func _on_slider_music_value_changed(value: float) -> void:
	Audio.AudioMusic(value)
	musicPercent.text = str(roundi(value*100)) + "%"

func _on_slider_sfx_value_changed(value: float) -> void:
	Audio.playUIMove()
	Audio.AudioSfx(value)
	sfxPercent.text = str(roundi(value*100)) + "%"

	#== Buttons ==#
func mouseInBtnSfx():
	Audio.playUIMove()

func pressBtnSfx():
	Audio.playUIAccept()

func _on_deny_pressed() -> void:
	Audio.playUICancel()
