extends Node2D

@onready var soul_cage: StaticBody2D = $SoulCage
@onready var fight_panel: Node2D = $FightPanel


func _ready() -> void:
	focusFightPanel()
	
func focusFightPanel():
	fight_panel.show()
	soul_cage.hide()
