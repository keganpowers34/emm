MINIGAME.name = "Elimination"
MINIGAME.color = COLOR_ORANGE
MINIGAME.default_player_class = "Hunter"

MINIGAME.random_player_classes = {
	class_key = "Hunter",
	rejected_class_key = "Hunted"
}

MINIGAME:AddPlayerClass {
	name = "Hunter",
	can_tag = {"Hunted"},
	recruit_on_tag = true
}

MINIGAME:AddPlayerClass {
	name = "Hunted",
	color = COLOR_SKY,
	end_on_none = true,
	player_class_on_death = "Hunter"
}