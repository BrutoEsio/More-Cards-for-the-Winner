class_name UnitMover
extends Node


@export var play_areas: Array[PlayArea]

func _get_play_area_for_position(global:Vector2)-> int:
	var dropped_area_index := -1
	
	for i in play_areas.size():
		var tile := play_areas[i].get_tile_from_global(global)
		if play_areas[i].is_tile_in_bounds(tile):
			dropped_area_index = i
	return dropped_area_index

func _reset_card_starting_position(starting_position: Vector2, card: Card) -> void :
	var i := _get_play_area_for_position(starting_position)
	var tile := play_areas[i].get_tile_from_global(starting_position)
	
	card.reset_after_dragging(starting_position)
	play_areas[i].unit_grid.add_card(tile,card)
	


func _move_card(card:Card, play_area: PlayArea, tile: Vector2i) -> void:
	play_area.unit_grid.add_card(tile,card)
	card.global_position = play_area.get_global_from_tile(tile)
	card.reparent(play_area.unit_grid)
	
