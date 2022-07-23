require "script_common.main"
local btnClose = self:child("Close")
local mapImg = {self:child("Map1"), self:child("Map2"), self:child("Map3")}
local btnMapName = {mapImg[1]:child("MapName"), mapImg[2]:child("MapName"), mapImg[3]:child("MapName")}
local txtVoteCount = {mapImg[1]:child("VoteCount"), mapImg[2]:child("VoteCount"), mapImg[3]:child("VoteCount")}
local isVote = Me:getValue("isVote")
print(isVote)
Lib.pv(Global.maps)
Lib.pv(Global.mapsVoteIndexClient)
----------------------------------------------------------------------------
--function 
local setImg = function()
    for i, v in pairs(Global.mapsVoteIndexClient) do
        mapImg[i].Image = Global.maps[v].img
    end
end

local resetVoteView = function()
    for i, v in pairs(txtVoteCount) do
        v.Text = Global.mapVoteClient[i]
    end
end

local disableVote = function()
    for _, v in pairs(btnMapName) do
        v.Disabled = true
    end
    resetVoteView()
end
--for chooseMap
setImg()
resetVoteView()
if(Me:getValue("isVote") == 1) then
    disableVote()
end

World.Timer(100, function()
     resetVoteView()
     return true
end)
-- For onMouseClick button
btnClose.onMouseClick = function()
    local closeChoose = UI:CreateGUIWindow("GUI/LobbyUI/ChooseMapButton")
    UI.Root:AddChild(closeChoose)
    self:close()
    
end
btnMapName[1].onMouseClick = function()
    PackageHandlers:SendToServer("plusMap", 1)
    disableVote()  
    txtVoteCount[1].Text = tonumber(txtVoteCount[1].Text)+1
    Me:setValue("isVote", 1)
end
btnMapName[2].onMouseClick = function()
    PackageHandlers:SendToServer("plusMap", 2)
    disableVote()  
    txtVoteCount[2].Text = tonumber(txtVoteCount[2].Text)+1
    Me:setValue("isVote", 1)
end
btnMapName[3].onMouseClick = function()
    PackageHandlers:SendToServer("plusMap", 3)
    disableVote()   
    txtVoteCount[3].Text = tonumber(txtVoteCount[3].Text)+1
    Me:setValue("isVote", 1)
end
--end

