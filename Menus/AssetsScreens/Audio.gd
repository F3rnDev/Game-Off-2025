extends Node

var isFullscreen = false

@onready var uiAccept := AudioStreamPlayer.new()
@onready var uiMove := AudioStreamPlayer.new()
@onready var uiCancel := AudioStreamPlayer.new()

@onready var soundAccept = load("res://Menus/AssetsScreens/Audio/UIAccept.mp3")
@onready var soundCancel = load("res://Menus/AssetsScreens/Audio/UICancel.mp3")
@onready var soundMove = load("res://Menus/AssetsScreens/Audio/UIMove.mp3")

var volumeMaster = 1.0
var volumeMusic = 1.0
var volumeSFX = 1.0

const MASTER_AUDIO_NAME:String = "Master"
const MUSIC_AUDIO_NAME:String = "Music"
const SFX_AUDIO_NAME:String = "SFX"

var MASTER_AUDIO_ID
var MUSIC_AUDIO_ID
var SFX_AUDIO_ID

var Decibels

func _ready() -> void:
	MASTER_AUDIO_ID = AudioServer.get_bus_index(MASTER_AUDIO_NAME)
	MUSIC_AUDIO_ID = AudioServer.get_bus_index(MUSIC_AUDIO_NAME)
	SFX_AUDIO_ID = AudioServer.get_bus_index(SFX_AUDIO_NAME)
	
	add_child(uiAccept)
	add_child(uiCancel)
	add_child(uiMove)
	
	uiAccept.bus = SFX_AUDIO_NAME
	uiCancel.bus = SFX_AUDIO_NAME
	uiMove.bus = SFX_AUDIO_NAME

func AudioMaster(value:float):
	volumeMaster = value
	Decibels = linear_to_db(value)
	AudioServer.set_bus_volume_db(MASTER_AUDIO_ID, Decibels)

func AudioMusic(value:float):
	volumeMusic = value
	Decibels = linear_to_db(value)
	AudioServer.set_bus_volume_db(MUSIC_AUDIO_ID, Decibels)

func AudioSfx(value:float):
	volumeSFX = value
	Decibels = linear_to_db(value)
	AudioServer.set_bus_volume_db(SFX_AUDIO_ID, Decibels)
	

func playUIAccept():
	uiAccept.stream = soundAccept
	uiAccept.play()

func playUIMove():
	uiMove.stream = soundMove
	uiMove.play()

func playUICancel():
	uiCancel.stream = soundCancel
	uiCancel.play()
