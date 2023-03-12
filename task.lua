task.wait(1)
local Players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local LocalCharacter = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local LocalHumanoid = LocalCharacter:WaitForChild("Humanoid")
local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
local uis = game:GetService("UserInputService")
local jumpingJacks = {'ONE!','TWO!','THREE!','FOUR!','FIVE!','SIX!','SEVEN!','EIGHT!','NINE!','TEN!','ELEVEN!','TWELVE!','THIRTEEN!','FOURTEEN!','FIFTEEN!','SIXTEEN!','SEVENTEEN!','EIGHTEEN!','NINETEEN!','TWENTY!','TWENTY ONE!','TWENTY TWO!','TWENTY THREE!','TWENTY FOUR!','TWENTY FIVE!','TWENTY SIX!','TWENTY SEVEN!','TWENTY EIGHT!','TWENTY NINE!','THIRTY!','THIRTY ONE!','THIRTY TWO!','THIRTY THREE!','THIRTY FOUR!','THIRTY FIVE!','THIRTY SIX!','THIRTY SEVEN!','THIRTY EIGHT!','THIRTY NINE!','FORTY!','FORTY ONE!','FORTY TWO!','FORTY THREE!','FORTY FOUR!','FORTY FIVE!','FORTY SIX!','FORTY SEVEN!','FORTY EIGHT!','FORTY NINE!','FIFTY!','FIFTY ONE!','FIFTY TWO!','FIFTY THREE!','FIFTY FOUR!','FIFTY FIVE!','FIFTY SIX!','FIFTY SEVEN!','FIFTY EIGHT!','FIFTY NINE!','SIXTY!','SIXTY ONE!','SIXTY TWO!','SIXTY THREE!','SIXTY FOUR!','SIXTY FIVE!','SIXTY SIX!','SIXTY SEVEN!','SIXTY EIGHT!','SIXTY NINE!','EIGHTY!','EIGHTY ONE!','EIGHTY TWO!','EIGHTY THREE!','EIGHTY FOUR!','EIGHTY FIVE!','EIGHTY SIX!','EIGHTY SEVEN!','EIGHTY EIGHT!','EIGHTY NINE!','NINTY!'}
local dragToggle = nil
local dragSpeed = 0.01
local dragStart = nil
local startPos = nil
local gui = nil
local maxJJ = #jumpingJacks
function createGui()
	gui = Instance.new("ScreenGui")
	
	local frame = Instance.new("Frame")
	frame.BackgroundColor3 = Color3.new(0,0,0.07)
	frame.BackgroundTransparency = 0.3
	frame.Size = UDim2.new(0.232,0,0.31,0)
	frame.Position = UDim2.new(0.616,0,0.495,0)
	frame.Parent = gui
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0.1,0)
	uiCorner.Parent = frame
	local uiAspectRatio = Instance.new("UIAspectRatioConstraint")
	uiAspectRatio.AspectRatio = 1.326
	uiAspectRatio.Parent = frame
	
	local function createTextLabel(name,text,pos,size)
		local label = Instance.new("TextLabel")
		label.Name = name
		label.Size = size
		label.RichText = true
		label.Text = text
		label.TextScaled = true
		label.Font = "Roboto"
		label.Position = pos
		label.Parent = frame
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1,1,1)
		return label
	end
	local function createTextButton(name,text,pos,size,_function)
		local button = Instance.new("TextButton")
		button.Name = name
		button.Size = size
		button.RichText = true
		button.Text = text
		button.TextScaled = true
		button.TextColor3 = Color3.new(0,0,0)
		button.BackgroundColor3 = Color3.new(1,1,1)
		button.Position = pos
		button.Parent = frame
		button.MouseButton1Click:Connect(function()
			if _function then
				_function()
			end
			button.BackgroundColor3 = Color3.new(0,1,0)
			wait(.1)
			button.BackgroundColor3 = Color3.new(1,1,1)
		end)
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0.3,0)
		uiCorner.Parent = button
		return button
	end
	local function createTextBox(name,text,pos,size)
		local box = Instance.new("TextBox")
		box.Name = name
		box.Size = size
		box.Text = ""
		box.PlaceholderText = text
		box.ClearTextOnFocus = false
		box.TextScaled = true
		box.BackgroundColor3 = Color3.new(1,1,1)
		box.Position = pos
		box.Parent = frame
		return box
	end
	
	createTextLabel("Title","<b>JUMPING JACK SCRIPT!</b>",UDim2.new(0.093,0,0.024,0),UDim2.new(0.844,0,0.085,0))
	
	createTextLabel("JJAmount","<b>JJ Amount: 0</b>",UDim2.new(0.093,0,0.937,0),UDim2.new(0.844,0,0.063,0))
	
	createTextLabel("MaxAmount","<b>MAX JJ AMOUNT: "..maxJJ.."</b>",UDim2.new(0.091,0,0.145,0),UDim2.new(0.844,0,0.063,0))
	
	createTextBox("JJ Amount","JJ Amount",UDim2.new(0.027,0,0.21,0),UDim2.new(0.611,0,0.121,0))
	
	createTextButton("JJ Confirm","<b>Confirm</b>",UDim2.new(0.675,0,0.22,0),UDim2.new(0.295,0,0.112,0))
	
	createTextButton("SwitchToJJ","<b>Switch to JJ</b>",UDim2.new(0.027,0,0.375,0),UDim2.new(0.943,0,0.099,0))
	
	createTextButton("SwitchToGJ","<b>Switch to GJ</b>",UDim2.new(0.027,0,0.498,0),UDim2.new(0.943,0,0.099,0))
	
	createTextButton("SwitchToHJ","<b>Switch to HJ</b>",UDim2.new(0.027,0,0.62,0),UDim2.new(0.943,0,0.099,0))
	
	createTextButton("Start","<b>Start!</b>",UDim2.new(0.351,0,0.825,0),UDim2.new(0.295,0,0.112,0))
	
	local stop = createTextButton("Stop","<b>Stop</b>",UDim2.new(0.377,0,1.029,0),UDim2.new(0.243,0,0.092,0))
	stop.Visible = false
	
	createTextButton("Close","<b>X</b>",UDim2.new(0.867,0,0.032,0),UDim2.new(0.068,0,0.077,0),function()
		gui:Destroy()
	end)
	
	gui.Parent = playerGui
end
createGui()
local frame = gui:FindFirstChild("Frame")
frame.InputBegan:Connect(function(input,isNotFocused)
	if isNotFocused then return end
	if (input.UserInputType == Enum.UserInputType.MouseButton1) then
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)
function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end
uis.InputChanged:Connect(function(input,isNotFocused)
	if isNotFocused then return end
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		if dragToggle then
			updateInput(input)
		end
	end
end)
local doJumpingJacks = 0
local JJAmount = frame:FindFirstChild("JJ Amount")
local JJAmountText = frame:FindFirstChild("JJAmount")
local JJConfirm = frame:FindFirstChild("JJ Confirm")
local doing = "JJ"
local SwitchToJJ = frame:FindFirstChild("SwitchToJJ")
local SwitchToGJ = frame:FindFirstChild("SwitchToGJ")
local SwitchToHJ = frame:FindFirstChild("SwitchToHJ")
local isJumping = false
local _stop = false
JJConfirm.MouseButton1Click:Connect(function()
	if JJAmount.Text ~= "" and tonumber(JJAmount.Text) then
		if isJumping then _stop = true end
		doJumpingJacks = JJAmount.Text
		JJAmountText.Text = "<b>"..doing.." Amount: "..doJumpingJacks.."</b>"
	end
end)
SwitchToJJ.MouseButton1Click:Connect(function()
	if doing ~= "JJ" then
		if isJumping then _stop = true end
		doing = "JJ"
		JJAmount.PlaceholderText = "JJ Amount"
		JJAmount.Text = ""
		JJAmountText.Text = "<b>JJ Amount: "..doJumpingJacks.."</b>"
	end
end)
SwitchToGJ.MouseButton1Click:Connect(function()
	if doing ~= "GJ" then
		if isJumping then _stop = true end
		doing = "GJ"
		JJAmount.PlaceholderText = "GJ Amount"
		JJAmount.Text = ""
		doJumpingJacks = 0
		JJAmountText.Text = "<b>GJ Amount: "..doJumpingJacks.."</b>"
	end
end)
SwitchToHJ.MouseButton1Click:Connect(function()
	if doing ~= "HJ" then
		if isJumping then _stop = true end
		doing = "HJ"
		JJAmount.PlaceholderText = "HJ Amount"
		JJAmount.Text = ""
		doJumpingJacks = 0
		JJAmountText.Text = "<b>HJ Amount: "..doJumpingJacks.."</b>"
	end
end)
local start = frame:FindFirstChild("Start")
local stop = frame:FindFirstChild("Stop")
function sendMessage(message)
	replicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest"):FireServer(message, "All")
end
start.MouseButton1Click:Connect(function()
	if isJumping then return end
	isJumping = true
	stop.Visible = true
	for i = 0, doJumpingJacks do
		if _stop then _stop = false break end
		if i > maxJJ then break end
		if i ~= 0 then
			if doing == "JJ" then
				sendMessage(jumpingJacks[i])
				wait(.1)
				LocalHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			elseif doing == "GJ" then
				local num = jumpingJacks[i]
				if num then
					num = string.lower(num)
					local _num = ""
					for i, v in pairs(num:split("")) do
						if v ~= "!" then
							if i == 1 then
								v = string.upper(v)
							else
								if string.sub(_num, #_num) == " " and v ~= "a" then
									v = string.upper(v)
								end
							end
							_num ..= v
						end
					end
					_num ..= "."
					sendMessage(_num)
					wait(.1)
					LocalHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			elseif doing == "HJ" then
				local num = jumpingJacks[i]
				if num then
					for letter in string.gmatch(num,"(%w)") do
						sendMessage(letter)
						wait(.1)
						LocalHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						wait(1)
					end
					sendMessage(num)
					wait(.1)
					LocalHumanoid:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
			wait(math.random(1,1.5))
		end
	end
	isJumping = false
	stop.Visible = false
end)
stop.MouseButton1Click:Connect(function()
	if _stop then return end
	_stop = true
end)