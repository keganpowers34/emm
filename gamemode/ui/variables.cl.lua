QUARTER_ALPHA = 255/4
ANIMATION_DURATION = 0.2

LINE_THICKNESS = 4
MARGIN = 4

CAMUI_SMOOTH_MULTIPLIER = 16

HUD_PADDING_X = 256
HUD_PADDING_Y = 64
HUD_METER_SIZE = 3/4
HUD_ICON_SIZE = 64
HUD_MIDDLE_DISTANCE = 10.75
HUD_SIDE_ANGLE = 10
HUD_SIDE_DISTANCE = 15

HUD_METER_VALUE_TEXT_SIZE = 36

surface.CreateFont("HUDMeterValue", {
	font = "Roboto Mono",
	size = HUD_METER_VALUE_TEXT_SIZE,
	weight = 700
})

HUD_METER_VALUE_TEXT_MARGIN = HUD_METER_VALUE_TEXT_SIZE/18

HUD_METER_VALUE_TEXT_SMALL_SIZE = 22

surface.CreateFont("HUDMeterValueSmall", {
	font = "Roboto Mono",
	size = HUD_METER_VALUE_TEXT_SMALL_SIZE,
	weight = 900
})

INDICATOR_WORLD_SIZE = 24
INDICATOR_PERIPHERAL_SIZE = 40
INDICATOR_COASTER_SIZE = 150

surface.CreateFont("Notification", {
	font = "Roboto",
	size = 24,
	weight = 900
})

BAR_WIDTH = 256
BAR_HEIGHT = 64