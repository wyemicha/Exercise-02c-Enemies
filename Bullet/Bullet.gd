extends Area2D

onready var VP = get_viewport().size
export var Velocity = Vector2(0,1)
export var Acceleration = Vector2(0,0.2)
var Explosion = load("res://Explosion/Explosion.tscn")
onready var Explosions = get_node("/root/Game/Explosions")

func _physics_process(delta):
	if global_position.x < -10 or global_position.x > VP.x + 10 or global_position.y < -10 or global_position.y > VP.y + 10:
		queue_free()
	position += Velocity
	Velocity += Acceleration

func explode():
	var explosion = Explosion.instance()
	explosion.position = position
	Explosions.add_child(explosion)
	queue_free()

func _on_Timer_timeout():
	explode()


func _on_Bullet_body_entered(body):
	body.queue_free()
	explode()
