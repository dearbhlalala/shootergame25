extends CharacterBody2D

@onready var player = get_node_or_null("/root/GameScene/Player")
@onready var sprite = $Sprite2D  # Cache the sprite node for efficiency
@export var possible_textures: Array[Texture] = []  # Assign 5 textures in the Inspector
var can_be_hit: bool = true  # Enemy starts as vulnerable

const SPEED = 100

#func _physics_process(delta: float) -> void:
	#if player:  # Check if player exists before accessing global_position
		#velocity = (player.global_position - global_position).normalized() * SPEED
		#look_at(player.global_position)
		#move_and_slide()
func _on_bullet_hit(bullet):  # Call this function when a bullet hits
	if can_be_hit and bullet.is_in_group("bullets"):  # Ensure the object is a bullet
		can_be_hit = false
		var random_texture = possible_textures[randi() % possible_textures.size()]  # Pick a random texture
		sprite.texture = random_texture  # Change sprite texture
		bullet.queue_free()  # Remove the bullet
		GameManager.add_score(1)

func _on_area_2d_area_entered(area: Area2D) -> void:
	_on_bullet_hit(area)
