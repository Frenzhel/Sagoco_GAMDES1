extends Node2D

@onready var enemy_pre = preload("res://subpre/enemy.tscn")

var score = 0

func _ready() -> void:
	_update_ui()

func _on_enemy_timer_timeout() -> void:
	var enemy = enemy_pre.instantiate()
	var random_x = randi_range(70,1070)
	enemy.position = Vector2(random_x,-20)
	enemy.enemy_killed.connect(_on_enemy_killed)
	add_child(enemy)

func _update_ui():
	$game_ui/score_label.text = "Score: " + str(score)

func _on_enemy_killed():
	score += 100
	_update_ui()

func _on_player_player_killed() -> void:
	$restart_timer.start()


func _on_restart_timer_timeout() -> void:
	get_tree().reload_current_scene()
