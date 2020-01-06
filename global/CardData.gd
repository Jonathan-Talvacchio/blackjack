extends Node

var path = "res://cards.json"
var json_data = {}

var full_deck = []
var inactive_deck = []
var active_deck = []


func _ready() -> void:
	_load()
	pass


func _load():
	var file = File.new()

	if not file.file_exists(path):
		print("NOT FOUND")

	file.open(path, file.READ)

	var text = file.get_as_text()

	json_data = parse_json(text)
	var deck = json_data.values()
	for card in deck:
		full_deck.append(card)
	inactive_deck = full_deck
	file.close()


# Pull a random card from the inactave deck
func _random_card():
	if not inactive_deck.empty():
		randomize()
		var index = randi() % inactive_deck.size()
		var selected_card = inactive_deck[index]
		active_deck.append(selected_card)
		inactive_deck.remove(index)
		return selected_card
	else:
		print("No inactive card.")


func _reset_deck():
	inactive_deck = full_deck
	active_deck = []