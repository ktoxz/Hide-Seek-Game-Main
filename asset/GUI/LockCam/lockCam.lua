local btnLock = self:child("LockCam")
btnLock.onMouseClick = function()
    local CameraCfg = {
        enable = true,
        lockBodyRotation = false
    }
    Blockman.Instance():changeCameraCfg(CameraCfg, -1)
    UI:openWindow("GUI\\OpenCam\\OpenCam" )
    self:close()
    
end