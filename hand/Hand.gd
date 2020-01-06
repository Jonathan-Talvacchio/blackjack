extends Node2D

export var starting_cards:int = 2
export var starting_flipped:int = 2

var cards: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards = get_children()
#	_new_deal()

func _new_deal():
	for card in cards:
		card.face_up = false
	for i in starting_cards:
		cards[i].visible = true
	for i in starting_flipped:
		cards[i].face_up = true


func _on_Blackjack_new_game() -> void:
	_new_deal()
	for card in cards:
		card._set_card(CardData._random_card())

