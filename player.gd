extends CharacterBody2D

@onready var sfx_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const SWAP_DELAY = 0.2 # Time in seconds between sprite swaps

const START_POSITION := Vector2(218.0, 362.0)
const DRAG_SPEED = 400.0

var wait_timer = 120

var is_dead = false
var has_won = false
var anim_timer: float = 0.0

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	sfx_player.play()
	pass # Replace with function body.









func _physics_process(delta: float) -> void:
	if not is_dead and not has_won:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			if direction < 0:
				$Sprite2D.flip_h = true
				$Sprite2D2.flip_h = true

			elif direction > 0:
				$Sprite2D.flip_h = false
				$Sprite2D2.flip_h = false

			
			velocity.x = direction * SPEED
			
			anim_timer -= delta
			if anim_timer <= 0:
				# Flip each sprite's current visibility (true becomes false, false becomes true)
				$Sprite2D.visible = not $Sprite2D.visible
				$Sprite2D2.visible = not $Sprite2D.visible
				anim_timer = SWAP_DELAY
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			$Sprite2D.visible = false
			$Sprite2D2.visible = true
			anim_timer = 0.0
	elif is_dead:
		$Sprite2D.visible = false
		$Sprite2D2.visible = false
		$Sprite2D3.visible = true
		$Sprite2D4.visible = false
		velocity.y = 0
		velocity.x = 0
		
		while global_position != START_POSITION:
			await get_tree().create_timer(0.75).timeout
			$Sprite2D3.visible = false
			$Sprite2D4.visible = true
			
			set_collision_mask_value(2,false)
			global_position = global_position.move_toward(START_POSITION, DRAG_SPEED * delta)
		
		set_collision_mask_value(1,false)
		get_tree().call_deferred("reload_current_scene")

	elif has_won:
		await get_tree().create_timer(0.75).timeout
		$Sprite2D.visible = false
		$Sprite2D2.visible = false
		$Sprite2D3.visible = false
		$Sprite2D4.visible = false
		$Sprite2D5.visible = true
		
		velocity.y = 0
		velocity.x = 0

	move_and_slide()
