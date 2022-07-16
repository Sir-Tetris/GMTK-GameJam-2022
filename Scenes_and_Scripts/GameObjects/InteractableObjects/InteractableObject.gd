extends GameObject
class_name InteractableObject



func _ready():
	stopHighlighting()




func _on_InteractionRange_body_entered(body):
	if body.is_network_master() and body.is_in_group("musketeer"):
		body.startOverlappingInteractionRange(self)


func _on_InteractionRange_body_exited(body):
	if body.is_network_master():
		body.endOverlappingInteractionRange(self)


func startHighlighting() -> void:
	$SpriteRoot/InteractionHighlight.show()
func stopHighlighting() -> void:
	$SpriteRoot/InteractionHighlight.hide()


func on_playerInteracting(p) -> void:
	p.gainPanache()
