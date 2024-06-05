extends Area2D

const VELOCITY = 1000

func _physics_process(delta):
	var direction = Vector2(cos(rotation), sin(rotation))
	var vel = direction.normalized() * VELOCITY

	position += vel * delta

func _on_body_entered(body):
	queue_free()
