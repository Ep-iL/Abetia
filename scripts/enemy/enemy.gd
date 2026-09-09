extends CharacterBody3D

@export var speed = 3.0
@export var detection_range = 10.0
@export var attack_range = 1.5
@export var attack_damage = 15
@export var health_max = 30

var gravity = 9.8
var health = health_max
var player: CharacterBody3D
var attack_cooldown = 0.0

func _ready():
	add_to_group("enemies")
	player = get_tree().root.get_child(0).get_node("Player")

func _physics_process(delta):
	# Gravity
	velocity.y -= gravity * delta
	
	if player == null:
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Chase player if in range
	if distance_to_player < detection_range:
		var direction = (player.global_position - global_position).normalized()
		direction.y = 0
		
		if distance_to_player > attack_range:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = 0
			velocity.z = 0
			# Attack if cooldown is ready
			if attack_cooldown <= 0:
				attack()
				attack_cooldown = 1.0
	else:
		velocity.x = 0
		velocity.z = 0
	
	if attack_cooldown > 0:
		attack_cooldown -= delta
	
	move_and_slide()

func attack():
	if player != null:
		var distance = global_position.distance_to(player.global_position)
		if distance < attack_range + 1.0:
			player.take_damage(attack_damage)
			print("Enemy attacked player!")

func take_damage(damage: int):
	health -= damage
	print("Enemy took %d damage. Health: %d" % [damage, health])
	if health <= 0:
		die()

func die():
	print("Enemy defeated!")
	queue_free()