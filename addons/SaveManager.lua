local SaveManager = {}

local Library = nil
local SaveFolder = nil
local Ignore = {}

function SaveManager:SetLibrary(Lib)
    Library = Lib
end

function SaveManager:SetFolder(Folder)
    SaveFolder = Folder
end

function SaveManager:IgnoreThemeSettings()
    -- No-op
end

function SaveManager:SetIgnoreIndexes(Indexes)
    for _, Index in ipairs(Indexes) do
        Ignore[Index] = true
    end
end

function SaveManager:BuildConfigSection(Tab)
    local ConfigGroup = Tab:AddRightGroupbox("Configuration")
    
    ConfigGroup:AddInput("ConfigName", {
        Text = "Config Name",
        Placeholder = "MyConfig",
        Finished = true
    })

    ConfigGroup:AddButton({
        Text = "Create Config",
        Func = function()
            Library:Notify("Config created (placeholder)", 2)
        end
    })

    ConfigGroup:AddDropdown("ConfigList", {
        Values = {"Config1", "Config2"},
        Default = 1,
        Multi = false,
        Text = "Configs"
    })

    ConfigGroup:AddButton({
        Text = "Load Config",
        Func = function()
            Library:Notify("Config loaded (placeholder)", 2)
        end
    })

    ConfigGroup:AddButton({
        Text = "Save Config",
        Func = function()
            Library:Notify("Config saved (placeholder)", 2)
        end
    })

    ConfigGroup:AddButton({
        Text = "Delete Config",
        Func = function()
            Library:Notify("Config deleted (placeholder)", 2)
        end
    })
end

function SaveManager:LoadAutoloadConfig()
    -- No-op for now
end

return SaveManager
