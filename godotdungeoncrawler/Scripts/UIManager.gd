extends Control

const UI_HEART_EMPTY = preload("res://Assets/frames/ui_heart_empty.png")
const UI_HEART_FULL = preload("res://Assets/frames/ui_heart_full.png")
const UI_HEART_HALF = preload("res://Assets/frames/ui_heart_half.png")

@onready var points_label: Label = $CanvasLayer/pointContainer/pointsLabel


@onready var died_label: Label = $CanvasLayer/diedLabel
@onready var health_cont: HBoxContainer = $CanvasLayer/healthContainer



var maxHealth : int = 6

func changed_health(newHealth : int):
	
	if(newHealth == 0):
		died_label.visible = true
	
	if newHealth > maxHealth:
		maxHealth = newHealth
		
	if(maxHealth/2 > health_cont.get_child_count()):
		for h in (maxHealth/2) - health_cont.get_child_count():
			add_heart()
	
	for i in health_cont.get_child_count():
		if (i * 2) + 1 < newHealth:
			health_cont.get_child(i).texture = UI_HEART_FULL
		elif (i * 2) < newHealth:
			health_cont.get_child(i).texture = UI_HEART_HALF
		else:
			health_cont.get_child(i).texture = UI_HEART_EMPTY
		

func add_heart():
	var img : TextureRect = TextureRect.new()
	img.expand_mode = TextureRect.EXPAND_FIT_WIDTH
	health_cont.add_child(img)
	
func add_point():
	points_label.text = str(int(points_label.text) + 1)
