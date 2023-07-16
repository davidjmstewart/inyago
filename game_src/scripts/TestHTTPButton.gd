extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	$HTTPRequest.request_completed.connect(_on_request_completed)


func _on_request_completed(result, response_code, headers, body):
	print(result)
	print(response_code)
	print(body)
#	var json = JSON.parse_string(body.get_string_from_utf8())
#	print(json["name"])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_pressed():
	#var result = $HTTPRequest.request("http://192.168.201.79:5288/PuzzleSolution")
	#var result = $HTTPRequest.request("http://localhost:5288/PuzzleSolution")
	
	var example_puzzle_solution = {
		puzzle_id = 456,
		props = [
			{
				type = "SPRING",
				pos_x = 2,
				pos_y = 4,
				rotation = 1
			},
			{
				type = "SPRING",
				pos_x = 4,
				pos_y = 8,
				rotation = 2
			}
		],
		drawable_obstacles = [
			{
				type = "NORMAL",
				points = [
					{
						x = 2,
						y = 2
					},
					{
						x = 4,
						y = 5
					}
				]
			}
		],
		simulation_length = 13,
		track_length_used = 6
	}
	
	var json = JSON.stringify(example_puzzle_solution)
	var headers = ["Content-Type: application/json"]
	
	# Development
	$HTTPRequest.request("http://localhost:5288/PuzzleSolution", headers, HTTPClient.METHOD_POST, json)
	
	# Production
	#$HTTPRequest.request("http://localhost:5000/PuzzleSolution", headers, HTTPClient.METHOD_POST, json)
	
	pass # Replace with function body.
