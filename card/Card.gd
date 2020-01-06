extends Node2D

export var face_up: bool = false

var face_sprite_path = "res://card/sprites/front/"
var sprite_path = preload("res://card/sprites/back/B1.png")
var selected_card = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _set_card(card):
	selected_card = card
	if not face_up:
		$Sprite.texture = sprite_path
	else:
		$Sprite.texture = load(face_sprite_path + selected_card["sprites"]["front"] + ".png")


func _set_face_up(is_face_up: bool):
	face_up = is_face_up
	_set_card(selected_card)