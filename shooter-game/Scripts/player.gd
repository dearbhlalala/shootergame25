extends CharacterBody2D

var bullet_scene = preload("res://Scenes/bullet.tscn")
const SPEED = 200
@onready var shooty_part = $shootypart
@onready var shoot_sound = $Water

func _ready():
	randomize()

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	
	velocity.x = Input.get_axis("left", "right") * SPEED
	velocity.y = Input.get_axis("up", "down") * SPEED
	velocity = lerp(get_real_velocity(), velocity, 0.1)
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate()
		bullet.global_position = shooty_part.global_position
		bullet.direction = (get_global_mouse_position() - global_position).normalized()
		get_tree().current_scene.add_child(bullet)
		
		if shoot_sound:
			shoot_sound.pitch_scale = randf_range(0.9, 1.1)
			shoot_sound.play()
		
		
		
	move_and_slide()
