extends Node2D

@onready var soul_cage: StaticBody2D = $SoulCage
@onready var fight_panel: Node2D = $FightPanel


func _ready() -> void:
	rollEnemies()
	focusFightPanel()
	
func focusFightPanel():
	fight_panel.show()
	soul_cage.hide()

func rollEnemies():
	var enemies = Global.currentDifficulty + (randi() % (4-Global.currentDifficulty))
	print(str(enemies)+" enemies ecountered, prepare for battle!")
