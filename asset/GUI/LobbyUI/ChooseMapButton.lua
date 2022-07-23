local btnOpen = self:child("Open")
btnOpen.onMouseClick = function()
    local chooseMap = UI:CreateGUIWindow("GUI/LobbyUI/ChooseMap")
    UI.Root:AddChild(chooseMap)
    self:close()
end