extends State

class_name StateStoring

const label = "Storing"


func transition():
	if unit.has_arrived():
		unit.interact(unit.navigation_component.get_target().get_parent())
		if unit.current_resource_node == null:
			unit.change_state(STATE.IDLE)
		else:
			unit.navigation_component.set_target(unit.current_resource_node)
			unit.change_state(STATE.MOVING_TO_GATHER)


func process():
	unit.move_to_target()
