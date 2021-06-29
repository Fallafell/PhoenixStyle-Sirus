function psfpullbegin()

if(thisaddonwork and pstemporarystop==nil)then
if(IsRaidOfficer()==1) then
if pspullactiv==0 then
if pstimeruraid==nil or (pstimeruraid and GetTime()>pstimeruraid) then

pspullactiv=1
SendAddonMessage("PSaddon", "10"..timertopull, "RAID")

pstimermake(psattack, timertopull)

SendChatMessage(psattackin.." "..timertopull.." "..pssec, "raid_warning")

if timertopull > 17 then
howmuchwaitpull = timertopull-15
timertopull=15
elseif timertopull >13 then
howmuchwaitpull = timertopull-10
timertopull=10
elseif timertopull>9 then
howmuchwaitpull = timertopull-7
timertopull=7
elseif timertopull >6 then
howmuchwaitpull = timertopull-5
timertopull=5

elseif timertopull >5 then
howmuchwaitpull = timertopull-4
timertopull=4

elseif timertopull >4 then
howmuchwaitpull = timertopull-3
timertopull=3
elseif timertopull >0 then
howmuchwaitpull = 1
timertopull=timertopull-1
else



end --timertopull>17

else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pserrorcantdoanotherpullis)
timertopull=0
end--конец если запущен у кого в рейде таймер
else
psfcancelpull()
end--конец проверки на активный таймер
				else
				if (spammver==nil) then
				out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pserrornotofficer)
				spammvar=1
				end 
				end --конец проверки на промоут
else out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pserrorcantdo1)
end


end

function psfcancelpull()
SendChatMessage(psattack.." >>>"..pscanceled.."<<<", "raid_warning")
pspullactiv=0
timertopull=0
DelayTimepull=nil
pstimermake(psattack, timertopull+0.1,1)

end


function PSFbeginpullmenu()
if(thisaddonwork and IsRaidOfficer()==1 and pspullactiv==0)then
if(PSFmain5_timertopull1:GetNumber() > 1 and PSFmain5_timertopull1:GetNumber() < 21) then
timertopull=PSFmain5_timertopull1:GetNumber()
PSFmain5_timertopull1:ClearFocus()
PSF_buttonsaveexit()
psfpullbegin()
else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pstimeerror1)
end
else
psfpullbegin()
end
end


function PSFbeginpereriv(nn1,nn2)
if(IsRaidOfficer()==1) then
if(nn2)then
--минут
if(nn1 > 0 and nn1 < 31) then
skokasecpereriv=nn1*60

SendChatMessage(pstimerstarts.." '"..pspereriv.."' -> "..nn1.." "..psmin.." "..pstwobm, "raid_warning")

pstimermake(pspereriv2, skokasecpereriv)
PSFmain5_timerpereriv1:ClearFocus()


else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pstimeerror2)
end
else
--секунд

if(nn1 > 29) then
skokasecpereriv=math.fmod (nn1, 60)
skokaminpereriv=math.floor (nn1/60)

SendChatMessage(pstimerstarts.." '"..pspereriv.."' -> "..skokaminpereriv.." "..psmin.." "..skokasecpereriv.." "..pssec.." "..pstwobm, "raid_warning")

pstimermake(pspereriv2, skokaminpereriv*60+skokasecpereriv)
PSFmain5_timerpereriv1:ClearFocus()

else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pstimeerror3)
end



end
else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pserrornotofficer)
end
end


function PSFbegiowntimer(name,sec,norepinchat)
if name then
	nazvtimera=name
else
	nazvtimera=PSFmain5_timersvoi2:GetText()
end
if(nazvtimera=="")then nazvtimera=pstimernoname end
if(IsRaidOfficer()==1) then

if sec then

		skokasecpereriv=math.fmod (sec, 60)
		skokaminpereriv=math.floor (sec/60)

		if norepinchat==nil then
			SendChatMessage(pstimerstarts.." '"..nazvtimera.."' -> "..skokaminpereriv.." "..psmin.." "..skokasecpereriv.." "..pssec.." "..pstwobm, "raid_warning")
		end

		pstimermake(nazvtimera, sec)

else
if(PSFmain5_RadioButton253:GetChecked())then
	--минут
	if(PSFmain5_timersvoi1:GetNumber() > 0 and PSFmain5_timersvoi1:GetNumber() < 121) then
		skokasecpereriv=PSFmain5_timersvoi1:GetNumber()*60

		if norepinchat==nil then
			SendChatMessage(pstimerstarts.." '"..nazvtimera.."' -> "..PSFmain5_timersvoi1:GetNumber().." "..psmin.." "..pstwobm, "raid_warning")
		end

		pstimermake(nazvtimera, skokasecpereriv)
		PSFmain5_timersvoi1:ClearFocus()
		PSFmain5_timersvoi2:ClearFocus()


	else
		out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pstimeerror4)
	end
else
	--секунд

	if(PSFmain5_timersvoi1:GetNumber() > 9) then
		skokasecpereriv=math.fmod (PSFmain5_timersvoi1:GetNumber(), 60)
		skokaminpereriv=math.floor (PSFmain5_timersvoi1:GetNumber()/60)

		if norepinchat==nil then
			SendChatMessage(pstimerstarts.." '"..nazvtimera.."' -> "..skokaminpereriv.." "..psmin.." "..skokasecpereriv.." "..pssec.." "..pstwobm, "raid_warning")
		end

		pstimermake(nazvtimera, skokaminpereriv*60+skokasecpereriv)
		PSFmain5_timersvoi1:ClearFocus()
		PSFmain5_timersvoi2:ClearFocus()



	else
		out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pstimeerror5)
	end

end
end

else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pserrornotofficer)
end
end


function pstimermake(pstext, pstime,otmtimera)
local sender22=UnitName("player")

--DBM
if(DBM)then
		DBM:CreatePizzaTimer(pstime, pstext, sender22)

else
		--SendAddonMessage("DBMv4-Pizza", ("%s\t%s"):format(pstime, pstext), "RAID")
		SendAddonMessage("D4", ("%s\t%s\t%s"):format("U",pstime, pstext), "RAID")
end

--BIGWIGS
SendAddonMessage("BigWigs", "T:BWCustomBar "..pstime.." "..pstext, "RAID")


--DXE
SendAddonMessage("DXE", "^1^SAlertsRaidBar^N"..pstime.."^S~`"..pstext.."^^", "RAID")
--fire("ааы",20,"TAN","Interface\\Icons\\INV_Misc_PocketWatch_02")

if IsAddOnLoaded("DXE") then
SlashCmdList.DXEALERTLOCALBAR(pstime.." "..pstext)
end

--KLE
--SendAddonMessage("KLE", "^1^SAlertsRaidBar^N"..pstime.."^S~`"..pstext.."^^", "RAID")

--if IsAddOnLoaded("KLE") then
--SlashCmdList.KLEALERTLOCALBAR(pstime.." "..pstext)
--end

--RW2
if otmtimera==nil then
SendAddonMessage("RW2","^1^SStartCommBar^F"..(math.random()*10).."^f-53^N"..pstime.."^S"..pstext.."^^", "RAID")
end


--отправка для ФС инфы
if pstime>60 then
  SendAddonMessage("PSaddon", "20"..pstext.."^"..pstime, "RAID")
end


end


function psftimecrepol()
if pstttiimcr==nil then
pstttiimcr=1

--рысочка
local p={-76,-196,-296,-396}
for i=1,4 do
local t = PSFmain5:CreateTexture(nil,"OVERLAY")
t:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Divider")
t:SetPoint("TOP",20,p[i])
t:SetWidth(250)
t:SetHeight(16)
end

local t = PSFmain5:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t:SetText(pstimersinfo1.."\n\n"..pstimersinfo2.." |cff00ff00BigWigs    DBM    DXE    RaidWatch2|r")
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")
t:SetPoint("TOPLEFT",20,-15)
t:SetWidth(700)
t:SetHeight(155)



end
end
