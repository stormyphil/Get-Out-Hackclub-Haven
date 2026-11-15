extends Area2D

func _on_body_entered(body: Node2D) -> void:
	## Option A: Check by node name
	#if body.name == "Player":
		#print("Player entered the area!")
		#
	# Option B: Check by group (Recommended for multiple scenes/instances)
	if body.is_in_group("player"):
		print("You ded")
		body.is_dead = true
		
