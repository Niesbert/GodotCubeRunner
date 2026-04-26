extends CharacterBody2D
class_name Player

const SPEED = 200.0
const JUMP_VELOCITY = -325.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	# Check every collision that happened during move_and_slide
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is TileMapLayer or collider is TileMap:
			# 1. Get the position where the hit happened
			var hit_position = collision.get_position() - (collision.get_normal() * 4)
			
			# 2. Convert that world position to tile coordinates
			var coords = collider.local_to_map(collider.to_local(hit_position))
			
			# 3. Get the data from that coordinate
			var data: TileData
			if collider is TileMapLayer:
				data = collider.get_cell_tile_data(coords)
			else:
				# If using old TileMap, we check the first 3 layers for death
				for layer in collider.get_layers_count():
					data = collider.get_cell_tile_data(layer, coords)
					if data: break 

			# 4. NOW check the data
			if data:
				var deadly = data.get_custom_data("is_deadly")
				if deadly:
					die()

func _ready() -> void:
	# Tell the GameManager: "This is where I should come back to"
	GameManager.respawn_point = global_position
	add_to_group("player") # Helps the GameManager find the player node later

func die():
	# Stop movement so the player doesn't keep sliding while 'dead'
	set_physics_process(false)
	print("Death Triggered!")
	# We call the GameManager, but the delay happens there
	GameManager.respawn_player()
