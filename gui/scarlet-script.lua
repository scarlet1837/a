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
    mainFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    -- Title label
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = titleText or "UI Lib"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BorderSizePixel = 0
    title.Parent = mainFrame

    -- Sidebar for navigation
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 100, 1, -30)
    sidebar.Position = UDim2.new(0, 0, 0, 30)
    sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
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

    -- Return the sidebar and main frame for creating tabs
    return screenGui, sidebar, mainFrame
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
    tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabButton.Parent = sidebar

    -- Create a scroll frame for this tab's content
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Size = UDim2.new(1, -100, 1, -30)
    tabContent.Position = UDim2.new(0, 100, 0, 30)
    tabContent.CanvasSize = UDim2.new(0, 0, 2, 0)
    tabContent.ScrollBarThickness = 6
    tabContent.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
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

    -- Return the content frame for adding buttons
    return tabContent
end

-- Function to add a button to a specific tab
function GUILibrary:CreateButton(text, parent, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 40)
    button.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 50) -- Automatically space buttons
    button.Text = text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Parent = parent

    -- Connect the button click to the provided callback
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
end

-- Function to rename the GUI title
function GUILibrary:RenameGUI(newTitle)
    if activeGUI and activeGUI:FindFirstChild("Frame") then
        local title = activeGUI.Frame:FindFirstChild("TextLabel")
        if title then
            title.Text = newTitle
        end
    end
end

return GUILibrary
