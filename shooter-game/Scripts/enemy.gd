extends CharacterBody2D

@onready var player = get_node_or_null("/root/GameScene/Player")
@onready var animated_sprite = $AnimatedSprite2D  
@export var possible_sprite_frames: Array[SpriteFrames] = []  
var can_be_hit: bool = true  

const SPEED = 100

func _ready():
	if animated_sprite:
		animated_sprite.show()
		animated_sprite.play() 
	

func _on_bullet_hit(bullet):
	if can_be_hit and bullet.is_in_group("bullets"):
		can_be_hit = false
		
		if possible_sprite_frames.size() > 0:
			var random_frames = possible_sprite_frames[randi() % possible_sprite_frames.size()]
			animated_sprite.sprite_frames = random_frames  
			animated_sprite.play()

		bullet.queue_free()
		GameManager.add_score(1)

func _on_area_2d_area_entered(area: Area2D) -> void:
	_on_bullet_hit(area)
