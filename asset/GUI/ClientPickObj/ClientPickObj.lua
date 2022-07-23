objStorage = {
    {"bin", "asset/map_tron_tim/b1s.actor", "myPlugin/40b134a0-16c5-48be-b360-076f09a09c79", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 2, ["pos-x"]=0, ["pos-y"]=0},
    {"vase", "asset/map_tron_tim/b2s.actor", "myPlugin/627cfd69-ae06-4b87-8bef-c5c2598014bf", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 2, ["pos-x"]=0, ["pos-y"]=0},
    {"wardrobe", "asset/map_tron_tim/b3s.actor", "myPlugin/627cfd69-ae06-4b87-8bef-c5c2598014bf", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 2, ["pos-x"]=0, ["pos-y"]=0},
    {"laptop", "asset/map_tron_tim/b4s.actor", "myPlugin/f1094dc4-f62c-4aff-90de-41f5299b9745", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 2, ["pos-x"]=0, ["pos-y"]=50},
    {"cup", "asset/map_tron_tim/b5s.actor", "myPlugin/6db74975-0824-4052-a052-1bc5376a5037", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 4, ["pos-x"]=0, ["pos-y"]=0},
    {"table", "asset/map_tron_tim/b6s.actor", "myPlugin/9250aeed-0e5b-4adc-85d6-7277d9d64ac8", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 1.5, ["pos-x"]=0, ["pos-y"]=0},
    {"bowling", "asset/map_tron_tim/b7s.actor", "myPlugin/1eaa0f52-2999-4334-a7b4-37a58b2621e5", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 2, ["pos-x"]=0, ["pos-y"]=0},
    {"little Tree", "asset/map_tron_tim/b8s.actor", "myPlugin/706e1422-4bdf-4d6b-9c7a-9517519dee82", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 3, ["pos-x"]=0, ["pos-y"]=0},
    {"Tree With No Leaves", "asset/map_tron_tim/b9s.actor", "myPlugin/b0fac06b-f2a9-457d-97c9-625acf2ce8c1", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 1, ["pos-x"]=0, ["pos-y"]=0},
    {"Tree With Little Leaves", "asset/map_tron_tim/b10s.actor", "myPlugin/b0fac06b-f2a9-457d-97c9-625acf2ce8c1", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 1, ["pos-x"]=0, ["pos-y"]=0},
    {"light Bulb", "asset/map_tron_tim/b11s.actor", "myPlugin/55dd8654-8516-4eba-b4a1-905771a6da88", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 3, ["pos-x"]=0, ["pos-y"]=90},
    {"line Of Tree", "asset/map_tron_tim/b12s.actor", "myPlugin/097d52fb-3bff-47a5-b9ad-6e70b0fec88a", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 0.5, ["pos-x"]=0, ["pos-y"]=0},
    {"street Lamp", "asset/map_tron_tim/b13s.actor", "myPlugin/a2eb5111-3ce6-4437-9587-04c5556cdef5", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 1, ["pos-x"]=0, ["pos-y"]=0},
    {"shelf", "asset/map_tron_tim/b14s.actor", "myPlugin/5483710b-9d90-4d23-91dd-967de631fcbb", ["x-axis"] = 0, ["y-axis"] =0, ["z-axis"] =0, ["scale"] = 0.7, ["pos-x"]=0, ["pos-y"]=0},
    {"pc Case", "asset/map_tron_tim/b15s.actor", "myPlugin/e69b74b1-c387-437e-87a7-9c40615f05bc", ["x-axis"] = 0, ["y-axis"] =-40, ["z-axis"] =0, ["scale"] = 3, ["pos-x"]=0, ["pos-y"]=0},
    {"pc Screen", "asset/map_tron_tim/b16s.actor", "myPlugin/db3dabee-bd95-4a23-a365-09bd7e0d113a", ["x-axis"] = 0, ["y-axis"] =-50, ["z-axis"] =0, ["scale"] = 3, ["pos-x"]=0, ["pos-y"]=0} --Còn tiếp
}

local objStorageLength = 15
local Image = self:child("Image")
function setActorView(now)
    local actorView = Image:child("ActorChoosing")
    actorView.Actor = objStorage[now][2]
    actorView.ActorScale = objStorage[now]["scale"]
    actorView.ActorPosition = {objStorage[now]["pos-x"], objStorage[now]["pos-y"], 0}
    actorView.ActorRotation = {objStorage[now]["x-axis"], objStorage[now]["y-axis"], objStorage[now]["z-axis"]}
    local actorDescript = Image:child("ActorDescrip")
    actorDescript.Text = objStorage[now][1]
end
local now = 1
setActorView(now)
local btnClose = Image:child("Close");
local btnPrev = Image:child("Prev")
local btnNext = Image:child("Next")
local btnSubmit = self:child("Submit")

btnClose.onMouseClick = function()
     self:close()
     UI:openWindow("GUI\\ClientMainUI\\ClientMainUI" )
end

btnPrev.onMouseClick = function()
    now = now - 1
    if(now<1) then
        now = 15
    end
    setActorView(now)
end

btnNext.onMouseClick = function()
    now = now + 1
    if(now>15) then
        now = 1
    end
    setActorView(now)
end


btnSubmit.onMouseClick = function()
    local actorURL = objStorage[now][2]
    Me:changeActor(actorURL)
    PackageHandlers:SendToServer("changeModel", {actorURL})
end
