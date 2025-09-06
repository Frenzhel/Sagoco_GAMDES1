extends Area2D

@export var speed = 2
@onready var explosion_pre = preload("res://subpre/explosion.tscn")
@onready var shell_enemy = preload("res://subpre/enemy_shells.tscn")
signal enemy_killed

func _process(delta: float) -> void:
	position.y += speed * delta * 60
	$l_wheel.play()
	$r_wheel.play()

func _on_area_entered(area: Area2D) -> void:
	if area is player_shoots_shell:
		var explosion = explosion_pre.instantiate()
		explosion.position = position
		get_parent().add_child(explosion)
		queue_free()
		area.queue_free()
		enemy_killed.emit()


func _on_enemy_shell_timer_timeout() -> void:
	var shell = shell_enemy.instantiate()
	shell.position = position + Vector2(0,80)
	get_parent().add_child(shell)
