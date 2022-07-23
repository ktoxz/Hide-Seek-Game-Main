local AnnounceLine = self:child("AnnounceLine")
local AnnounceList = {}
local addAnnounce = function(announceText, delay)
  local text = AnnounceLine:child("Announce")
  text.Text = announceText
  table.insert(AnnounceList, text)
  AnnounceLine:AddChild(text)
  local textIndex = #AnnounceList
  local timerDelete = Timer.new(delay, function()
    AnnounceLine:RemoveChild(AnnounceList[textIndex])
    print("remove")
  end)
  print("added")
  timerDelete.Start()
end

addAnnounce("Số người chơi hiện tại   ", 60)
