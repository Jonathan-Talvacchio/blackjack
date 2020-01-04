extends Node2D


var path = "res://cards.json"
var json_data = {}

var full_deck : Array = []

var sprite_path = "res://card/sprites/front/"
var back_path = "res://card/sprites/back/"
var selected_card

var card_index = 0


func _ready() -> void:
	_load()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			_random_card()
		if event.pressed and event.scancode == KEY_UP:
			_cycle_card()
		if event.pressed and event.scancode == KEY_B:
			$Card/Sprite.texture = load(back_path + selected_card["sprites"]["back"] + ".png")


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
	_random_card()
	
	file.close()


func _random_card():
	randomize()

	selected_card = full_deck[randi() % full_deck.size()]
	$Card/Sprite.texture = load(sprite_path + selected_card["sprites"]["front"] + ".png")
	$Card2/Sprite.texture = load(sprite_path + selected_card["sprites"]["front"] + ".png")
	
	var new_text = "%s of %s" % [selected_card["name"], selected_card["suit"]]
	
	print(selected_card)


func _cycle_card():
	card_index += 1
	if card_index >=full_deck.size():
		card_index = 0
	selected_card = full_deck[card_index]
	
	$Card/Sprite.texture = load(sprite_path + selected_card["sprites"]["front"] + ".png")
	$Card2/Sprite.texture = load(sprite_path + selected_card["sprites"]["front"] + ".png")