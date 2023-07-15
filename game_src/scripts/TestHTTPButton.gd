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
	$HTTPRequest.request("192.168.201.79:5288/PuzzleSolution")
	pass # Replace with function body.
