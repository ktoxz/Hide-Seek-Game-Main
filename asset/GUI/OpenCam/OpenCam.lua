local btnOpen = self:child("OpenCam")
btnOpen.onMouseClick = function()
    local CameraCfg = {
        enable = true,
        lockBodyRotation = true
    }
    Blockman.Instance():changeCameraCfg(CameraCfg, -1)
    self:close()
    UI:openWindow("GUI\\LockCam\\LockCam" )
    
end