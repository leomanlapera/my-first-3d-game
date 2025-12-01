extends RigidBody3D

var speed: float = randf_range(2.0, 4.0)

@onready var bat_model: Node3D = %bat_model
@onready var player:CharacterBody3D = get_node("/root/Game/Player")

func _physics_process(_delta: float) -> void:
	var direction := global_position.direction_to(player.global_position)
	direction.y = 0
	linear_velocity = direction * speed
	bat_model.rotation.y = Vector3.FORWARD.signed_angle_to(direction, Vector3.UP) + PI

func take_damage() -> void:
	bat_model.hurt()
