extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _export_begin(preset_name, target_name, path, debug):
	if target_name == "HTML5": # Only for HTML5 exports
		var html_path = path + "/index.html" # Path to the exported HTML file
		var js_path = "res://fullscreen_helper.js" # Path to your JavaScript file in your Godot project


		# Check if the needed files exist
		if not FileAccess.file_exists(html_path):
			push_error("HTML file not found at: " + html_path)
			return

		if not FileAccess.file_exists(js_path):
			push_error("JS file not found at: " + js_path)
			return

		# Read the HTML content
		var file = FileAccess.open(html_path, FileAccess.READ)
		var html_content = file.get_as_text()
		file.close()

		# Read the JavaScript content
		var js_file = FileAccess.open(js_path, FileAccess.READ)
		var js_content = js_file.get_as_text()
		js_file.close()


		# Find the closing </head> tag and insert the script inclusion before it
		var head_end_tag_pos = html_content.find("</head>")

		if head_end_tag_pos != -1:
			var script_tag = "<script src=\"fullscreen_helper.js\"></script>\n"

			# Create a new file access to write the js file to the output directory
			var js_output_path = path + "/fullscreen_helper.js"
			var js_output_file = FileAccess.open(js_output_path, FileAccess.WRITE)
			js_output_file.store_string(js_content)
			js_output_file.close()

			html_content = html_content.insert(head_end_tag_pos, script_tag)

			# Write the modified HTML back to the file
			file = FileAccess.open(html_path, FileAccess.WRITE)
			file.store_string(html_content)
			file.close()
			print("Successfully injected javascript into html file")

		else:
			push_error("</head> tag not found in HTML")
