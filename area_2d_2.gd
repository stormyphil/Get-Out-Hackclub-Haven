extends Area2D


func _on_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):

		body.has_won = true
	
	pass # Replace with function body.
