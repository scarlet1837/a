--[[ 
Discord server
https://discord.gg/pTmc8uEqJr

YouTube channel
gameroblox0

Credits 
scarletbackup#3582

This gui Works For Pc And Mobile

]]--
-- Scarlet Script Customizable GUI Library with Tabs (Permanent label "Created by Scarlet Script")
-- Scarlet Script Customizable GUI Library with Tabs

local GUILibrary = {}

-- Table to store the current GUI elements
local activeGUI
local tabs = {}
local contentFrames = {}

-- Function to create the main GUI with tabs
function GUILibrary:CreateMainGUI(titleText)
    local player = game.Players.LocalPlayer
    local screenGui = Instance.new("ScreenGui", player.PlayerGui)
    activeGUI = screenGui

    -- Main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28) -- Darker color for main frame
    mainFrame.BorderSizePixel = 0
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.Parent = screenGui

    -- Apply rounded corners to the main frame
    local mainFrameCorner = Instance.new("UICorner")
    mainFrameCorner.CornerRadius = UDim.new(0, 10)
    mainFrameCorner.Parent = mainFrame

    -- Title label
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = titleText or "UI Lib"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BorderSizePixel = 0
    title.Parent = mainFrame

    -- Sidebar for navigation
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 100, 1, -30)
    sidebar.Position = UDim2.new(0, 0, 0, 30)
    sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame

    -- Permanent "Created by Scarlet Script" label
    local permanentLabel = Instance.new("TextLabel")
    permanentLabel.Size = UDim2.new(0, 400, 0, 20)
    permanentLabel.Position = UDim2.new(0, 0, 1, -20) -- Bottom of the screen
    permanentLabel.Text = "Created by Scarlet Script"
    permanentLabel.Font = Enum.Font.Gotham
    permanentLabel.TextSize = 12
    permanentLabel.BackgroundTransparency = 1
    permanentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    permanentLabel.BorderSizePixel = 0
    permanentLabel.Parent = mainFrame

    -- Make the main frame draggable
    makeDraggable(mainFrame, title)

    -- Return the sidebar and main frame for creating tabs
    return screenGui, sidebar, mainFrame
end

-- Function to make the GUI draggable
local function makeDraggable(guiObject, dragHandle)
    local UIS = game:GetService("UserInputService")
    local dragging, dragStart, startPos

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Function to create a new tab
function GUILibrary:CreateTab(tabName, sidebar, mainFrame)
    -- Create a tab button in the sidebar
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 80, 0, 30)
    tabButton.Position = UDim2.new(0, 10, 0, #sidebar:GetChildren() * 40)
    tabButton.Text = tabName
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    tabButton.BorderSizePixel = 0
    tabButton.Parent = sidebar

    -- Apply rounded corners to the tab button
    local tabButtonCorner = Instance.new("UICorner")
    tabButtonCorner.CornerRadius = UDim.new(0, 8)
    tabButtonCorner.Parent = tabButton

    -- Create a scroll frame for this tab's content
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Size = UDim2.new(1, -100, 1, -50)
    tabContent.Position = UDim2.new(0, 100, 0, 30)
    tabContent.CanvasSize = UDim2.new(0, 0, 2, 0)
    tabContent.ScrollBarThickness = 6
    tabContent.BackgroundColor3 = Color3.fromRGB(36, 36, 40)
    tabContent.BorderSizePixel = 0
    tabContent.Parent = mainFrame
    tabContent.Visible = false

    -- Store the tab and content frame
    table.insert(tabs, tabButton)
    table.insert(contentFrames, tabContent)

    -- Tab button logic: switch between tabs
    tabButton.MouseButton1Click:Connect(function()
        for _, contentFrame in ipairs(contentFrames) do
            contentFrame.Visible = false
        end
        tabContent.Visible = true
    end)

    return tabContent
end

-- Function to show the first tab on start
function GUILibrary:Initialize()
    if #contentFrames > 0 then
        contentFrames[1].Visible = true -- Show the first tab
    end
end

return GUILibrary
