extends Node
class_name PlayerManager

var player_character:Player
var skin:CharacterSkin
@export var spawn_loc:Vector2
enum control_mode {ROUND_CONTROL,UI_CONTROL}
var current_mode = control_mode.UI_CONTROL
var device_id:int
var player_index:int

func _ready():
	player_character=%"Player Character"
	player_character.disable()
	player_character.new_auth(device_id)

func add_controls(controls:Input_Keys):
	print("Adding controls, ", controls)
	player_character.add_input(controls)

func set_start_pos(position:Vector2):
	spawn_loc=position

func start_round():
	player_character.enable()
	player_character.position=spawn_loc
	current_mode=control_mode.ROUND_CONTROL
	if player_character.my_input!=null:
		player_character.my_input.current_mode=PlayerCharacterInput.input_mode.GAMEPLAY
		player_character.my_input.input_mode_changed.emit(player_character.my_input.current_mode)
	
func stop_round():
	player_character.disable()
	current_mode=control_mode.UI_CONTROL
	player_character.my_input.current_mode=PlayerCharacterInput.input_mode.UI
	player_character.my_input.input_mode_changed.emit(player_character.my_input.current_mode)

func set_skin(new_skin:CharacterSkin):
	skin=new_skin
	player_character.set_skin(new_skin)

func set_spell(new_spell:Spell):
	if new_spell==null:
		player_character.unequip_spell()
	else:
		player_character.equip_spell(new_spell)
