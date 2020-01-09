extends Node2D
"""
Main script that controls the blackjack game
"""
signal new_game
signal end_game

enum Turn_Event {HIT, STAND, BUST, BLACKJACK, WIN, LOSE, TIE, NONE}
enum Players {COMPUTER, PLAYER}

const BUST_VALUE = 21

export var card_display_delay:float = 0.25
export var new_game_delay:float = 2

var active_player:int


func _ready() -> void:
	_new_game()
	# \/\/\/TEMP\/\/\/
	$Buttons/MarginContainer/VBoxContainer/HitButton.grab_focus()
	$Buttons2/MarginContainer/HBoxContainer/HitButton.grab_focus()


# -----TEMP-----
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			pass
		if event.pressed and event.scancode == KEY_H:
			pass
		if event.pressed and event.scancode == KEY_G:
			pass


func _process(delta: float) -> void:
	$Label.text = "value: %s" % $ComputerHand.shown_value
	$Label2.text = "value: %s" % $PlayerHand.shown_value


"""
Base hit function
"""
func _hit(current_player:int):
	if current_player == Players.PLAYER:
		$PlayerHand._show_next_card(true)
	else:
		$ComputerHand._show_next_card(true)


"""""
Hit the computers hand until it has
- A higher shown value the the player or
- It busts

Built from _hit base
"""""
func _hit_computer():
	$ComputerHand._flip_next_card()
	for card in $ComputerHand.cards:
		if $ComputerHand.shown_value < $PlayerHand.shown_value:
			if not _bust_check($ComputerHand):
				_game_timer_set(card_display_delay)
				yield($GameTimer, "timeout")
				_hit(Players.COMPUTER)
	
	# timer set to help set winner after computer is done hitting 
	_game_timer_set(card_display_delay)
	yield($GameTimer, "timeout")
	_win_check()
	# -----TEMP-----
	_game_timer_set(new_game_delay)
	yield($GameTimer, "timeout")
	_new_game()


"""""
Check hand for a bust 
set hand event and return bool true if bust
"""""
func _bust_check(hand:Node2D):
	if hand.shown_value > BUST_VALUE:
		hand._set_event(Turn_Event.BUST)
		return true
	else:
		return false


"""""
Check to see who won at the end of the game.
Set hand events based on winner
"""""
func _win_check():
	var player_value = $PlayerHand.shown_value
	var computer_value = $ComputerHand.shown_value
	
	if _bust_check($PlayerHand):
		$Label3.text = "Computer Wins! Player Busts with %s!" % player_value
		
		$PlayerHand._set_event(Turn_Event.LOSE)
		$ComputerHand._set_event(Turn_Event.WIN)
		return # computer win
	if _bust_check($ComputerHand):
		$Label3.text = "Player Wins! Computer Busts with %s!" % computer_value

		$PlayerHand._set_event(Turn_Event.WIN)
		$ComputerHand._set_event(Turn_Event.LOSE)
		return # player win
	
	if computer_value > player_value:
		$Label3.text = "Computer Wins with %s!" %  computer_value

		$PlayerHand._set_event(Turn_Event.LOSE)
		$ComputerHand._set_event(Turn_Event.WIN)
		return # computer win
	elif computer_value == player_value:
		$Label3.text = "Tie Both at %s" % player_value

		$PlayerHand._set_event(Turn_Event.TIE)
		$ComputerHand._set_event(Turn_Event.TIE)
		return # tie
	
	$Label3.text = "Player Wins with %s!" % player_value

	$PlayerHand._set_event(Turn_Event.WIN)
	$ComputerHand._set_event(Turn_Event.LOSE)
	# player win
	


func _set_active_player(player: int):
	active_player = player


func _get_active_player():
	return active_player


func _new_game():
	$Label3.text = "" # <<<---TEMP---
	_set_active_player(Players.PLAYER)
	$ComputerHand._set_event(Turn_Event.NONE)
	$PlayerHand._set_event(Turn_Event.NONE)
	CardData._reset_deck()
	emit_signal("new_game")


func _end_game():
	emit_signal("end_game")


"""""
Set the GameTimer node for a wait time delay
* yield($GameTimer, timeout) * not working when called from func
"""""
func _game_timer_set(wait_time:float = 0.25):
	$GameTimer.set_wait_time(wait_time)
	$GameTimer.set_one_shot(true)
	$GameTimer.start()
#	yield($GameTimer, "timeout")


func _on_HitButton_button_down() -> void:
	if _get_active_player() == Players.PLAYER:
		if not _bust_check($PlayerHand):
			_hit(Players.PLAYER)
			_bust_check($PlayerHand)
	
	if _bust_check($PlayerHand):
		_win_check()
		# ---TEMP---
		_game_timer_set(new_game_delay)
		yield($GameTimer, "timeout")
		_new_game()


func _on_StandButton_button_down() -> void:
	if not _bust_check($PlayerHand):
		_set_active_player(Players.COMPUTER)
		_hit_computer()


func _on_NewButton_button_down() -> void:
	_new_game()
