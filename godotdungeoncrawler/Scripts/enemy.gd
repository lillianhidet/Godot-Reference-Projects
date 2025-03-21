extends CharacterBody2D

var target

@export var speed : float = 50.0
@onready var animated_sprite_2d = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target != null):
		
		velocity = (target.global_position - global_position).normalized() * speed
		
		if(target.global_position.x < global_position.x):
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
		move_and_slide()
		
	
func _on_range_body_entered(body):
	if(body.is_in_group("player")):
		target = body
		animated_sprite_2d.play("move")

func _on_range_body_exited(body):
	if(body.is_in_group("player")):
		animated_sprite_2d.play("idle")
