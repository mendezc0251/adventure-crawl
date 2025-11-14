extends Node2D

@onready var h_box: HBoxContainer = $HBoxContainer
@onready var rich_text_label: RichTextLabel = $RichTextLabel

enum BattleState {
	MAIN,
	ATTACK_SELECT,
	MAGIC_SELECT,
	ITEM_SELECT,
	DEFEND_SELECT
}

var current_state = BattleState.MAIN
var buttons: Array[Button] = []
var selected_index := 0

func _ready() -> void:
	h_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	show_fight_panel()
	update_selection()
	rich_text_label.text = ""


# menu state change logic
func show_fight_panel():
	clear_hbox()
	buttons.clear()
	selected_index = 0
	
	match current_state:
		BattleState.MAIN:
			add_main_buttons()
		BattleState.ATTACK_SELECT:
			add_attack_buttons()
		BattleState.MAGIC_SELECT:
			add_magic_buttons()
		BattleState.ITEM_SELECT:
			add_item_buttons()
		BattleState.DEFEND_SELECT:
			add_defend_buttons()
			
	update_selection()


func add_main_buttons():
	add_button("Attack")
	add_button("Cast")
	add_button("Inventory")
	add_button("Defend")
func add_attack_buttons():
	pass
func add_magic_buttons():
	pass
func add_item_buttons():
	pass
func add_defend_buttons():
	pass

func add_button(text:String):
	var btn = Button.new()
	btn.text = text
	btn.focus_mode = Control.FOCUS_NONE
	btn.mouse_filter = Control.MOUSE_FILTER_IGNORE
	btn.pressed.connect(Callable(self, "_on_button_pressed").bind(btn))
	h_box.add_child(btn)
	buttons.append(btn)

func change_state(new_state: BattleState):
	current_state = new_state
	show_fight_panel()

func clear_hbox():
	for child in h_box.get_children():
		h_box.remove_child(child)
		child.queue_free()

# Show user what button is selected and update based on key inputs
func update_selection():
	for i in range(buttons.size()):
		if i==selected_index:
			buttons[i].modulate = Color(1.0, 0.341, 0.502, 1.0)
		else:
			buttons[i].modulate = Color(1,1,1)
# Button press handler
func _on_button_pressed(btn: Button) -> void:
	var t := btn.text
	if current_state == BattleState.MAIN:
		match t:
			"Attack":
				change_state(BattleState.ATTACK_SELECT)
			"Cast":
				change_state(BattleState.MAGIC_SELECT)
			"Inventory":
				change_state(BattleState.ITEM_SELECT)
			"Defend":
				change_state(BattleState.DEFEND_SELECT)

func _input(event):
	# if no buttons present return
	if buttons.is_empty():
		return
	# TODO: fix bug with input not registering
	if Input.is_action_pressed("ui_right"):
		selected_index = (selected_index+1) % buttons.size()
		update_selection()
	elif Input.is_action_pressed("ui_left"):
		selected_index = max(0,selected_index-1)
		update_selection()
	
