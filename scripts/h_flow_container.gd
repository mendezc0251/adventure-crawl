extends HFlowContainer


@export var button_scene: PackedScene = load("res://scenes/character_button.tscn")
var paths = DirAccess.get_files_at("res://characters")

func _ready() -> void:
	add_chars()

func add_chars()->void:
	for file_path in paths:
		var character = ResourceLoader.load("res://characters/"+file_path)
		var btn = button_scene.instantiate() as TextureButton
		btn.texture_normal = character.soul_texture
		btn.pressed.connect(func(): _on_button_pressed(character))
		add_child(btn)

func _on_button_pressed(character):
	Global.characterSelected = character
	get_tree().change_scene_to_file("res://scenes/map.tscn")
	print(character.character_name + " selected")
