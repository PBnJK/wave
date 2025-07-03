extends StaticBody2D

@onready var sprite := $Sprite2D as Sprite2D
@onready var build := $Build as Build

func _ready() -> void:
	build.was_hurt.connect(_on_build_was_hurt)
	build.was_destroyed.connect(_on_build_was_destroyed)

func _on_build_was_hurt(_damage: int, new_health: int) -> void:
	# TODO: Damage number sprite
	sprite.frame = 4 - new_health

func _on_build_was_destroyed() -> void:
	pass
