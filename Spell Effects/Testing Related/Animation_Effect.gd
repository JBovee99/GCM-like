extends Spell_Effect
class_name  Animation_Effect


@export var animation_name:String

func trigger(target,caster:Player, spellindex:int):
	if target.has_node("NetworkAnimationPlayer"):
		print("Playing ",animation_name)
		target.get_node("NetworkAnimationPlayer").play(animation_name)
