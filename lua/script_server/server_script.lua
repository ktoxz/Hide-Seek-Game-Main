Global.mapVoteCount = {0, 0, 0}

Trigger.RegisterHandler(World.cfg, "GAME_START", function()
    --Create a timer with an interval of 20 frames, execute the print
    local printTimer = Timer.new(20, function()
        print("hello world")
    end)
    --Set the timer to loop, i.e. execute every 20 frames
    printTimer.Loop = true
    --Start the timer
    printTimer:Start()

    --Stop the timer after 10 seconds
    Timer.new(20 * 10, function()
        printTimer:Stop()
    end):Start()
    local players = Game.GetAllPlayers()
    local survivor = Game.GetTeam(1, true):getEntityList()
    local hunter = Game.GetTeam(2, true):getEntityList()
    for _, v in pairs(survivor) do 
        if(v.isPlayer == true) then
            PackageHandlers.sendServerHandler(v, "openMainUI")
            v.addValueDef("entityLink", "", true, true, true)
            v.addValueDef("entityRotation", "", true, true, true)
            v.addValueDef("isSur", 1, true, true, true)
            v:setValue("isSur", 1)
        end
    end
    for _, v in pairs(hunter) do 
        if(v.isPlayer == true) then
            v.addValueDef("isSur", 0, true, true, true)
            v:setValue("isSur", 0)
        end
    end
    PackageHandlers:SendToAllClients("GameStart")

end)

PackageHandlers:Receive("changeModel", function(player, packet)
    player:changeActor(packet[1])
end)

PackageHandlers:Receive("plusMap", function(player, packet)
    Global.mapVoteCount[packet] = Global.mapVoteCount[packet]+1
    PackageHandlers:SendToAllClients("mapVoteNow", Global.mapVoteCount)
    Lib.pv(Global.mapVoteCount)
end)

