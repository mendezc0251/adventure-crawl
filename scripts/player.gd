extends Node2D
@onready var tile_map: TileMapLayer = $"../TileMapLayer"

var is_moving = false
@onready var char_sprite: Sprite2D = $Sprite2D/CharacterBody2D/Sprite2D
@onready var target_sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# Set texture of char_sprite depending on character selected
	char_sprite.texture = Global.soul_textures[Global.characters.find(Global.characterSelected)]
	target_sprite.texture = Global.target_textures[Global.characters.find(Global.characterSelected)]

func _physics_process(delta: float) -> void:
	if is_moving == false:
		return
	
	if global_position == char_sprite.global_position:
		is_moving=false
		return
		
	char_sprite.global_position = char_sprite.global_position.move_toward(global_position,1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_moving:
		return
		
	if Input.is_action_pressed("up"):
		move(Vector2.UP)
	elif Input.is_action_pressed("down"):
		move(Vector2.DOWN)
	elif Input.is_action_pressed("left"):
		move(Vector2.LEFT)
	elif Input.is_action_pressed("right"):
		move(Vector2.RIGHT)

func move(direction: Vector2):
	# Get current tile Vector2i
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	# Get target tile Vector2i
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y,
	)
	print(current_tile, target_tile)
	# Get custom data layer from target tile
	var tile_data: TileData = tile_map.get_cell_tile_data( target_tile)
	
	if tile_data.get_custom_data("walkable") == false:
		return
	# Move player
	is_moving = true
	
	global_position = tile_map.map_to_local(target_tile)
	
	char_sprite.global_position = tile_map.map_to_local(current_tile)
