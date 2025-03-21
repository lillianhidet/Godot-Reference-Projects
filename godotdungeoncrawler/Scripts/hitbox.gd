extends Area2D

signal on_health_changed(new_health : int)
signal on_point_gained
@export var max_health : int = 6
@onready var damage_timer = $damageTimer
var health : int
var can_take_damage : bool = true
@onready var ui : Control = UIGlobal

# Called when the node enters the scene tree for the first time.
func _ready():
	on_health_changed.connect(ui.changed_health)
	on_point_gained.connect(ui.add_point)
	damage_timer.connect("timeout", allow_damage)
	health = max_health
	emit_signal("on_health_changed", health)
	
func _on_body_entered(body):
	if body.is_in_group("health"):
		heal(body)
	elif body.is_in_group("coin"):
		emit_signal("on_point_gained")
		body.queue_free()
		
func _process(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy"):
			take_damage()

func take_damage():
	if can_take_damage:
		health = health - 1
		emit_signal("on_health_changed", health)
		
		if health <= 0:
			get_tree().paused = true
		else:
			can_take_damage = false
			
			damage_timer.start()
	
func heal(body):
	if health < max_health:
		health = health + 1
		emit_signal("on_health_changed", health)
		body.queue_free()

	
func allow_damage():
	can_take_damage = true
	
