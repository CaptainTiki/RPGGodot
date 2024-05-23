class_name ItemEffectHeal extends ItemEffect


@export var heal_ammount : int = 1
@export var audio : AudioStream

func use() -> void:
	#update player's health
	PlayerManager.player.update_hp(heal_ammount)
	PauseMenu.play_audio(audio)
