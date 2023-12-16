extends CharacterBody3D


const SPEED = 150.0
const JUMP_VELOCITY = 300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var target_velocity = Vector3.ZERO
var m_sens = 0.5

@onready var anim = $"blockbench_export/AnimationPlayer"

func _ready():
	anim.play("idle")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	var direction = Vector3()
	# Add the gravity.
	if not is_on_floor():
		target_velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		target_velocity.y = JUMP_VELOCITY * delta

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		anim.play("walk")
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		anim.play("walk")
	elif Input.is_action_pressed("ui_up"):
		direction.z -= 1
		anim.play("walk")
	elif Input.is_action_pressed("ui_down"):
		direction.z += 1
		anim.play("walk")
	else:
		anim.play("idle")
		
	direction = direction.rotated(Vector3(0,1,0), rotation.y)
	target_velocity.x = direction.x * SPEED * delta
	target_velocity.z = direction.z * SPEED * delta
	
	velocity = target_velocity
	move_and_slide()
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * m_sens))
