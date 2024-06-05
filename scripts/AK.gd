extends AnimatedSprite2D


const weapon_offset = Vector2(0, 25)
var bullet_scene = preload("res://scenes/bullet.tscn")

func get_weapon_offset():
	return weapon_offset
	
func fire():
	print("Fired the weapon!")
	var bullet = bullet_scene.instantiate()
	
	get_parent().add_child(bullet)
	bullet.position = global_position
	bullet.rotation = rotation
	
func flip(bool0):
	flip_v = bool0
