local module = {}

-- Services
local CoreGui = game:GetService("CoreGui")

function module.FindMainGui(Script: Script)
	local function FindButtons(Gui)
		local buttons = {}

		for i, v in pairs(Gui:GetDescendants()) do
			if v:IsA("TextButton") or v:IsA("ImageButton") then
				buttons[v.Name] = v
			end
		end
		
		return buttons
	end
	
	if Script:FindFirstChild("PathFindingVisualizationGui") then
		local MainGui = Script:FindFirstChild("PathFindingVisualizationGui"):Clone()
		local GuiderTextlabel = MainGui:FindFirstChild("Guider", true)
		MainGui.Parent = CoreGui
		
		return MainGui, GuiderTextlabel, FindButtons(MainGui)
	else
		local MainGui = CoreGui:FindFirstChild("PathFindingVisualizationGui")
		local GuiderTextlabel = MainGui:FindFirstChild("Guider", true)
		
		return MainGui, GuiderTextlabel, FindButtons(MainGui)
	end
end

function module.FindSettingsGui(Script: Script)
	local function FindButtons(Gui)
		local buttons = {}

		for i, v in pairs(Gui.bg:GetChildren()) do
			if v:IsA("Frame") then
				if v:FindFirstChild("Header") and v:FindFirstChild("Button") then
					buttons[v.Name] = {
						["Header"] = v.Header,
						["Button"] = v.Button,
					}
				end
			end
		end

		return buttons
	end
	
	if Script:FindFirstChild("PathFindingSettingsGui") then
		local MainGui = Script:FindFirstChild("PathFindingSettingsGui"):Clone()
		MainGui.Parent = CoreGui

		return MainGui, FindButtons(MainGui)
	else
		local MainGui = CoreGui:FindFirstChild("PathFindingSettingsGui")
		return MainGui, FindButtons(MainGui)
	end
end

return module
