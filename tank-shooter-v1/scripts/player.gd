extends Area2D

@onready var shell_player = preload("res://subpre/player_shells.tscn")
@onready var shell_flash = preload("res://subpre/player_shell_flash.tscn")
@onready var explosion_pre = preload("res://subpre/explosion.tscn")
signal	player_killed
var shoot_cooldown = 0.5
var time_of_last_shot = 0.0

func _process(delta: float) -> void:
	time_of_last_shot += delta
	var screen_size = get_viewport_rect().size
	var margin = 70
	var is_moving = false
	
	if Input.is_action_pressed("player_move_right") and position.x < screen_size.x - margin:
		position.x += 11 * delta * 60
		is_moving = true
	if Input.is_action_pressed("player_move_left") and position.x > margin:
		position.x -= 11 * delta * 60
		is_moving = true
	if Input.is_action_pressed("player_move_up") and position.y > screen_size.y / 2 + margin * 2:
		position.y -= 11 * delta * 60
		is_moving = true
	if Input.is_action_pressed("player_move_down") and position.y < screen_size.y - (margin + margin / 2):
		position.y += 11 * delta * 60
		is_moving = true
	
	if is_moving:
		$r_wheels.play()
		$l_wheels.play()
	else:
		$r_wheels.stop()
		$l_wheels.stop()
	
	if Input.is_action_pressed("player_shoots") and time_of_last_shot >= shoot_cooldown:
		var shell = shell_player.instantiate()
		var flash = shell_flash.instantiate()
		shell.position = position + Vector2(0,-80)
		flash.position = position + Vector2(0,-80)
		get_parent().add_child(shell)
		get_parent().add_child(flash)
		time_of_last_shot = 0.0

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		var explosion = explosion_pre.instantiate()
		explosion.position = position
		get_parent().add_child(explosion)
		queue_free()
		area.queue_free()
		player_killed.emit()
