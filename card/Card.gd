extends Node2D

export var face_up:bool = false
export var value:int

var card_name:String
var suit:String
var color:String
var face_sprite:String
#var back_sprite:String

var selected_card = {}

var face_sprite_path = "res://card/sprites/front/"
var sprite_path = preload("res://card/sprites/back/B1.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


"""""
Set selected_card data
"""""
func _set_card(card):
	selected_card = card
	card_name = card["name"]
	value = card["value"]
	face_sprite = card["sprites"]["front"] + ".png"
	_set_face_up(face_up)


"""""
Set card's face_up, then changes the card's sprite
"""""
func _set_face_up(is_face_up: bool):
	face_up = is_face_up
	if not face_up:
		$Sprite.texture = sprite_path
	else:
		$Sprite.texture = load(face_sprite_path + face_sprite)