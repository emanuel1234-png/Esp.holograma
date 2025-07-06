-- Holograma preto com botão de ativar/desativar
-- Para uso educacional no Roblox

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

local hologramEnabled = false

-- Cria o holograma
local function createHologram(player)
    if player == LocalPlayer then return end

    local character = player.Character
    if not character then return end

    -- Verifica se já existe
    if character:FindFirstChild("Hologram") then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "Hologram"
    highlight.FillColor = Color3.new(0, 0, 0) -- preto
    highlight.OutlineColor = Color3.new(0, 0, 0) -- contorno preto
    highlight.FillTransparency = 0.3 -- Ajuste para ver através
    highlight.OutlineTransparency = 0
    highlight.Parent = character
end

local function removeHologram(player)
    local character = player.Character
    if character and character:FindFirstChild("Hologram") then
        character.Hologram:Destroy()
    end
end

local function updateHolograms()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if hologramEnabled then
                createHologram(player)
            else
                removeHologram(player)
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        updateHolograms()
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    removeHologram(player)
end)

-- GUI para ativar/desativar
local screenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
screenGui.Name = "HologramGui"

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 200, 0, 50)
toggleButton.Position = UDim2.new(0.5, -100, 0.9, 0)
toggleButton.Text = "Ativar Holograma"
toggleButton.Parent = screenGui

toggleButton.MouseButton1Click:Connect(function()
    hologramEnabled = not hologramEnabled
    if hologramEnabled then
        toggleButton.Text = "Desativar Holograma"
    else
        toggleButton.Text = "Ativar Holograma"
    end
    updateHolograms()
end)

-- Atualizar sempre que o script rodar
updateHolograms()
