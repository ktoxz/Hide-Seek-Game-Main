local btnOpenPicker = self:child("OpenPicker")

btnOpenPicker.onMouseClick = function()
    self:close()
    UI:openWindow("GUI\\ClientPickObj\\ClientPickObj" )
end