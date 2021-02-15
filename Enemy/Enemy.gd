extends KinematicBody2D

var Bullet = load("res://Bullet/Bullet.tscn")
onready var Bullets = get_node("/root/Game/Bullets")

var move_speed = 3

var p = 0
var positions = [
	Vector2(100,100),
	Vector2(924,100),
	Vector2(924,400),
	Vector2(100,400),
]
var offset = Vector2.ZERO

func _ready():
	offset = position
	position = positions[0] + offset
	p = 1


func _on_Move_timeout():
	$Tween.interpolate_property(self, "position", position, positions[p] + offset, move_speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	p = wrapi(p+1, 0, len(positions))
 # Replace with function body.


func _on_Shoot_timeout():
	var bullet = Bullet.instance()
	bullet.position = position + Vector2(0,30)
	Bullets.add_child(bullet)
