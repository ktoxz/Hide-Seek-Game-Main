-- PackageHandlers.registerClientHandler("openPickerUI", function()
--  UI:openWindow("GUI\\ClientPickObj\\ClientPickObj" )
-- end)

-- PackageHandlers.registerClientHandler("openMainUI", function()
--  UI:openWindow("GUI\\ClientMainUI\\ClientMainUI")
-- end)

require "lua.script_server.main_server"
Global.mapVoteClient = Global.mapVoteCount
Global.mapsVoteIndexClient = {}
PackageHandlers.registerClientHandler("openMainUI", function()
   UI:openWindow("GUI/LockCam/LockCam")
end)

PackageHandlers.registerClientHandler("openSpectate", function()
  UI:openWindow("GUI/SpectateView/SpectateView")
end)

PackageHandlers.registerClientHandler("GameStart", function(player, packet)
  local chooseMapBtn = UI:CreateGUIWindow("GUI/LobbyUI/ChooseMapButton")
  local Announce = UI:CreateGUIWindow("GUI/Announce/Announce")
  UI.Root:AddChild(chooseMapBtn)
  UI.Root:AddChild(Announce)
  Global.mapsVoteIndexClient = packet
  Me.addValueDef("isVote", 0, true, true, true, true)
  Me:setValue("isVote", 0)
end)


PackageHandlers:Receive("mapVoteNow", function(server, packet)
  Lib.pv(packet)
  Global.mapVoteClient = packet
end)
