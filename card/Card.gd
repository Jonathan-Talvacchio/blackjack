extends Node2D

export var face_up: bool = false

var face_sprite_path = "res://card/sprites/front/"
var sprite_path = "res://card/sprites/back/B1.png"
var selected_card = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
#	if not face_up:
#		$Sprite.texture = load(sprite_path)
#	else:
#		$Card/Sprite.texture = load(sprite_path + selected_card["sprites"]["front"] + ".png")
	pass

