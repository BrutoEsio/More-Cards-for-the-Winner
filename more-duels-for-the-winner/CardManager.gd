extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_CARD_SLOT = 2

var screen_size
var card_being_dragged
var is_hovering_on_card
var player_hand_reference
var deck



func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_hand_reference = $"../Player_Hand"
	$"../InputManager".connect("left_mouse_button_released",on_left_click_released)
	deck = $"../Deck"
	
	

func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos =  get_global_mouse_position()
		card_being_dragged.position = Vector2(clamp(mouse_pos.x , 0, screen_size.x), 
			clamp(mouse_pos.y, 0, screen_size.y))
		

func start_drag(card):
	card_being_dragged = card
	card.scale = Vector2(1 , 1)
	
func finish_drag():
	card_being_dragged.scale = Vector2(1.05 , 1.05)
	var tile_existe = $"../Node"._get_play_area_for_position(get_global_mouse_position())
	var posicao_da_carta = $"../Tileset/Field".get_tile_from_global(get_global_mouse_position())
	
	print(deck.player_general_reference)
	#CARTAS QUE ESTAO NA MAO
	
	if tile_existe > -1 and card_being_dragged.card_in_slot == false:
		if $"../Tileset/Field/Field_grid".is_tile_occupied(posicao_da_carta) == false :
			if deck.player_general_reference.real_position.x == posicao_da_carta.x and card_being_dragged.cost <= deck.energy :
				if deck.player_general_reference.real_position.y == posicao_da_carta.y + 1 or deck.player_general_reference.real_position.y == posicao_da_carta.y -1 :
					player_hand_reference.remove_card_from_hand(card_being_dragged)
					$"../Node"._move_card( card_being_dragged,$"../Tileset/Field", posicao_da_carta)
					card_being_dragged.card_in_slot = true
					card_being_dragged.real_position = posicao_da_carta
					$"../Deck".energy = $"../Deck".energy - card_being_dragged.cost
				else : 
					player_hand_reference.add_card_to_hand(card_being_dragged)
			
			elif deck.player_general_reference.real_position.y == posicao_da_carta.y and card_being_dragged.cost <= deck.energy  :
				if deck.player_general_reference.real_position.x == posicao_da_carta.x + 1 or deck.player_general_reference.real_position.x == posicao_da_carta.x -1 :
					player_hand_reference.remove_card_from_hand(card_being_dragged)
					$"../Node"._move_card( card_being_dragged,$"../Tileset/Field", posicao_da_carta)
					card_being_dragged.card_in_slot = true
					card_being_dragged.real_position = posicao_da_carta
					$"../Deck".energy = $"../Deck".energy - card_being_dragged.cost
				else : 
					player_hand_reference.add_card_to_hand(card_being_dragged)
			
			else  :
				player_hand_reference.add_card_to_hand(card_being_dragged)
			
		else :
			player_hand_reference.add_card_to_hand(card_being_dragged)
		
	#PARA CARTAS QUE NO CAMPO
	if card_being_dragged.this_card_can_move == false and card_being_dragged.card_in_slot == true :
		card_being_dragged.reset_after_dragging($"../Tileset/Field".get_global_from_tile(card_being_dragged.real_position))
		card_being_dragged = null
		return
	
	elif card_being_dragged.card_in_slot == true and tile_existe == -1 :
		card_being_dragged.reset_after_dragging($"../Tileset/Field".get_global_from_tile(card_being_dragged.real_position))
		print(card_being_dragged.real_position)
	
	elif card_being_dragged.card_in_slot == true and tile_existe > -1 :
		if $"../Tileset/Field/Field_grid".is_tile_occupied(posicao_da_carta) == true :
			card_being_dragged.reset_after_dragging($"../Tileset/Field".get_global_from_tile(card_being_dragged.real_position))
		
		elif posicao_da_carta.x == card_being_dragged.real_position.x  :
			
			if posicao_da_carta.y == card_being_dragged.real_position.y + 1 or posicao_da_carta.y == card_being_dragged.real_position.y -1 :
				$"../Tileset/Field/Field_grid".remove_card(card_being_dragged.real_position)
				
				$"../Node"._move_card( card_being_dragged,$"../Tileset/Field", posicao_da_carta)
				card_being_dragged.real_position = posicao_da_carta
				card_being_dragged.this_card_can_move = false
			else : 
				card_being_dragged.reset_after_dragging($"../Tileset/Field".get_global_from_tile(card_being_dragged.real_position))
				print('resetou')
				
				
		elif posicao_da_carta.y == card_being_dragged.real_position.y  :
			if posicao_da_carta.x == card_being_dragged.real_position.x + 1 or posicao_da_carta.x == card_being_dragged.real_position.x -1 :
				$"../Tileset/Field/Field_grid".remove_card(card_being_dragged.real_position)
				
				$"../Node"._move_card( card_being_dragged,$"../Tileset/Field", posicao_da_carta)
				card_being_dragged.real_position = posicao_da_carta
				card_being_dragged.this_card_can_move = false
			else : 
				card_being_dragged.reset_after_dragging($"../Tileset/Field".get_global_from_tile(card_being_dragged.real_position))
				print('resetou')
		else : 
			card_being_dragged.reset_after_dragging($"../Tileset/Field".get_global_from_tile(card_being_dragged.real_position))
			print('resetou')
	else :
		player_hand_reference.add_card_to_hand(card_being_dragged)
	card_being_dragged = null
	

func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off_card)

func on_hovered_over_card(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(card, true)
	
func on_hovered_off_card(card):
	if !card_being_dragged:
		highlight_card(card, false)
		
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered:
			highlight_card(new_card_hovered, true)
		else:
			is_hovering_on_card = false
	
func highlight_card(card, hovered):
	if hovered:
		card.scale = Vector2(1.05 , 1.05)
		card.z_index = 2
	else:
		card.scale = Vector2(1 , 1)
		card.z_index = 1


func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(parameters)
	if result.size() > 0:
		#return result[0].collider.get_parent()
		return get_card_with_highest_z_index(result)
	return null

func get_card_with_highest_z_index(cards):
	var highest_z_card = cards[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	
	for i in range(1, cards.size()):
		var current_card = cards[i].collider.get_parent()
		if current_card.z_index > highest_z_index:
			highest_z_card = current_card
			highest_z_index = current_card.z_index
			
	return highest_z_card

#Modificar Aqui para se a carta pode mover ou nao
func on_left_click_released() :
	if card_being_dragged : 
		finish_drag()
