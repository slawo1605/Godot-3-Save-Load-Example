extends KinematicBody2D

var direction = Vector2()
var speed = 250
const MAX_SPEED = 400

var velocity = Vector2()
export(int) var max_health = 6





func get_input():
    # Detect up/down/left/right keystate and only move when pressed
    velocity = Vector2()
    if Input.is_action_pressed('ui_right_alt'):
        velocity.x += 1
    if Input.is_action_pressed('ui_left_alt'):
        velocity.x -= 1
    if Input.is_action_pressed('ui_down_alt'):
        velocity.y += 1
    if Input.is_action_pressed('ui_up_alt'):
        velocity.y -= 1
    velocity = velocity.normalized() * speed


func _physics_process(delta):
	get_input()
	move_and_slide(velocity)
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collision_point = collision_info.position
		print("collision position: ", str(collision_point))

# The "save" method. It collects important data as a dictionary, and returns it to the Save node
func get_state():
	var save_dict = {
		pos={
			x=position.x,
			y=position.y
		},
		max_health=max_health
	}
	return save_dict


# JSON cannot store Vector2 values, so we have to reconstruct it manually. That's why for small games,
# the ConfigFile format is more convenient (it supports all of Godot's core data types)
# Refer to the previous tutorial/demo
func load_state(data):
	for attribute in data:
		if attribute == 'pos':
			position = (Vector2(data['pos']['x'], data['pos']['y']))
		else:
			set(attribute, data[attribute])