extends Node

var score: int = 0

# Function to increase score
func add_score(points: int = 1):
	score += points
	print("Score:", score)  # Debugging, replace with UI update later

# Function to reset score
func reset_score():
	score = 0
