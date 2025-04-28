extends Node2D

var flower_scene = preload("res://Scenes/enemy.tscn")
@onready var player = $Player

var flower_positions = []  # Store where flowers have been spawned
var spawn_timer = 1.0  # Time between flower spawns
var min_distance = 50  # Minimum distance between flowers

func _ready():
	# Start the spawn loop
	set_process(true)

func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_timer = 1.0  # Reset timer for next spawn
		spawn_flower()

func spawn_flower():
	var amount = 1  # Spawn one flower at a time
	var radius = 300
	var pattern_type = randi_range(0, 1)

	for i in amount:
		var try_count = 0
		var max_tries = 10
		var spawn_pos

		while try_count < max_tries:
			var t = randf_range(0, TAU)  # Random angle
			t += randf_range(-0.2, 0.2)  # Slight randomness

			var r = radius
			if pattern_type == 0:
				r += sin(t * 5) * 80  # Flower pattern
			else:
				if sin(t * 2.5) > 0:
					r += 60  # Star pattern
				else:
					r -= 30

			spawn_pos = player.global_position + Vector2(cos(t), sin(t)) * r
			spawn_pos += Vector2(randf_range(-30, 30), randf_range(-30, 30))  # Random offset

			var too_close = false
			for pos in flower_positions:
				if pos.distance_to(spawn_pos) < min_distance:
					too_close = true
					break

			if not too_close:
				break  # Found a good spot!

			try_count += 1

		if try_count < max_tries:
			var flower = flower_scene.instantiate()
			flower.global_position = spawn_pos
			add_child(flower)
			flower_positions.append(spawn_pos)
