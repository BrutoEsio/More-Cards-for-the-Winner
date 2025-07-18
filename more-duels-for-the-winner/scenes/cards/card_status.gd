class_name CardStatus
extends Node

var card_atributes = {
	#Generais
	'General Voxus' : [0,22,'monster','general',0],
	'General Ghell' : [0,22,'monster','general',0],
	
	#Bruxas
	'Cursed Doll' :[2,1,'monster','witch',2] ,
	'Backpack Magician' : [3,3,'monster','witch',3],
	'Forbbiden Spear' : [1,7,'monster', 'witch', 5],
	'Baba Express' : [3,4,'monster','witch',4],
	'Shovelling Eye' : [6,8,'monster','witch',7],
	'Dark Magic' : [null,null,'spell','witch',1],
	
	#Insetos
	'Spy Spider' : [2,2,'monster','insect',2],
	'Little Caterpillar' : [1,1,'monster','insect',2],
	'Apple Devourer' : [3,4,'monster','insect',4],
	'Queen Bee' : [1,6,'monster','insect',3],
	'Dragon Bite' : [9,2,'monster','insect',6],
	'Insect-Morphosis' : [null,null,'spell','insect',2],
	
	#Dinosauros
	'Egg Walker' : [3,1,'monster','dinosaur',1],
	'Rex Bite' : [5,1,'monster','dinosaur',3],
	'Big Bad Neck' : [4,5,'monster','dinosaur',5],
	'Lake Monster' : [3,6,'monster','dinosaur',5],
	'Quetzal Follower' : [2,10,'monster','dinosaur',8],
	'Ultra Meat' : [null,null,'spell','dinosaur',3],
	
	
	#Chaos
	'Turkey Hatter' : [1,2,'monster','chaos',1],
	'Prophet of what has already happened' : [1,3,'monster','chaos',2],
	'Hydra Head' : [1,4,'monster','chaos',2],
	'Overlord Hydra' : [3,12,'monster','chaos',6],
	'Fragility Ruler' : [1,5,'monster','chaos',6],
	'Pandora Box' : [null,null,'spell','chaos',0],
	
	#Aquaticos
	'Clown of Waters' : [1,2,'monster','aquatic',2],
	'Atlantean Memaid' : [3,2,'monster','aquatic',3],
	'Spear Master' : [5,2,'monster','aquatic',3],
	'Navigating Turtle' : [3,2,'monster','aquatic',4],
	'Moby Dick' : [7,7,'monster','aquatic',7],
	'Giant Wave' : [null,null,'spell','aquatic',1],
}




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
