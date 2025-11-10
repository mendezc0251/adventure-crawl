extends HFlowContainer


@export var button_scene: PackedScene = load("res://scenes/character_button.tscn")


func _ready() -> void:
	add_chars()

func add_chars()->void:
	for i in range(Global.soul_textures.size()):
		var btn = button_scene.instantiate() as TextureButton
		if Global.soul_textures.size()>i:
			btn.texture_normal = Global.soul_textures[i]
		btn.pressed.connect(func(): _on_button_pressed(i))
		add_child(btn)

func _on_button_pressed(index):
	Global.characterSelected = Global.characters[index]
	get_tree().change_scene_to_file("res://scenes/map.tscn")
	print(Global.characters[index]+" selected")
	print(Global.characterSelected)
