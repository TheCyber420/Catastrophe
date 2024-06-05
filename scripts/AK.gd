extends AnimatedSprite2D

const fire_rate = 5.0
const weapon_offset = Vector2(0, 25)

var bullet_scene = preload("res://scenes/bullet.tscn")
var fire_cooldown : float = 0

func _process(delta):
	if fire_cooldown > 0:
		fire_cooldown -= fire_rate * delta

func get_weapon_offset():
	return weapon_offset
	
func fire():
	if fire_cooldown > 0:
		return
	
	print("Fired the weapon!")
	var bullet = bullet_scene.instantiate()
	
	get_parent().add_child(bullet)
	bullet.position = global_position
	bullet.rotation = rotation
	
	fire_cooldown = 1
	
func flip(bool0):
	flip_v = bool0
