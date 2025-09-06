extends Node2D

@onready var particles: GPUParticles2D = $shell_flash

func _ready() -> void:
	particles.restart()
