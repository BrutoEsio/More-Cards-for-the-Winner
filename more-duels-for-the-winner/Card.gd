class_name Card
extends Node2D

signal hovered
signal hovered_off



var card_in_slot = false
var real_position
var starting_position

var attack
var defense
var cost
var type
var group
var this_card_can_move = false 

func _ready() -> void:
	get_parent().connect_card_signals(self)
	

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func reset_after_dragging(starting_position:Vector2i) -> void :
	global_position = starting_position
