Trigger.RegisterHandler(this:cfg(), "ENTITY_CLICK", function(context)
    local target = context.obj1
    local player = context.obj2
    local entityLink = player:getValue("entityLink");
    local entityRotation = player:getValue("entityRotation")
    local entityPos = player:getPosition();
    local isSur = player:getValue("isSur")
    
    if(isSur == 1) then
        if(entityLink == "" or entityPos == "" or entityRotation == "") then
            print("no")
        end 
        if(entityLink ~= "" and entityPos ~= "" and entityRotation ~= "") then
            local world = World.CurWorld    
            local defaultMap = world.defaultMap
            local createParams = {cfgName = entityLink, pos=entityPos, map=defaultMap}
            print("entityPos "..entityPos.x.." "..entityPos.y .. " " .. entityPos.z )
            print("hello" .. entityLink)
            EntityServer.Create(createParams):setRotationYaw(player:getRotationYaw())
        end
        local entityActorLink = target:cfg().actorName
        entityLink = target:cfg().fullName
        player:setValue("entityRotation", player:getRotationYaw())
        player:setValue("entityLink", entityLink)
        player:changeActor(entityActorLink)
        target:kill(player, "hehe")
        print("the target is"..target.name)
    end
    if(isSur == 0) then
        print("hehe")
    end
    
end)