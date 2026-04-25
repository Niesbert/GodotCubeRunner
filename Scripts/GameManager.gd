extends Node
var currentLevel = 1
var LevelPath = "res://Scenes/Levels/Levels/"
var coinsCollected = 0

func ready():
	resetCoins()

func LoadNextLevel():
		currentLevel += 1
		var allLevels = LevelPath + "level_" +  str(currentLevel) + ".tscn"
		get_tree().change_scene_to_file(allLevels)
		print("Entered level " + str(currentLevel))
		setupLevel()

func setupLevel():
	resetCoins()
	
func addCoin():
	
	coinsCollected += 1
	if coinsCollected >= 5 :
		var ends = get_tree().get_first_node_in_group("Ends") as end
		ends.open()
	
	
func resetCoins():
	coinsCollected = 0
