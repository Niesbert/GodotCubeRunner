extends Area2D

func _on_body_entered(body: Node2D):
	if body is Player:
		GameManager.addCoin()
		queue_free()
		print("coin!!!")
	
