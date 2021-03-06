TextInput = TextInput or Class.New(Element)

local TextInputPanel = {}

function TextInputPanel:Init()
	self:SetUpdateOnType(true)
end

function TextInputPanel:Paint(w, h)
	local attr = self.element.attributes
	local color = attr.text_color and attr.text_color.current or self.element:GetColor()

	self:DrawTextEntryText(color, COLOR_GRAY_LIGHTER, color)
end

function TextInputPanel:OnValueChange(v)
	self.element:OnValueChanged(v)
end

function TextInputPanel:OnCursorEntered()
	self.element.panel:OnCursorEntered()
end

function TextInputPanel:OnCursorExited()
	self.element.panel:OnCursorExited()
end

function TextInputPanel:OnMousePressed(mouse)
	self.element.panel:OnMousePressed(mouse)
end

function TextInputPanel:OnLoseFocus()
	self.element:OnUnFocus()
end

vgui.Register("TextInputPanel", TextInputPanel, "DTextEntry")

function TextInput:Init(text, props)
	TextInput.super.Init(self, {
		width_percent = 1,
		height_percent = 1,
		padding_left = 2,
		background_color = COLOR_GRAY_DARK,
		cursor = "beam",
		font = "InputText",
		border = 2,
		border_alpha = 0,
		
		disabled = {
			background_color = COLOR_BLACK_CLEAR,
			border = 1,
			border_color = COLOR_GRAY_DARK,
			border_alpha = 255
		},

		hover = {
			border_alpha = 255
		},

		text_line = self:CreateTextLine()
	})

	self.value = tostring(text)
	self.panel.text = self.panel:Add(vgui.Create "TextInputPanel")
	self:SetupPanel(text)

	if props then
		self:SetAttributes(props)
		self.read_only = props.read_only
		self.on_change = props.on_change
		self.on_click = props.on_click

		if props.read_only then
			self:Disable()
		end
	end
end

function TextInput:Disable()
	self.disabled = true
	self.panel:SetMouseInputEnabled(false)
	self:OnUnFocus()
	self:AnimateState "disabled"
end

function TextInput:Enable()
	self.disabled = false
	self.panel:SetMouseInputEnabled(true)
	self:RevertState()
end

function TextInput:CreateTextLine()
	return Element.New {
		overlay = true,
		layout = false,
		origin_position = true,
		origin_justification_x = JUSTIFY_CENTER,
		origin_justification_y = JUSTIFY_END,
		position_justification_x = JUSTIFY_CENTER,
		position_justification_y = JUSTIFY_END,
		width_percent = 1,
		height = LINE_THICKNESS,
		fill_color = true,
		alpha = 0
	}
end

function TextInput:SetupPanel(text)
	self.panel.text.element = self
	self.panel.text:SetFont(self:GetAttribute "font")
	self.panel.text:SetText(text or self:GetAttribute "text" or "")
end

function TextInput:OnValueChanged(v, no_callback)
	self.value = v

	if not no_callback and self.on_change then
		self.on_change(self, v)
	end
end

function TextInput:SetValue(v, no_callback)
	self.panel.text:SetText(v)
	self.panel.text:OnValueChange(v, no_callback)
end

function TextInput:OnMousePressed(mouse)
	TextInput.super.OnMousePressed(self, mouse)
	
	if self.on_click then
		self.on_click(self, mouse)
	end

	self:OnFocus(self)
end

function TextInput:OnMouseEntered()
	if self.disabled then
		self.panel:SetMouseInputEnabled(false)
	else
		TextInput.super.OnMouseEntered(self)
	end
end

function TextInput:OnMouseExited()
	if not self.disabled then
		TextInput.super.OnMouseExited(self)
	end
end

function TextInput:OnFocus()
	self.panel.text:RequestFocus()
	hook.Run("TextEntryFocus", self)
	self.text_line:AnimateAttribute("alpha", 255)
end

function TextInput:OnUnFocus()
	hook.Run("TextEntryUnFocus", self)
	self.text_line:AnimateAttribute("alpha", 0)
end