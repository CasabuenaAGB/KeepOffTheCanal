extends Node2D

var money = 50
var wave = 1
var trash_left = 0
var wave_trash = [5,7,9,10,20,0]
var wave_speed = [3,3,2,2,1.5,100]
var cleanliness = 50

var instance
var instance2
var building = false
var enemy = preload("res://Scenes/Trash Enemies/rec_trash.tscn")
var cleaner1 = preload("res://Scenes/Cleaners/cleaner_1.tscn")
var cleaner2 = preload("res://Scenes/Cleaners/cleaner_2.tscn")

func cleaner1_in():
	building = false
	money -= 25

func cleaner2_in():
	building = false
	money -= 45

func _ready():
	$WaveTimer.start()

func _process(delta):
	$GUI/Money.text = "Cash: " + str(money)
	$GUI/Cleanliness.text = "River Cleanliness: " + str(cleanliness)

func _on_wave_timer_timeout():
	trash_left = wave_trash[wave]
	$EnemyTimer.wait_time = wave_speed[wave]
	$EnemyTimer.start()


func _on_enemy_timer_timeout():
	instance = enemy.instantiate()
	$Path2D.add_child(instance)
	trash_left -= 1
	if trash_left <= 0:
		$EnemyTimer.stop()
		wave += 1
		if wave < len(wave_trash):
			$WaveTimer.start()
		else:
			get_tree().change_scene_to_file("res://Scenes/Screens/win_screen.tscn")


func _on_texture_button_pressed():
	if building == false and money >= 25:
		instance = cleaner1.instantiate()
		add_child(instance)

func _on_texture_button_2_pressed():
	if building == false and money >= 45:
		instance2 = cleaner2.instantiate()
		add_child(instance2)



func _on_river_cleanliness_area_entered(area):
	if area.is_in_group("Enemy"):
		cleanliness -= 5
		if cleanliness <= 0:
			get_tree().change_scene_to_file("res://Scenes/Screens/lose_screen.tscn")
