--// DIR.lua
--[[
    Easy access to directories in the game.
    Usage example:
        local DIR = require(game.ReplicatedFirst.DIR)
        local Knit = require(DIR.packages.Knit)
        ...
]]

local Players = game:GetService("Players")

local player = Players.LocalPlayer

local function toNil(value)
    if not value then
        return nil
    end
end

return {
    client = player and player:WaitForChild("PlayerScripts"):WaitForChild("src");
    server = toNil(not player) and game:GetService("ServerScriptService"):WaitForChild("src");
    shared = game:GetService("ReplicatedStorage"):WaitForChild("src");
    preload = game:GetService("ReplicatedFirst"):WaitForChild("src");
    unreplicated = toNil(not player) and game:GetService("ServerStorage"):WaitForChild("src");
    packages = game:GetService("ReplicatedStorage"):WaitForChild("Packages");
}