class_name Build
extends Area2D

signal was_hurt(damage: int, new_health: int)
signal was_destroyed()

enum Type {
	NONE,
	WALL,
	DIGGER,
}

@export var type := Type.NONE
@export var max_health := 10

var health := max_health

func _ready() -> void:
	assert(type != Type.NONE, "Must set the type of the build!")

func hurt(damage: int) -> void:
	health -= damage
	if health > 0:
		was_hurt.emit(damage, health)
	else:
		was_destroyed.emit()
