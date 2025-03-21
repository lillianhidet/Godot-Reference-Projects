extends Node2D

@onready var animation_player: AnimationPlayer = $Movement/AnimationPlayer


@export var attacking : bool = false
@onready var area_2d = $Movement/Area2D

func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("Attack"):
		animation_player.play("Attack")
		
	if attacking:	
		for body in area_2d.get_overlapping_bodies():
			if body.is_in_group("enemy"):
				body.queue_free()
			
