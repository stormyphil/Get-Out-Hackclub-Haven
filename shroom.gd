extends Area2D

const BOUNCE_FORCE = -800

@onready var anim: AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D

func _on_body_entered(body: Node2D) -> void:
	# Verify the entering body is a CharacterBody2D (your player)
	if body is CharacterBody2D:
		# Override vertical velocity to launch the player upward
		body.velocity.y = BOUNCE_FORCE
		anim.play("default")
	
