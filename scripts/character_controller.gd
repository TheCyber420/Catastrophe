extends CharacterBody2D

const SPEED = 300.0

var mouse_position = get_global_mouse_position()


var equipped_weapon = null
var offhand_weapon = null
var weapon_offset = null
var firing = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var weapon = $Weapon

func _ready():
	load_weapon(String("res://scenes/ak47.tscn"))
	swop_weapon()
	load_weapon(String("res://scenes/staff.tscn"))
	
func _physics_process(delta):
	var direction_horizontal = Input.get_axis("move_left", "move_right")
	var direction_vertical = Input.get_axis("move_up", "move_down")
	var dir = Vector2(direction_horizontal, direction_vertical)

	if direction_horizontal:
		velocity.x = dir.normalized().x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 9 * SPEED * delta)
		
	if direction_vertical:
		velocity.y =  dir.normalized().y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, 9 * SPEED * delta)
		
		
	move_and_slide()
	
func _process(_delta):
	if firing:
		equipped_weapon.fire()
	mouse_position = get_global_mouse_position()
	if equipped_weapon != null:
		equipped_weapon.look_at(mouse_position)
		equipped_weapon.position = weapon_offset + global_position
		
	if (mouse_position.x > global_position.x):
		animated_sprite.flip_h = false
		if equipped_weapon != null:
			equipped_weapon.flip(false)
	else:
		animated_sprite.flip_h = true
		if equipped_weapon != null:
			equipped_weapon.flip(true)
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			firing = true
		else:
			firing = false
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
		swop_weapon()
		
func load_weapon(path : String):
	var weapon_resource = ResourceLoader.load(path)
	equipped_weapon = weapon_resource.instantiate()
	weapon.add_child(equipped_weapon)
	weapon_offset = equipped_weapon.get_weapon_offset()
	
func swop_weapon():
	if equipped_weapon != null:
		equipped_weapon.visible = false
		
	var temp = offhand_weapon
	offhand_weapon = equipped_weapon
	equipped_weapon = temp
	
	if equipped_weapon != null:
		weapon_offset = equipped_weapon.get_weapon_offset()
		equipped_weapon.visible = true
