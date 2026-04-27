extends Node
var currentLevel = 1
var LevelPath = "res://Scenes/Levels/Levels/"
var coinsCollected = 0
var respawn_point: Vector2 = Vector2.ZERO
var deathCount = 0

func reset_game_state():
	coinsCollected = 0
	deathCount = 0
	currentLevel = 1
	respawn_point = Vector2.ZERO
	startGame()
	
func startGame():
	var allLevels = LevelPath + "level_" +  str(currentLevel) + ".tscn"
	get_tree().change_scene_to_file(allLevels)

func ready():
	resetCoins()

func LoadNextLevel():
		currentLevel += 1
		var allLevels = LevelPath + "level_" +  str(currentLevel) + ".tscn"
		if FileAccess.file_exists(allLevels):
			get_tree().change_scene_to_file(allLevels)
			print("Entered level " + str(currentLevel))
			setupLevel()
		else:
			get_tree().change_scene_to_file("res://Scenes/StartEndScene/end_screen.tscn")
			get_tree().change_scene_to_file(allLevels)
		

func setupLevel():
	resetCoins()
	
func addCoin():
	coinsCollected += 1
	if coinsCollected >= 5 :
		var ends = get_tree().get_first_node_in_group("Ends") as end
		ends.open()

func update_checkpoint(new_position: Vector2):
	respawn_point = new_position
	
	
func resetCoins():
	coinsCollected = 0
	
func respawn_player():
	deathCount += 1
	var player = get_tree().get_first_node_in_group("player")
	player.visible = false
	
	print("Waiting to respawn...")
	# 1. The Delay: Wait for 1.0 seconds
	await get_tree().create_timer(0.50).timeout
	player.visible = true
	
	
	if player:
		# 3. Move the player back to the start
		player.global_position = respawn_point
		
		# 4. Reset velocity so they don't 'fly' into the respawn point
	if player is CharacterBody2D:
		player.velocity = Vector2.ZERO    
		# 5. Re-enable physics so they can move again
	player.set_physics_process(true)
	print("Player respawned!")
