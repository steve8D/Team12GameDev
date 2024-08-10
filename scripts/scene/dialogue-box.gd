extends CanvasLayer

@onready var dialogueText = $"Control/Textbox/MarginContainer/Dialogue Text"
@onready var characterPhoto = $"Control/CharacterPhoto"
var dialogueSkipAllowed = false

func _ready():
	hide() 

func _process(delta):
	if Input.is_action_just_pressed("close_dialogue") and self.visible and dialogueSkipAllowed:
		hide()

func setDialogueSkipAllowed(bool):
	dialogueSkipAllowed = bool

func setText(text):
	dialogueText.text = text
	
func _on_player_trigger_dialogue():
	show()

func _on_player_end_dialogue():
	hide()
