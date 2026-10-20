extends Node2D

@onready var Head = $CleanerHead

var net = preload("res://Scenes/Cleaners/Net.tscn")

var building = true

var canPlace = false

var enemies = []

var current_enemy

func _physics_process(delta):
	if building == false:
		if enemies != []:
			current_enemy = enemies[0]
			Head.look_at(current_enemy.global_position)
	else:
		global_position = get_global_mouse_position()
		if canPlace == true:
			if Input.is_action_just_pressed("click"):
				building = false
				get_parent().cleaner1_in()

func _on_range_area_entered(area):
	if area.is_in_group("Enemy"):
		enemies.append(area)

func _on_range_area_exited(area):
	if area.is_in_group("Enemy"):
		enemies.erase(area)


func _on_grab_timer_timeout() -> void:
	if current_enemy:
		if enemies:
			if current_enemy == enemies[0]:
				var n = net.instantiate()
				n.global_position = global_position
				n.target = current_enemy
				get_parent().add_child(n)
				


func _on_placement_area_entered(area):
	if area.is_in_group("Platform"):
		if building == true:
			canPlace = true


func _on_placement_area_exited(area):
	if area.is_in_group("Platform"):
		if building == true:
			canPlace = false
