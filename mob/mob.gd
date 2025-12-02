extends RigidBody3D

var health: int = 3
var speed: float = randf_range(2.0, 4.0)

@onready var bat_model: Node3D = %bat_model
@onready var timer: Timer = %Timer
@onready var player:CharacterBody3D = get_node("/root/Game/Player")

func _physics_process(_delta: float) -> void:
	var direction:Vector3 = global_position.direction_to(player.global_position)
	direction.y = 0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI
	lock_rotation = true

func take_damage() -> void:
	if health == 0:
		return

	bat_model.hurt()
	health -= 1

	if health == 0:
		set_physics_process(false)
		lock_rotation = false
		gravity_scale = 1.0
		var direction: Vector3 = -1.0 * global_position.direction_to(player.global_position)
		var random_upward_force = Vector3.UP * randf_range(1.0, 3.0)
		apply_central_impulse(direction * 10.0 + random_upward_force)
		timer.start()

func _on_timer_timeout() -> void:
	queue_free()
