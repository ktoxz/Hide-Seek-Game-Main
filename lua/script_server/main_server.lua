Global.mapVoteCount = {0, 0, 0}
Global.mapsVoteIndex = {}
----------------------------------------------------------------------------
--function
local isInGame = false
local isStart = false
local getRand = function(how, from, to) -- get "how" number rand with no repeat
    local isChosen = {}
    local res = {}
    while (#res < how) do
        local a = math.random(from, to)
        if(isChosen[a] ~= true) then
            table.insert(res, a)
            isChosen[a] = true
        end
    end
    return res
end

local mapVoteMax = function()  -- get the max of mapVoteCount
    local maxIndex = 1
    for i, v in pairs(Global.mapVoteCount) do
        if(Global.mapVoteCount[i]>Global.mapVoteCount[maxIndex]) then
            maxIndex = i
        end
    end
    return maxIndex
end

local gameBegin = function() -- let the show begin
    World.CurWorld.SystemNotice(1, "GAME_BEGIN", 40)
    Global.mapsVoteIndex = getRand(3, 1, 4)
    PackageHandlers:SendToAllClients("GameStart", Global.mapsVoteIndex)
end

local teamCreate = function()
    Game.CreateTeam(1)
    Game.CreateTeam(2)
end

local teamDisband = function()
    Game.GetTeam(1):dismiss()
    Game.GetTeam(2):dismiss()
end

local setValueHider = function(player)
    PackageHandlers.sendServerHandler(player, "openMainUI")
    player.addValueDef("entityLink", "", true, true, true)
    player.addValueDef("entityRotation", "", true, true, true)
    player.addValueDef("isSur", 1, true, true, true)
    player:setValue("isSur", 1)
end

local setValueSeeker = function(player)
    player.addValueDef("isSur", 0, true, true, true)
    player:setValue("isSur", 0)
end

local Teleport = function(player, packet, dynamicMap)
    Lib.pv(packet)
    local index = Global.maps[Global.mapsVoteIndex[packet[1]]]
    local pos = {}
    if(packet["type"] == "Hider") then
       pos = index.hiderPos
    else
      pos = index.seekerPos 
    end
    
    local posV3 = Lib.v3(pos[1], pos[2], pos[3])
    player:setMapPos(dynamicMap,posV3)
end
local voteEnd = function()
    local mapMax = mapVoteMax()
    Global.mapVoteCount = {0, 0, 0}
    local players = Game.GetAllPlayers()
    local numOfHider = 1
    local numOfSeeker = 1
    if( #players<=5) then
        numOfHider = 1
        numOfSeeker = 1
        local mapID1 = Global.maps[Global.mapsVoteIndex[mapMax]]["mapID"]
        local dynamicMap = World.CurWorld:createDynamicMap(mapID1, true)
        teamCreate()
        local randomPlayer = getRand(#players, 1, #players)
        for i=1, numOfHider, 1 do
            setValueHider(players[randomPlayer[i]])
            Game.TryJoinTeamByPlayer(players[randomPlayer[i]], 1)    
            Teleport(players[randomPlayer[i]], {mapMax, type = "Hider"}, dynamicMap) 
        end
        for i=numOfHider+1, numOfHider+numOfSeeker, 1 do
            setValueSeeker(players[randomPlayer[i]])
            Game.TryJoinTeamByPlayer(players[randomPlayer[i]], 2)
            Teleport(players[randomPlayer[i]], {mapMax, type = "Seeker"}, dynamicMap)
        end
    end 
    isInGame = true
    
end
----------------------------------------------------------------------------
--timer


local mapVoteTimer = Timer.new(20*15, function()
    voteEnd()
end)

local gameBeginTimer = Timer.new(100, function()
    gameBegin()
end)
----------------------------------------------------------------------------
Trigger.RegisterHandler(World.cfg, "GAME_START", function() -- init
    local players = Game.GetAllPlayers()
    if(#players>1 and isStart == false) then
        gameBeginTimer:Start()
        mapVoteTimer:Start()
        isStart = true
    end
end)

Trigger.RegisterHandler(World.cfg, "ENTITY_ENTER", function(context) -- for players join after
    local player = context.obj1
    local players = Game.GetAllPlayers()
    if(#players>1) then
        if(isStart) then
            PackageHandlers:SendToClient(player, "GameStart", Global.mapsVoteIndex)
        else            
            gameBeginTimer:Start()
            mapVoteTimer:Start()
            isStart = true
        end
        
    end
end)


----------------------------------------------------------------------------
--Package

PackageHandlers:Receive("plusMap", function(player, packet)
    Global.mapVoteCount[packet] = Global.mapVoteCount[packet]+1
    PackageHandlers:SendToAllClients("mapVoteNow", Global.mapVoteCount)
    Lib.pv(Global.mapVoteCount)
end)
