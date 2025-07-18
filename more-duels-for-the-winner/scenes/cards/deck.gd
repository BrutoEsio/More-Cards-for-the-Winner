extends Node2D

@export var card_data : CardStatus


var player_deck 
var player_general
const CARD_SCENE_PATH = "res://scenes/cards/card.tscn"
var player_general_reference
var starting_hand_size = 3 
var card_draw_this_turn = false
var energy = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	player_general = 'General Voxus'
	player_deck = ['Backpack Magician','Forbbiden Spear','Little Caterpillar','Quetzal Follower']
	$RichTextLabel.text = str(player_deck.size())
	
	create_general()
	
	for i in range(starting_hand_size):
		draw_card()
		card_draw_this_turn = false 
	card_draw_this_turn = true 
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func draw_card():
	if card_draw_this_turn :
		return
	
	card_draw_this_turn = true
	
	var card_drawn = player_deck[0]
	player_deck.erase(card_drawn)

	if player_deck.size() == 0 : 
		$Area2D/CollisionShape2D.disabled = true
		$Sprite2D.visible = false
		
	$RichTextLabel.text = str(player_deck.size())
	
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card  = card_scene.instantiate()
	var card_image_path = str("res://assets/cards/all_png/"+card_drawn+".png")
	new_card.get_node('Sprite2D').texture = load(card_image_path)
	
	
	#Dando Atributos
	$"../CardManager".add_child(new_card)
	new_card.name = 'Card'
	new_card.position = self.position
	new_card.attack = $"../Card_data".card_atributes[card_drawn][0]
	new_card.defense = $"../Card_data".card_atributes[card_drawn][1]
	new_card.cost = $"../Card_data".card_atributes[card_drawn][4]
	new_card.type = $"../Card_data".card_atributes[card_drawn][2]
	new_card.group = $"../Card_data".card_atributes[card_drawn][3]
	
	
	
	
	$"../Player_Hand".add_card_to_hand(new_card)

func create_general():
	var card_scene = preload(CARD_SCENE_PATH)
	var new_card  = card_scene.instantiate()
	var card_image_path = str("res://assets/cards/all_png/"+player_general+".png")
	new_card.get_node('Sprite2D').texture = load(card_image_path)
	
	$"../CardManager".add_child(new_card)
	new_card.name = 'Card'
	$"../Node"._move_card(new_card,$"../Tileset/Field", Vector2i(5,5))
	new_card.card_in_slot = true
	new_card.real_position = Vector2i(5,5)
	player_general_reference = new_card
	new_card.this_card_can_move = true
