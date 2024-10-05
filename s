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
    mainFrame.Size = UDim2.new(0, 400, 0, 350) -- Adjust height to fit all elements
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175) -- Center the frame
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Active = true
    mainFrame.Draggable = true -- Enable dragging
    mainFrame.Parent = screenGui

    local mainFrameCorner = Instance.new("UICorner")
    mainFrameCorner.CornerRadius = UDim.new(0, 10)
    mainFrameCorner.Parent = mainFrame

    -- Title label
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30) -- Make the width 100%
    title.Position = UDim2.new(0, 0, 0, 0) -- Position it at the top
    title.Text = titleText or "UI Lib"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
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

    -- Permanent "Created by Scarlet Script" label
    local permanentLabel = Instance.new("TextLabel")
    permanentLabel.Size = UDim2.new(1, 0, 0, 20)
    permanentLabel.Position = UDim2.new(0, 0, 1, -20) -- Positioned at the bottom
    permanentLabel.Text = "Created by Scarlet Script"
    permanentLabel.Font = Enum.Font.Gotham
    permanentLabel.TextSize = 10  -- Reduced text size
    permanentLabel.BackgroundTransparency = 1
    permanentLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    permanentLabel.BorderSizePixel = 0
    permanentLabel.Parent = mainFrame

    -- Ensure there's enough space for the content frames
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -100, 1, -60) -- Adjust height to leave room for the permanent label
    contentFrame.Position = UDim2.new(0, 100, 0, 30)
    contentFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 46)
    contentFrame.BorderSizePixel = 0
    contentFrame.Parent = mainFrame

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
