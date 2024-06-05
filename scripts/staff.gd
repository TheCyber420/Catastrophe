extends AnimatedSprite2D


const weapon_offset = Vector2(0, 25)

func get_weapon_offset():
	return weapon_offset
	
func fire():
	print("shot with the staff!")
	
func flip(bool0):
	flip_v = bool0
