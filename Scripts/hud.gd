extends CanvasLayer

@onready var coin_label = $Control/Coins/CoinLabel
@onready var death_label = $Control/Deaths/DeathLabel

func _ready():
	update_ui()

func _process(_delta):
	update_ui()

func update_ui():
	coin_label.text = "Coins: " + str(GameManager.coinsCollected)
	death_label.text = "Deaths: " + str(GameManager.deathCount)
