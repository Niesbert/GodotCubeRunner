extends Area2D
class_name  end
var  isOpen = false


func _on_body_entered(body: Node2D):
	if body is Player:
		if isOpen :
			GameManager.LoadNextLevel()
	
func ready():
	close()
	
func close():
	isOpen = false
	
func open():
	isOpen = true
	
	
