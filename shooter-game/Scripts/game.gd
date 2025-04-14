extends Node2D

var enemy_scene = preload("res://Scenes/enemy.tscn")
@onready var player = $Player

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	
	enemy.global_position = player.global_position

	while enemy.global_position.distance_squared_to(player.global_position) < 5000:
		enemy.global_position.x = randi_range($Player.position.x - get_viewport_rect().size.x/2, get_viewport_rect().size.x)
		enemy.global_position.y = randi_range($Player.position.y - get_viewport_rect().size.y/2, get_viewport_rect().size.y)
		
		add_child(enemy)
