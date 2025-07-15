extends Node2D

var player_deck = ['Witch','Witch','Witch']
const CARD_SCENE_PATH = "res://scenes/cards/card.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$RichTextLabel.text = str(player_deck.size())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw_card():
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)

	if player_deck.size() == 0 : 
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		
	$RichTextLabel.text = str(player_deck.size())
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card  = card_scene.instantiate()
	$"../CardManager".add_child(new_card)
	new_card.name = 'Card'
	new_card.position = self.position
	$"../Player_Hand".add_card_to_hand(new_card)
