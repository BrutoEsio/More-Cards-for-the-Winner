class_name UnitGrid
extends Node2D

signal unit_grid_changed

@export var size : Vector2i
var cards : Dictionary

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in size.x :
		for j in size.y : 
			cards[Vector2i(i,j)] = null
	
	
	
	
func add_card (tile: Vector2i, card: Node) -> void :
	cards[tile] = card
	unit_grid_changed.emit()
	
	
func is_tile_occupied(tile: Vector2i) -> bool :
	return cards[tile] != null

func is_grid_full() -> bool :
	return cards.keys().all(is_tile_occupied)

func get_first_empty_tile() -> Vector2i : 
	for tile in cards :
		if tile in cards :
			if not is_tile_occupied(tile):
				return tile
	return Vector2i(-1,-1)

func get_all_cards() -> Array[Card] :
	var card_array: Array[Card] = []
	
	for card : Card in cards.values():
		if card:
			card_array.append(card)
		
	return card_array

func remove_card(tile: Vector2i)-> void:
	var card := cards[tile] as Node
	if not card :
		return
	cards[tile] = null
	unit_grid_changed.emit()

func _process(delta: float) -> void:
	#print(get_all_cards())
	pass
