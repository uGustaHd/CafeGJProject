extends Resource
class_name CustomerData

enum CustomerType {VILLAGER, SPECIAL}
enum RequestType {POTION, ITEM, SERVICE}

@export_group("Identity")
@export var name   : String
@export var id     : String
@export var type   : CustomerType
@export var possible_sprite : Array[Texture2D]

@export_group("Request")
@export var request_type : RequestType

# List of possible requests this customer can make
# One request will be randomly selected when the customer spawns
# Each request is represented as a Dictionary (ex { "green": 1, "blue": 2 })
@export var possible_requests: Potion

@export_group("Consequences")
@export var joy_on_success     : float
@export var anguish_on_success : float
@export var joy_on_fail       : float
@export var anguish_on_fail   : float
@export var gold_reward       : int

@export_group("Kill")
@export var can_be_killed   : bool
@export var joy_on_kill     : float
@export var anguish_on_kill : float

@export_group("Dialogs")
@export var dialog_intro   : Array[String]
@export var dialog_success : Array[String]
@export var dialog_fail    : Array[String]
@export var dialog_kill    : Array[String]

@export_group("Spawn Rules")
@export var spawn_weight      : int # Relative chance of this customer being selected during spawn
@export var max_simultaneous  : int # Maximum number of this customer that can exist at the same time
@export var min_day_to_appear : int # Minimum day required before this customer is allowed to appear
@export var cooldown_days     : int # Number of days that must pass before this customer can appear again
