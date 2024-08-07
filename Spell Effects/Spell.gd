extends Resource
class_name Spell

@export_category ("Main Effects")
enum effect_time {on_activate,on_held,on_release}
@export var timings:Array[effect_time]
@export var effects:Array[Spell_Effect]
#@export var effects=Array[Array[Spell_Effect],Array[effect_time]]
@export_category("Old Effects (Compatibility for old tests)")
@export var on_activate:Spell_Effect
@export var on_held:Spell_Effect
@export var on_release:Spell_Effect
#the held function will be called repeatedly while still held, based on timer
@export_category("Timers (in milliseconds)")
@export var ping_asap:bool
@export var held_ping_time:int
@export var cooldown_on_activate:bool
@export var cooldown_on_release:bool
@export var cooldown_time:int
#@export var max_charge_time:float

#@export var spell_scene:PackedScene


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
#func success(caster:Player,spell_index:int):
	#on_success.trigger(caster,spell_index)
