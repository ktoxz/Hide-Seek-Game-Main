Trigger.RegisterHandler(this:cfg(), "ENTITY_CLICK", function(context)
    local target = context.obj1
    local player = context.obj2
    local entityLink = player:getValue("entityLink");
    local entityPos = player:getValue("entityPos");
    local isTarSur = target:getValue("isSur")
    local isPlayHunt = player:getValue("isSur")
    if(isTarSur == 1 and isPlayHunt == 0) then
        target:takeDamage(10, player, false, ':>')
    end
end)
