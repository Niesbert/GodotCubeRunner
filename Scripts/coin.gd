extends Area2D

func _on_body_entered(body: Node2D):
	if body is Player:
		GameManager.addCoin()
		GameManager.update_checkpoint(global_position)
		queue_free()
		print("coin!!!")
	
