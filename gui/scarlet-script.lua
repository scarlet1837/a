--[[ 
Discord server
https://discord.gg/pTmc8uEqJr

YouTube channel
gameroblox0

Credits 
scarletbackup#3582

This gui Works For Pc And Mobile

]]--
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
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true -- Enable dragging
    mainFrame.Parent = screenGui

    local mainFrameCorner = Instance.new("UICorner")
    mainFrameCorner.CornerRadius = UDim.new(0, 10)
    mainFrameCorner.Parent = mainFrame

    -- Title label for the GUI title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40) -- Height of 40
    title.Position = UDim2.new(0, 0, 0, 20) -- Position it below the top
    title.Text = titleText or "UI Lib"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20 -- Increased text size for better visibility
    title.BackgroundColor3 = Color3.fromRGB(24, 24, 34)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BorderSizePixel = 0
    title.Parent = mainFrame

    -- Sidebar for navigation
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 100, 1, -30)
    sidebar.Position = UDim2.new(0, 0, 0, 30)
    sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame

    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 10)
    sidebarCorner.Parent = sidebar

    -- "Created by" label positioned at the bottom
    local createdByLabel = Instance.new("TextLabel")
    createdByLabel.Size = UDim2.new(1, 0, 0, 20) -- Full width
    createdByLabel.Position = UDim2.new(0, 0, 1, -20) -- Position it at the bottom
    createdByLabel.Text = "Created by https://discord.gg/pTmc8uEqJr"
    createdByLabel.Font = Enum.Font.Gotham
    createdByLabel.TextSize = 12 -- Slightly larger for better visibility
    createdByLabel.BackgroundTransparency = 1
    createdByLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    createdByLabel.BorderSizePixel = 0
    createdByLabel.TextScaled = true -- Scale text for better appearance
    createdByLabel.Parent = mainFrame

    -- Return the sidebar and main frame for creating tabs
    return screenGui, sidebar, mainFrame
end

-- Function to create a new tab
function GUILibrary:CreateTab(tabName, sidebar, mainFrame)
    -- Calculate Y position for the new tab based on the number of existing tabs
    local yOffset = (#tabs) * 40 + 10 -- Space between tabs and offset from the top

    -- Create a tab button in the sidebar
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0, 80, 0, 30)
    tabButton.Position = UDim2.new(0, 10, 0, yOffset)
    tabButton.Text = tabName
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    tabButton.Parent = sidebar

    local tabButtonCorner = Instance.new("UICorner")
    tabButtonCorner.CornerRadius = UDim.new(0, 8)
    tabButtonCorner.Parent = tabButton

    -- Create a scroll frame for this tab's content
    local tabContent = Instance.new("ScrollingFrame")
    tabContent.Size = UDim2.new(1, -100, 1, -30)
    tabContent.Position = UDim2.new(0, 100, 0, 30)
    tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)  -- Initial canvas size
    tabContent.ScrollBarThickness = 6
    tabContent.BackgroundColor3 = Color3.fromRGB(36, 36, 46)
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

-- Function to add a button to a specific tab
function GUILibrary:CreateButton(text, parent, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 40)
    button.Position = UDim2.new(0, 10, 0, (#parent:GetChildren() * 50) + 10) -- Automatically space buttons and add extra padding
    button.Text = text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    button.Parent = parent

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button

    -- Connect the button click to the provided callback
    button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    -- Update the CanvasSize of the scroll frame based on the number of buttons
    local scrollFrame = parent
    local buttonCount = #scrollFrame:GetChildren()
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, buttonCount * 50 + 20)  -- Update canvas size
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

-- Function to show the first tab on start
function GUILibrary:Initialize()
    if #contentFrames > 0 then
        contentFrames[1].Visible = true -- Show the first tab
    end
end

return GUILibrary
