extends Node2D

signal deal_finished
#enum Turn_Event {HIT, STAND, BUST, BLACKJACK, WIN, LOSE}

export var starting_cards:int = 2
export var starting_flipped:int = 2

var cards_shown:int
var cards_flipped:int
var shown_value:int
var turn_event:int

var cards: Array = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards = get_children()
#	_new_deal()

func _set_event(event:int):
	turn_event = event


func _get_event():
	return turn_event

func _new_deal():
	# ---Reset variables---
	cards_shown = starting_cards - 1
	cards_flipped = starting_flipped - 1
	
	# ---Reset cards for new deal---
	for card in cards:
		card.face_up = false
		card.visible = false
	
	# ---Reset cards visible---
	for i in starting_cards:
		cards[i].visible = true
	
	# ---Reset cards flipped---
	for i in starting_flipped:
		cards[i].face_up = true
	
	# ---Set cards datas---
	for card in cards:
		card._set_card(CardData._random_card())
	
	# ---Get shown card values---
	_get_shown_card_values()
	emit_signal("deal_finished")


"""""
Show the next card in the cards array
"""""
func _show_next_card(is_face_up:bool = true):
	if cards_shown < (cards.size() - 1):
		cards_shown += 1
		cards[cards_shown].visible = true
	if is_face_up:
		_flip_next_card(is_face_up)
	_get_shown_card_values()


"""""
Flip the next card in the cards array
"""""
func _flip_next_card(is_face_up:bool = true):
	if cards_flipped < (cards.size() - 1):
		cards_flipped += 1
		cards[cards_flipped]._set_face_up(is_face_up)
	_get_shown_card_values()


"""""
Get the value of all currently shown cards
"""""
func _get_shown_card_values():
	# ---Reset variables---
	shown_value = 0
	var number_of_aces = 0
	
	for card in cards:
		if card.visible == true and card.face_up:
			# ---If card is an ace---
			if card.card_name == "Ace":
				number_of_aces += 1
			else:
				shown_value += card.value
	
	# ---Fix ace values---
	if number_of_aces > 0:
		for i in number_of_aces:
			if (shown_value + 11) <= 21:
				shown_value += 11
			else:
				shown_value += 1


func _on_Blackjack_new_game() -> void:
	_new_deal()