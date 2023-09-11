extends Node2D

@export var target_threshold: int = 8

@onready var agent = $NavigationAgent2D
@onready var rays =[
	$RayLeftest,
	$RayLeft,
	$RayFront,
	$RayRight,
	$RayRightest
]

var distance_to_target = Vector2.ZERO
var interest = [0, 0, 0, 0, 0]

func set_target(pos: Vector2) -> bool:
	agent.set_target_position(pos)
	return agent.is_target_reachable()


func is_target_reached() -> bool:
	return distance_to_target < target_threshold or agent.is_navigation_finished()


func get_direction() -> Vector2:
	distance_to_target = global_position.distance_to(agent.get_final_position())
	var direction = global_position.direction_to(agent.get_next_path_position())
	rotation = direction.angle()
	return _set_interest()


func _set_interest() -> Vector2:
	var final_direction = 0
	interest = [0.79, 0.79, 1, 0.8, 0.8]
	for ray_index in rays.size():
		var ray = rays[ray_index]
		if ray.is_colliding():
			interest[ray_index] *= 0.01
		final_direction += ray.rotation * interest[ray_index]
	return Vector2(1, 0).rotated(final_direction + rotation)
	
