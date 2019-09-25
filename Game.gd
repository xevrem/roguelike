extends Node2D
const TILE_SIZE = 16
const LEVEL_SIZES = [
	Vector2(30,30),
	Vector2(35,35),
	Vector2(40,40),
	Vector2(45,45),
	Vector2(50,50),
]

const LEVEL_ROOM_COUNTS = [5, 7, 9, 12, 15]
const MIN_ROOM_DIMENSION = 5
const MAX_ROOM_DIMENSION = 8

enum Tile {Wall, Door, Floor, Ladder, Stone}
const WALL = Vector2(10,17)
const FLOOR = Vector2(0,0)
const DOOR = Vector2(10,9)
const STONE = Vector2(4,0)
const LADDER = Vector2(0,6)

# current level
var level_num = 0
var map = []
var rooms = []
var level_size

onready var tile_map = $TileMap
onready var player = $Player

#game state

var player_tile
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_size(Vector2(1280, 720))
	print_debug($TileMap.get_used_cells())
	randomize()
	build_level()
	
func build_level():
	#start with a blank map
	rooms.clear()
	map.clear()
	tile_map.clear()
	level_size = LEVEL_SIZES[level_num]
	for x in range(level_size.x):
		map.append([])
		for y in range(level_size.y):
			map[x].append(Tile.Stone)
			tile_map.set_cell(x, y, 0, false,false,false, STONE)
			
	var free_regions = [Rect2(Vector(2,2), level_size - Vector2(4,4))]		
	var num_rooms = LEVEL_ROOM_COUNTS[level_num]
	for i in range(num_rooms):
		add_room(free_regions)
		if free_regions.empty():
			break
			
func add_room(free_regions):
	var region = free_regions[randi() * free_regions.size()]
	
	var size_x = MIN_ROOM_DIMENSION
	if region.size.x > MIN_ROOM_DIMENSION:
		size_x += randi() % int(region.size.x - MIN_ROOM_DIMENSION)
	
	var size_y = MIN_ROOM_DIMENSION
	if region.size.y > MIN_ROOM_DIMENSION:
		size_y += randi() % int(region.size.y - MIN_ROOM_DIMENSION)
		
	size_x = min(size_x, MAX_ROOM_DIMENSION)
	size_y = min(size_y, MAX_ROOM_DIMENSION)
	
	var start_x = region.position.x
	if region.size.x > size_x:
		start_x += randi() % int(region.size.x - size_x)
		
	var start_y = region.position.y
	if region.size.y > size_y:
		start_y += randi() % int(region.size.x - size_y)
		
	var room = Rect2(start_x, start_y, size_x, size_y)
	rooms.append(room)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			
			