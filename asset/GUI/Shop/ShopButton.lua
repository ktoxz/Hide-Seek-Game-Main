local btnShop = self:child("Open")
btnShop.onMouseClick = function()
    local closeChoose = UI:CreateGUIWindow("GUI/Shop/ShopPack")
    UI.Root:AddChild(closeChoose)
    self:close()
end