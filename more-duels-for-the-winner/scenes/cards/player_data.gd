extends Node

var points_to_use_card
var my_turn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points_to_use_card = str ( $"../Deck".energy) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	points_to_use_card = str ( $"../Deck".energy) 
	$RichTextLabel2.text = 'Energy :' + ' ' + points_to_use_card
