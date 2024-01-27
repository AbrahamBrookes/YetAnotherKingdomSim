extends Node3D

# the map tile is a tile that spawns into the world with random values. Each
# map tile is the same scene but when it is instanced it adopts random values.
# These values are generally the amount of resources that can be harvested from
# that map tile, which also influences the model that is used.

enum ResourceType {
	Grass,
	Wood,
	Stone,
	Clay,
	Iron,
	Gold
}

# the meshes of each type, for assigning in the editor and selecting at runtime
var grass_mesh
var wood_mesh
var stone_mesh
var clay_mesh
var iron_mesh
var gold_mesh


# the actual resources that are found on this tile (dict booleans keyed by ResourceType)
var resources = {}

# the amount of each resource that is found on this tile (dict ints keyed by ResourceType)
@export var resource_amounts = {}

# given a dictionary of probablilities keyed by ResourceType, return a realized
# dictionary of the resources that will be found on this tile
func realize_resources(probabilities):
	for resource in ResourceType:
		if randf() < probabilities[resource]:
			resources[resource] = true
			return

# take the realized resources and generate the resource amounts
func realize_resource_amounts():
	for resource in resources:
		resource_amounts[resource] = randi() % 100

# return the model that should be used for this tile
func get_model():
	if resources.has("Wood"):
		return $"tile_types/wood"
	elif resources.has("Stone"):
		return $"tile_types/stone"
	elif resources.has("Clay"):
		return $"tile_types/clay"
	elif resources.has("Iron"):
		return $"tile_types/iron"
	elif resources.has("Gold"):
		return $"tile_types/gold"
	else:
		return $"tile_types/grass"

# Called when the node enters the scene tree for the first time.
func _ready():
	realize_resources({
		"Grass": 0.75,
		"Wood": 0.5,
		"Stone": 0.5,
		"Clay": 0.5,
		"Iron": 0.5,
		"Gold": 0.5
	})
	# now we have a single resource type on this tile, enable the relevant mesh
	get_model().visible = true
	# and generate the resource amounts
	realize_resource_amounts()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
