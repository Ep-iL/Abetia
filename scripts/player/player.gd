extends CharacterBody3D

@export var speed = 7.0
@export var jump_force = 12.0
@export var mouse_sensitivity = 0.003
@export var attack_range = 2.5
@export var attack_damage = 10

var gravity = 9.8
var health = 100
var is_attacking = false
var attack_cooldown = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Head/Camera3D.current = true

func _physics_process(delta):
	# Handle movement with WASD using direct key input
	var input_x = 0.0
	var input_y = 0.0
	
	if Input.is_key_pressed(KEY_W):
		input_y -= 1.0
	if Input.is_key_pressed(KEY_S):
		input_y += 1.0
	if Input.is_key_pressed(KEY_A):
		input_x -= 1.0
	if Input.is_key_pressed(KEY_D):
		input_x += 1.0
	
	var input_vector = Vector2(input_x, input_y).normalized()
	
	# Get the forward direction from the Head (camera rotation)
	var forward = -$Head.global_transform.basis.z
	var right = $Head.global_transform.basis.x
	
	# Calculate direction relative to camera
	var direction = (forward * input_vector.y + right * input_vector.x).normalized()
	direction.y = 0  # Keep movement horizontal
	
	if direction.length() > 0:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed * 2)
		velocity.z = move_toward(velocity.z, 0, speed * 2)
	
	# Gravity
	velocity.y -= gravity * delta
	
	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
	
	move_and_slide()
	
	# Handle attack (Tab key)
	if Input.is_key_pressed(KEY_TAB) and attack_cooldown <= 0:
		attack()
		attack_cooldown = 0.5
	
	if attack_cooldown > 0:
		attack_cooldown -= delta
	
	# Mouse look toggle (ESC key)
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		$Head.rotate_y(-event.relative.x * mouse_sensitivity)
		$Head/Camera3D.rotate_x(-event.relative.y * mouse_sensitivity)
		$Head/Camera3D.rotation.x = clamp($Head/Camera3D.rotation.x, -PI/2, PI/2)

func attack():
	is_attacking = true
	# Check for enemies in range
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsShapeQueryParameters3D.new()
	var sphere = SphereShape3D.new()
	sphere.radius = attack_range
	query.set_shape(sphere)
	query.transform = global_transform
	
	var result = space_state.intersect_shape(query)
	for collision in result:
		if collision.collider.is_in_group("enemies"):
			collision.collider.take_damage(attack_damage)
	
	print("Attack!")

func take_damage(damage: int):
	health -= damage
	print("Player took %d damage. Health: %d" % [damage, health])
	if health <= 0:
		die()

func die():
	print("Player died!")
	get_tree().reload_current_scene()
