extends GridContainer
class_name	PlayerSelectScreen

@export var player_panel:PackedScene
@export var max_players:int = 4
@export var min_players:int = 2
var most_recent_panel:PlayerPanel
var current_players=0
var starting:bool = false

signal players_ready()
signal players_unready()
signal player_quit(player:PlayerManager)

func _ready():
	most_recent_panel=get_child(0)

func player_join(player:PlayerManager):
	if !starting and current_players < max_players:
		most_recent_panel.player_join(player)
		current_players+=1
		if (current_players < max_players):
			new_panel()
		else:
			pass
			#players_ready.emit()
		
	else:
		print ("Too many players")	


func _on_player_quit(player:PlayerManager):
	current_players-=1
	player_quit.emit(player)

func _on_player_ready():
	if current_players >= min_players:
		for panel in get_children():
			if panel is PlayerPanel and !(panel as PlayerPanel).now_ready:
				return
		for panel in get_children():
			if panel is PlayerPanel and (panel as PlayerPanel).current_player == null:
				panel.queue_free()
		players_ready.emit()
		starting=true

func _on_player_unready():
	if starting and current_players < max_players:
		new_panel()
	players_unready.emit()
	starting=false
	print ("player unready")

func new_panel():
	most_recent_panel =  player_panel.instantiate()
	add_child(most_recent_panel)
	most_recent_panel.player_ready.connect(_on_player_ready)
	most_recent_panel.player_quit.connect(_on_player_quit)
	most_recent_panel.player_unready.connect(_on_player_unready)
