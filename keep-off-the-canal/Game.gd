extends Node2D

var money = 50
var wave = 1
var trash_left = 0
var wave_trash = [5,1,6,1,10,1,20,1,40,0]
var wave_speed = [2,5,2,5,2,5,2,5,2,100]

var instance
var building = false
var enemy = preload("res://Trash Enemies/rec_trash.tscn")
var cleaner1 = preload("res://Cleaners/cleaner_1.tscn")

func cleaner1_in():
	building = false
	money -= 25

func _ready():
	$WaveTimer.start()

func _process(delta):
	$GUI/Label.text = "Cash: " + str(money)

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
			get_tree().change_scene("res://icon.svg")


func _on_texture_button_pressed():
	if building == false and money >= 25:
		instance = cleaner1.instantiate()
		add_child(instance)
