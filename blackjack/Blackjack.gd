extends Node2D

signal new_game
signal end_game

var full_deck: Array = []


func _ready() -> void:
	full_deck = CardData.full_deck
	_new_game()


func _input(event: InputEvent) -> void:
	if event.pressed and event.scancode == KEY_ENTER:
		var selected_card = CardData._random_card()
		if selected_card != null:
			var text = "%s of %s" % [selected_card["name"],selected_card["suit"]]
			print(text)


func _new_game():
	emit_signal("new_game")
	pass