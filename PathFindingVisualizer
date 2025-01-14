local plugin: Plugin = plugin
local PluginIconId = 126615349246375
local PluginSettingsIconId = 108514581690616
local PluginId = 129468073881186
local PluginName = "PFV"

-- Services
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Selection = game:GetService("Selection")

local AdditionalModules = require(script.AdditionalModules)
local CreationModules = require(script.CreationModules)
local TrackerModules = require(script.TrackerModules)
local UiModules = require(script.UiModules)

-- Plugin setup
local Toolbar = plugin:CreateToolbar("Pathfinding")
local ActivationButton = Toolbar:CreateButton("ActivationButton", "", `rbxassetid://{PluginIconId}`, "Open")
--local PluginSettingsButton = Toolbar:CreateButton("SettingsButton", "", `rbxassetid://{PluginSettingsIconId}`, "Settings")
ActivationButton.ClickableWhenViewportHidden = false
--PluginSettingsButton.ClickableWhenViewportHidden = false

-- Variables
local PluginEnabled = false
local PluginSettingsEnabled = false

local ContainerName = "$PFV_POINTS"
local PointContainer: Folder
local ConfigFolder = script.Config

-- Functions & Events
local print = function(...)
	print(`[{PluginName}]: {...}`)
end

local warn = function(...)
	warn(`[!][{PluginName}]: {...}`)
end

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- Gui (Main)
local MainGui: ScreenGui
local GuiderTextlabel: TextLabel
local Buttons = nil

local pointConnections = {}

-- MAIN
ActivationButton.Click:Connect(function() 
	PluginEnabled = not PluginEnabled
	
	MainGui.Enabled = PluginEnabled
	PointContainer = AdditionalModules.CheckForMainContainer(ContainerName)
	
	if PluginEnabled == true then
		PointContainer.Parent = workspace
	else	
		PointContainer.Parent = script
	end
	
	-- Do not execute code below, if plugin is not on
	if PluginEnabled == false then return end
	
	Buttons.AddPoint.Activated:Connect(function(inputObject: InputObject, clickCount: number)
		local point = CreationModules.CreatePoint(PointContainer, 1, ConfigFolder.UseAttributesAsIdentifiers.Value)
		local camera: Camera = workspace:WaitForChild("CurrentCamera")
		local raycast = workspace:Raycast(camera.CFrame.Position, camera.CFrame.LookVector * 1000)
		
		if raycast then
			point.Position = raycast.Position
		else
			point.Position = Vector3.new(0, 0, 0)
			warn(`Couldn't put point to focus point, new position {point.Position}`)
		end
	end)
	
	Buttons.Complete.Activated:Connect(function(inputObject: InputObject, clickCount: number)
		print("Select instance, to which you want to parent points, after which press [ENTER] to continue")
		
		local SelectionConnection
		local InputListeningConnection
		local ParentingInstance: Instance
		
		SelectionConnection = Selection.SelectionChanged:Connect(function() 
			if #Selection:Get() == 1 then
				ParentingInstance = Selection:Get()[1]
				GuiderTextlabel.Text = `Selected: {ParentingInstance:GetFullName()}`
			elseif #Selection:Get() > 1 then	
				GuiderTextlabel.Text = "Too many instances selected"
			else	
				GuiderTextlabel.Text = ""
			end
		end)
		
		InputListeningConnection = UserInputService.InputBegan:Connect(function(input: InputObject, gameProcessedEvent: boolean) 
			if input.KeyCode == Enum.KeyCode.Return then
				SelectionConnection:Disconnect()
				InputListeningConnection:Disconnect()
				
				if PointContainer and ParentingInstance then
					for i, v in pairs(PointContainer:GetChildren()) do
						v.Parent = ParentingInstance
					end
					
					print(`Points parented to {ParentingInstance:GetFullName()} successfully`)
				elseif not ParentingInstance then
					warn("No parenting instance found, canceling")
				end
				
				GuiderTextlabel.Text = ""
				return
			end
		end)
	end)
end)

plugin.Unloading:Connect(function() 
	MainGui:Destroy()
	--SettingsMainGui:Destroy()
	
	if PointContainer then
		PointContainer:Destroy()
	end
end)

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

-- At start
local isLatestPluginVersion = AdditionalModules.CompareVersions(plugin, PluginId)
if isLatestPluginVersion == true then
	print(`Running`)
end

MainGui, GuiderTextlabel, Buttons = UiModules.FindMainGui(script)
