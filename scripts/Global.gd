extends Node
# When adding characters ensure all assets are in the same index in soul_textures and target_textures array
var characterSelected : String = ""
var soul_textures: Array[Texture2D] = [
	load("res://assets/sprites/Belch Soul.png")
]
var target_textures: Array[Texture2D] = [
	load("res://assets/sprites/BelchMoveIndicator.png")
]
var characters: Array[String] = [
	"Belch"
]
