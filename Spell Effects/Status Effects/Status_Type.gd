extends Resource
class_name Status_Type

@export_category ("Main Effects")
enum effect_time {on_activate,on_held,on_release}
@export var timings:Array[effect_time]
@export var effects:Array[Spell_Effect]

@export_category("Old for compatibility")
@export var on_activate:Spell_Effect
@export var on_held:Spell_Effect
@export var on_release:Spell_Effect
#the held function will be called repeatedly while still held, based on timer
@export var ping_time:int
@export var total_effect_time:int


func activate(caster:Player,spell_index:int):
	if(on_activate!=null):
		on_activate.trigger(caster,caster,spell_index)
	for i in range(timings.size()):
		if timings[i] == effect_time.on_activate:
			effects[i].trigger(caster,caster,spell_index)
func held(caster:Player,spell_index:int):
	if(on_held!=null):
		on_held.trigger(caster,caster,spell_index)
	for i in range(timings.size()):
		if timings[i] == effect_time.on_held:
			effects[i].trigger(caster,caster,spell_index)
func release(caster:Player,spell_index:int):
	if(on_release!=null):
		on_release.trigger(caster,caster,spell_index)
	for i in range(timings.size()):
		if timings[i] == effect_time.on_release:
			effects[i].trigger(caster,caster,spell_index)
