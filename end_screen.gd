extends Control
@onready var DeathScore = $Container/VBoxContainer/DeathScore

func _ready() -> void:
	updateUI()

func updateUI():
	DeathScore.text = "Deaths: " + str(GameManager.deathCount)

func _on_replay_pressed() -> void:
	GameManager.reset_game_state()

func _on_exit_pressed() -> void:
	get_tree().quit()
	
	
