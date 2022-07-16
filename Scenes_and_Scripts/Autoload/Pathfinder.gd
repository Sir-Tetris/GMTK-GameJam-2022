extends Node


const TileSize = 250
const HalfTile = 125

enum Direction{
	X_PLUS,
	X_MINUS,
	Y_PLUS,
	Y_MINUS,
	ERROR
}

var unitVectors = [
	Vector2(1, 0),
	Vector2(-1, 0),
	Vector2(0, 1),
	Vector2(0, -1),
]

func getVectorFromDirection(dir:int) -> Vector2:
	if dir == Direction.X_PLUS: 
		return Vector2(1, 0)
	elif dir == Direction.X_MINUS: 
		return Vector2(-1, 0)
	elif dir == Direction.Y_PLUS: 
		return Vector2(0, 1)
	elif dir == Direction.Y_MINUS: 
		return Vector2(0, -1)
	else:
		 return Vector2(0,0)
func getDirectionFromVector(vec:Vector2) -> int:
	match vec:
		Vector2(1, 0) : return Direction.X_PLUS 
		Vector2(-1, 0): return Direction.X_MINUS 
		Vector2(0, 1) : return Direction.Y_PLUS 
		Vector2(0, -1): return Direction.Y_MINUS
		_: return Direction.ERROR
	

func getTileFromPosition(pos:Vector2) -> Vector2:
	return Vector2(floor((pos.x + HalfTile) / TileSize), floor((pos.y + HalfTile) / TileSize))
func getPositionFromTile(tile:Vector2) -> Vector2:
	return Vector2(tile.x * TileSize, tile.y * TileSize)


var _pathfinder:AStar2D

func _ready():
	_pathfinder = AStar2D.new()


func getIdFromPos(atPos:Vector2) -> int:
	return int((atPos.x + 500) * 10000 + atPos.y + 500)

func getPosFromId(id:int) -> Vector2:
	return Vector2(floor(id / 10000.0) - 500, id % 10000 - 500)


func addTile(atPos:Vector2) -> void:
	var id = getIdFromPos(atPos)
	_pathfinder.add_point(id, atPos)
	
	for v in unitVectors:
		var neighbourId = getIdFromPos(atPos + v)
		
		if _pathfinder.get_points().has(neighbourId):
			_pathfinder.connect_points(id, neighbourId)
	

func getPath(from:Vector2, to:Vector2):
	var path = _pathfinder.get_point_path(getIdFromPos(from), getIdFromPos(to))
	return path
	
func getPathSize(from:Vector2, to:Vector2) -> int:
	return getPath(from, to).size()
