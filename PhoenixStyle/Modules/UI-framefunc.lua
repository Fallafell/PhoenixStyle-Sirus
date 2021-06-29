function PSF_buttonoffmark()
PSFmain4_Button22:Hide()
PSFmain4_Textmark2:Show()
PSFmain4_Textmark1:Hide()
PSFmain4_Button20:Show()
PSFmain4_Button210:Show()
PSFmain4_Button212:Hide()
if(autorefmark) then autorefmark=false out("|cff99ffffPhoenixStyle|r - "..psmarkreflesh.." |cffff0000"..psmarkrefleshoff.."|r.") end
psautomarunfoc()
for i=1,8 do
psautoupok[i]:SetText("|cffff0000-|r")
end
end

function PSF_buttonresetmark()
for i=1,8 do
	for j=1,#pssetmarknew[i] do
		if pssetmarknew[i][j] and UnitExists(pssetmarknew[i][j]) and GetRaidTargetIndex(pssetmarknew[i][j]) then
			SetRaidTarget(pssetmarknew[i][j], 0)
		end
	end
psfautomebtable[i]:SetText("")
psautoupok[i]:SetText("|cffff0000-|r")
end
pssetmarknew={{},{},{},{},{},{},{},{}}
truemark={"false","false","false","false","false","false","false","false"}
psautomarunfoc()
if(autorefmark) then out("|cff99ffffPhoenixStyle|r - "..psmarkreflesh.." |cffff0000"..psmarkrefleshoff.."|r.") end
autorefmark=false
PSFmain4_Button22:Hide()
PSFmain4_Textmark2:Show()
PSFmain4_Textmark1:Hide()
PSFmain4_Button20:Show()
PSFmain4_Button210:Show()
PSFmain4_Button212:Hide()
end

function PSF_buttonbeginmark()
if(thisaddonwork) then
if(IsRaidOfficer()==1) then
for te=1,8 do
	if psfautomebtable[te]:GetText() == "" then psautomarchangeno(te) else
	psmarksisinraid(psfautomebtable[te]:GetText(), 1, te)
	end
end

 
psdatrumark=0
for i=1,8 do
if truemark[i]=="true" then psdatrumark=1 end
end

psautomarunfoc()

if (psdatrumark==1) then
if(IsRaidOfficer()==1) then
autorefmark=true
PSFmain4_Button20:Hide()
PSFmain4_Button210:Hide()
PSFmain4_Button212:Show()
PSFmain4_Button22:Show()
PSFmain4_Textmark1:Show()
PSFmain4_Textmark2:Hide()
out("|cff99ffffPhoenixStyle|r - "..psmarkreflesh.." |cff00ff00"..psmarkrefleshon.."|r.")
else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..psnopermissmark)
end
else
if(autorefmark) then autorefmark=false out("|cff99ffffPhoenixStyle|r - "..psmarkreflesh.." |cffff0000"..psmarkrefleshoff.."|r.") else out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..psnonickset) end
end
else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..psnopermissmark)
end
else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..psaddonofmodno)
end
end

function psmarksisinraid(chekat, trueli, nomir)
	if trueli==1 then
local spisoknikov={}

		local rsctemptext2=""
		local rsctemptext=chekat.." "
		while string.len(rsctemptext)>1 do
			if (string.find(rsctemptext," ") and string.find(rsctemptext," ")==1) or (string.find(rsctemptext,"%.") and string.find(rsctemptext,"%.")==1) or (string.find(rsctemptext,",") and string.find(rsctemptext,",")==1) then

				rsctemptext=string.sub(rsctemptext,2)

			else
				local a1=string.find(rsctemptext," ")
				local a2=string.find(rsctemptext,",")
				local a3=string.find(rsctemptext,"%.")
				local min=1000
				if a1 and a1<min then
				min=a1
				end
				if a2 and a2<min then
				min=a2
				end
				if a3 and a3<min then
				min=a3
				end
				if min==1000 then
					rsctemptext=""
				else
					if string.len(rsctemptext2)>1 then
						rsctemptext2=rsctemptext2..", "
					end
					table.insert(spisoknikov,string.sub(rsctemptext,1,min-1))
					rsctemptext2=rsctemptext2..string.sub(rsctemptext,1,min-1)
					rsctemptext=string.sub(rsctemptext,min)

				end
			end
		end
		psfautomebtable[nomir]:SetText(rsctemptext2)

if spisoknikov[1] then

if UnitInRaid(spisoknikov[1]) then
	table.wipe(pssetmarknew[nomir])
	pssetmarknew[nomir][1]=spisoknikov[1]
	truemark[nomir]="true"
	psautoupok[nomir]:SetText("|cff00ff00ok|r")

		if UnitExists(pssetmarknew[nomir][1]) and (GetRaidTargetIndex(pssetmarknew[nomir][1])==nil or (GetRaidTargetIndex(pssetmarknew[nomir][1]) and GetRaidTargetIndex(pssetmarknew[nomir][1])~=nomir)) then
			SetRaidTarget(pssetmarknew[nomir][1], nomir)
		end
	if #spisoknikov>1 then
		for uy=2,#spisoknikov do
			if UnitInRaid(spisoknikov[uy]) then
				table.insert(pssetmarknew[nomir],spisoknikov[uy])
			else
				out("|cff99ffffPhoenixStyle|r - '|CFF00FF00"..spisoknikov[uy].."|r' - "..psnotfoundinr)
				psautoupok[nomir]:SetText("|cff00ff00ok|r |cffff0000-|r")
				table.insert(pssetmarknew[nomir],spisoknikov[uy])
			end
		end
	end
else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..psattention.."|r '|CFF00FF00"..spisoknikov[1].."|r' - "..psnotfoundinr.." "..format(psautomarnotu,nomir))
truemark[nomir]="false"
table.wipe(pssetmarknew[nomir])
for tg=1,#spisoknikov do
table.insert(pssetmarknew[nomir],spisoknikov[tg])
end
psautoupok[nomir]:SetText("|cffff0000-|r")
end

end


if #spisoknikov==0 then
truemark[nomir]="false"
table.wipe(pssetmarknew[nomir])
psautoupok[nomir]:SetText("|cffff0000-|r")
end




	else




local spisoknikov={}

		local rsctemptext2=""
		local rsctemptext=chekat.." "
		while string.len(rsctemptext)>1 do
			if (string.find(rsctemptext," ") and string.find(rsctemptext," ")==1) or (string.find(rsctemptext,"%.") and string.find(rsctemptext,"%.")==1) or (string.find(rsctemptext,",") and string.find(rsctemptext,",")==1) then

				rsctemptext=string.sub(rsctemptext,2)

			else
				local a1=string.find(rsctemptext," ")
				local a2=string.find(rsctemptext,",")
				local a3=string.find(rsctemptext,"%.")
				local min=1000
				if a1 and a1<min then
				min=a1
				end
				if a2 and a2<min then
				min=a2
				end
				if a3 and a3<min then
				min=a3
				end
				if min==1000 then
					rsctemptext=""
				else
					if string.len(rsctemptext2)>1 then
						rsctemptext2=rsctemptext2..", "
					end
					table.insert(spisoknikov,string.sub(rsctemptext,1,min-1))
					rsctemptext2=rsctemptext2..string.sub(rsctemptext,1,min-1)
					rsctemptext=string.sub(rsctemptext,min)

				end
			end
		end
		psfautomebtable[nomir]:SetText(rsctemptext2)


if spisoknikov[1] then

if UnitInRaid(spisoknikov[1]) then
	table.wipe(pssetmarknew[nomir])
	pssetmarknew[nomir][1]=spisoknikov[1]
if autorefmark then
	truemark[nomir]="true"
	psautoupok[nomir]:SetText("|cff00ff00ok|r")

		if UnitExists(pssetmarknew[nomir][1]) and (GetRaidTargetIndex(pssetmarknew[nomir][1])==nil or (GetRaidTargetIndex(pssetmarknew[nomir][1]) and GetRaidTargetIndex(pssetmarknew[nomir][1])~=nomir)) then
			SetRaidTarget(pssetmarknew[nomir][1], nomir)
		end
end
	if #spisoknikov>1 then
		for uy=2,#spisoknikov do
			if UnitInRaid(spisoknikov[uy]) then
				table.insert(pssetmarknew[nomir],spisoknikov[uy])
			else
				if autorefmark then
					out("|cff99ffffPhoenixStyle|r - '|CFF00FF00"..spisoknikov[uy].."|r' - "..psnotfoundinr)
					psautoupok[nomir]:SetText("|cff00ff00ok|r |cffff0000-|r")
				end
				table.insert(pssetmarknew[nomir],spisoknikov[uy])
			end
		end
	end
else
if autorefmark then
out("|cff99ffffPhoenixStyle|r - |cffff0000"..psattention.."|r '|CFF00FF00"..spisoknikov[1].."|r' - "..psnotfoundinr.." "..format(psautomarnotu,nomir))
end
truemark[nomir]="false"
table.wipe(pssetmarknew[nomir])
for tg=1,#spisoknikov do
table.insert(pssetmarknew[nomir],spisoknikov[tg])
end
psautoupok[nomir]:SetText("|cffff0000-|r")
end

end


if #spisoknikov==0 then
truemark[nomir]="false"
table.wipe(pssetmarknew[nomir])
psautoupok[nomir]:SetText("|cffff0000-|r")
end

	end
end





function openremovechat()
if not DropDownremovechat then
CreateFrame("Frame", "DropDownremovechat", PSFmainchated, "UIDropDownMenuTemplate")
end

DropDownremovechat:ClearAllPoints()
DropDownremovechat:SetPoint("TOPLEFT", 8, -241)
DropDownremovechat:Show()

local items = bigmenuchatlist

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownremovechat, self:GetID())

--тут делать чо та
pschcnumrem=1
PSFmainchated_Button20:Hide()
PSFmainchated_Button21:Show()

if self:GetID()>8 then
PSFmainchated_Button20:Show()
PSFmainchated_Button21:Hide()
pschcnumrem=self:GetID()
end



end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end

PSFmainchated_Button21:Show()
PSFmainchated_Button20:Hide()
pschcnumrem=1

UIDropDownMenu_Initialize(DropDownremovechat, initialize)
UIDropDownMenu_SetWidth(DropDownremovechat, 90)
UIDropDownMenu_SetButtonWidth(DropDownremovechat, 105)
UIDropDownMenu_SetSelectedID(DropDownremovechat, 1)
UIDropDownMenu_JustifyText(DropDownremovechat, "LEFT")
end



function openaddchat()
if not DropDownaddchat then
CreateFrame("Frame", "DropDownaddchat", PSFmainchated, "UIDropDownMenuTemplate")
end

DropDownaddchat:ClearAllPoints()
DropDownaddchat:SetPoint("TOPLEFT", 8, -136)
DropDownaddchat:Show()

--создание списка чата
pschc={}
table.wipe(pschc)
_,pschc[1],_,pschc[2],_,pschc[3],_,pschc[4],_,pschc[5],_,pschc[6],_,pschc[7],_,pschc[8],_,pschc[9],_,pschc[10]=GetChannelList()

local pschc2={}
table.wipe(pschc2)
pschc2[1],pschc2[2],pschc2[3],pschc2[4],pschc2[5],pschc2[6],pschc2[7],pschc2[8],pschc2[9],pschc2[10]=EnumerateServerChannels()
if #pschc2>0 then
	for i=1,#pschc2 do
		for j=1,#pschc do
		if pschc[j]==pschc2[i] then table.remove(pschc,j)
		end end
	end
end

	for i=8,#bigmenuchatlist do
		for j=1,#pschc do
		if pschc[j] and bigmenuchatlist[i] then if string.lower(pschc[j])==string.lower(bigmenuchatlist[i]) then table.remove(pschc,j) end end
		end
	end

PSFmainchated_Button10:Hide()
PSFmainchated_Button11:Hide()
tchataddtxt1:SetText(pschataddtxtset1)
if #pschc>0 then
PSFmainchated_Button10:Show()
pschcnum=1

else
PSFmainchated_Button11:Show()
pschcnum=0
tchataddtxt1:SetText("|cffff0000"..pschataddtxtset2.."|r")
pschc={pschatnothadd}
end



local items = pschc

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownaddchat, self:GetID())

if pschcnum==0 then
else
pschcnum=self:GetID()
end

end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end


UIDropDownMenu_Initialize(DropDownaddchat, initialize)
UIDropDownMenu_SetWidth(DropDownaddchat, 90)
UIDropDownMenu_SetButtonWidth(DropDownaddchat, 105)
UIDropDownMenu_SetSelectedID(DropDownaddchat, 1)
UIDropDownMenu_JustifyText(DropDownaddchat, "LEFT")
end



function PSF_chatedit()
PSF_closeallpr()
if(thisaddonwork)then
PSFmainchated:Show()
PhoenixStyleFailbot:RegisterEvent("CHANNEL_UI_UPDATE")

if psfchatedvar==nil then
psfchatedvar=1
local t = PSFmainchated:CreateFontString()
t:SetWidth(700)
t:SetHeight(45)
t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t:SetPoint("TOPLEFT",20,-15)
t:SetText(pschattitl2)
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")

tchataddtxt1 = PSFmainchated:CreateFontString()
tchataddtxt1:SetWidth(700)
tchataddtxt1:SetHeight(30)
tchataddtxt1:SetFont(GameFontNormal:GetFont(), psfontsset[2])
tchataddtxt1:SetPoint("TOPLEFT",20,-100)
tchataddtxt1:SetText(" ")
tchataddtxt1:SetJustifyH("LEFT")
tchataddtxt1:SetJustifyV("BOTTOM")


local t = PSFmainchated:CreateFontString()
t:SetWidth(700)
t:SetHeight(30)
t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t:SetPoint("TOPLEFT",20,-205)
t:SetText(pschetremtxt1)
t:SetJustifyH("LEFT")
t:SetJustifyV("BOTTOM")

end


openremovechat()
openaddchat()

else
PSFmain10:Show()
end

end


function PSF_addchatrep()
if #psfchatadd>4 then
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pschatmaxchan)
else
table.insert (bigmenuchatlist,pschc[pschcnum])
table.insert (lowmenuchatlist,pschc[pschcnum])
table.insert (psfchatadd,pschc[pschcnum])
--RA
if bigmenuchatlistea then
table.insert (bigmenuchatlistea,pschc[pschcnum])
table.insert (lowmenuchatlistea,pschc[pschcnum])
end

out("|cff99ffffPhoenixStyle|r - |cff00ff00"..pschc[pschcnum].."|r - "..pschataddsuc)
openremovechat()
openaddchat()
end
end

function PSF_remchatrep()
if pschcnumrem>8 then
out("|cff99ffffPhoenixStyle|r - |cffff0000"..bigmenuchatlist[pschcnumrem].."|r - "..pschatremsuc)
table.remove (bigmenuchatlist,pschcnumrem)
table.remove (psfchatadd,pschcnumrem-8)
table.remove (lowmenuchatlist,pschcnumrem-2)
--RA
if bigmenuchatlistea then
table.remove (bigmenuchatlistea,pschcnumrem)
table.remove (lowmenuchatlistea,pschcnumrem-2)
end
openremovechat()
openaddchat()
end
end

function psautomarunfoc()
for tg=1,8 do
psfautomebtable[tg]:ClearFocus()
end
end




function PSF_fontedit()
PSF_closeallpr()
if(thisaddonwork)then
PSFmainfontchange:Show()

if psfchatedvarfont==nil then
psfchatedvarfont=1
local t = PSFmainfontchange:CreateFontString()
t:SetWidth(700)
t:SetHeight(95)
t:SetFont(GameFontNormal:GetFont(), 14)
t:SetPoint("TOPLEFT",20,-15)
t:SetText(psmainfonttxtdescr)
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")


tfonttxt1 = PSFmainfontchange:CreateFontString()
tfonttxt1:SetWidth(700)
tfonttxt1:SetHeight(100)
tfonttxt1:SetFont(GameFontNormal:GetFont(), psfontsset[1])
tfonttxt1:SetPoint("TOPLEFT",20,-130)
tfonttxt1:SetText(format(psmainfontused1,"|cff00ff00"..psfontssetdef[1].."|r","|cff00ff00"..psfontsset[1].."|r"))
tfonttxt1:SetJustifyH("LEFT")
tfonttxt1:SetJustifyV("TOP")

PSFmainfontchange_slid1:SetMinMaxValues(8, 16)
PSFmainfontchange_slid1:SetValueStep(1)
PSFmainfontchange_slid1:SetValue(psfontsset[1])
psfontsliderf(1)

tfonttxt2 = PSFmainfontchange:CreateFontString()
tfonttxt2:SetWidth(700)
tfonttxt2:SetHeight(100)
tfonttxt2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
tfonttxt2:SetPoint("TOPLEFT",20,-300)
tfonttxt2:SetText(format(psmainfontused2,"|cff00ff00"..psfontssetdef[2].."|r","|cff00ff00"..psfontsset[2].."|r"))
tfonttxt2:SetJustifyH("LEFT")
tfonttxt2:SetJustifyV("TOP")

PSFmainfontchange_slid2:SetMinMaxValues(8, 16)
PSFmainfontchange_slid2:SetValueStep(1)
PSFmainfontchange_slid2:SetValue(psfontsset[2])
psfontsliderf(2)

end




else
PSFmain10:Show()
end

end

function psfontsliderf(i)
if i then
	if i==1 then
		psfontsset[1] = PSFmainfontchange_slid1:GetValue()
	end
	if i==2 then
		psfontsset[2] = PSFmainfontchange_slid2:GetValue()
	end
end

if i==nil or i==1 then
tfonttxt1:SetText(format(psmainfontused1,"|cff00ff00"..psfontssetdef[1].."|r","|cff00ff00"..psfontsset[1].."|r"))
tfonttxt1:SetFont(GameFontNormal:GetFont(), psfontsset[1])
PSFmainfontchange_slid1:SetValue(psfontsset[1])
if psiccchbtfrtxt then
	for t=1,#psiccchbtfrtxt do
		psiccchbtfrtxt[t]:SetFont(GameFontNormal:GetFont(), psfontsset[1])
	end
end
if rafontsset then
	rafontsset[1]=psfontsset[1]
end
end


if i==nil or i==2 then
tfonttxt2:SetText(format(psmainfontused2,"|cff00ff00"..psfontssetdef[2].."|r","|cff00ff00"..psfontsset[2].."|r"))
tfonttxt2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
PSFmainfontchange_slid2:SetValue(psfontsset[2])

if rafontsset then
	rafontsset[2]=psfontsset[2]
end
end





end

function psfontreset()
for i=1,#psfontsset do
	psfontsset[i]=psfontssetdef[i]
end
psfontsliderf()
end





function PSF_creditsgo()
PSF_closeallpr()
--if(thisaddonwork)then
PSFthanks:Show()

if PSFthanksdraw==nil then
PSFthanksdraw=1
local t = PSFthanks:CreateFontString()
t:SetWidth(700)
t:SetHeight(475)
t:SetFont(GameFontNormal:GetFont(), 14)
t:SetPoint("TOPLEFT",20,-15)
t:SetText(pscredits3)
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")
end


--else
--PSFmain10:Show()
--end

end


function PSF_marksgetfromraid()
psautomarunfoc()

if autorefmark then
PSF_buttonoffmark()
end

if(thisaddonwork) then
	if GetNumRaidMembers() > 1 then
		local found=0
		for i=1,GetNumRaidMembers() do
			if GetRaidTargetIndex("raid"..i) and GetRaidTargetIndex("raid"..i)>0 and GetRaidTargetIndex("raid"..i)<9 then
				if found==0 then
					found=1
					for j=1,8 do
						table.wipe(pssetmarknew[j])
					end
					truemark={"false","false","false","false","false","false","false","false"}
				end
				local nm=UnitName("raid"..i)
				pssetmarknew[GetRaidTargetIndex("raid"..i)][1]=nm
			end
		end
		if found>0 then
			for nr=1,8 do
				local nicks=""
				if #pssetmarknew[nr]>0 then
					for h=1,#pssetmarknew[nr] do
						if string.len(nicks)>1 then
							nicks=nicks..", "
						end
						nicks=nicks..pssetmarknew[nr][h]
					end
				end
				psfautomebtable[nr]:SetText(nicks)
			end
		end
	end
end





end



function PSF_buttonspellidcreate()
if psscrolllinkid==nil then

local s = PSFmainspellidframe:CreateFontString()
s:SetWidth(255)
s:SetHeight(20)
s:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s:SetPoint("TOPLEFT",0,-50)
s:SetJustifyH("RIGHT")
s:SetJustifyV("TOP")
s:SetText(psspellidt1)

local s = PSFmainspellidframe:CreateFontString()
s:SetWidth(255)
s:SetHeight(20)
s:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s:SetPoint("TOPLEFT",0,-90)
s:SetJustifyH("RIGHT")
s:SetJustifyV("TOP")
s:SetText(psspellidt2)


psscrolllinkid = CreateFrame("ScrollFrame", "psscrolllinkid", PSFmainspellidframe, "UIPanelScrollFrameTemplate")
psscrolllinkid:SetPoint("TOPLEFT", PSFmainspellidframe, "TOPLEFT", 20, -140)
psscrolllinkid:SetHeight(300)
psscrolllinkid:SetWidth(695)

--текст о ошибке!
psspellinffrerror = PSFmainspellidframe:CreateFontString()
psspellinffrerror:SetWidth(700)
psspellinffrerror:SetHeight(50)
psspellinffrerror:SetFont(GameFontNormal:GetFont(), psfontsset[2])
psspellinffrerror:SetPoint("TOP",-10,-170)
psspellinffrerror:SetJustifyH("CENTER")
psspellinffrerror:SetJustifyV("BOTTOM")
psspellinffrerror:SetText(psspellidt6.."\n"..psspellidt7)

--скролл фрейм с ачивками
pslinkidscrollmain = CreateFrame("ScrollingMessageFrame", "pslinkidscrollmain", psscrolllinkid)

pslinkidscrollmain:SetPoint("TOPRIGHT", psscrolllinkid, "TOPRIGHT", 0, 0)
pslinkidscrollmain:SetPoint("TOPLEFT", psscrolllinkid, "TOPLEFT", 0, 0)
pslinkidscrollmain:SetPoint("BOTTOMRIGHT", psscrolllinkid, "BOTTOMRIGHT", 0, 0)
pslinkidscrollmain:SetPoint("BOTTOMLEFT", psscrolllinkid, "BOTTOMLEFT", 0, 0)
pslinkidscrollmain:SetFont(GameFontNormal:GetFont(), 12) --ыытест как появится ТОП пролистывание, сменить размер на rafontsset[2]
pslinkidscrollmain:SetMaxLines(150)
pslinkidscrollmain:SetHyperlinksEnabled(true)
pslinkidscrollmain:SetScript("OnHyperlinkClick", function(self,link,text,button) SetItemRef(link,text,button) end)
pslinkidscrollmain:SetHeight(65)
pslinkidscrollmain:SetWidth(690)
pslinkidscrollmain:Show()
pslinkidscrollmain:SetFading(false)
pslinkidscrollmain:SetJustifyH("LEFT")
pslinkidscrollmain:SetJustifyV("TOP")
--pslinkidscrollmain:SetInsertMode("TOP") --ыытест to check after 4.0.1

psscrolllinkid:SetScrollChild(pslinkidscrollmain)
psscrolllinkid:Show()

PSFmainspellidframe_edbox1:SetScript("OnEnterPressed", function(self) psfindspelllinks(1) end )
PSFmainspellidframe_edbox2:SetScript("OnEnterPressed", function(self) psfindspelllinks(2) end )
PSFmainspellidframe_edbox3:SetScript("OnEnterPressed", function(self) psspellcheck2() end )
PSFmainspellidframe_edbox4:SetScript("OnEnterPressed", function(self) psspellcheck2() end )

PSFmainspellidframe_edbox1:SetScript("OnTabPressed", function(self) PSFmainspellidframe_edbox1:ClearFocus() PSFmainspellidframe_edbox2:SetFocus() end )
PSFmainspellidframe_edbox2:SetScript("OnTabPressed", function(self) PSFmainspellidframe_edbox2:ClearFocus() PSFmainspellidframe_edbox1:SetFocus() end )

PSFmainspellidframe_edbox3:SetScript("OnTabPressed", function(self) PSFmainspellidframe_edbox3:ClearFocus() PSFmainspellidframe_edbox4:SetFocus() end )
PSFmainspellidframe_edbox4:SetScript("OnTabPressed", function(self) PSFmainspellidframe_edbox4:ClearFocus() PSFmainspellidframe_edbox3:SetFocus() end )

PSFmainspellidframe_edbox3:SetText(80000)
PSFmainspellidframe_edbox4:SetText(120000)

end

PSFmainspellidframe_edbox3:Hide()
PSFmainspellidframe_edbox4:Hide()
psspellinffrerror:Hide()
PSFmainspellidframe_Button3:Hide()

end

function psspellcheck2()
if PSFmainspellidframe_edbox3:GetNumber()<PSFmainspellidframe_edbox4:GetNumber() then
psfindspelllinks(2,PSFmainspellidframe_edbox3:GetNumber(),PSFmainspellidframe_edbox4:GetNumber())
end
end

function psfindspelllinks(n,ids,ide)

PSFmainspellidframe_edbox3:Hide()
PSFmainspellidframe_edbox4:Hide()
psspellinffrerror:Hide()
PSFmainspellidframe_Button3:Hide()


PSFmainspellidframe_edbox1:ClearFocus()
PSFmainspellidframe_edbox2:ClearFocus()
PSFmainspellidframe_edbox3:ClearFocus()
PSFmainspellidframe_edbox4:ClearFocus()

pslinkidscrollmain:Clear()
if n==1 and string.len(PSFmainspellidframe_edbox1:GetText())>0 then
pslastcheckid2="00shursh"
pslastcheckid1=PSFmainspellidframe_edbox1:GetText()

local a=GetSpellInfo(PSFmainspellidframe_edbox1:GetText())
if pslinkidscrollmain:GetHeight()>39 and pslinkidscrollmain:GetHeight()<41 then
else
pslinkidscrollmain:SetHeight(40)
end


PSFmainspellidframe_edbox2:SetText("")
if a then
pslinkidscrollmain:AddMessage("\124cff71d5ff\124Hspell:"..PSFmainspellidframe_edbox1:GetText().."\124h["..a.."]\124h\124r")
else
pslinkidscrollmain:AddMessage(psspellidt3)
end
end


if n==2 and string.len(PSFmainspellidframe_edbox2:GetText())>0 then
pslastcheckid1="10000000"
pslastcheckid2=PSFmainspellidframe_edbox2:GetText()
PSFmainspellidframe_edbox1:SetText("")
	local tabl1={} --точное совпадание
	local tabl2={} --частичное совпадание
	local az1=ids or 1
	local az2=ide or 130000
	for i=az1,az2 do
		local a=GetSpellInfo(i)
		if a then
			if string.lower(a)==string.lower(PSFmainspellidframe_edbox2:GetText()) then
				table.insert(tabl1,"\124cff71d5ff\124Hspell:"..i.."\124h["..a.."]\124h\124r ID: "..i)
			elseif string.find(string.lower(a),string.lower(PSFmainspellidframe_edbox2:GetText())) then
				table.insert(tabl2,"\124cff71d5ff\124Hspell:"..i.."\124h["..a.."]\124h\124r ID: "..i)
			end
		end
	end

	if #tabl1+#tabl2==0 then
		pslinkidscrollmain:AddMessage(psspellidt3)
		if pslinkidscrollmain:GetHeight()>39 and pslinkidscrollmain:GetHeight()<41 then
		else
			pslinkidscrollmain:SetHeight(40)
		end
	elseif #tabl1+#tabl2>140 and (#tabl1>110 or #tabl1==0) then
		if pslinkidscrollmain:GetHeight()>130 and pslinkidscrollmain:GetHeight()<170 then
		else
			pslinkidscrollmain:SetHeight(150)
		end
		psspellinffrerror:SetText(format(psspellidt6,(#tabl1+#tabl2)).."\n"..psspellidt7)
		PSFmainspellidframe_edbox3:Show()
		PSFmainspellidframe_edbox4:Show()
		psspellinffrerror:Show()
		PSFmainspellidframe_Button3:Show()
	elseif #tabl1>0 and #tabl1<111 and #tabl1+#tabl2>140 then
		if pslinkidscrollmain:GetHeight()>((#tabl1)*12+100) and pslinkidscrollmain:GetHeight()<((#tabl1)*12+120) then
		else
			pslinkidscrollmain:SetHeight((#tabl1)*12+110)
		end
		pslinkidscrollmain:AddMessage("|cff00ff00"..psspellidt4.." ("..#tabl1.."):|r")
		for i=1,#tabl1 do
			pslinkidscrollmain:AddMessage(tabl1[i])
		end

		pslinkidscrollmain:AddMessage(" ")
		pslinkidscrollmain:AddMessage(" ")
		pslinkidscrollmain:AddMessage(" ")
		pslinkidscrollmain:AddMessage("|cff00ff00"..psspellidt5..":|r")
		pslinkidscrollmain:AddMessage(format(psspellidt6,(#tabl2)))


	else
		if pslinkidscrollmain:GetHeight()>((#tabl1+#tabl2)*12+60) and pslinkidscrollmain:GetHeight()<((#tabl1+#tabl2)*12+80) then
		else
			pslinkidscrollmain:SetHeight((#tabl1+#tabl2)*12+70)
		end
		if #tabl1>0 then
			pslinkidscrollmain:AddMessage("|cff00ff00"..psspellidt4.." ("..#tabl1.."):|r")
			for i=1,#tabl1 do
				pslinkidscrollmain:AddMessage(tabl1[i])
			end
		end
		if #tabl1>0 and #tabl2>0 then
			pslinkidscrollmain:AddMessage(" ")
			pslinkidscrollmain:AddMessage(" ")
			pslinkidscrollmain:AddMessage(" ")
		end
		if #tabl2>0 then
			pslinkidscrollmain:AddMessage("|cff00ff00"..psspellidt5.." ("..#tabl2.."):|r")
			for i=1,#tabl2 do
				pslinkidscrollmain:AddMessage(tabl2[i])
			end
		end
	end
	table.wipe(tabl1)
	table.wipe(tabl2)
end

end


--имя, время трекеринга, ид в кого шокать, ИД босс евента, название босс евента, имя босса, тип репорта для -1 (или обозначение репорта! 1 - если учитывать ВСЕ интерапты, 2 - спец для выделения КРАСНЫМ всех абилок а не ток прерывания, для поклонения!, 0 то босс), имя в кого что-то попало!, никтаблица, кол-во таблица
--timetoshowifnotnow - время евента, если не сейчас произошло
--tablnm1 так же будет переносить в себе ФРАЗУ! что должна будет добавиться в текст в конце (малориак: чар вспышка УРОН...)

function pscaststartinfo(arg9,arg10, sec, bossid, idevent, nameevent, bossname, nrrep, whoget,tablnm1,tablcl1,skokaseckrasn,timetoshowifnotnow,deathreponly)
if nameevent or (nameevent==nil and pssavedreportcreatedforcurfight) then

pscreatesavedreports3(bossname)

if pssavedplayerpos>0 then

--сначала проверка нет ли смертей в списке ожидания!
if deathreponly==nil and psdeathwaiting[1] and #psdeathwaiting[1]>0 then
  for kl=1,#psdeathwaiting[1] do
    pscaststartinfo(0,psdeathwaiting[1][kl], -1, "id1", 666, psdreventname,bossname,2,nil,nil,nil,nil,psdeathwaiting[2][kl],1)
  end
  psdeathwaiting=nil
  psdeathwaiting={{},{}}
end


--создаем евент если он еще не создан
local biil=0
if #pssicombatin_indexboss[pssavedplayerpos][1]>0 then
	for i=1,#pssicombatin_indexboss[pssavedplayerpos][1] do
		if pssicombatin_indexboss[pssavedplayerpos][1][i]==idevent then
			biil=1
		end
	end
end

--если нет имени евента и был ==0 тогда не идем дальше!
if nameevent==nil and biil==0 then
else



if biil==0 then
table.insert(pssicombatin_indexboss[pssavedplayerpos][1],idevent)
table.insert(pssicombatin_title2[pssavedplayerpos][1],nameevent)
table.insert(pssicombatin_damageinfo[pssavedplayerpos][1],{{},{},{}})
end



--запись в онапдейт таблицы всей инфы, для начала трекеринга, кики!
if sec>0 then
table.insert(psincombattrack1_bossid,bossid)
table.insert(psincombattrack2_timecaststart,GetTime())
table.insert(psincombattrack3_timestopcheck,GetTime()+sec)
table.insert(psincombattrack4_eventidtoinsert,idevent)
table.insert(psincombattrack5_whokiked,{})
table.insert(psincombattrack6_timekiked,{})
table.insert(psincombattrack7_whocasted,{})
table.insert(psincombattrack8_timecasted,{})
table.insert(psincombattrack9_bossspellname,arg10)

if tablnm1==nil then
tablnm1=""
else
tablnm1=tablnm1.." "
end
table.insert(psincombattrack16_additionaltext,tablnm1)

if arg9==nil then
  arg9=0
end
table.insert(psincombattrack15_castid,arg9)
--добавить время 90% каста


table.insert(psincombattrack11_writeinfoinmodule,GetTime()+sec)

if nrrep and (nrrep==1 or nrrep==2) then
  table.insert(psincombattrack12_useallinterrupts,nrrep)
else
  table.insert(psincombattrack12_useallinterrupts,0)
end

if whoget then
  table.insert(psincombattrack13_showwaskikedornot,1)
else
  table.insert(psincombattrack13_showwaskikedornot,0)
end

local sleppnam="0"
local time90=0

if GetNumRaidMembers()>0 and bossid~=0 then
	for nm=1,GetNumRaidMembers() do
		if time90==0 then
			if UnitGUID("raid"..nm.."-target") and UnitGUID("raid"..nm.."-target")==bossid then
				local spell1,_,_,_,_,endTime = UnitCastingInfo("raid"..nm.."-target")
				if endTime then
					time90=endTime/1000-0.2
					sleppnam=spell1 or "0"
				end
			end
		end
	end
end

table.insert(psincombattrack14_nameofthecurrentcast,sleppnam)

if skokaseckrasn then
	if GetTime()+skokaseckrasn<time90 or time90==0 then
		time90=GetTime()+skokaseckrasn
	end
end

table.insert(psincombattrack10_redtimeifmorethen,time90)




--проверяем прекасты киков

local fgf=1
while fgf<31 do
	if psprecast1[fgf] then
		if GetTime()<=psprecast1[fgf]+1 then
--прекасты каких типов записывать, для боссов спелаплай не писать
if psprecast6[fgf]=="0" or (psprecast6[fgf]=="1" and nrrep and nrrep==1) then
			local fff=0
			if psprecast4[fgf]==bossid then
				local bbbb=0
				if #psincombattrack7_whocasted[#psincombattrack7_whocasted]>0 then
					for zx=1,#psincombattrack7_whocasted[#psincombattrack7_whocasted] do
						if psincombattrack7_whocasted[#psincombattrack7_whocasted][zx]==psprecast2[fgf] then
							bbbb=1
						end
					end
				end
				if bbbb==0 then
					table.insert(psincombattrack7_whocasted[#psincombattrack7_whocasted],psprecast2[fgf])
					if psprecast5[fgf]=="0" then
						table.insert(psincombattrack8_timecasted[#psincombattrack8_timecasted],(psprecast3[fgf]..", "..(math.ceil((psprecast1[fgf]-GetTime())*10)/10)))
					else
						table.insert(psincombattrack8_timecasted[#psincombattrack8_timecasted],(psprecast3[fgf]..", "..(math.ceil((psprecast1[fgf]-GetTime())*10)/10)).." - "..psprecast5[fgf])
					end
				end
				table.remove(psprecast1,fgf)
				table.remove(psprecast2,fgf)
				table.remove(psprecast3,fgf)
				table.remove(psprecast4,fgf)
				table.remove(psprecast5,fgf)
				table.remove(psprecast6,fgf)
				fff=1


			end

			fgf=fgf+1
			if fff==1 then
				fgf=fgf-1
			end
else
fgf=fgf+1
end
		else
			fgf=32
		end
	else
		fgf=32
	end
end

--добавляем табл ПРОВЕРКИ кика прекиком!
if time90>0 and time90>GetTime()+0.3 then
	table.insert(preinterrupt1,GetTime()+0.3)
	table.insert(preinterrupt2,"0")
	table.insert(preinterrupt3,"0")
	table.insert(preinterrupt4,bossid)
end



elseif sec==0 then
	for j=1,#pssicombatin_indexboss[pssavedplayerpos][1] do
		if pssicombatin_indexboss[pssavedplayerpos][1][j]==idevent then
			local timeevent=GetTime()-pscombatstarttime
			if timetoshowifnotnow then
				timeevent=timetoshowifnotnow
			end
			table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][2],timeevent)
			table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][1],"|cff00ff00"..arg10.."|r")
			if #pssicombatin_damageinfo[pssavedplayerpos][1][j][3]>0 then
				table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][3],pssicombatin_damageinfo[pssavedplayerpos][1][j][3][#pssicombatin_damageinfo[pssavedplayerpos][1][j][3]])
			else
				table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][3],0)
			end
		end
	end
elseif sec==-1 then
--не цветная надпись, для фейлов! 
	for j=1,#pssicombatin_indexboss[pssavedplayerpos][1] do
		if pssicombatin_indexboss[pssavedplayerpos][1][j]==idevent then
			local timeevent=GetTime()-pscombatstarttime
			if timetoshowifnotnow then
				timeevent=timetoshowifnotnow
			end
			table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][2],timeevent)
			if #pssicombatin_damageinfo[pssavedplayerpos][1][j][3]>0 then
				table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][3],pssicombatin_damageinfo[pssavedplayerpos][1][j][3][#pssicombatin_damageinfo[pssavedplayerpos][1][j][3]]+1)
			else
				table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][3],1)
			end

			if nrrep==1 then
				table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][1],arg10..": "..pssicombatin_damageinfo[pssavedplayerpos][1][j][3][#pssicombatin_damageinfo[pssavedplayerpos][1][j][3]]..", "..psaddcolortxt(1,whoget)..whoget..psaddcolortxt(1,whoget))
			end
			if nrrep==2 then
				table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][1],psspellfilter(arg10))
			end
			if nrrep==3 then
				local txtwithnicks=""
				if tablnm1 and #tablnm1>0 then
					for t=1,#tablnm1 do
						txtwithnicks=txtwithnicks..psaddcolortxt(1,tablnm1[t])..tablnm1[t]..psaddcolortxt(2,tablnm1[t]).." ("..tablcl1[t]..")"
						if t==#tablnm1 then
							txtwithnicks=txtwithnicks.."."
						else
							txtwithnicks=txtwithnicks..", "
						end
					end
				end
				table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][1],format(arg10,pssicombatin_damageinfo[pssavedplayerpos][1][j][3][#pssicombatin_damageinfo[pssavedplayerpos][1][j][3]])..txtwithnicks)
			end
		end
	end

end

--обновл фрейма если открыт
psupdateframewithnewinfo()


end
end
end
end

function pscheckrunningbossid(arg3)
if #psincombattrack1_bossid>0 then
	for i=1,#psincombattrack1_bossid do
		if psincombattrack1_bossid[i] and psincombattrack1_bossid[i]==arg3 then
			for j=1,#pssicombatin_indexboss[pssavedplayerpos][1] do
				if pssicombatin_indexboss[pssavedplayerpos][1][j]==psincombattrack4_eventidtoinsert[i] then

					table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][2],psincombattrack2_timecaststart[i]-pscombatstarttime)
					if #pssicombatin_damageinfo[pssavedplayerpos][1][j][3]>0 then
						table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][3],pssicombatin_damageinfo[pssavedplayerpos][1][j][3][#pssicombatin_damageinfo[pssavedplayerpos][1][j][3]]+1)
					else
						table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][3],1)
					end
					local txt=""
					local ttt=""
					txt=format(psincombattrack9_bossspellname[i],pssicombatin_damageinfo[pssavedplayerpos][1][j][3][#pssicombatin_damageinfo[pssavedplayerpos][1][j][3]]).." "
					if #psincombattrack5_whokiked[i]>0 then
						if psincombattrack5_whokiked[i][1]=="1" then
							txt=txt.."|cff00ff00"..psinterrupted3.."|r. "
						elseif psincombattrack5_whokiked[i][1]=="2" then
							txt=txt.."|cffff0000"..psinterrupted4.."|r. "
						else
						txt=txt..psinterrupted1..": "
						for g=1,#psincombattrack5_whokiked[i] do
							txt=txt..psaddcolortxt(1,psincombattrack5_whokiked[i][g])..psincombattrack5_whokiked[i][g]..psaddcolortxt(2,psincombattrack5_whokiked[i][g]).." ("..psincombattrack6_timekiked[i][g]..")"
							if g==#psincombattrack5_whokiked[i] then
								txt=txt..". "
							else
								txt=txt..", "
							end
						end
						end
					else
						if psincombattrack13_showwaskikedornot[i]==0 then
							ttt="|cffff0000"..psinterrupted5.."|r. "
						end
					end
					if #psincombattrack7_whocasted[i]>0 then
						txt=txt..ttt..psinterrupted2..": "
						for g=1,#psincombattrack7_whocasted[i] do
							txt=txt..psaddcolortxt(1,psincombattrack7_whocasted[i][g])..psincombattrack7_whocasted[i][g]..psaddcolortxt(2,psincombattrack7_whocasted[i][g]).." ("..psincombattrack8_timecasted[i][g]..")"
							if g==#psincombattrack7_whocasted[i] then
								txt=txt.."."
							else
								txt=txt..", "
							end
						end
					end
					if #psincombattrack5_whokiked[i]==0 and #psincombattrack7_whocasted[i]==0 then
						txt=txt..ttt
					end


					table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][1],txt)
					table.remove(psincombattrack1_bossid,i)
					table.remove(psincombattrack2_timecaststart,i)
					table.remove(psincombattrack3_timestopcheck,i)
					table.remove(psincombattrack4_eventidtoinsert,i)
					table.remove(psincombattrack5_whokiked,i)
					table.remove(psincombattrack6_timekiked,i)
					table.remove(psincombattrack7_whocasted,i)
					table.remove(psincombattrack8_timecasted,i)
					table.remove(psincombattrack9_bossspellname,i)
					table.remove(psincombattrack10_redtimeifmorethen,i)
					table.remove(psincombattrack11_writeinfoinmodule,i)
					table.remove(psincombattrack12_useallinterrupts,i)
					table.remove(psincombattrack13_showwaskikedornot,i)
					table.remove(psincombattrack14_nameofthecurrentcast,i)
					table.remove(psincombattrack15_castid,i)
					table.remove(psincombattrack16_additionaltext,i)

--обновл фрейма если открыт
psupdateframewithnewinfo()

				end
			end
		end
	end
end
end

function sa_checkversions()
if UnitInRaid("player") and sa_delayforwaiting==nil then
	sa_raidrosteronline={}
	sa_raidrosteroffline={}

	for i = 1,GetNumRaidMembers() do
		local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
		if name~=UnitName("player") then
		if online then
			table.insert(sa_raidrosteronline,name)
		else
			table.insert(sa_raidrosteroffline,name)
		end
		end
	end

	local a=UnitName("player")
	sa_raidwithaddons={}
	if pssaaddon_12[2]==1 then
		table.insert(sa_raidwithaddons,a)
	end
	sa_delayforwaiting=GetTime()+5
	out ("|cff99ffffPhoenixStyle|r - "..psmain_sawait.."...")
	SendAddonMessage("SAver", "1", "RAID")
end
end


function PSF_saopen()
PSF_closeallpr()
PSFmain2_Button52:SetAlpha(0.3)
if(thisaddonwork)then
PSF_saframe:Show()
PSF_saframecreate()
else
PSFmain10:Show()
end
end



	local updateFrame = CreateFrame("Frame")
	local function onUpdate(self, elapsed)
		local x, y = GetCursorPosition()
		local scale = UIParent:GetEffectiveScale()
		x, y = x / scale, y / scale
		GameTooltip:SetPoint("BOTTOMLEFT", nil, "BOTTOMLEFT", x + 5, y + 2)
	end

	local function onHyperlinkClick2(self, data, link)

		if IsShiftKeyDown() then
			if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then
				ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..link)
			else
				ChatFrame_OpenChat(link)
			end
		end

	end

	local function onHyperlinkEnter2(self, data, link)
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetHyperlink(data)
		GameTooltip:Show()
		updateFrame:SetScript("OnUpdate", onUpdate)
	end

	local function onHyperlinkLeave2(self, data, link)
		GameTooltip:Hide()
		updateFrame:SetScript("OnUpdate", nil)
	end


function PSF_saframecreate()
if ps_saactivetxt1==nil then

local t = PSF_saframe:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t:SetSize(700,200)
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")
t:SetText(psmain_sadescript)
t:SetPoint("TOPLEFT",20,-20)

local t1 = PSF_saframe:CreateFontString()
t1:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t1:SetSize(700,40)
t1:SetJustifyH("LEFT")
t1:SetJustifyV("CENTER")
t1:SetText(psmainsadescript)
t1:SetPoint("TOPLEFT",200,-64)


local t2 = PSF_saframe:CreateFontString()
t2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t2:SetSize(700,40)
t2:SetJustifyH("LEFT")
t2:SetJustifyV("CENTER")
t2:SetText(psmaincheckversions)
t2:SetPoint("TOPLEFT",200,-94)

local c = CreateFrame("CheckButton", nil, PSF_saframe, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", 20, -135)
c:SetScript("OnClick", function(self) if pssaaddon_12[2]==1 then pssaaddon_12[2]=0 checkaddbut_sa1:Hide() textbutadd_sa1:Hide() else pssaaddon_12[2]=1 checkaddbut_sa1:Show() textbutadd_sa1:Show() end ps_sa_checkonoff() end )
if pssaaddon_12[2]==1 then c:SetChecked() else c:SetChecked(false)
end

ps_saactivetxt1=PSF_saframe:CreateFontString()
ps_saactivetxt1:SetFont(GameFontNormal:GetFont(), 22)
ps_saactivetxt1:SetSize(300,200)
ps_saactivetxt1:SetJustifyH("CENTER")
ps_saactivetxt1:SetJustifyV("TOP")
ps_saactivetxt1:SetText()
ps_saactivetxt1:SetPoint("TOPRIGHT",-30,-80)



local t3 = PSF_saframe:CreateFontString()
t3:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t3:SetSize(700,40)
t3:SetJustifyH("LEFT")
t3:SetJustifyV("CENTER")
t3:SetText(psmain_saonoff)
t3:SetPoint("TOPLEFT",45,-127)


checkaddbut_sa1 = CreateFrame("CheckButton", nil, PSF_saframe, "UICheckButtonTemplate")
checkaddbut_sa1:SetWidth("25")
checkaddbut_sa1:SetHeight("25")
checkaddbut_sa1:SetPoint("TOPLEFT", 20, -155)
checkaddbut_sa1:SetScript("OnClick", function(self) if pssaaddon_12[3]==1 then pssaaddon_12[3]=0 else pssaaddon_12[3]=1 end end )
if pssaaddon_12[3]==1 then checkaddbut_sa1:SetChecked() else checkaddbut_sa1:SetChecked(false)
end

textbutadd_sa1 = PSF_saframe:CreateFontString()
textbutadd_sa1:SetFont(GameFontNormal:GetFont(), psfontsset[2])
textbutadd_sa1:SetSize(700,40)
textbutadd_sa1:SetJustifyH("LEFT")
textbutadd_sa1:SetJustifyV("CENTER")
textbutadd_sa1:SetText(psmainsamodadd)
textbutadd_sa1:SetPoint("TOPLEFT",45,-147)

if pssaaddon_12[2]==0 then
checkaddbut_sa1:Hide() textbutadd_sa1:Hide()
end


--рисуем чекбатоны + текст либо названия инстов/боссов
local k=0 --количество строк, после 5 перенос пока
local totk=12 -- общее количество созданых строк, делаем пока 10
local maxk=10
local w=-220 --высота
local l=20 --ширина
local lotstup=400
local wotstup=25
local curw=w
local curl=l


ps_sa_tableofnames1={} --текст у чек батона
ps_sa_tableofnames2={} --чекбатоны
ps_sa_tableofnames3={} --имена боссов
for i=1,totk do
	if k>=maxk then
		k=0
		curw=w
		curl=curl+lotstup
	end
	local c = CreateFrame("CheckButton", nil, PSF_saframe, "UICheckButtonTemplate")
	c:SetWidth("25")
	c:SetHeight("25")
	c:SetPoint("TOPLEFT",curl,curw)
	table.insert(ps_sa_tableofnames2,c)


	--текст
	local html = CreateFrame("SimpleHTML", nil, PSF_saframe)
	html:SetHeight(12)
	--html:SetFontObject("GameFontNormal")
	html:SetFont(GameFontNormal:GetFont(), 11)
	html:SetPoint("RIGHT", 0, 1)
	html:SetScript("OnHyperlinkClick", onHyperlinkClick2)
	html:SetScript("OnHyperlinkEnter", onHyperlinkEnter2)
	html:SetScript("OnHyperlinkLeave", onHyperlinkLeave2)
	--html:SetText(ps_getspelllink(1))
	html:SetText()
	html:SetWidth(360)

	html:SetPoint("TOPLEFT",curl+25,curw-6)
	html:SetJustifyH("RIGHT")
	html:Show()
		
	table.insert(ps_sa_tableofnames1,html)



	local t6 = PSF_saframe:CreateFontString()
	t6:SetFont(GameFontNormal:GetFont(), 12)
	t6:SetSize(180,25)
	t6:SetJustifyH("LEFT")
	t6:SetJustifyV("CENTER")
	t6:SetText()
	t6:SetPoint("TOPLEFT",curl,curw)
	table.insert(ps_sa_tableofnames3,t6)

	k=k+1
	curw=curw-wotstup
end




end


opensadrop()

opensaybossad()
ps_sa_checkonoff()

end



function ps_sa_checkonoff()
local txt=""
if pssaaddon_12[2]==1 then
	txt="|cff00ff00"..psmoduletxton.."|r"
else
	txt="|cffff0000"..psmoduletxtoff.."|r"
end

local bil=0
if IsRaidOfficer()==1 then
	bil=1
else
local num=GetNumGuildMembers()
for i=1,num do
	local name, rank, rankIndex=GetGuildRosterInfo(i)
	if (rankIndex==0 or rankIndex==1) and name then
		if name==UnitName("player") then
			bil=1
		end
	end
end
end

if bil==0 then
	txt=txt.."\n".."|cffff0000"..psmain_saneedpromote.."|r"
end

ps_saactivetxt1:SetText(txt)


end


function ps_sa_showbossopt()

for i=1,#ps_sa_tableofnames1 do
	ps_sa_tableofnames1[i]:Hide()
	ps_sa_tableofnames1[i]:SetText()
end
for i=1,#ps_sa_tableofnames2 do
	ps_sa_tableofnames2[i]:Hide()
end
for i=1,#ps_sa_tableofnames3 do
	ps_sa_tableofnames3[i]:Hide()
	ps_sa_tableofnames3[i]:SetText()
end

local k=1 --в какой строчке мы сейчас находимся
local m=1 -- в какой строчке столбика находимся
local maxk=10 --макс в 1 строчке

	if ps_saoptions[ps_sa_menuchoose1] and #ps_saoptions[ps_sa_menuchoose1]>0 then
		for j=1,#ps_saoptions[ps_sa_menuchoose1] do
			local boss=0
			if #ps_saoptions[ps_sa_menuchoose1][j]>0 then
				if (boss==0 and (m==maxk or m==maxk*2 or m==maxk*3 or m==maxk*4 or m==maxk*5)) then
					k=k+1
					m=1
				end
				if boss==0 then
					ps_sa_tableofnames3[k]:Show()
					ps_sa_tableofnames3[k]:SetText(psbossnames[ps_sa_menuchoose1][j])
					boss=1
					k=k+1
					m=m+1
				end

				for q=1,#ps_saoptions[ps_sa_menuchoose1][j] do

					ps_sa_tableofnames1[k]:Show()


				local spellid=""
				local comm=""
				if ps_sa_id[ps_sa_menuchoose1][j][q] and string.find(ps_sa_id[ps_sa_menuchoose1][j][q],"|AddComm") then
          spellid=string.sub(ps_sa_id[ps_sa_menuchoose1][j][q],0,string.find(ps_sa_id[ps_sa_menuchoose1][j][q],"|AddComm")-1)
          comm=psspellfilter(", "..string.sub(ps_sa_id[ps_sa_menuchoose1][j][q],string.find(ps_sa_id[ps_sa_menuchoose1][j][q],"|AddComm")+8))
        else
          spellid=ps_sa_id[ps_sa_menuchoose1][j][q]
        end
        if spellid and spellid~="" then
					ps_sa_tableofnames1[k]:SetText(ps_getspelllink(spellid)..comm)

					ps_sa_tableofnames2[k]:Show()
					if ps_saoptions[ps_sa_menuchoose1][j][q]==1 then
						ps_sa_tableofnames2[k]:SetChecked()
					else
						ps_sa_tableofnames2[k]:SetChecked(false)
					end
					ps_sa_tableofnames2[k]:SetScript("OnClick", function(self) if ps_saoptions[ps_sa_menuchoose1][j][q]==1 then ps_saoptions[ps_sa_menuchoose1][j][q]=0 else ps_saoptions[ps_sa_menuchoose1][j][q]=1 end end )

					k=k+1
					m=m+1
        end
        
				end
			end
		end
	end



end

function ps_sa_sendinfo (name, txt, blocksec, important, chat)
local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
if IsPartyLFG() and IsInLFGDungeon() and difficulty == 2 and instanceType == "raid" and maxPlayers == 25 then
else
--только не для ЛФР

if chat==nil then
	if pssaaddon_12[1]==1 then
		chat="say"
	elseif pssaaddon_12[1]==2 then
		chat="yell"
	end
end
if blocksec==nil then
	blocksec=1
end
if important==nil then
	important=0
end
if name and UnitInRaid(name) and pssaaddon_12[2]==1 and chat and txt then
if sayelldelay==nil then
sayelldelay=0
end
	if name==UnitName("player") then
		if ((chat=="say" and GetTime()<ps_sa_waitfilter[1]) or (chat=="yell" and GetTime()<ps_sa_waitfilter[2])) and important==0 then
		else
			if GetTime()>sayelldelay then
				if pssaaddon_12[3]==1 then
					ps_sa_myreportdelay={(GetTime()+0.13),chat,important,txt,blocksec}
					SendChatMessage(txt, chat)
				end
				sayelldelay=GetTime()+blocksec
			end
		end
	else
		SendAddonMessage("SAYell", txt.."+0!"..chat.."+1!"..blocksec.."+2!"..important.."+3!", "WHISPER", name)
	end
end

end--не для лфр
end


function ps_sa_checktargets(time,guid,rechecktime,texttosend,blocksec,important)

local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
if IsPartyLFG() and IsInLFGDungeon() and difficulty == 2 and instanceType == "raid" and maxPlayers == 25 then
else
--только не для ЛФР

table.insert(ps_sa_checktarg1,time)
table.insert(ps_sa_checktarg2,guid)
table.insert(ps_sa_checktarg3,rechecktime)
table.insert(ps_sa_checktarg4,texttosend)
table.insert(ps_sa_checktarg5,blocksec)
table.insert(ps_sa_checktarg6,important)

end

end

function psresetallsave()

pssavedinforeset(1)
if IsAddOnLoaded("RaidSlackCheck") then
rscrezetpot()
end
if UnitAffectingCombat("player")==nil and UnitIsDeadOrGhost("player")==nil then
  out ("|cff99ffffPhoenixStyle|r - OK!")
end
end



function psautoinvphrasesave(chekat)
table.wipe(psautoinvsave[6])

		local rsctemptext2=""
		local rsctemptext=chekat..","
		while string.len(rsctemptext)>1 do
			if (string.find(rsctemptext," ") and string.find(rsctemptext," ")==1) or (string.find(rsctemptext,"%.") and string.find(rsctemptext,"%.")==1) or (string.find(rsctemptext,",") and string.find(rsctemptext,",")==1) then

				rsctemptext=string.sub(rsctemptext,2)

			else
				--local a1=string.find(rsctemptext," ")
				local a2=string.find(rsctemptext,",")
				local a3=string.find(rsctemptext,"%.")
				local min=1000
				if a1 and a1<min then
				min=a1
				end
				if a2 and a2<min then
				min=a2
				end
				if a3 and a3<min then
				min=a3
				end
				if min==1000 then
					rsctemptext=""
				else
					if string.len(rsctemptext2)>1 then
						rsctemptext2=rsctemptext2..", "
					end
					table.insert(psautoinvsave[6],string.lower(string.sub(rsctemptext,1,min-1)))
					rsctemptext2=rsctemptext2..string.lower(string.sub(rsctemptext,1,min-1))
					rsctemptext=string.sub(rsctemptext,min)
				end
			end
		end
		PSFautoinvframe_edbox10:SetText(rsctemptext2)
end


function psautoinvphrasesave2(chekat)
table.wipe(psautoinvsave[7])

		local rsctemptext2=""
		local rsctemptext=chekat.." "
		while string.len(rsctemptext)>1 do
			if (string.find(rsctemptext," ") and string.find(rsctemptext," ")==1) or (string.find(rsctemptext,"%.") and string.find(rsctemptext,"%.")==1) or (string.find(rsctemptext,",") and string.find(rsctemptext,",")==1) then

				rsctemptext=string.sub(rsctemptext,2)

			else
				local a1=string.find(rsctemptext," ")
				local a2=string.find(rsctemptext,",")
				local a3=string.find(rsctemptext,"%.")
				local min=1000
				if a1 and a1<min then
				min=a1
				end
				if a2 and a2<min then
				min=a2
				end
				if a3 and a3<min then
				min=a3
				end
				if min==1000 then
					rsctemptext=""
				else
					if string.len(rsctemptext2)>1 then
						rsctemptext2=rsctemptext2..", "
					end
					table.insert(psautoinvsave[7],string.sub(rsctemptext,1,min-1))
					rsctemptext2=rsctemptext2..string.sub(rsctemptext,1,min-1)
					rsctemptext=string.sub(rsctemptext,min)

				end
			end
		end
		PSFautoinvframe_edbox20:SetText(rsctemptext2)
end


function psautoinvphrasesave3(chekat)
table.wipe(psautoinvsave[8])

		local rsctemptext2=""
		local rsctemptext=chekat.." "
		while string.len(rsctemptext)>1 do
			if (string.find(rsctemptext," ") and string.find(rsctemptext," ")==1) or (string.find(rsctemptext,"%.") and string.find(rsctemptext,"%.")==1) or (string.find(rsctemptext,",") and string.find(rsctemptext,",")==1) then

				rsctemptext=string.sub(rsctemptext,2)

			else
				local a1=string.find(rsctemptext," ")
				local a2=string.find(rsctemptext,",")
				local a3=string.find(rsctemptext,"%.")
				local min=1000
				if a1 and a1<min then
				min=a1
				end
				if a2 and a2<min then
				min=a2
				end
				if a3 and a3<min then
				min=a3
				end
				if min==1000 then
					rsctemptext=""
				else
					if string.len(rsctemptext2)>1 then
						rsctemptext2=rsctemptext2..", "
					end
					table.insert(psautoinvsave[8],string.sub(rsctemptext,1,min-1))
					rsctemptext2=rsctemptext2..string.sub(rsctemptext,1,min-1)
					rsctemptext=string.sub(rsctemptext,min)
				end
			end
		end
		PSFautoinvframe_edbox30:SetText(rsctemptext2)
end




function openguildranktoprom()
if not DropDownguildranktoprom then
CreateFrame("Frame", "DropDownguildranktoprom", PSFautoinvframe, "UIDropDownMenuTemplate")
end

DropDownguildranktoprom:ClearAllPoints()
DropDownguildranktoprom:SetPoint("TOPLEFT", 120, -309)
DropDownguildranktoprom:Show()

local tab={"no guild"}
if IsInGuild() then
	tab={}
	local a=GuildControlGetNumRanks()
	if a>0 then
		for qw=1,a do
			table.insert(tab,GuildControlGetRankName(qw))
		end
	else
		table.insert(tab,"no ranks, error")
	end
end

local items = tab

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownguildranktoprom, self:GetID())

psautoinvsave[5]=self:GetID()


end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end

local b=1
if psautoinvsave[5]<=GuildControlGetNumRanks() then
b=psautoinvsave[5]
else
psautoinvsave[5]=1
end

UIDropDownMenu_Initialize(DropDownguildranktoprom, initialize)
UIDropDownMenu_SetWidth(DropDownguildranktoprom, 95)
UIDropDownMenu_SetButtonWidth(DropDownguildranktoprom, 105)
UIDropDownMenu_SetSelectedID(DropDownguildranktoprom, b)
UIDropDownMenu_JustifyText(DropDownguildranktoprom, "LEFT")
end


function psinviteonrankfunc()
if pstempnoclickrank1==nil or (pstempnoclickrank1 and GetTime()>pstempnoclickrank1+10) then
if GuildControlGetNumRanks()>=psautoinvsave[5] then
pstempnoclickrank1=GetTime()
	if psrankstoinvite==nil then
		psrankstoinvite={}
	end
	table.insert(psrankstoinvite,psautoinvsave[5])
	if psautoinvsave[9]==1 then
		local txt=format(psspaminvgiphrase,GuildControlGetRankName(psautoinvsave[5]).." "..psrankandhigher)
		SendChatMessage(txt, "GUILD")
		psinviteonrankgo=GetTime()+10
	else
		psinviteonrankgo=GetTime()
	end
	ps_i_h=1
else
out("error")
end
else
out("too quick")
end
end

function psinviteonrankfunc2()
if pstempnoclickrank1==nil or (pstempnoclickrank1 and GetTime()>pstempnoclickrank1+10) then
if GuildControlGetNumRanks()>=psautoinvsave[5] then
	if psrankstoinvite==nil then
		psrankstoinvite={}
	end
	local bil=0
	if #psrankstoinvite>0 then
		for i=1,#psrankstoinvite do
			if psrankstoinvite[i]==psautoinvsave[5] then
				bil=1
			end
		end
	end
	if bil==0 then
		table.insert(psrankstoinvite,psautoinvsave[5])
		if psautoinvsave[9]==1 then
			local txt=format(psspaminvgiphrase,GuildControlGetRankName(psautoinvsave[5]))
			SendChatMessage(txt, "GUILD")
			psinviteonrankgo=GetTime()+10
		else
			psinviteonrankgo=GetTime()
		end
		ps_i_h=2
	else
		out("error, already waiting to invite")
	end
else
out("error")
end
else
out("too quick")
end
end


function psbossmodframeopen()


if (psdxespamfilter==nil or (psdxespamfilter and GetTime()>psdxespamfilter+30)) then
		local inInstance, instanceType = IsInInstance()
		if instanceType=="raid" then
--SendAddonMessage("DXE", "^1^SRequestAddOnVersion^^", "RAID")
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
SendAddonMessage("DXE","DXEVersionRequest","RAID")
end
psreloadbossmodwind=GetTime()+3
psdxespamfilter=GetTime()
		end

--получение своей версии ДХЕ
if IsAddOnLoaded("DXE") then
local adxe=DXE:GetVersionString()
local bdxe=0
local verd=0
	if string.find(adxe,":") then
		bdxe=string.find(adxe,":")
	end
	if bdxe>0 then
		verd=tonumber(string.sub(adxe,7,bdxe-1))
	else
		verd=tonumber(string.sub(adxe,7))
	end
	if verd>0 then
		local bil=0
		if #psbossmods3>0 then
			for i=1,#psbossmods3 do
				if psbossmods3[i]==UnitName("player") and psbossmods1[i]=="DXE" then
					bil=1
					psbossmods2[i]=verd
					psbossmods5[i]=GetTime()
					psbossmods4[i]=0
				end
			end
		end
		if bil==0 then
			local nik=UnitName("player")
			table.insert(psbossmods1,"DXE")
			table.insert(psbossmods2,verd)
			table.insert(psbossmods3,nik)
			table.insert(psbossmods4,0)
			table.insert(psbossmods5,GetTime())
		end
	end
end



end


if bossmodfdsfsdf==nil then
bossmodfdsfsdf=1


	--чекбатон
	local c = CreateFrame("CheckButton", nil, PSFbossmodframe, "UICheckButtonTemplate")
	c:SetWidth("25")
	c:SetHeight("25")
	c:SetPoint("TOPLEFT", 20, -435)
	c:SetScript("OnClick", function(self) if psbossmodnoalphavar==1 then psbossmodnoalphavar=0 psbossmodframeopen() else psbossmodnoalphavar=1 psbossmodframeopen() end end )
	if psbossmodnoalphavar==1 then
		c:SetChecked()
	else
		c:SetChecked(false)
	end
	
	--текст
	local t = PSFbossmodframe:CreateFontString()
	t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
	t:SetWidth(465)
	t:SetHeight(45)
  t:SetText(psbossmodnoalphatxt)
	t:SetJustifyH("LEFT")
	t:SetJustifyV("CENTER")
  t:SetPoint("TOPLEFT", 45, -425)
	

psbossmodcolumn1=PSFbossmodframe:CreateFontString()
psbossmodcolumn2=PSFbossmodframe:CreateFontString()
psbossmodcolumn3=PSFbossmodframe:CreateFontString()
psbossmodcolumn4=PSFbossmodframe:CreateFontString()
psbossmodcolumn5=PSFbossmodframe:CreateFontString()
psbossmodcolumn6=PSFbossmodframe:CreateFontString()

psbossmodcolumn1:SetWidth(380)
psbossmodcolumn1:SetHeight(415)
psbossmodcolumn1:SetFont(GameFontNormal:GetFont(), 12)
psbossmodcolumn1:SetPoint("TOPLEFT",17,-60)
psbossmodcolumn1:SetText(" ")
psbossmodcolumn1:SetJustifyH("LEFT")
psbossmodcolumn1:SetJustifyV("TOP")

psbossmodcolumn2:SetWidth(380)
psbossmodcolumn2:SetHeight(415)
psbossmodcolumn2:SetFont(GameFontNormal:GetFont(), 12)
psbossmodcolumn2:SetPoint("TOPLEFT",121,-60)
psbossmodcolumn2:SetText(" ")
psbossmodcolumn2:SetJustifyH("LEFT")
psbossmodcolumn2:SetJustifyV("TOP")

psbossmodcolumn3:SetWidth(380)
psbossmodcolumn3:SetHeight(395)
psbossmodcolumn3:SetFont(GameFontNormal:GetFont(), 12)
psbossmodcolumn3:SetPoint("TOPLEFT",260,-60)
psbossmodcolumn3:SetText(" ")
psbossmodcolumn3:SetJustifyH("LEFT")
psbossmodcolumn3:SetJustifyV("TOP")

psbossmodcolumn4:SetWidth(380)
psbossmodcolumn4:SetHeight(395)
psbossmodcolumn4:SetFont(GameFontNormal:GetFont(), 12)
psbossmodcolumn4:SetPoint("TOPLEFT",364,-60)
psbossmodcolumn4:SetText(" ")
psbossmodcolumn4:SetJustifyH("LEFT")
psbossmodcolumn4:SetJustifyV("TOP")

psbossmodcolumn5:SetWidth(380)
psbossmodcolumn5:SetHeight(395)
psbossmodcolumn5:SetFont(GameFontNormal:GetFont(), 12)
psbossmodcolumn5:SetPoint("TOPLEFT",503,-60)
psbossmodcolumn5:SetText(" ")
psbossmodcolumn5:SetJustifyH("LEFT")
psbossmodcolumn5:SetJustifyV("TOP")

psbossmodcolumn6:SetWidth(380)
psbossmodcolumn6:SetHeight(395)
psbossmodcolumn6:SetFont(GameFontNormal:GetFont(), 12)
psbossmodcolumn6:SetPoint("TOPLEFT",607,-60)
psbossmodcolumn6:SetText(" ")
psbossmodcolumn6:SetJustifyH("LEFT")
psbossmodcolumn6:SetJustifyV("TOP")



if psbosssmodchosesort==nil then
	psbosssmodchosesort=1
end


openchoosebssort()


pssendwhisptext = PSFbossmodframe:CreateFontString()
pssendwhisptext:SetWidth(700)
pssendwhisptext:SetHeight(45)
pssendwhisptext:SetFont(GameFontNormal:GetFont(), psfontsset[2])
pssendwhisptext:SetPoint("TOPLEFT",155,-451)
pssendwhisptext:SetText(psmainrepinf)
pssendwhisptext:SetJustifyH("LEFT")
pssendwhisptext:SetJustifyV("CENTER")


psbossmframescroll1 = PSFbossmodframe:CreateFontString()
psbossmframescroll1:SetWidth(380)
psbossmframescroll1:SetHeight(395)
psbossmframescroll1:SetFont(GameFontNormal:GetFont(), 12)
psbossmframescroll1:SetPoint("TOPLEFT",17,-60)
psbossmframescroll1:SetText(" ")
psbossmframescroll1:SetJustifyH("LEFT")
psbossmframescroll1:SetJustifyV("TOP")


psbossmframescroll2 = PSFbossmodframe:CreateFontString()
psbossmframescroll2:SetWidth(600)
psbossmframescroll2:SetHeight(395)
psbossmframescroll2:SetFont(GameFontNormal:GetFont(), 12)
psbossmframescroll2:SetPoint("TOPLEFT",121,-60)
psbossmframescroll2:SetText(" ")
psbossmframescroll2:SetJustifyH("LEFT")
psbossmframescroll2:SetJustifyV("TOP")



end
--create frame end

psbossmframescroll1:Hide()
psbossmframescroll2:Hide()
psbossmodcolumn1:Hide()
psbossmodcolumn2:Hide()
psbossmodcolumn3:Hide()
psbossmodcolumn4:Hide()
psbossmodcolumn5:Hide()
psbossmodcolumn6:Hide()




psbossmodinfoshowstats()

end


function openchoosebssort()
if not DropDownchoosebssort then
CreateFrame("Frame", "DropDownchoosebssort", PSFbossmodframe, "UIDropDownMenuTemplate")
end

DropDownchoosebssort:ClearAllPoints()
DropDownchoosebssort:SetPoint("TOPLEFT", 105, -12)
DropDownchoosebssort:Show()

local items = {psmainbossmsort1,psmainbossmsort2,psmainbossmsort3, psmainonly.." DBM", psmainonly.." BigWigs", psmainonly.." RaidWatch2", psmainonly.." DXE"}

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownchoosebssort, self:GetID())

psbosssmodchosesort=self:GetID()
psbossmodinfoshowstats()

end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end


UIDropDownMenu_Initialize(DropDownchoosebssort, initialize)
UIDropDownMenu_SetWidth(DropDownchoosebssort, 90)
UIDropDownMenu_SetButtonWidth(DropDownchoosebssort, 105)
UIDropDownMenu_SetSelectedID(DropDownchoosebssort, psbosssmodchosesort)
UIDropDownMenu_JustifyText(DropDownchoosebssort, "LEFT")
end





function psbossmodinfoshowstats(reportold)
local trackfin=0
local nobossmodf=0
if reportold==nil or (reportold and (pslastbossmodwhisper==nil or (pslastbossmodwhisper and GetTime()>pslastbossmodwhisper+20))) then

local maxletter=13
if GetLocale()=="ruRU" then
  maxletter=25
end

psbossmframescroll1:Hide()
psbossmframescroll2:Hide()
psbossmframescroll1:SetText(" ")
psbossmframescroll2:SetText(" ")
psbossmodcolumn1:Hide()
psbossmodcolumn2:Hide()
psbossmodcolumn3:Hide()
psbossmodcolumn4:Hide()
psbossmodcolumn5:Hide()
psbossmodcolumn6:Hide()
psbossmodcolumn1:SetText(" ")
psbossmodcolumn2:SetText(" ")
psbossmodcolumn3:SetText(" ")
psbossmodcolumn4:SetText(" ")
psbossmodcolumn5:SetText(" ")
psbossmodcolumn6:SetText(" ")

pssendwhisptext:SetText(psmainrepinf)

if UnitInRaid("player") then

--определение самых посл версий
local bossmods={}
local versions={}
local versions2={}
local dbmmaxversion=0

for i=1,#psbossmods1 do
	local bil=0
	if #bossmods>0 then
		for j=1,#bossmods do
			if bossmods[j]==psbossmods1[i] then
				bil=1
				if psbossmods2[i]==nil or versions[j]==nil and fffffe==nil then
          fffffe=1
          out ("PhoenixStyle - I'am looking to get this error. If you get it - please let me know next info:")
          print (psbossmods1[i])
          print (psbossmods2[i])
          print (psbossmods3[i])
          print (psbossmods4[i])
          print (versions[j])
				end
				if psbossmods2[i] and (psbossmods2[i]>versions[j] or psbossmods1[i]=="DBM") then
          if psbossmodnoalphavar==1 then
            --только НЕ альфа
            if psbossmods1[i]=="DXE" or psbossmods1[i]=="RaidWatch2" then
              versions[j]=psbossmods2[i]
              local add=""
              if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
                add=psbossmods4[i]
              end
              versions2[j]=add
            elseif psbossmods1[i]=="BigWigs" then
              if psbossmods4[i] and (string.find(string.lower(psbossmods4[i]), "alpha") or string.find(string.lower(psbossmods4[i]), "beta")) then
                --альфа :(
              else
                versions[j]=psbossmods2[i]
                local add=""
                if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
                  add=psbossmods4[i]
                end
                versions2[j]=add
              end
            elseif psbossmods1[i]=="DBM" then
              local numb=psgetdbmverbig(psbossmods4[i])
              if numb>0 then
                if numb>=dbmmaxversion then
                  if numb>dbmmaxversion then
                    versions[j]=psbossmods2[i]
                    local add=""
                    if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
                      add=psbossmods4[i]
                    end
                    versions2[j]=add
                  end
                  dbmmaxversion=numb
                  if versions[j]>psbossmods2[i] then
                    versions[j]=psbossmods2[i]
                    local add=""
                    if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
                      add=psbossmods4[i]
                    end
                    versions2[j]=add
                  end
                end
              end
            end
          elseif psbossmods2[i]>versions[j] then
            versions[j]=psbossmods2[i]
            local add=""
            if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
              add=psbossmods4[i]
            end
            versions2[j]=add
          end
				end
			end
		end
	end
	if bil==0 then
    if psbossmodnoalphavar==1 then
      --только не альфа
      if psbossmods1[i]=="DXE" or psbossmods1[i]=="RaidWatch2" then
        table.insert(bossmods,psbossmods1[i])
        table.insert(versions,psbossmods2[i])
        local add=""
        if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
          add=psbossmods4[i]
        end
        table.insert(versions2,add)
      elseif psbossmods1[i]=="BigWigs" then
        if psbossmods4[i] and (string.find(string.lower(psbossmods4[i]), "alpha") or string.find(string.lower(psbossmods4[i]), "beta")) then
          --альфа :(
          table.insert(bossmods,psbossmods1[i])
          table.insert(versions,0)
          table.insert(versions2,"")
        else
          table.insert(bossmods,psbossmods1[i])
          table.insert(versions,psbossmods2[i])
          local add=""
          if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
            add=psbossmods4[i]
          end
          table.insert(versions2,add)
        end
      elseif psbossmods1[i]=="DBM" then
        local numb=psgetdbmverbig(psbossmods4[i])
        if numb>0 then
          dbmmaxversion=numb
          table.insert(bossmods,psbossmods1[i])
          table.insert(versions,psbossmods2[i])
                local add=""
                if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
                  add=psbossmods4[i]
                end
                table.insert(versions2,add)
        else
          --версия не определена, поэтому считается как 0
          dbmmaxversion=0
          table.insert(bossmods,psbossmods1[i])
          table.insert(versions,0)
          table.insert(versions2,"")
        end
      end
    else
      --пофик
      table.insert(bossmods,psbossmods1[i])
      table.insert(versions,psbossmods2[i])
      local add=""
      if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
        add=psbossmods4[i]
      end
      table.insert(versions2,add)
    end
	end
end


--табл для устаревших версий
local psbossmodold1={} --ник для виспа
local psbossmodold2={} --назв аддона
local psbossmodold3={} --текущая версия
local psbossmodold4={} --посл версия

--таблица оффлайнеров которых мы игнорим
local psoffline={}
--таблица тех, у кого еще не найден босс мод
local psnobossmod={}
local zonebg={string.lower(psmainbattlegr1),string.lower(psmainbattlegr2),string.lower(psmainbattlegr3),string.lower(psmainbattlegr4),string.lower(psmainbattlegr5),string.lower(psmainbattlegr6),string.lower(psmainbattlegr7),string.lower(psmainbattlegr8)}

for i = 1,GetNumRaidMembers() do
	local name,_,_,_,_,_,pszone,psonline = GetRaidRosterInfo(i)
	if psonline==nil then
		table.insert(psoffline,"1"..name)
	else
		local bilz=0
		if pszone then
			for v=1,#zonebg do
				if zonebg[v]==string.lower(pszone) then
					local alr=0
					for f=1,#psbossmods3 do
						if psbossmods3[f]==name then
							alr=1
						end
					end
					if alr==0 then
						bilz=1
					end
				end
			end
		end
		if bilz==0 then
			table.insert(psnobossmod,name)
		else
			table.insert(psoffline,"2"..name)
		end
	end
end

table.sort(psoffline)



--1 вариант! босс моды все
if psbosssmodchosesort==1 then
psbossmodcolumn1:Show()
psbossmodcolumn2:Show()
psbossmodcolumn3:Show()
psbossmodcolumn4:Show()
psbossmodcolumn5:Show()
psbossmodcolumn6:Show()

local sortbm={{},{},{},{}} --строчка ник версия для аддона
local sortbmnameaddon={"DBM", "BigWigs", "RaidWatch2", "DXE"} --назв аддонов
for i=1,#psbossmods1 do
	local off=0
	for t=1,#psoffline do
		if psoffline[t]=="1"..psbossmods3[i] then
			off=1
		end
	end
	if UnitInRaid(psbossmods3[i]) and off==0 then
			for j=1,#sortbmnameaddon do
				if sortbmnameaddon[j]==psbossmods1[i] then
					local add=""
					if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
						add=psbossmods4[i]
					end
					local ver1=""
					local ver2=""
					for k=1,#bossmods do
						if bossmods[k]==psbossmods1[i] then
							if psbossmods2[i]<versions[k] then
								ver1="|cffff0000"
								ver2="|r"
								if reportold then
									table.insert(psbossmodold1,psbossmods3[i])
									table.insert(psbossmodold2,psbossmods1[i])
									table.insert(psbossmodold3,psbossmods2[i]..add)
									table.insert(psbossmodold4,versions[k]..versions2[k])
								end
							end
						end
					end
					--ыытест
					local aadd=psbossmods3[i]
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
					table.insert(sortbm[j],psunitclassget(nil,psbossmods3[i])..aadd.."|r\t"..ver1..psbossmods2[i]..add..ver2)
					for b=1,#psnobossmod do
						if psnobossmod[b] and psnobossmod[b]==psbossmods3[i] then
							table.remove(psnobossmod,b)
						end
					end
				end
			end
	end
end

if #sortbm[1]>0 or #sortbm[2]>0 or #sortbm[3] or #sortbm[4]>0 then
	for i=1,#sortbm do
		table.sort(sortbm[i])
	end
	local txt1={"","","",""}
	local txt2={"","","",""}
	for i=1,#sortbm do
		if #sortbm[i]>0 then
			txt1[i]=txt1[i].."|cff00ff00"..sortbmnameaddon[i]..":|r\n\r"
			txt2[i]=txt2[i].." \n\r"
			for j=1,#sortbm[i] do
				txt1[i]=txt1[i]..string.sub(sortbm[i][j],1,string.find(sortbm[i][j],"\t")-1).."\n"
				txt2[i]=txt2[i]..string.sub(sortbm[i][j],string.find(sortbm[i][j],"\t")+1).."\n"
			end
		end
	end
	local m=4
	if #sortbm[1]==0 then
		m=1
	elseif #sortbm[2]==0 then
		m=2
	elseif #sortbm[2]<#sortbm[3]+#sortbm[4] and #sortbm[2]<#sortbm[1] then
		m=2
	elseif #sortbm[1]<#sortbm[2] and #sortbm[1]<#sortbm[3]+#sortbm[4] then
		m=1
	end
	local add=""
	if #sortbm[m]>0 then
		add="\n\n\n"
	end
	if #psnobossmod>0 then
		txt1[m]=txt1[m]..add.."|cffff0000"..psmainnobosm..":|r\n\r"
		txt2[m]=txt2[m]..add.." \n\r"
		for i=1,#psnobossmod do
					--ыытест
					local aadd=psnobossmod[i]
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
			txt1[m]=txt1[m]..psunitclassget(nil,psnobossmod[i])..aadd.."|r\n"
			txt2[m]=txt2[m].."|cffff0000-|r\n"
			add="\n\n\n"
			nobossmodf=1
		end
	end
	if #psoffline>0 then
		txt1[m]=txt1[m]..add.."|cffff0000"..psmainnotcheckbosm..":|r\n\r"
		txt2[m]=txt2[m]..add.." \n\r"
		for i=1,#psoffline do
			local z1=string.sub(psoffline[i],1,1)
			local z2=string.sub(psoffline[i],2)
					--ыытест
					local aadd=z2
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
			txt1[m]=txt1[m]..psunitclassget(nil,z2)..aadd.."|r\n"
			if z1=="1" or z1==1 then
				txt2[m]=txt2[m].."|cffff0000"..psmainoffline.."|r\n"
			else
				txt2[m]=txt2[m].."|cffff0000"..psmainbgbm.."|r\n"
			end
		end
	end
if #sortbm[3]>0 then
txt2[4]="\n\n\n"..txt2[4]
txt1[4]="\n\n\n"..txt1[4]
end


psbossmodcolumn1:SetText(txt1[1])
psbossmodcolumn3:SetText(txt1[2])
psbossmodcolumn5:SetText(txt1[3]..txt1[4])
psbossmodcolumn2:SetText(txt2[1])
psbossmodcolumn4:SetText(txt2[2])
psbossmodcolumn6:SetText(txt2[3]..txt2[4])

trackfin=1

--репорт старых версий
if reportold then
	if #psbossmodold1>0 then
		for i=1,#psbossmodold1 do
			SendChatMessage("PhoenixStyle > "..format(psmainreportoldbm1,psbossmodold2[i],psbossmodold3[i],psbossmodold4[i]), "WHISPER", nil, psbossmodold1[i])
			pslastbossmodwhisper=GetTime()
		end
	end
	if #psnobossmod>0 then
		for i=1,#psnobossmod do
			SendChatMessage("PhoenixStyle > "..psmainreportoldbm2, "WHISPER", nil, psnobossmod[i])
			pslastbossmodwhisper=GetTime()
		end
	end
end

else
	psbossmodcolumn1:SetText(pcicccombat4)
end


end


--выравнивание по алфавиту
if psbosssmodchosesort==2 then
psbossmframescroll1:Show()
psbossmframescroll2:Show()


local sortbm={} --строчка ник аддон версия
local sortbm2={} --ники для ускоренного поиска
for i=1,#psbossmods1 do
	local off=0
	for t=1,#psoffline do
		if psoffline[t]=="1"..psbossmods3[i] then
			off=1
		end
	end
	if UnitInRaid(psbossmods3[i]) and off==0 then
		local bil=0
		if #sortbm2>0 then
			for j=1,#sortbm2 do
				if sortbm2[j]==psbossmods3[i] then
					bil=1
					local add=""
					if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
						add=psbossmods4[i]
					end
					local ver1=""
					local ver2=""
					for k=1,#bossmods do
						if bossmods[k]==psbossmods1[i] then
							if psbossmods2[i]<versions[k] then
								ver1="|cffff0000"
								ver2="|r"
								if reportold then
									table.insert(psbossmodold1,psbossmods3[i])
									table.insert(psbossmodold2,psbossmods1[i])
									table.insert(psbossmodold3,psbossmods2[i]..add)
									table.insert(psbossmodold4,versions[k]..versions2[k])
								end
							end
						end
					end
					sortbm[j]=sortbm[j]..", "..ver1..psbossmods1[i].." - "..psbossmods2[i]..add..ver2
				end
			end
		end
		if bil==0 then
					local add=""
					if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
						add=psbossmods4[i]
					end
					local ver1=""
					local ver2=""
					for k=1,#bossmods do
						if bossmods[k]==psbossmods1[i] then
							if psbossmods2[i]<versions[k] then
								ver1="|cffff0000"
								ver2="|r"
								if reportold then
									table.insert(psbossmodold1,psbossmods3[i])
									table.insert(psbossmodold2,psbossmods1[i])
									table.insert(psbossmodold3,psbossmods2[i]..add)
									table.insert(psbossmodold4,versions[k]..versions2[k])
								end
							end
						end
					end
					table.insert(sortbm,psbossmods3[i].."\t"..ver1..psbossmods1[i].." - "..psbossmods2[i]..add..ver2)
					table.insert(sortbm2,psbossmods3[i])
					for b=1,#psnobossmod do
						if psnobossmod[b] and psnobossmod[b]==psbossmods3[i] then
							table.remove(psnobossmod,b)
						end
					end
		end
			
	end
end
if #sortbm>0 then
	table.sort(sortbm)
	local txt=""
	local newtab1={}
	local newtab2={}
	for i=1,#sortbm do
		local ab1=string.sub(sortbm[i],1,string.find(sortbm[i],"\t")-1)
		local ab2=string.sub(sortbm[i],string.find(sortbm[i],"\t")+1)
					--ыытест
					local aadd=ab1
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
		table.insert(newtab1,psunitclassget(nil,ab1)..aadd.."|r")
		table.insert(newtab2,ab2)
	end


	if #psnobossmod>0 then
		for i=1,#psnobossmod do
					--ыытест
					local aadd=psnobossmod[i]
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
			table.insert(newtab1,psunitclassget(nil,psnobossmod[i])..aadd.."|r")
			table.insert(newtab2,"|cffff0000"..psmainnobosm.."|r")
			nobossmodf=1
		end
	end
	if #psoffline>0 then
		for i=1,#psoffline do
			local z1=string.sub(psoffline[i],1,1)
			local z2=string.sub(psoffline[i],2)
					--ыытест
					local aadd=z2
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
			table.insert(newtab1,psunitclassget(nil,z2)..aadd.."|r")
			if z1=="1" or z1==1 then
				table.insert(newtab2,"|cffff0000"..psmainoffline.."|r")
			else
				table.insert(newtab2,"|cffff0000"..psmainbgbm.."|r")
			end
		end
	end


	local txt1=""
	local txt2=""
	for j=1,#newtab1 do
		txt1=txt1..newtab1[j].."\n"
		txt2=txt2..newtab2[j].."\n"
	end

		psbossmframescroll1:SetText(txt1)
		psbossmframescroll2:SetText(txt2)
		trackfin=1


--репорт старых версий
if reportold then
	if #psbossmodold1>0 then
		for i=1,#psbossmodold1 do
			SendChatMessage("PhoenixStyle > "..format(psmainreportoldbm1,psbossmodold2[i],psbossmodold3[i],psbossmodold4[i]), "WHISPER", nil, psbossmodold1[i])
			pslastbossmodwhisper=GetTime()
		end
	end
	if #psnobossmod>0 then
		for i=1,#psnobossmod do
			SendChatMessage("PhoenixStyle > "..psmainreportoldbm2, "WHISPER", nil, psnobossmod[i])
			pslastbossmodwhisper=GetTime()
		end
	end
end

else
	psbossmframescroll1:Hide()
	psbossmframescroll2:Hide()

	psbossmodcolumn1:Show()
	psbossmodcolumn1:SetText(pcicccombat4)
end


end




if psbosssmodchosesort==3 then
psbossmframescroll1:Show()
psbossmframescroll2:Show()


local sortbm={} --строчка ник аддон версия
local sortbm2={} --ники для ускоренного поиска
for i=1,#psbossmods1 do
	local off=0
	for t=1,#psoffline do
		if psoffline[t]=="1"..psbossmods3[i] then
			off=1
		end
	end
	if UnitInRaid(psbossmods3[i]) and off==0 then
		local bil=0
		if #sortbm2>0 then
			for j=1,#sortbm2 do
				if sortbm2[j]==psbossmods3[i] then
					bil=1
					local add=""
					if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
						add=psbossmods4[i]
					end
					local ver1=""
					local ver2=""
					for k=1,#bossmods do
						if bossmods[k]==psbossmods1[i] then
							if psbossmods2[i]<versions[k] then
								ver1="|cffff0000"
								ver2="|r"
								if reportold then
									table.insert(psbossmodold1,psbossmods3[i])
									table.insert(psbossmodold2,psbossmods1[i])
									table.insert(psbossmodold3,psbossmods2[i]..add)
									table.insert(psbossmodold4,versions[k]..versions2[k])
								end
							end
						end
					end
					sortbm[j]=sortbm[j]..", "..ver1..psbossmods1[i].." - "..psbossmods2[i]..add..ver2
				end
			end
		end
		if bil==0 then
					local add=""
					if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
						add=psbossmods4[i]
					end
					local ver1=""
					local ver2=""
					for k=1,#bossmods do
						if bossmods[k]==psbossmods1[i] then
							if psbossmods2[i]<versions[k] then
								ver1="|cffff0000"
								ver2="|r"
								if reportold then
									table.insert(psbossmodold1,psbossmods3[i])
									table.insert(psbossmodold2,psbossmods1[i])
									table.insert(psbossmodold3,psbossmods2[i]..add)
									table.insert(psbossmodold4,versions[k]..versions2[k])
								end
							end
						end
					end
					--ыытест
					local aadd=psbossmods3[i]
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
					table.insert(sortbm,psunitclassget(nil,psbossmods3[i])..aadd.."|r\t"..ver1..psbossmods1[i].." - "..psbossmods2[i]..add..ver2)
					table.insert(sortbm2,psbossmods3[i])
					for b=1,#psnobossmod do
						if psnobossmod[b] and psnobossmod[b]==psbossmods3[i] then
							table.remove(psnobossmod,b)
						end
					end
		end
			
	end
end
if #sortbm>0 then
	table.sort(sortbm)
	local txt=""
	local newtab1={}
	local newtab2={}
	for i=1,#sortbm do
		local ab1=string.sub(sortbm[i],1,string.find(sortbm[i],"\t")-1)
		local ab2=string.sub(sortbm[i],string.find(sortbm[i],"\t")+1)
		table.insert(newtab1,ab1)
		table.insert(newtab2,ab2)
	end


	if #psnobossmod>0 then
		for i=1,#psnobossmod do
					--ыытест
					local aadd=psnobossmod[i]
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
			table.insert(newtab1,psunitclassget(nil,psnobossmod[i])..aadd.."|r")
			table.insert(newtab2,"|cffff0000"..psmainnobosm.."|r")
			nobossmodf=1
		end
	end
	if #psoffline>0 then
		for i=1,#psoffline do
			local z1=string.sub(psoffline[i],1,1)
			local z2=string.sub(psoffline[i],2)
					--ыытест
					local aadd=z2
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
			table.insert(newtab1,psunitclassget(nil,z2)..aadd.."|r")
			if z1=="1" or z1==1 then
				table.insert(newtab2,"|cffff0000"..psmainoffline.."|r")
			else
				table.insert(newtab2,"|cffff0000"..psmainbgbm.."|r")
			end
		end
	end
			
	local txt1=""
	local txt2=""
	for j=1,#newtab1 do
		txt1=txt1..newtab1[j].."\n"
		txt2=txt2..newtab2[j].."\n"
	end

		psbossmframescroll1:SetText(txt1)
		psbossmframescroll2:SetText(txt2)
		trackfin=1

--репорт старых версий
if reportold then
	if #psbossmodold1>0 then
		for i=1,#psbossmodold1 do
			SendChatMessage("PhoenixStyle > "..format(psmainreportoldbm1,psbossmodold2[i],psbossmodold3[i],psbossmodold4[i]), "WHISPER", nil, psbossmodold1[i])
			pslastbossmodwhisper=GetTime()
		end
	end
	if #psnobossmod>0 then
		for i=1,#psnobossmod do
			SendChatMessage("PhoenixStyle > "..psmainreportoldbm2, "WHISPER", nil, psnobossmod[i])
			pslastbossmodwhisper=GetTime()
		end
	end
end

else
	psbossmframescroll1:Hide()
	psbossmframescroll2:Hide()

	psbossmodcolumn1:Show()
	psbossmodcolumn1:SetText(pcicccombat4)
end


end



--только выбранные босс моды!!!
if psbosssmodchosesort==4 or psbosssmodchosesort==5 or psbosssmodchosesort==6 or psbosssmodchosesort==7 then
psbossmodcolumn1:Show()
psbossmodcolumn2:Show()
psbossmodcolumn3:Show()
psbossmodcolumn4:Show()
psbossmodcolumn5:Show()
psbossmodcolumn6:Show()

local bossmod=""
if psbosssmodchosesort==4 then
	bossmod="DBM"
elseif psbosssmodchosesort==5 then
	bossmod="BigWigs"
elseif psbosssmodchosesort==6 then
	bossmod="RaidWatch2"
elseif psbosssmodchosesort==7 then
	bossmod="DXE"
end

pssendwhisptext:SetText(format(psmainrepinf2,"|cff00ff00"..bossmod.."|r"))


local sortbm={} --строчка ник версия для аддона
local sortbmnameaddon={} --назв аддонов
for i=1,#psbossmods1 do
	if psbossmods1[i]==bossmod then
	local off=0
	for t=1,#psoffline do
		if psoffline[t]=="1"..psbossmods3[i] then
			off=1
		end
	end
	if UnitInRaid(psbossmods3[i]) and off==0 then
		local bil=0
		if #sortbmnameaddon>0 then
			for j=1,#sortbmnameaddon do
				if sortbmnameaddon[j]==psbossmods1[i] then
					bil=1
					local add=""
					if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
						add=psbossmods4[i]
					end
					local ver1=""
					local ver2=""
					for k=1,#bossmods do
						if bossmods[k]==psbossmods1[i] then
							if psbossmods2[i]<versions[k] then
								ver1="|cffff0000"
								ver2="|r"
								if reportold then
									table.insert(psbossmodold1,psbossmods3[i])
									table.insert(psbossmodold2,psbossmods1[i])
									table.insert(psbossmodold3,psbossmods2[i]..add)
									table.insert(psbossmodold4,versions[k]..versions2[k])
								end
							end
						end
					end
					--ыытест
					local aadd=psbossmods3[i]
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
					table.insert(sortbm[j],psunitclassget(nil,psbossmods3[i])..aadd.."|r\t"..ver1..psbossmods2[i]..add..ver2)
					for b=1,#psnobossmod do
						if psnobossmod[b] and psnobossmod[b]==psbossmods3[i] then
							table.remove(psnobossmod,b)
						end
					end
				end
			end
		end
		if bil==0 then
			table.insert(sortbmnameaddon,psbossmods1[i])
			table.insert(sortbm,{})
					local add=""
					if psbossmods4[i]~=0 and psbossmods4[i]~="0" then
						add=psbossmods4[i]
					end
					local ver1=""
					local ver2=""
					for k=1,#bossmods do
						if bossmods[k]==psbossmods1[i] then
							if psbossmods2[i]<versions[k] then
								ver1="|cffff0000"
								ver2="|r"
								if reportold then
									table.insert(psbossmodold1,psbossmods3[i])
									table.insert(psbossmodold2,psbossmods1[i])
									table.insert(psbossmodold3,psbossmods2[i]..add)
									table.insert(psbossmodold4,versions[k]..versions2[k])
								end
							end
						end
					end
					--ыытест
					local aadd=psbossmods3[i]
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
					table.insert(sortbm[#sortbm],psunitclassget(nil,psbossmods3[i])..aadd.."|r\t"..ver1..psbossmods2[i]..add..ver2)
					for b=1,#psnobossmod do
						if psnobossmod[b] and psnobossmod[b]==psbossmods3[i] then
							table.remove(psnobossmod,b)
						end
					end
		end

	end
	end
end
if #sortbm>0 then
	for i=1,#sortbm do
		table.sort(sortbm[i])
	end
	local txt1={"","",""}
	local txt2={"","",""}
	for i=1,#sortbm do
		txt1[i]=txt1[i].."|cff00ff00"..sortbmnameaddon[i]..":|r\n\r"
		txt2[i]=txt2[i].." \n\r"
		for j=1,#sortbm[i] do
			txt1[i]=txt1[i]..string.sub(sortbm[i][j],1,string.find(sortbm[i][j],"\t")-1).."\n"
			txt2[i]=txt2[i]..string.sub(sortbm[i][j],string.find(sortbm[i][j],"\t")+1).."\n"
		end
	end
	local col2=0
	if #psnobossmod>0 then
		txt1[2]=txt1[2].."|cffff0000NO "..bossmod..":|r\n\r"
		txt2[2]=txt2[2].." \n\r"
		for i=1,#psnobossmod do
					--ыытест
					local aadd=psnobossmod[i]
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
			txt1[2]=txt1[2]..psunitclassget(nil,psnobossmod[i])..aadd.."|r\n"
			txt2[2]=txt2[2].."|cffff0000-|r\n"
			col2=1
			nobossmodf=1
		end
	end
	local m=2
	if col2==1 then
		m=3
	end
	if #psoffline>0 then
		txt1[m]=txt1[m].."|cffff0000"..psmainnotcheckbosm..":|r\n\r"
		txt2[m]=txt2[m].." \n\r"
		for i=1,#psoffline do
			local z1=string.sub(psoffline[i],1,1)
			local z2=string.sub(psoffline[i],2)
					--ыытест
					local aadd=z2
					if string.len(aadd)>maxletter then
            aadd=string.sub(aadd,1,maxletter)..".."
          end
			txt1[m]=txt1[m]..psunitclassget(nil,z2)..aadd.."|r\n"
			if z1=="1" or z1==1 then
				txt2[m]=txt2[m].."|cffff0000"..psmainoffline.."|r\n"
			else
				txt2[m]=txt2[m].."|cffff0000"..psmainbgbm.."|r\n"
			end
		end
	end


psbossmodcolumn1:SetText(txt1[1])
psbossmodcolumn3:SetText(txt1[2])
psbossmodcolumn5:SetText(txt1[3])
psbossmodcolumn2:SetText(txt2[1])
psbossmodcolumn4:SetText(txt2[2])
psbossmodcolumn6:SetText(txt2[3])
trackfin=1

--репорт старых версий
if reportold then
	if #psbossmodold1>0 then
		for i=1,#psbossmodold1 do
			SendChatMessage("PhoenixStyle > "..format(psmainreportoldbm1,psbossmodold2[i],psbossmodold3[i],psbossmodold4[i]), "WHISPER", nil, psbossmodold1[1])
			pslastbossmodwhisper=GetTime()
		end
	end
	if #psnobossmod>0 then
		for i=1,#psnobossmod do
			SendChatMessage("PhoenixStyle > "..format(psmainreportoldbm3,bossmod), "WHISPER", nil, psnobossmod[i])
			pslastbossmodwhisper=GetTime()
		end
	end
end

else
	psbossmodcolumn1:SetText(pcicccombat4)
end





end

--общее для 6 сортировок






else
	psbossmodcolumn1:Show()
	psbossmodcolumn1:SetText(pcicccombat4)
end


else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..psattention.."|r "..psmainbmnotmorethenof)
end

if trackfin==1 and nobossmodf==1 and psmylogin and psfirtstbmtimeww==nil and (GetTime()<psmylogin+180 or psjoininraidtime and GetTime()<psjoininraidtime+180) then
out("|cff99ffffPhoenixStyle|r - |cffff0000"..psattention.."|r "..psmaintooearlybm)
psfirtstbmtimeww=1
end

end


function psunitclassget(clas,aa)
if clas==nil and aa then
_,clas=UnitClass(aa)
end
if clas==nil then
clas=""
end
local rsctekclass=string.lower(clas)
local rsccodeclass=0

if rsctekclass=="warrior" then rsccodeclass=1
elseif rsctekclass=="deathknight" then rsccodeclass=2
elseif rsctekclass=="paladin" then rsccodeclass=3
elseif rsctekclass=="priest" then rsccodeclass=4
elseif rsctekclass=="shaman" then rsccodeclass=5
elseif rsctekclass=="druid" then rsccodeclass=6
elseif rsctekclass=="rogue" then rsccodeclass=7
elseif rsctekclass=="mage" then rsccodeclass=8
elseif rsctekclass=="warlock" then rsccodeclass=9
elseif rsctekclass=="hunter" then rsccodeclass=10
end
local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372"}
if rsccodeclass==0 then
	return "|cff999999" --для цвет петов тест
else
	return tablecolor[rsccodeclass]
end
end

function psdeathrepreset()
psdeathrepsavemain={0,1,0,1,0,0,0,1,0,"raid",1,3,6,1,"party",2,1,1}
--ыытест обновить чек батоны и другие фигни
opendeathrc1()
opendeathrc2()
opendeathrc3()
for i=1,#psdeathcheckbutt do
	if psdeathrepsavemain[i]==1 then
		psdeathcheckbutt[i]:SetChecked()
		if i==2 then
      pstabletextdeathreptt[2]:SetText("|cff00ff00"..psdropt1.." "..format(psmaindeathrepforppl,"10/25").."|r")
    end
	else
		psdeathcheckbutt[i]:SetChecked(false)
		if i==2 then
      pstabletextdeathreptt[2]:SetText("|cffff0000"..psdropt1.." "..format(psmaindeathrepforppl,"10/25").."|r")
    end
	end
end
psdeathreppartycheckbut1:SetChecked()
psdeathreppartycheckbuttxt1:SetText("|cff00ff00"..psdropt1.." "..format(psmaindeathrepforppl,5).."|r")


psdeathrepscroll1:SetValue(psdeathrepsavemain[12])
getglobal(psdeathrepscroll1:GetName().."Text"):SetText(psdeathrepsavemain[12])
psdeathrepscroll2:SetValue(psdeathrepsavemain[13])
getglobal(psdeathrepscroll2:GetName().."Text"):SetText(psdeathrepsavemain[13])
psdeathrepscroll3:SetValue(psdeathrepsavemain[16])
getglobal(psdeathrepscroll3:GetName().."Text"):SetText(psdeathrepsavemain[16])


end


function PSF_autoinvopenf()
PSF_closeallpr()
PSFmain2_Button53:SetAlpha(0.3)
if(thisaddonwork)then
PSFautoinvframe:Show()
PSF_autoinvcreate()
else
PSFmain10:Show()
end
end

function PSF_dropen()
PSF_closeallpr()
PSFmain2_Button54:SetAlpha(0.3)
if(thisaddonwork)then
PSFdeathreport:Show()
PSF_dropencreate()
--print("Not yet ready... Haven`t time to finish...")
else
PSFmain10:Show()
end
end

--чаты дес репорта

function opendeathrc1()
if not DropDowndeathrc1 then
CreateFrame("Frame", "DropDowndeathrc1", PSFdeathreport, "UIDropDownMenuTemplate")
end

DropDowndeathrc1:ClearAllPoints()
DropDowndeathrc1:SetPoint("TOPLEFT", 27, -98)
DropDowndeathrc1:Show()

local items = bigmenuchatlist

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDowndeathrc1, self:GetID())

if self:GetID()>8 then
psdeathrepsavemain[10]=psfchatadd[self:GetID()-8]
else
psdeathrepsavemain[10]=bigmenuchatlisten[self:GetID()]
end

psdeathreportantispam=nil

end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end

bigmenuchat2(psdeathrepsavemain[10])
if bigma2num==0 then
psdeathrepsavemain[10]=bigmenuchatlisten[1]
bigma2num=1
end

UIDropDownMenu_Initialize(DropDowndeathrc1, initialize)
UIDropDownMenu_SetWidth(DropDowndeathrc1, 100)
UIDropDownMenu_SetButtonWidth(DropDowndeathrc1, 115)
UIDropDownMenu_SetSelectedID(DropDowndeathrc1, bigma2num)
UIDropDownMenu_JustifyText(DropDowndeathrc1, "LEFT")
end


function opendeathrc3()
if not DropDowndeathrc3 then
CreateFrame("Frame", "DropDowndeathrc3", PSFdeathreport, "UIDropDownMenuTemplate")
end

DropDowndeathrc3:ClearAllPoints()
DropDowndeathrc3:SetPoint("TOPLEFT", 27, -123)
DropDowndeathrc3:Show()

local items = lowmenuchatlist

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDowndeathrc3, self:GetID())

if self:GetID()>6 then
psdeathrepsavemain[15]=psfchatadd[self:GetID()-6]
else
psdeathrepsavemain[15]=lowmenuchatlisten[self:GetID()]
end

psdeathreportantispam=nil

end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end
if psdeathrepsavemain[15]==nil then
  psdeathrepsavemain[14]=1
  psdeathrepsavemain[15]="party"
  psdeathrepsavemain[8]=1
end
lowmenuchat2(psdeathrepsavemain[15])
if lowma2num==0 then
psdeathrepsavemain[15]=lowmenuchatlisten[1]
lowma2num=1
end

UIDropDownMenu_Initialize(DropDowndeathrc3, initialize)
UIDropDownMenu_SetWidth(DropDowndeathrc3, 100)
UIDropDownMenu_SetButtonWidth(DropDowndeathrc3, 115)
UIDropDownMenu_SetSelectedID(DropDowndeathrc3, lowma2num)
UIDropDownMenu_JustifyText(DropDowndeathrc3, "LEFT")
end


function psplaysounddr(nr)
if psdrsounds2[nr] then
	if psdrsounds2[nr]=="2" then
		PlaySoundFile("Interface\\AddOns\\PhoenixStyle\\Sounds\\"..psdrsounds[nr], "Master")
	elseif psdrsounds2[nr]=="1" then
		PlaySound(psdrsounds[nr], "Master")
	else
		PlaySoundFile(psdrsounds2[nr]..psdrsounds[nr], "Master")
	end
end
end

function opendeathrc2()
if not DropDowndeathrc2 then
CreateFrame("Frame", "DropDowndeathrc2", PSFdeathreport, "UIDropDownMenuTemplate")
end

DropDowndeathrc2:ClearAllPoints()
DropDowndeathrc2:SetPoint("TOPLEFT", 27, -148)
DropDowndeathrc2:Show()



local items = psdrsounds


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDowndeathrc2, self:GetID())

psdeathrepsavemain[11]=self:GetID()
psplaysounddr(psdeathrepsavemain[11])



end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end


UIDropDownMenu_Initialize(DropDowndeathrc2, initialize)
UIDropDownMenu_SetWidth(DropDowndeathrc2, 100)
UIDropDownMenu_SetButtonWidth(DropDowndeathrc2, 115)
UIDropDownMenu_SetSelectedID(DropDowndeathrc2, psdeathrepsavemain[11])
UIDropDownMenu_JustifyText(DropDowndeathrc2, "LEFT")
end


function PSF_dropencreate()

if psdeathwdfdsfcw2==nil then
psdeathwdfdsfcw2=1

psdeathcheckbutt={}
local j=-50
local tab1={psdropt01,psdropt1.." ("..format(psmaindeathrepforppl,"10/25")..")",psdropt2,psdropt3,psdroptlfr,psdropt4,psdropt5,psdropt6,psdropt7,psdropt8,psdropt9}

--дескрипт
local t = PSFdeathreport:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t:SetSize(700,200)
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")
t:SetText(psdeathrepdesc)
t:SetPoint("TOPLEFT",20,-20)

--создание текста и чекбаттонов
pstabletextdeathreptt={}
for i=1,11 do
	j=j-25
	if i==3 then
    j=j-25
  end
	--чекбатон
	local c = CreateFrame("CheckButton", nil, PSFdeathreport, "UICheckButtonTemplate")
	c:SetWidth("25")
	c:SetHeight("25")
	c:SetPoint("TOPLEFT", 20, j)
	if i==10 then
    c:SetScript("OnClick", function(self) if psdeathrepsavemain[17]==1 then psdeathrepsavemain[17]=0 else psdeathrepsavemain[17]=1 end end )
  elseif i==11 then
    c:SetScript("OnClick", function(self) if psdeathrepsavemain[18]==1 then psdeathrepsavemain[18]=0 else psdeathrepsavemain[18]=1 end end )
  else
    c:SetScript("OnClick", function(self) if psdeathrepsavemain[i]==1 then psdeathrepsavemain[i]=0 if i==2 then pstabletextdeathreptt[2]:SetText("|cffff0000"..psdropt1.." ("..format(psmaindeathrepforppl,"10/25")..")|r") end else psdeathrepsavemain[i]=1 if i==2 then pstabletextdeathreptt[2]:SetText("|cff00ff00"..psdropt1.." ("..format(psmaindeathrepforppl,"10/25")..")|r") end end end )
  end
  if i==10 then
    if psdeathrepsavemain[17]==1 then
      c:SetChecked()
    else
      c:SetChecked(false)
    end
  elseif i==11 then
    if psdeathrepsavemain[18]==1 then
      c:SetChecked()
    else
      c:SetChecked(false)
    end
  else
    if psdeathrepsavemain[i]==1 then
      c:SetChecked()
    else
      c:SetChecked(false)
    end
  end
	table.insert(psdeathcheckbutt, c)


	--текст
	local t = PSFdeathreport:CreateFontString()
	t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
	t:SetWidth(548)
	if i==2 then
    if psdeathrepsavemain[i]==1 then
      t:SetText("|cff00ff00"..tab1[i].."|r")
    else
      t:SetText("|cffff0000"..tab1[i].."|r")
    end
	else
    t:SetText(tab1[i])
  end
	t:SetJustifyH("LEFT")
	if i==2 or i==3 then
		t:SetPoint("TOPLEFT", 168, j-5)
	else
		t:SetPoint("TOPLEFT", 48, j-5)
	end
	table.insert(pstabletextdeathreptt,t)
end

if psdeathrepsavemain[14]==nil then
  psdeathrepsavemain[14]=1
  psdeathrepsavemain[15]="party"
  psdeathrepsavemain[8]=1
end

--пати создание фреймов
	psdeathreppartycheckbut1 = CreateFrame("CheckButton", nil, PSFdeathreport, "UICheckButtonTemplate")
	psdeathreppartycheckbut1:SetWidth("25")
	psdeathreppartycheckbut1:SetHeight("25")
	psdeathreppartycheckbut1:SetPoint("TOPLEFT", 20, -125)
	psdeathreppartycheckbut1:SetScript("OnClick", function(self) if psdeathrepsavemain[14]==1 then psdeathrepsavemain[14]=0 psdeathreppartycheckbuttxt1:SetText("|cffff0000"..psdropt1.." ("..format(psmaindeathrepforppl,5)..")|r") else psdeathrepsavemain[14]=1 psdeathreppartycheckbuttxt1:SetText("|cff00ff00"..psdropt1.." ("..format(psmaindeathrepforppl,5)..")|r") end end )
	if psdeathrepsavemain[14]==1 then
		psdeathreppartycheckbut1:SetChecked()
	else
		psdeathreppartycheckbut1:SetChecked(false)
	end
	
	psdeathreppartycheckbuttxt1 = PSFdeathreport:CreateFontString()
	psdeathreppartycheckbuttxt1:SetFont(GameFontNormal:GetFont(), psfontsset[2])
	psdeathreppartycheckbuttxt1:SetWidth(548)
  if psdeathrepsavemain[14]==1 then
    psdeathreppartycheckbuttxt1:SetText("|cff00ff00"..psdropt1.." ("..format(psmaindeathrepforppl,5)..")|r")
  else
    psdeathreppartycheckbuttxt1:SetText("|cffff0000"..psdropt1.." ("..format(psmaindeathrepforppl,5)..")|r")
  end
	psdeathreppartycheckbuttxt1:SetJustifyH("LEFT")
	psdeathreppartycheckbuttxt1:SetPoint("TOPLEFT", 168, -130)



psdeathrepscroll1=CreateFrame("Slider","sliderdetr1",PSFdeathreport,"OptionsSliderTemplate")
psdeathrepscroll1:SetWidth(145)
psdeathrepscroll1:SetHeight(16)
psdeathrepscroll1:SetPoint("TOPLEFT",500,-200)
getglobal(psdeathrepscroll1:GetName().."High"):SetText(10)
getglobal(psdeathrepscroll1:GetName().."Low"):SetText(1)
getglobal(psdeathrepscroll1:GetName().."Text"):SetText(psdeathrepsavemain[12])
psdeathrepscroll1:SetMinMaxValues(1, 10)
psdeathrepscroll1:SetValueStep(1)
psdeathrepscroll1:SetValue(psdeathrepsavemain[12])
psdeathrepscroll1:SetScript("OnValueChanged", function (self) psdeathrepsavemain[12]=self:GetValue() getglobal(self:GetName().."Text"):SetText(psdeathrepsavemain[12]) end )


local s = PSFdeathreport:CreateFontString()
s:SetWidth(180)
s:SetHeight(20)
s:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s:SetPoint("TOPLEFT",485,-208)
s:SetJustifyH("CENTER")
s:SetJustifyV("BOTTOM")
s:SetText(format(psmaindeathrepforppl,10))


psdeathrepscroll2=CreateFrame("Slider","sliderdetr2",PSFdeathreport,"OptionsSliderTemplate")
psdeathrepscroll2:SetWidth(145)
psdeathrepscroll2:SetHeight(16)
psdeathrepscroll2:SetPoint("TOPLEFT",500,-140)
getglobal(psdeathrepscroll2:GetName().."High"):SetText(20)
getglobal(psdeathrepscroll2:GetName().."Low"):SetText(1)
getglobal(psdeathrepscroll2:GetName().."Text"):SetText(psdeathrepsavemain[13])
psdeathrepscroll2:SetMinMaxValues(1, 20)
psdeathrepscroll2:SetValueStep(1)
psdeathrepscroll2:SetValue(psdeathrepsavemain[13])
psdeathrepscroll2:SetScript("OnValueChanged", function (self) psdeathrepsavemain[13]=self:GetValue() getglobal(self:GetName().."Text"):SetText(psdeathrepsavemain[13]) end )

local s2 = PSFdeathreport:CreateFontString()
s2:SetWidth(180)
s2:SetHeight(20)
s2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s2:SetPoint("TOPLEFT",485,-148)
s2:SetJustifyH("CENTER")
s2:SetJustifyV("BOTTOM")
s2:SetText(format(psmaindeathrepforppl,25))

psdeathrepscroll3=CreateFrame("Slider","sliderdetr3",PSFdeathreport,"OptionsSliderTemplate")
psdeathrepscroll3:SetWidth(145)
psdeathrepscroll3:SetHeight(16)
psdeathrepscroll3:SetPoint("TOPLEFT",500,-260)
getglobal(psdeathrepscroll3:GetName().."High"):SetText(5)
getglobal(psdeathrepscroll3:GetName().."Low"):SetText(1)
getglobal(psdeathrepscroll3:GetName().."Text"):SetText(psdeathrepsavemain[16])
psdeathrepscroll3:SetMinMaxValues(1, 20)
psdeathrepscroll3:SetValueStep(1)
psdeathrepscroll3:SetValue(psdeathrepsavemain[16])
psdeathrepscroll3:SetScript("OnValueChanged", function (self) psdeathrepsavemain[16]=self:GetValue() getglobal(self:GetName().."Text"):SetText(psdeathrepsavemain[16]) end )

local s3 = PSFdeathreport:CreateFontString()
s3:SetWidth(180)
s3:SetHeight(20)
s3:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s3:SetPoint("TOPLEFT",485,-268)
s3:SetJustifyH("CENTER")
s3:SetJustifyV("BOTTOM")
s3:SetText(format(psmaindeathrepforppl,5))



local wsrcstxt = PSFdeathreport:CreateFontString()
wsrcstxt:SetWidth(220)
wsrcstxt:SetHeight(45)
wsrcstxt:SetFont(GameFontNormal:GetFont(), 15)
wsrcstxt:SetPoint("TOPLEFT",463,-78)
wsrcstxt:SetJustifyH("CENTER")
wsrcstxt:SetJustifyV("TOP")
wsrcstxt:SetText(psstopdeathrep)







end
--обновлять чат здесь:
opendeathrc1()
opendeathrc2()
opendeathrc3()


end

local GroupDisband = function()
if psdisbandinsec25==nil or (psdisbandinsec25 and GetTime()>psdisbandinsec25+25) then
psdisbandinsec25=GetTime()
	local pName = UnitName("player")
	pswaitlisttoreinvite={}
	table.wipe(pswaitlisttoreinvite)
	pswaitlisttoreinvitet=GetTime()+10

	if UnitInRaid("player") then
		SendChatMessage("PhoenixStyle - "..psdisbandmess, "RAID")
		for i = 1, GetNumRaidMembers() do
			local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i)
			if online and name ~= pName then
				table.insert(pswaitlisttoreinvite,name)
				UninviteUnit(name)
			end
		end
	else
		SendChatMessage("PhoenixStyle - "..psdisbandmess, "PARTY")
		for i = GetNumPartyMembers(), 1, -1 do
			if GetPartyMember(i) then
				local as=UnitName("party"..i)
				table.insert(pswaitlisttoreinvite, as)
				UninviteUnit(UnitName("party"..i))
			end
		end
	end

	psleavepartydelay=GetTime()+0.9
	if #pswaitlisttoreinvite>4 then
		pswhatdiff=GetRaidDifficulty()
		psneedconvertquick=GetTime()+1.5
	end
else
out ("too quick. 25 sec pausa.")
end
end


function psdisbantandinvitef()
--ыытест
if psnotoftenthansec10==nil or (psnotoftenthansec10 and GetTime()>psnotoftenthansec10+10) then


if (UnitInRaid("player") and (IsRaidOfficer() or IsRaidLeader())) or (GetNumPartyMembers()>0 and IsPartyLeader()) then

psnotoftenthansec10=GetTime()

StaticPopupDialogs["DISBAND_RAID2"] = {
	text = psdispandquestion,
	button1 = YES,
	button2 = NO,
	OnAccept = GroupDisband,
	timeout = 0,
	whileDead = 1,
}
StaticPopup_Show("DISBAND_RAID2")

else
out ("error: not leader!")
end



end

end


function psinvonwhisper(arg1,arg2,bnet)
if (psautoinvsave[1]==1 or (pstempinv and pstempinv>GetTime())) and arg1 and arg2 then
	local bil=0
	if #psautoinvsave[6]>0 then
		for i=1,#psautoinvsave[6] do
			if psautoinvsave[6][i]==string.lower(arg1) then
				bil=1
			end
		end
	end
	if bil==1 then
		local friend=0
		if psautoinvsave[2]==1 then
			for i=1, GetNumFriends() do
				if(GetFriendInfo(i)==arg2) then
					friend=1
				end
			end
      --друзья чары но в батлнете
      if friend==0 then
        local b,a=BNGetNumFriends() for i=1,a do local a1,a2,a3,a4=BNGetFriendInfo(i) if a4==arg2 then friend=1 end end
      end
			if bnet then
				local b,a=BNGetNumFriends() for i=1,a do local a1,a2,a3,a4=BNGetFriendInfo(i) if a1==bnet then friend=1 temptoinvite=a4 end end
			end
		end
		if UnitIsInMyGuild(arg2) then
			friend=1
		end
		if friend==1 or psautoinvsave[2]==0 then
			local ool=0
			if GetNumPartyMembers()==4 and IsPartyLeader() then
				ConvertToRaid()
				if psneedinvitethem==nil then
					psneedinvitethem={arg2}
					psconvertedinv=GetTime()+0.5
					ool=1
				end
				--установка сложности
				if psautoinvsave[3]==1 or (pstempconvert and pstempconvert>GetTime()) then
					pswhatdiff=psautoinvraiddiffsave[1]
					psneedchangediff=GetTime()+0.5
				end
				pschangequalityitems=GetTime()+1
			end
			if ool==0 and (UnitInRaid("player") and (IsRaidOfficer() or IsRaidLeader())) or (GetNumPartyMembers()>0 and IsPartyLeader()) or (GetNumPartyMembers()==0 and UnitInRaid("player")==nil) then
				if bnet==nil then
					InviteUnit(arg2)
        else
          InviteUnit(temptoinvite)
          temptoinvite=nil
				end
				--ыытест не знаю как инвайтить по батлнету!
			end
		end
	end
end
end


function openraiddiff()
if not DropDowndiffrai1 then
CreateFrame("Frame", "DropDowndiffrai1", PSFautoinvframe, "UIDropDownMenuTemplate")
end

DropDowndiffrai1:ClearAllPoints()
DropDowndiffrai1:SetPoint("TOPLEFT", 3, -166)
DropDowndiffrai1:Show()

local items = {"10, "..psiccnormal, "25, "..psiccnormal, "10, "..psiccheroic, "25, "..psiccheroic}

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDowndiffrai1, self:GetID())

psautoinvraiddiffsave[1]=self:GetID()

end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end


UIDropDownMenu_Initialize(DropDowndiffrai1, initialize)
UIDropDownMenu_SetWidth(DropDowndiffrai1, 100)
UIDropDownMenu_SetButtonWidth(DropDowndiffrai1, 115)
UIDropDownMenu_SetSelectedID(DropDowndiffrai1, psautoinvraiddiffsave[1])
UIDropDownMenu_JustifyText(DropDowndiffrai1, "LEFT")
end



function openraiddiff2()
if not DropDownraiddiff2 then
CreateFrame("Frame", "DropDownraiddiff2", PSFautoinvframe, "UIDropDownMenuTemplate")
end

DropDownraiddiff2:ClearAllPoints()
DropDownraiddiff2:SetPoint("TOPLEFT", 3, -309)
DropDownraiddiff2:Show()

local items = {"10, "..psiccnormal, "25, "..psiccnormal, "10, "..psiccheroic, "25, "..psiccheroic, pschatlist4}

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownraiddiff2, self:GetID())

psautoinvraiddiffsave[2]=self:GetID()

end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end


UIDropDownMenu_Initialize(DropDownraiddiff2, initialize)
UIDropDownMenu_SetWidth(DropDownraiddiff2, 100)
UIDropDownMenu_SetButtonWidth(DropDownraiddiff2, 115)
UIDropDownMenu_SetSelectedID(DropDownraiddiff2, psautoinvraiddiffsave[2])
UIDropDownMenu_JustifyText(DropDownraiddiff2, "LEFT")
end


function openthreshold()
if not DropDownthreshold then
CreateFrame("Frame", "DropDownthreshold", PSFautoinvframe, "UIDropDownMenuTemplate")
end

DropDownthreshold:ClearAllPoints()
DropDownthreshold:SetPoint("TOPLEFT", 3, -191)
DropDownthreshold:Show()

local items = {psthresholdno,psthreshold1,psthreshold2,psthreshold3,psthreshold4,psthreshold5}

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownthreshold, self:GetID())

psautoinvsave[11]=self:GetID()

end

local function initialize(self, level)
local info = UIDropDownMenu_CreateInfo()
for k,v in pairs(items) do
	info = UIDropDownMenu_CreateInfo()
	info.text = v
	info.value = v
	info.func = OnClick
	UIDropDownMenu_AddButton(info, level)
end
end


UIDropDownMenu_Initialize(DropDownthreshold, initialize)
UIDropDownMenu_SetWidth(DropDownthreshold, 100)
UIDropDownMenu_SetButtonWidth(DropDownthreshold, 115)
UIDropDownMenu_SetSelectedID(DropDownthreshold, psautoinvsave[11])
UIDropDownMenu_JustifyText(DropDownthreshold, "LEFT")
end

function PSF_autoinvcreate()

if figniautoinv==nil then
figniautoinv=1

--ыытест временно, для альф старых
if psautoinvsave[8]==nil then
	psautoinvsave[8]={}
end
if psautoinvsave[9]==nil then
	psautoinvsave[9]=0
end
if psautoinvsave[10]==nil then
	psautoinvsave[10]=psannouncephrase
end
if psautoinvsave[11]==nil then
	psautoinvsave[11]=1
end


--фигни автоинвайта

if #psautoinvsave[6]>0 then
	local tt=""
	for i=1,#psautoinvsave[6] do
		tt=tt..psautoinvsave[6][i]
		if i~=#psautoinvsave[6] then
			tt=tt..", "
		end
	end
	PSFautoinvframe_edbox10:SetText(tt)
else
	PSFautoinvframe_edbox10:SetText("")
end

if #psautoinvsave[7]>0 then
	local tt=""
	for i=1,#psautoinvsave[7] do
		tt=tt..psautoinvsave[7][i]
		if i~=#psautoinvsave[7] then
			tt=tt..", "
		end
	end
	PSFautoinvframe_edbox20:SetText(tt)
else
	PSFautoinvframe_edbox20:SetText("")
end

if #psautoinvsave[8]>0 then
	local tt=""
	for i=1,#psautoinvsave[8] do
		tt=tt..psautoinvsave[8][i]
		if i~=#psautoinvsave[8] then
			tt=tt..", "
		end
	end
	PSFautoinvframe_edbox30:SetText(tt)
else
	PSFautoinvframe_edbox30:SetText("")
end

PSFautoinvframe_edbox40:SetText(psautoinvsave[10])

PSFautoinvframe_edbox10:SetScript("OnEnterPressed", function(self) PSFautoinvframe_edbox10:ClearFocus() end )
PSFautoinvframe_edbox10:SetScript("onescapepressed", function(self) PSFautoinvframe_edbox10:ClearFocus() end )
PSFautoinvframe_edbox10:SetScript("OnTabPressed", function(self) PSFautoinvframe_edbox10:ClearFocus() end )
PSFautoinvframe_edbox10:SetScript("OnTextChanged", function(self) if string.find (PSFautoinvframe_edbox10:GetText(), " ",-1)==string.len(PSFautoinvframe_edbox10:GetText()) or string.find(PSFautoinvframe_edbox10:GetText(),",",-1)==string.len(PSFautoinvframe_edbox10:GetText()) then else psautoinvphrasesave(PSFautoinvframe_edbox10:GetText()) end end )


if psautoinvsave[1]==1 then PSFautoinvframe_CheckButtonau10:SetChecked() else PSFautoinvframe_CheckButtonau10:SetChecked(false) end
if psautoinvsave[2]==1 then PSFautoinvframe_CheckButtonau11:SetChecked() else PSFautoinvframe_CheckButtonau11:SetChecked(false) end
if psautoinvsave[3]==1 then PSFautoinvframe_CheckButtonau12:SetChecked() else PSFautoinvframe_CheckButtonau12:SetChecked(false) end
if psautoinvsave[4]==1 then PSFautoinvframe_CheckButtonau13:SetChecked() else PSFautoinvframe_CheckButtonau13:SetChecked(false) end
if psautoinvsave[9]==1 then PSFautoinvframe_CheckButtonau14:SetChecked() else PSFautoinvframe_CheckButtonau14:SetChecked(false) end



PSFautoinvframe_edbox20:SetScript("OnEnterPressed", function(self) PSFautoinvframe_edbox20:ClearFocus() end )
PSFautoinvframe_edbox20:SetScript("onescapepressed", function(self) PSFautoinvframe_edbox20:ClearFocus() end )
PSFautoinvframe_edbox20:SetScript("OnTabPressed", function(self) PSFautoinvframe_edbox20:ClearFocus() end )
PSFautoinvframe_edbox20:SetScript("OnTextChanged", function(self) if string.find (PSFautoinvframe_edbox20:GetText(), " ",-1)==string.len(PSFautoinvframe_edbox20:GetText()) or string.find(PSFautoinvframe_edbox20:GetText(),",",-1)==string.len(PSFautoinvframe_edbox20:GetText()) then else psautoinvphrasesave2(PSFautoinvframe_edbox20:GetText()) end end )


PSFautoinvframe_edbox30:SetScript("OnEnterPressed", function(self) PSFautoinvframe_edbox30:ClearFocus() end )
PSFautoinvframe_edbox30:SetScript("onescapepressed", function(self) PSFautoinvframe_edbox30:ClearFocus() end )
PSFautoinvframe_edbox30:SetScript("OnTabPressed", function(self) PSFautoinvframe_edbox30:ClearFocus() end )
PSFautoinvframe_edbox30:SetScript("OnTextChanged", function(self) if string.find (PSFautoinvframe_edbox30:GetText(), " ",-1)==string.len(PSFautoinvframe_edbox30:GetText()) or string.find(PSFautoinvframe_edbox30:GetText(),",",-1)==string.len(PSFautoinvframe_edbox30:GetText()) then else psautoinvphrasesave3(PSFautoinvframe_edbox30:GetText()) end end )

PSFautoinvframe_edbox40:SetScript("OnEnterPressed", function(self) PSFautoinvframe_edbox40:ClearFocus() end )
PSFautoinvframe_edbox40:SetScript("onescapepressed", function(self) PSFautoinvframe_edbox40:ClearFocus() end )
PSFautoinvframe_edbox40:SetScript("OnTabPressed", function(self) PSFautoinvframe_edbox40:ClearFocus() end )
PSFautoinvframe_edbox40:SetScript("OnTextChanged", function(self) psautoinvsave[10]=PSFautoinvframe_edbox40:GetText() end )


local psrcstxt2 = PSFautoinvframe:CreateFontString()
psrcstxt2:SetWidth(180)
psrcstxt2:SetHeight(25)
psrcstxt2:SetFont(GameFontNormal:GetFont(), 15)
psrcstxt2:SetPoint("TOPLEFT",20,-260)
psrcstxt2:SetJustifyH("LEFT")
psrcstxt2:SetJustifyV("TOP")
psrcstxt2:SetText("|cff00ff00"..psguildinvnam.."|r")

local psrcstxt3 = PSFautoinvframe:CreateFontString()
psrcstxt3:SetWidth(180)
psrcstxt3:SetHeight(25)
psrcstxt3:SetFont(GameFontNormal:GetFont(), 15)
psrcstxt3:SetPoint("TOPLEFT",20,-348)
psrcstxt3:SetJustifyH("LEFT")
psrcstxt3:SetJustifyV("TOP")
psrcstxt3:SetText("|cff00ff00"..psannounceinvtext.."|r")

PSFautoinvframe_Text141:SetJustifyH("LEFT")
PSFautoinvframe_Text14:SetJustifyH("LEFT")
PSFautoinvframe_Text15:SetJustifyH("LEFT")
PSFautoinvframe_Text16:SetJustifyH("LEFT")
PSFautoinvframe_Text17:SetJustifyH("LEFT")
PSFautoinvframe_Text18:SetJustifyH("LEFT")




openguildranktoprom()
openraiddiff()
openraiddiff2()
openthreshold()


end

end

function ps_inv_ann()
if IsInGuild() and psautoinvsave[10] then
SendChatMessage(psautoinvsave[10], "GUILD")
pstempinv=GetTime()+1800
pstempconvert=GetTime()+1800
end
end










































function psincombatinfoallfights(damagerep)

if pssavedinfotextframe1 then

if damagerep and (damagerep==1 or damagerep==2) then
  --инфо урона
  
	if pssidamageinf_indexboss==nil or (pssidamageinf_indexboss and pssidamageinf_indexboss[pssichose1] and #pssidamageinf_indexboss[pssichose1]==0) then
	
		pssavedinfotextframe1:ClearFocus()

		--PSFmainfrainsavedinfo_slid1:Hide()
		--PSFmainfrainsavedinfo_slid2:Hide()

	else

		pssavedinfotextframe1:ClearFocus()
		PSFmainfrainsavedinfo_slid1:Hide()
		PSFmainfrainsavedinfo_slid2:Hide()
		PSFmainfrainsavedinfo_Button1:Hide()
		PSFmainfrainsavedinfo_Button2:Hide()
		PSFmainfrainsavedinfo_Button3:Hide()
		PSFmainfrainsavedinfo_Button4:Hide()
		PSFmainfrainsavedinfo_edbox2:Hide()
    psisicombattypeduring1:Hide()
    psisicombattypeduring2:Hide()
    psisicombattypeduring3:Hide()
    psisicombattypeduring4:Hide()
    psisicombattypeduring5:Hide()


		if pssidamageinf_indexboss and pssidamageinf_indexboss[pssichose1] and #pssidamageinf_indexboss[pssichose1]>0 then
			pssavedinfotextframe1:SetText(format(psmainwaitexport,psicctxtbysaved))
			pssavedinfotextframe1:SetFocus(false)
			psreportthinkdelay2=GetTime()+0.2
			if damagerep==2 then
        psreportthinkdelayonlythisevent1=GetTime()
        psreportthinkdelayonlythisevent2=pssidamageinf_indexboss[pssichose1][pssichose2][pssichose4]
			end
		end
  end

elseif (damagerep==nil or (damagerep and damagerep==3)) then
  --по ходу боя
	if pssicombatin_indexboss==nil or (pssicombatin_indexboss and pssicombatin_indexboss[pssichose1] and #pssicombatin_indexboss[pssichose1]==0) then
	
		pssavedinfotextframe1:ClearFocus()

		PSFmainfrainsavedinfo_slid1:Hide()
		PSFmainfrainsavedinfo_slid2:Hide()

	else

		pssavedinfotextframe1:ClearFocus()
		PSFmainfrainsavedinfo_slid1:Hide()
		PSFmainfrainsavedinfo_slid2:Hide()
		PSFmainfrainsavedinfo_Button1:Hide()
		PSFmainfrainsavedinfo_Button2:Hide()
		PSFmainfrainsavedinfo_Button3:Hide()
		PSFmainfrainsavedinfo_Button4:Hide()
		PSFmainfrainsavedinfo_edbox2:Hide()
    psisicombattypeduring1:Hide()
    psisicombattypeduring2:Hide()
    psisicombattypeduring3:Hide()
    psisicombattypeduring4:Hide()
    psisicombattypeduring5:Hide()


		if pssicombatin_indexboss and pssicombatin_indexboss[pssichose1] and #pssicombatin_indexboss[pssichose1]>0 then
			pssavedinfotextframe1:SetText(format(psmainwaitexport,psicctxtbysaved))
			pssavedinfotextframe1:SetFocus(false)
			psreportthinkdelay=GetTime()+0.2
			if damagerep and damagerep==3 then
        psreportthinkdelayonlythisevent1=GetTime()
        psreportthinkdelayonlythisevent2=pssicombatin_indexboss[pssichose1][pssichose2][pssichose4-1]
        psreportthinkdelayonlythisevent3=pssisavedbossinfo[pssichose1][pssichose2][1]
			end
		end
  end
  
end

end

end



function psafterdelaysta(eventid,bossname)

local psstrochka=""

if pssavedinfocheckexport[4]==1 then
psstrochka=psstrochka.."[html] <div style=\"background:#070707;border:1px solid #333;padding:15px;\">"
end

psstrochka=psstrochka.."PhoenixStyle - "..pssaveityperep1
if eventid then
psstrochka=psstrochka.." (|cff00ff00"..pssavediradiobexp3.."|r)"
end

--если psicccombatexport 0 значит бои за сегодня и не нада листать
--только сегодня
local text=""
local _, month, day, year = CalendarGetDate()
if month<10 then month="0"..month end
if day<10 then day="0"..day end
--if year>2000 then year=year-2000 end
text=month.."/"..day.."/"..year
    
if pssisavedbossinfo[pssichose1] and #pssisavedbossinfo[pssichose1]>0 then
  local maxcomb=#pssisavedbossinfo[pssichose1]
  if psicccombatexport==0 then
    psstrochka=psstrochka.." ("..pssavediexportopt6..", "..text.."):\n\n"
    maxcomb=0
    for o=1,#pssisavedbossinfo[pssichose1] do
      if string.find(pssisavedbossinfo[pssichose1][o][2],text) then
        maxcomb=maxcomb+1
      end
    end
  else
    psstrochka=psstrochka..":\n\n"
    if psicccombatexport<maxcomb then
      maxcomb=psicccombatexport
    end
  end
  if maxcomb>0 then
		for q1=1,maxcomb do
      local bosstitle=""
			if pssisavedbossinfo[pssichose1][q1] then
        local a1=""
        local a2=""
        if pssavedinfocheckexport[1]==1 then
          a1="[B][color=orange]"
          a2="[/color][/B]"
        end
        local addtime=", "..pssisavedbossinfo[pssichose1][q1][2]
        if psicccombatexport==0 then
          addtime=""
        end
				bosstitle="\n"..a1..pssisavedbossinfo[pssichose1][q1][1].." ("..pssisavedbossinfo[pssichose1][q1][3]..")"..addtime..a2.."\n\n"
			end

			--фейлы листаем
			if pssicombatin_title2[pssichose1][q1] and #pssicombatin_title2[pssichose1][q1]>0 then
				for q2=1,#pssicombatin_title2[pssichose1][q1] do
          if (q2~=1 or (q2==1 and (pssicombatin_damageinfo[pssichose1][q1][q2] and pssicombatin_damageinfo[pssichose1][q1][q2][1] and pssicombatin_damageinfo[pssichose1][q1][q2][1][1]))) and (eventid==nil or (eventid and eventid==666 and pssicombatin_indexboss[pssichose1][q1][q2]==666) or (eventid and eventid==pssicombatin_indexboss[pssichose1][q1][q2] and bossname==pssisavedbossinfo[pssichose1][q1][1])) then
            local a1=""
            local a2=""
            if pssavedinfocheckexport[1]==1 then
              a1="[B]"
              a2="[/B]"
            end
            local spellnametocut=""
            if string.find(pssicombatin_title2[pssichose1][q1][q2],"|s4id") and string.find(pssicombatin_title2[pssichose1][q1][q2],"|id") then
              spellnametocut=GetSpellInfo(string.sub(pssicombatin_title2[pssichose1][q1][q2],string.find(pssicombatin_title2[pssichose1][q1][q2],"|s4id")+5,string.find(pssicombatin_title2[pssichose1][q1][q2],"|id")-1))
            end
            psstrochka=psstrochka..bosstitle..a1..psrestorelinksforexport(pssicombatin_title2[pssichose1][q1][q2])..a2.."\n\n"
            bosstitle=""

            if pssicombatin_indexboss[pssichose1][q1][q2]>0 and pssicombatin_indexboss[pssichose1][q1][q2]<999 then
              local maxnick=#pssicombatin_damageinfo[pssichose1][q1][q2][1]
              if #pssicombatin_damageinfo[pssichose1][q1][q2][1]>0 then
                for i = 1,maxnick do
                  local time=""
                  local ltime=math.ceil(pssicombatin_damageinfo[pssichose1][q1][q2][2][i])
                  if ltime<10 then
                    time="00:0"..ltime
                  elseif ltime<60 then
                    time="00:"..ltime
                  else
                    local sec=math.fmod (ltime, 60)
                    local min=math.floor (ltime/60)
                    if min<10 then
                      time="0"..min
                    else
                      time=min
                    end
                    if sec<10 then
                      time=time..":0"..sec
                    else
                      time=time..":"..sec
                    end
                  end
                  local failt=format(pssicombatin_damageinfo[pssichose1][q1][q2][1][i],pssicombatin_damageinfo[pssichose1][q1][q2][3][i])
                  if spellnametocut and string.len(spellnametocut)>2 then
                    if string.find(failt,spellnametocut..":") and string.find(failt,spellnametocut..":")==1 then
                      local s1,s2=string.find(failt,spellnametocut..":")
                      if s2 then
                        failt=">"..string.sub(failt, s2+1)
                      end
                    elseif string.find(failt,spellnametocut.." %s:") and string.find(failt,spellnametocut.." %s:")==1 then
                      local s1,s2=string.find(failt,spellnametocut.." %s:")
                      if s2 then
                        failt="%s >"..string.sub(failt, s2+1)
                      end
                    elseif string.find(failt,spellnametocut.." #") and string.find(failt,spellnametocut.." #")==1 then
                      local s1,s2=string.find(failt,spellnametocut.." #")
                      if s2 then
                        local oka=0
                        if string.find(failt,":") and string.find(failt,":")<s2+4 then
                          local nr=string.sub(failt,s2+1,string.find(failt,":")-1)
                          failt="#"..nr.." >"..string.sub(failt, string.find(failt,":")+1)
                          oka=1
                        end
                        if string.find(failt,",") and string.find(failt,",")<s2+2 and oka==0 then
                          local nr=string.sub(failt,s2+1,string.find(failt,",")-1)
                          failt="#"..nr.." >"..string.sub(failt, string.find(failt,":")+1)
                        end
                      end
                    end
                  end
                  if pssavedinfocheckexport[2]==0 and pssavedinfocheckexport[1]==1 then --только если цвета откл но красный вкл
                    while string.find(failt,"|cffff0000") do
                      if string.find(failt,"|cffff0000") then
                        local zx=string.find(failt,"|cffff0000")
                        failt=string.sub(failt,1,zx-1).."[color=red][B]"..string.sub(failt,zx+10)
                        if string.find(failt,"|r",zx) then
                          failt=string.sub(failt,1,string.find(failt,"|r",zx)-1).."[/B][/color]"..string.sub(failt,string.find(failt,"|r",zx)+2)
                        end
                      end
                    end
                    while string.find(failt,"|cff00ff00") do
                      if string.find(failt,"|cff00ff00") then
                        local zx=string.find(failt,"|cff00ff00")
                        failt=string.sub(failt,1,zx-1).."[color=green][B]"..string.sub(failt,zx+10)
                        if string.find(failt,"|r",zx) then
                          failt=string.sub(failt,1,string.find(failt,"|r",zx)-1).."[/B][/color]"..string.sub(failt,string.find(failt,"|r",zx)+2)
                        end
                      end
                    end
                  end
                  failt=psrestorelinksforexport(failt)
                  --
                  if i==maxnick then
                    psstrochka=psstrochka..time.."  "..failt.."\n\n"
                  else
                    psstrochka=psstrochka..time.."  "..failt.."\n"
                  end
                end
              end
            end --стандарт тип боя
          end
	--3 енда закрыть листание боев, и фейлов
        end
      end
    end

    if pssavedinfocheckexport[2]==1 then
      --все меняем в цвете --смена ТОЛЬКО красного и зеленого будет по ходу создания текста если эта откл

      local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372","|cff00ff00","|cffff0000","|CFFFFFF00","|cff71d5ff","|cff999999"}
      local tablecolor2={"#C79C6E","#C41F3B","#F58CBA","#FFFFFF","#0070DE","#FF7D0A","#FFF569","#69CCF0","#9482C9","#ABD473","green","red","orange","black","grey"}
      for i=1,#tablecolor do
        psstrochka=string.gsub(psstrochka, tablecolor[i], "[color="..tablecolor2[i].."]")
      end
      psstrochka=string.gsub(psstrochka, "|r", "[/color]")
    else
      --откл, но вырезать цвета нужно
      local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372","|cff00ff00","|cffff0000","|CFFFFFF00","|cff71d5ff","|cff999999"}
      for i=1,#tablecolor do
        psstrochka=string.gsub(psstrochka, tablecolor[i], "")
      end
      psstrochka=string.gsub(psstrochka, "|r", "")
    end
    --если отключены ссылки то нужно удалить всю хрень с ИД и НПЦ
    if pssavedinfocheckexport[3]==0 then
      psstrochka=psrestorelinksforexport2(psstrochka)
    end
    if pssavedinfocheckexport[4]==1 then
      psstrochka=psstrochka.."</div>[/html]"
    end
    pssavedinfotextframe1:SetText(psstrochka)
    pssavedinfotextframe1:HighlightText(0,string.len(psstrochka))
    pssavedinfotextframe1:SetFocus()
  else
    pssavedinfotextframe1:SetText(pcicccombat4)
  end
end
end


function PSFdonatef()
PSF_closeallpr()
PSFthanks2:Show()

if PSFthanksdrawd2==nil then
PSFthanksdrawd2=1
local t = PSFthanks2:CreateFontString()
t:SetWidth(700)
t:SetHeight(475)
t:SetFont(GameFontNormal:GetFont(), 14)
t:SetPoint("TOPLEFT",20,-20)
t:SetText("Thanks to everyone who's been helping to improve this addon!\n\n\nUnfortunately, I don't raid anymore and i don't spend much time in-game.\nI don't have much time to maintain this addon but i'm trying to find some.\n\n|cff00ff00if you want to thank me for the work i'm doing, please help me to update and support it. More information you will get on official addon site.|r Don't expect someone else to help...")
t:SetJustifyH("LEFT")
t:SetJustifyV("TOP")


t2 = PSFthanks2:CreateFontString()
t2:SetWidth(700)
t2:SetHeight(475)
t2:SetFont(GameFontNormal:GetFont(), 14)
t2:SetPoint("TOPLEFT",270,-150)
t2:SetText("|CFFFFFF00Support development!|r\n\n|cff00ff00Click  Ctrl+C  to copy|r")
t2:SetJustifyH("LEFT")
t2:SetJustifyV("TOP")

psdonatefr2 = CreateFrame("ScrollFrame", "psdonatefr2", PSFthanks2, "UIPanelScrollFrameTemplate")
psdonatefr2:SetPoint("TOPLEFT", PSFthanks2, "TOPLEFT", 240, -205)
psdonatefr2:SetHeight(100)
psdonatefr2:SetWidth(200)

psdonateeb2 = CreateFrame("EditBox", "psdonateeb2", psdonatefr2)
psdonateeb2:SetPoint("TOPRIGHT", psdonatefr2, "TOPRIGHT", 0, 0)
psdonateeb2:SetPoint("TOPLEFT", psdonatefr2, "TOPLEFT", 0, 0)
psdonateeb2:SetPoint("BOTTOMRIGHT", psdonatefr2, "BOTTOMRIGHT", 0, 0)
psdonateeb2:SetPoint("BOTTOMLEFT", psdonatefr2, "BOTTOMLEFT", 0, 0)
psdonateeb2:SetScript("onescapepressed", function(self) psdonateeb2:ClearFocus() end)
psdonateeb2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
psdonateeb2:SetMultiLine()
psdonateeb2:SetAutoFocus(false)
psdonateeb2:SetHeight(150)
psdonateeb2:SetWidth(185)
psdonateeb2:Show()
psdonateeb2:SetScript("OnTextChanged", function(self) psdonateeb2:SetText("http://www.phoenixstyle.com") psdonateeb2:HighlightText(0,string.len(psdonateeb2:GetText())) end )

psdonatefr2:SetScrollChild(psdonateeb2)
psdonatefr2:Show()

end

psdonateeb2:SetText("http://www.phoenixstyle.com")
psdonateeb2:HighlightText(0,string.len(psdonateeb2:GetText()))
psdonateeb2:SetFocus()


end




function psrestorelinksforexport(frase)
if pssavedinfocheckexport[3]==1 then
  if psadditionalsiteprefix==nil then
    psadditionalsiteprefix=""
    if GetLocale()=="deDE" then
      psadditionalsiteprefix="de."
    elseif GetLocale()=="ruRU" then
      psadditionalsiteprefix="ru."
    elseif GetLocale()=="frFR" then
      psadditionalsiteprefix="fr."
    elseif GetLocale()=="esES" or GetLocale()=="esMX" then
      psadditionalsiteprefix="es."
    elseif GetLocale()=="ptBR" then
      psadditionalsiteprefix="pt."
    end
  end
  
      if string.find(frase,"|s4id") and string.find(frase,"|id") then
        while string.find(frase,"|s4id") do
          local spellid=string.sub(frase,string.find(frase,"|s4id")+5,string.find(frase,"|id")-1)
          local spelln=GetSpellInfo(spellid)
          if spelln==nil then
            spelln="[URL=http://phoenixstyle.com]"..psiccunknown.."[/URL]"
          else
            spelln="[URL=http://"..psadditionalsiteprefix.."wowhead.com/spell="..spellid.."]"..spelln.."[/URL]"
          end
          frase=string.sub(frase,1,string.find(frase,"|s4id")-1)..spelln..string.sub(frase,string.find(frase,"|id")+3)
        end
      end
      if string.find(frase,"|snpc") and string.find(frase,"|fnpc") then
        while string.find(frase,"|snpc") do
          local aaaa=string.find(frase,"|snpc")
          if aaaa==nil then
            aaaa=1
          end
          frase=string.sub(frase,1,string.find(frase,"|snpc")-1).."[URL=http://"..psadditionalsiteprefix.."wowhead.com/npc="..string.sub(frase,string.find(frase,"%^",aaaa)+1,string.find(frase,"|fnpc")-1).."]"..string.sub(frase,string.find(frase,"|snpc")+5,string.find(frase,"%^",aaaa)-1).."[/URL]"..string.sub(frase,string.find(frase,"|fnpc")+5)
        end
      end
      return frase
else
  return frase
end
end

function psrestorelinksforexport2(frase,aslink) --если линки не нужны избавиться от лишнего текста  
      if string.find(frase,"|s4id") and string.find(frase,"|id") then
        while string.find(frase,"|s4id") do
          local spellid=string.sub(frase,string.find(frase,"|s4id")+5,string.find(frase,"|id")-1)
          local spelln=GetSpellInfo(spellid)
          if spelln==nil then
            spelln=psiccunknown
          end
          if aslink and aslink==1 then
            frase=string.sub(frase,1,string.find(frase,"|s4id")-1).."["..spelln.."]"..string.sub(frase,string.find(frase,"|id")+3)
          elseif aslink and aslink==2 then
            frase=string.sub(frase,1,string.find(frase,"|s4id")-1).."\124cff71d5ff\124Hspell:"..spellid.."\124h["..spelln.."]\124h\124r"..string.sub(frase,string.find(frase,"|id")+3)
          else
            frase=string.sub(frase,1,string.find(frase,"|s4id")-1)..spelln..string.sub(frase,string.find(frase,"|id")+3)
          end
        end
      end
      if string.find(frase,"|snpc") and string.find(frase,"|fnpc") then
        while string.find(frase,"|snpc") do
          local aaaa=string.find(frase,"|snpc")
          if aaaa==nil then
            aaaa=1
          end
          frase=string.sub(frase,1,string.find(frase,"|snpc")-1)..string.sub(frase,string.find(frase,"|snpc")+5,string.find(frase,"%^",aaaa)-1)..string.sub(frase,string.find(frase,"|fnpc")+5)
        end
      end
      return frase
end


function psgetdbmverbig(txt) --return 4.10.5 as 4010005
local ret=0
              local a1=string.find(txt,"%.")
              if a1 then
                local a2=string.find(txt,"%.",a1+1)
                if a2 then
                  local a31=string.find(txt," ",a2+1)
                  local a32=string.find(txt,")",a2+1)
                  local a3=0
                  if a31==nil and a32 then
                    a3=a32
                  end
                  if a32==nil and a31 then
                    a3=a31
                  end
                  if a31 and a32 then
                    if a31<a32 then
                      a3=a31
                    else
                      a3=a32
                    end
                  end
                  if a3 then
                  --нашли все 3 точки
                    local currdbm=string.sub(txt,3,a1-1)
                    local b1=string.sub(txt,a1+1,a2-1)
                    local b2=string.sub(txt,a2+1,a3-1)
                    if string.len(b1)==1 then
                      currdbm=currdbm.."00"..b1
                    elseif string.len(b1)==2 then
                      currdbm=currdbm.."0"..b1
                    else
                      currdbm=currdbm..b1
                    end

                    if string.len(b2)==1 then
                      currdbm=currdbm.."00"..b2
                    elseif string.len(b2)==2 then
                      currdbm=currdbm.."0"..b2
                    else
                      currdbm=currdbm..b2
                    end
                    currdbm=tonumber(currdbm)
                    if string.find(string.lower(txt),"alpha") or string.find(string.lower(txt),"beta") then
                      currdbm=currdbm-1
                    end
                    ret=1
                    return currdbm
                  end
                end
              end
if ret==0 then
  return 0
end
end