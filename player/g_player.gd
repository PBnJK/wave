class_name Player
extends CharacterBody2D

enum State {
	IDLE,
	WALK,
}

const BASE_SPEED := 80.0

var input := Vector2.ZERO
var state := State.IDLE

var speed := BASE_SPEED

@onready var sprite := $Visual/Sprite2D as Sprite2D
@onready var animator := $Visual/Animator as AnimationPlayer

func _unhandled_input(_event: InputEvent) -> void:
	input = Input.get_vector(&"left", &"right", &"up", &"down")

func _physics_process(delta: float) -> void:
	_match_state(delta)
	move_and_slide()

func _match_state(delta: float) -> void:
	match state:
		State.IDLE:
			_process_idle(delta)
		State.WALK:
			_process_walk(delta)

func _change_state(to: State) -> void:
	match state:
		State.IDLE:
			_exit_idle()
		State.WALK:
			_exit_walk()

	match to:
		State.IDLE:
			_enter_idle()
		State.WALK:
			_enter_walk()
	
	state = to

func _enter_idle() -> void:
	animator.play(&"Idle")

func _process_idle(_delta: float) -> void:
	if input:
		_change_state(State.WALK)
		return

func _exit_idle() -> void:
	pass

func _enter_walk() -> void:
	animator.play(&"Walk")

func _process_walk(_delta: float) -> void:
	if input:
		velocity = input * speed
		_do_flip_sprite()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, speed)

	if not velocity:
		_change_state(State.IDLE)

func _exit_walk() -> void:
	pass

func _do_flip_sprite() -> void:
	if input.x > 0.0:
		sprite.flip_h = false
	elif input.x < 0.0:
		sprite.flip_h = true
