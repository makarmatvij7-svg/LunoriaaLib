local ThemeManager = {} 

local Library = nil

function ThemeManager:SetLibrary(Lib)
    Library = Lib
end

function ThemeManager:SetFolder(Folder)
    self.Folder = Folder
    self:BuildFolderTree()
end

function ThemeManager:BuildFolderTree()
    -- No-op for GitHub raw URLs
end

function ThemeManager:ApplyToTab(Tab)
    local Themes = {
        Default = { FontColor = Color3.fromRGB(255, 255, 255); MainColor = Color3.fromRGB(24, 24, 24); BackgroundColor = Color3.fromRGB(20, 20, 20); AccentColor = Color3.fromRGB(71, 119, 182); OutlineColor = Color3.fromRGB(31, 31, 31); RiskColor = Color3.fromRGB(255, 50, 50); },
        Midnight = { FontColor = Color3.fromRGB(255, 255, 255); MainColor = Color3.fromRGB(15, 15, 25); BackgroundColor = Color3.fromRGB(10, 10, 20); AccentColor = Color3.fromRGB(100, 100, 255); OutlineColor = Color3.fromRGB(25, 25, 40); RiskColor = Color3.fromRGB(255, 50, 50); },
        Sentinel = { FontColor = Color3.fromRGB(255, 255, 255); MainColor = Color3.fromRGB(25, 25, 25); BackgroundColor = Color3.fromRGB(20, 20, 20); AccentColor = Color3.fromRGB(235, 100, 50); OutlineColor = Color3.fromRGB(40, 40, 40); RiskColor = Color3.fromRGB(255, 50, 50); },
        Synapse = { FontColor = Color3.fromRGB(255, 255, 255); MainColor = Color3.fromRGB(30, 30, 30); BackgroundColor = Color3.fromRGB(25, 25, 25); AccentColor = Color3.fromRGB(60, 200, 100); OutlineColor = Color3.fromRGB(40, 40, 40); RiskColor = Color3.fromRGB(255, 50, 50); },
        Serpent = { FontColor = Color3.fromRGB(255, 255, 255); MainColor = Color3.fromRGB(20, 20, 20); BackgroundColor = Color3.fromRGB(15, 15, 15); AccentColor = Color3.fromRGB(200, 50, 50); OutlineColor = Color3.fromRGB(35, 35, 35); RiskColor = Color3.fromRGB(255, 50, 50); },
        GameSense = { FontColor = Color3.fromRGB(255, 255, 255); MainColor = Color3.fromRGB(20, 20, 20); BackgroundColor = Color3.fromRGB(15, 15, 15); AccentColor = Color3.fromRGB(100, 180, 100); OutlineColor = Color3.fromRGB(35, 35, 35); RiskColor = Color3.fromRGB(255, 50, 50); },
        Purple = { FontColor = Color3.fromRGB(255, 255, 255); MainColor = Color3.fromRGB(20, 20, 20); BackgroundColor = Color3.fromRGB(15, 15, 15); AccentColor = Color3.fromRGB(180, 100, 255); OutlineColor = Color3.fromRGB(35, 35, 35); RiskColor = Color3.fromRGB(255, 50, 50); },
        Ocean = { FontColor = Color3.fromRGB(255, 255, 255); MainColor = Color3.fromRGB(20, 30, 40); BackgroundColor = Color3.fromRGB(15, 25, 35); AccentColor = Color3.fromRGB(50, 150, 200); OutlineColor = Color3.fromRGB(30, 40, 50); RiskColor = Color3.fromRGB(255, 50, 50); },
        Light = { FontColor = Color3.fromRGB(0, 0, 0); MainColor = Color3.fromRGB(240, 240, 240); BackgroundColor = Color3.fromRGB(230, 230, 230); AccentColor = Color3.fromRGB(71, 119, 182); OutlineColor = Color3.fromRGB(200, 200, 200); RiskColor = Color3.fromRGB(255, 50, 50); },
    }

    local ThemeGroup = Tab:AddLeftGroupbox("Themes")
    
    ThemeGroup:AddDropdown("ThemeDropdown", {
        Values = {"Default", "Midnight", "Sentinel", "Synapse", "Serpent", "GameSense", "Purple", "Ocean", "Light"},
        Default = 1,
        Multi = false,
        Text = "Theme",
        Callback = function(Value)
            local Theme = Themes[Value]
            if Theme then
                for Property, Color in pairs(Theme) do
                    Library[Property] = Color
                end
                Library:UpdateColorsUsingRegistry()
            end
        end
    })

    ThemeGroup:AddToggle("RainbowToggle", {
        Text = "Rainbow Accent",
        Callback = function(Value)
            if Value then
                local RS = game:GetService("RunService")
                local Connection
                Connection = RS.RenderStepped:Connect(function()
                    if not Library.RainbowEnabled then
                        Connection:Disconnect()
                        return
                    end
                    Library.AccentColor = Library.CurrentRainbowColor or Color3.fromHSV(tick() % 5 / 5, 0.8, 1)
                    Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor)
                    Library:UpdateColorsUsingRegistry()
                end)
                Library.RainbowEnabled = true
            else
                Library.RainbowEnabled = false
            end
        end
    })

    ThemeGroup:AddInput("CustomColorHex", {
        Text = "Custom Accent (Hex)",
        Placeholder = "#4777B6",
        Finished = true,
        Callback = function(Value)
            local Success, Result = pcall(Color3.fromHex, Value)
            if Success and typeof(Result) == "Color3" then
                Library.AccentColor = Result
                Library.AccentColorDark = Library:GetDarkerColor(Result)
                Library:UpdateColorsUsingRegistry()
            end
        end
    })
end

return ThemeManager
