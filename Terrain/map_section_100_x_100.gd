extends Node3D

# This class instantiates 100x100 map_tile scenes in a square


# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(0, 10):
		for y in range(0, 10):
			var map_tile = load("res://map_tile.tscn").instantiate()
			map_tile.global_transform.origin = Vector3(x * 2, 0, y * 2)
			add_child(map_tile)
			print("Added map tile at: " + str(x) + ", " + str(y))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
