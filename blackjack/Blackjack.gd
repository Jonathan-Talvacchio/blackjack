extends Node2D

signal new_game
signal end_game

var full_deck: Array = []


func _ready() -> void:
	full_deck = CardData.full_deck
	_new_game()


func _input(event: InputEvent) -> void:
	if event.pressed and event.scancode == KEY_ENTER:
		_reset_game()


func _new_game():
	emit_signal("new_game")


func _end_game():
	emit_signal("end_game")
	pass


func _reset_game():
	CardData._reset_deck()
	_new_game()
	pass