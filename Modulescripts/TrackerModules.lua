local module = {}

local alreadyGeneratedNames = {}
local alreadyGeneratedNumericKeys = {}

function module.CreateUniquePointName()
	local randomString = ""
	local randomChar = ""
	
	local function generate()
		for i = 1, 10 do
			randomChar = string.char(math.random(97, 122))
			randomString = randomString .. randomChar
		end
	end
	
	-- First try
	generate()
	
	-- Second try, unlikely, but adding anyway
	if table.find(alreadyGeneratedNames, randomString) then
		randomString, randomChar = "", ""
		generate()
	end
	
	table.insert(alreadyGeneratedNames, randomString)
	return randomString
end

function module.CreateUniqueNumericKey(CharacterLenght: number)
	local randomNumber = 0
	
	local function generate()
		randomNumber = math.random(10 ^ (CharacterLenght - 1), (10 ^ CharacterLenght) - 1)
	end
	
	generate()
	
	if table.find(alreadyGeneratedNumericKeys, randomNumber) then
		randomNumber = 0
		generate()
	end
	
	table.insert(alreadyGeneratedNumericKeys, randomNumber)
	return randomNumber
end

function module.ClearNameCache()
	table.clear(alreadyGeneratedNames)
end

function module.ClearNumericCache()
	table.clear(alreadyGeneratedNumericKeys)
end

return module
