extends CollisionShape3D

var m_sens = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	if event is InputEventMouseMotion:
		rotate_x(deg_to_rad(-event.relative.y * m_sens))
		rotation.x = clamp(rotation.x, -1, 1)

