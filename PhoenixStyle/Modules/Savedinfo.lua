function psbutclickedsavedinfo()
--открыть фрейм просто
local curframe=0
if PSFmainfrainsavedinfo:IsShown() then
  curframe=1
end
PSF_closeallpr()
PSFmainfrainsavedinfo:Show()
PSFmain2_Button71:SetAlpha(0.3)


if pssavedinfoframecreate132==nil then
  pssavedinfoframecreate132=GetTime()
  pscreatesavedinfoframes()
end


--доп настройки кнопка:
if pssavedinfomorebutton==1 then
  PSFmainfrainsavedinfo_Combatsvd1:Show()
  PSFmainfrainsavedinfo_Buttonmore:SetText(pssavedibutmore2)
  psiccbytimtxtd2:Show()
  pssavedinfscrollfr:SetWidth(505)
  pssavedinfotextframe1:SetWidth(505)
  PSFmainfrainsavedinfo_Buttonreset2:Show()
  PSFmainfrainsavedinfo_Buttonreset3:Show()
  psiccbytimtxtd3:Show()
  for i=1,#pssavediexportcheckbut do
    pssavediexportcheckbut[i]:Show()
    pssavediexportchecktxt[i]:Show()
  end
  psiccbytimtxtd4:Show()
  PSFmainfrainsavedinfo_Combatsvd2:Show()
  PSFmainfrainsavedinfo_Buttonexport:Show()

  PSFmainfrainsavedinfo_RadioButton1:Show()
  PSFmainfrainsavedinfo_RadioButton2:Show()
  PSFmainfrainsavedinfo_RadioButton3:Show()

else
  PSFmainfrainsavedinfo_Combatsvd1:Hide()
  PSFmainfrainsavedinfo_Buttonmore:SetText(pssavedibutmore1)
  psiccbytimtxtd2:Hide()
  pssavedinfscrollfr:SetWidth(695)
  pssavedinfotextframe1:SetWidth(695)
  PSFmainfrainsavedinfo_Buttonreset2:Hide()
  PSFmainfrainsavedinfo_Buttonreset3:Hide()
  psiccbytimtxtd3:Hide()
  for i=1,#pssavediexportcheckbut do
    pssavediexportcheckbut[i]:Hide()
    pssavediexportchecktxt[i]:Hide()
  end
  psiccbytimtxtd4:Hide()
  PSFmainfrainsavedinfo_Combatsvd2:Hide()
  PSFmainfrainsavedinfo_Buttonexport:Hide()
  PSFmainfrainsavedinfo_RadioButton1:Hide()
  PSFmainfrainsavedinfo_RadioButton2:Hide()
  PSFmainfrainsavedinfo_RadioButton3:Hide()
  
  

end--доп настройка кнопка



--инфа обновляется только если фрейм не открыт еще
--запуск отображения инфы

if curframe==0 then

--переменные при открытии обнуляются
pssichose1=nil --ник
pssichose2=nil --босс
pssichose3=nil --тип репорта 1 2 3
pssichose4=nil --евент
pssavedinfotextframe1:SetText("")
opensiquantname()
opensiplayers()
opensilogchat()
pspaneldownreload(pssichose3)


--psreloadinfoafterdropdown()

pspreviousbeforeshutdown=nil



end


end
























function pscreatesavedinfoframes()




PSFmainfrainsavedinfo_edbox2:SetScript("OnTextChanged", function(self) if string.len(PSFmainfrainsavedinfo_edbox2:GetText())>1 then PSFmainfrainsavedinfo_Button2:Show() PSFmainfrainsavedinfo_Button1:Hide() if pssichose3 and pstableofcurrentevents[pssichose3]==pssaveityperep1 then PSFmainfrainsavedinfo_Button4:Show() PSFmainfrainsavedinfo_Button3:Hide() end else PSFmainfrainsavedinfo_Button2:Hide() PSFmainfrainsavedinfo_Button1:Show() if pssichose3 and pstableofcurrentevents[pssichose3]==pssaveityperep1 then PSFmainfrainsavedinfo_Button3:Show() PSFmainfrainsavedinfo_Button4:Hide() end end end )

pssavedinfscrollfr = CreateFrame("ScrollFrame", "pssavedinfscrollfr", PSFmainfrainsavedinfo, "UIPanelScrollFrameTemplate")
pssavedinfscrollfr:SetPoint("TOPLEFT", PSFmainfrainsavedinfo, "TOPLEFT", 20, -80)
pssavedinfscrollfr:SetHeight(280)
pssavedinfscrollfr:SetWidth(695)

pssavedinfotextframe1 = CreateFrame("EditBox", "pssavedinfotextframe1", PSFmainfrainsavedinfo)
pssavedinfotextframe1:SetPoint("TOPRIGHT", pssavedinfscrollfr, "TOPRIGHT", 0, 0)
pssavedinfotextframe1:SetPoint("TOPLEFT", pssavedinfscrollfr, "TOPLEFT", 0, 0)
pssavedinfotextframe1:SetPoint("BOTTOMRIGHT", pssavedinfscrollfr, "BOTTOMRIGHT", 0, 0)
pssavedinfotextframe1:SetPoint("BOTTOMLEFT", pssavedinfscrollfr, "BOTTOMLEFT", 0, 0)
pssavedinfotextframe1:SetScript("onescapepressed", function(self) pssavedinfotextframe1:ClearFocus() end)
pssavedinfotextframe1:SetFont(GameFontNormal:GetFont(), psfontsset[2])
pssavedinfotextframe1:SetMultiLine()
pssavedinfotextframe1:SetAutoFocus(false)
pssavedinfotextframe1:SetHeight(655)
pssavedinfotextframe1:SetWidth(695)
pssavedinfotextframe1:Show()
pssavedinfotextframe1:SetText(" ")

pssavedinfscrollfr:SetScrollChild(pssavedinfotextframe1)
pssavedinfscrollfr:Show()



--5 txt for titles and quantity of drop down
pssidropdownquantity1 = PSFmainfrainsavedinfo:CreateFontString()
pssidropdownquantity1:SetWidth(200)
pssidropdownquantity1:SetHeight(40)
pssidropdownquantity1:SetFont(GameFontNormal:GetFont(), psfontsset[2])
pssidropdownquantity1:SetPoint("TOPLEFT",-31,-20)
pssidropdownquantity1:SetJustifyH("CENTER")
pssidropdownquantity1:SetJustifyV("TOP")
pssidropdownquantity1:SetText(pssaveditit1)

pssidropdownquantity2 = PSFmainfrainsavedinfo:CreateFontString()
pssidropdownquantity2:SetWidth(200)
pssidropdownquantity2:SetHeight(40)
pssidropdownquantity2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
pssidropdownquantity2:SetPoint("TOPLEFT",95,-20)
pssidropdownquantity2:SetJustifyH("CENTER")
pssidropdownquantity2:SetJustifyV("TOP")
pssidropdownquantity2:SetText(pssaveditit2)

pssidropdownquantity3 = PSFmainfrainsavedinfo:CreateFontString()
pssidropdownquantity3:SetWidth(310)
pssidropdownquantity3:SetHeight(40)
pssidropdownquantity3:SetFont(GameFontNormal:GetFont(), psfontsset[2])
pssidropdownquantity3:SetPoint("TOPLEFT",170,-20)
pssidropdownquantity3:SetJustifyH("CENTER")
pssidropdownquantity3:SetJustifyV("TOP")
pssidropdownquantity3:SetText(pssaveditit3)

pssidropdownquantity4 = PSFmainfrainsavedinfo:CreateFontString()
pssidropdownquantity4:SetWidth(420)
pssidropdownquantity4:SetHeight(40)
pssidropdownquantity4:SetFont(GameFontNormal:GetFont(), psfontsset[2])
pssidropdownquantity4:SetPoint("TOPLEFT",252,-20)
pssidropdownquantity4:SetJustifyH("CENTER")
pssidropdownquantity4:SetJustifyV("TOP")
pssidropdownquantity4:SetText(pssaveditit4)

pssidropdownquantity5 = PSFmainfrainsavedinfo:CreateFontString()
pssidropdownquantity5:SetWidth(420)
pssidropdownquantity5:SetHeight(40)
pssidropdownquantity5:SetFont(GameFontNormal:GetFont(), psfontsset[2])
pssidropdownquantity5:SetPoint("TOPLEFT",363,-20)
pssidropdownquantity5:SetJustifyH("CENTER")
pssidropdownquantity5:SetJustifyV("TOP")
pssidropdownquantity5:SetText(pssaveditit5..":")



--txt & slider
psiccbytimtxtd2 = PSFmainfrainsavedinfo:CreateFontString()
psiccbytimtxtd2:SetWidth(260)
psiccbytimtxtd2:SetHeight(40)
psiccbytimtxtd2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
psiccbytimtxtd2:SetPoint("TOPLEFT",512,-70)
psiccbytimtxtd2:SetJustifyH("CENTER")
psiccbytimtxtd2:SetJustifyV("TOP")

getglobal("PSFmainfrainsavedinfo_Combatsvd1High"):SetText("40")
getglobal("PSFmainfrainsavedinfo_Combatsvd1Low"):SetText("3")
PSFmainfrainsavedinfo_Combatsvd1:SetMinMaxValues(3, 40)
PSFmainfrainsavedinfo_Combatsvd1:SetValueStep(1)
PSFmainfrainsavedinfo_Combatsvd1:SetValue(psicccombatsavedreport)
psicccombqcha2()

local v = PSFmainfrainsavedinfo:CreateFontString()
v:SetWidth(550)
v:SetHeight(20)
v:SetFont(GameFontNormal:GetFont(), 13)
v:SetPoint("TOPLEFT",25,-428)
v:SetJustifyH("LEFT")
v:SetJustifyV("TOP")
v:SetText(psiccwhispertxt)

local s = PSFmainfrainsavedinfo:CreateFontString()
s:SetWidth(550)
s:SetHeight(20)
s:SetFont(GameFontNormal:GetFont(), 13)
s:SetPoint("TOPLEFT",25,-377)
s:SetJustifyH("LEFT")
s:SetJustifyV("TOP")
s:SetText(psiccwhispertxt2)


pssavedinfotextframe2 = PSFmainfrainsavedinfo:CreateFontString()
pssavedinfotextframe2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
pssavedinfotextframe2:SetJustifyH("LEFT")
pssavedinfotextframe2:SetJustifyV("BOTTOM")
pssavedinfotextframe2:SetPoint("BOTTOMLEFT",20,140)


--експорт текст скрытый
psiccbytimtxtd3 = PSFmainfrainsavedinfo:CreateFontString()
psiccbytimtxtd3:SetWidth(200)
psiccbytimtxtd3:SetHeight(40)
psiccbytimtxtd3:SetFont(GameFontNormal:GetFont(), 15)
psiccbytimtxtd3:SetPoint("TOPLEFT",540,-135)
psiccbytimtxtd3:SetJustifyH("CENTER")
psiccbytimtxtd3:SetJustifyV("TOP")
psiccbytimtxtd3:SetText("|cff00ff00"..pssavediexporttext..":|r")


--настройки для експорта
pssavediexportcheckbut={}
pssavediexportchecktxt={}
local tab1={pssavediexportopt01,pssavediexportopt1,pssavediexportopt2,pssavediexportopt3}


--создание текста и чекбаттонов
for i=1,#tab1 do
	--чекбатон
	local c = CreateFrame("CheckButton", nil, PSFmainfrainsavedinfo, "UICheckButtonTemplate")
	c:SetWidth("25")
	c:SetHeight("25")
	c:SetPoint("TOPLEFT", 550, -130-22*i)
	c:SetScript("OnClick", function(self) if pssavedinfocheckexport[i]==1 then pssavedinfocheckexport[i]=0 else pssavedinfocheckexport[i]=1 end end )
	if pssavedinfocheckexport[i]==1 then
		c:SetChecked()
	else
		c:SetChecked(false)
	end
	table.insert(pssavediexportcheckbut, c)


	--текст
	local t = PSFmainfrainsavedinfo:CreateFontString()
	t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
	t:SetWidth(165)
	t:SetHeight(45)
  t:SetText(tab1[i])
	t:SetJustifyH("LEFT")
	t:SetJustifyV("CENTER")
  t:SetPoint("TOPLEFT", 575, -120-22*i)
	table.insert(pssavediexportchecktxt,t)
end

--доп фигня для експорта
--txt & slider for EXPORT
psiccbytimtxtd4 = PSFmainfrainsavedinfo:CreateFontString()
psiccbytimtxtd4:SetWidth(260)
psiccbytimtxtd4:SetHeight(40)
psiccbytimtxtd4:SetFont(GameFontNormal:GetFont(), psfontsset[2])
psiccbytimtxtd4:SetPoint("TOPLEFT",512,-250)
psiccbytimtxtd4:SetJustifyH("CENTER")
psiccbytimtxtd4:SetJustifyV("TOP")

getglobal("PSFmainfrainsavedinfo_Combatsvd2High"):SetText("40")
getglobal("PSFmainfrainsavedinfo_Combatsvd2Low"):SetText(pssavediexportopt6)
PSFmainfrainsavedinfo_Combatsvd2:SetMinMaxValues(0, 40)
PSFmainfrainsavedinfo_Combatsvd2:SetValueStep(1)
PSFmainfrainsavedinfo_Combatsvd2:SetValue(psicccombatexport)
psicccombqcha3()

--ыытест временно для смены версии
if pssaveexpradiobutset==0 then
  pssaveexpradiobutset=2
end
if pssaveexpradiobutset==1 then
  PSFmainfrainsavedinfo_RadioButton1:SetChecked(1)
  PSFmainfrainsavedinfo_RadioButton2:SetChecked(nil)
  PSFmainfrainsavedinfo_RadioButton3:SetChecked(nil)
elseif pssaveexpradiobutset==2 then
  PSFmainfrainsavedinfo_RadioButton1:SetChecked(nil)
  PSFmainfrainsavedinfo_RadioButton2:SetChecked(1)
  PSFmainfrainsavedinfo_RadioButton3:SetChecked(nil)
else
  PSFmainfrainsavedinfo_RadioButton1:SetChecked(nil)
  PSFmainfrainsavedinfo_RadioButton2:SetChecked(nil)
  PSFmainfrainsavedinfo_RadioButton3:SetChecked(1)
end

--для типа репорта по ходу боя
--5 текста
psisicombattypeduring1 = PSFmainfrainsavedinfo:CreateFontString()
psisicombattypeduring1:SetWidth(100)
psisicombattypeduring1:SetHeight(20)
psisicombattypeduring1:SetFont(GameFontNormal:GetFont(), 13)
psisicombattypeduring1:SetPoint("TOPLEFT",150,-377)
psisicombattypeduring1:SetJustifyH("CENTER")
psisicombattypeduring1:SetJustifyV("TOP")
psisicombattypeduring1:SetText(psincombaddtxtlocal1)

psisicombattypeduring2 = PSFmainfrainsavedinfo:CreateFontString()
psisicombattypeduring2:SetWidth(200)
psisicombattypeduring2:SetHeight(20)
psisicombattypeduring2:SetFont(GameFontNormal:GetFont(), 13)
psisicombattypeduring2:SetFont(GameFontNormal:GetFont(), 13)
psisicombattypeduring2:SetPoint("TOPLEFT",207,-377)
psisicombattypeduring2:SetJustifyH("CENTER")
psisicombattypeduring2:SetJustifyV("TOP")
psisicombattypeduring2:SetText(psincombaddtxtlocal2)

psisicombattypeduring3 = PSFmainfrainsavedinfo:CreateFontString()
psisicombattypeduring3:SetWidth(300)
psisicombattypeduring3:SetHeight(20)
psisicombattypeduring3:SetFont(GameFontNormal:GetFont(), 13)
psisicombattypeduring3:SetPoint("TOPLEFT",395,-377)
psisicombattypeduring3:SetJustifyH("RIGHT")
psisicombattypeduring3:SetJustifyV("TOP")
psisicombattypeduring3:SetText(psincombaddtxtlocal3)

psisicombattypeduring4 = PSFmainfrainsavedinfo:CreateFontString()
psisicombattypeduring4:SetWidth(200)
psisicombattypeduring4:SetHeight(20)
psisicombattypeduring4:SetFont(GameFontNormal:GetFont(), 13)
psisicombattypeduring4:SetPoint("TOPLEFT",285,-405)
psisicombattypeduring4:SetJustifyH("RIGHT")
psisicombattypeduring4:SetJustifyV("TOP")
psisicombattypeduring4:SetText(psincombaddtxtlocal4)

psisicombattypeduring5 = PSFmainfrainsavedinfo:CreateFontString()
psisicombattypeduring5:SetWidth(200)
psisicombattypeduring5:SetHeight(20)
psisicombattypeduring5:SetFont(GameFontNormal:GetFont(), 13)
psisicombattypeduring5:SetPoint("TOPLEFT",285,-445)
psisicombattypeduring5:SetJustifyH("RIGHT")
psisicombattypeduring5:SetJustifyV("TOP")
psisicombattypeduring5:SetText(psincombaddtxtlocal5)

--слайдеры по ходу боя
getglobal("PSFmainfrainsavedinfo_slid1High"):SetText("?")
getglobal("PSFmainfrainsavedinfo_slid1Low"):SetText("?")
PSFmainfrainsavedinfo_slid1:SetMinMaxValues(1, 1)
PSFmainfrainsavedinfo_slid1:SetValueStep(1)
PSFmainfrainsavedinfo_slid1:SetValue(1)

getglobal("PSFmainfrainsavedinfo_slid2High"):SetText("?")
getglobal("PSFmainfrainsavedinfo_slid2Low"):SetText("?")
PSFmainfrainsavedinfo_slid2:SetMinMaxValues(1, 1)
PSFmainfrainsavedinfo_slid2:SetValueStep(1)
PSFmainfrainsavedinfo_slid2:SetValue(1)
psslidincomb12()


end


function psicccombqcha2()
psicccombatsavedreport = PSFmainfrainsavedinfo_Combatsvd1:GetValue()
local text=psicctxtbysaved.." "..psicccombatsavedreport
psiccbytimtxtd2:SetText(text)
end
function psicccombqcha21()
psicccombatsavedreport = PSFmainoptionsps_Combatsvd1:GetValue()
local text=psicctxtbysaved.." "..psicccombatsavedreport
psiccbytimtxtd211:SetText(text)
end
function psicccombqcha22()
psicccombatsavedreport = PSFraidopt_Combatsvd1:GetValue()
local text=psicctxtbysaved.." "..psicccombatsavedreport
psiccbytimtxtd212:SetText(text)
end

function psicccombqcha3()
psicccombatexport = PSFmainfrainsavedinfo_Combatsvd2:GetValue()
local text=pssavediexportopt4..": "..psicccombatexport
if psicccombatexport==0 then
  text=pssavediexportopt4..": "..pssavediexportopt6
end
psiccbytimtxtd4:SetText(text)
end

function psslidincomb12(slid)
psisicombattypeduring2:SetText(format(psincombaddtxtlocal2,PSFmainfrainsavedinfo_slid1:GetValue(),PSFmainfrainsavedinfo_slid2:GetValue()))
local a1=PSFmainfrainsavedinfo_slid1:GetMinMaxValues()
local _,a4=PSFmainfrainsavedinfo_slid2:GetMinMaxValues()
if pspartoftextofkicks==nil then
	pspartoftextofkicks={}
end
table.wipe(pspartoftextofkicks)
pssavedinfotextframe1:HighlightText(0,0)
if a1~=PSFmainfrainsavedinfo_slid1:GetValue() or a4~=PSFmainfrainsavedinfo_slid2:GetValue() then
	if PSFmainfrainsavedinfo_slid1:GetValue()<=PSFmainfrainsavedinfo_slid2:GetValue() and GetTime()>psstopcheckslid12+0.3 then
		psiccdmgshow2(pssichose1,pssichose2,pssichose4,PSFmainfrainsavedinfo_slid1:GetValue(),PSFmainfrainsavedinfo_slid2:GetValue())
	end
end

if slid and slid==1 and PSFmainfrainsavedinfo_slid2:IsEnabled()==nil then
PSFmainfrainsavedinfo_slid2:Enable()
psisicombattypeduring5:SetText(psincombaddtxtlocal5)
end

end























function opensiplayers(notchange)
if not DropDownsiplayerchoose then
CreateFrame("Frame", "DropDownsiplayerchoose", PSFmainfrainsavedinfo, "UIDropDownMenuTemplate")
end

DropDownsiplayerchoose:ClearAllPoints()
DropDownsiplayerchoose:SetPoint("TOPLEFT", 0, -35)
DropDownsiplayerchoose:Show()

local table1={}

	if #pssisavedfailsplayern[2]>0 then
	for i=1,#pssisavedfailsplayern[2] do
		if pssisavedfailsplayern[2][i]==UnitGUID("player") then
      if pssichose1==nil then
        pssichose1=i
      end
			pssisavedfailsplayern[1][i]=UnitName("player").." - "..GetRealmName()
		end
	end
	end

  local num=0
	if #pssisavedfailsplayern[1]==0 then
		table1={pcicccombat4}
		num=0
	else
		for t=1,#pssisavedfailsplayern[1] do
			table.insert(table1,pssisavedfailsplayern[1][t])
			num=num+1
		end
	end

if pssichose1==nil then
  pssichose1=1
end



local items = table1
pssidropdownquantity1:SetText(pssaveditit1..", |cff00ff00"..num..":|r")


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownsiplayerchoose, self:GetID())

--if psiccsv1~=self:GetID() then
pssichose1=self:GetID()
pssichose2=nil
pssichose3=nil
pssichose4=nil
opensicombarchoose()


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

opensicombarchoose(notchange)

UIDropDownMenu_Initialize(DropDownsiplayerchoose, initialize)
UIDropDownMenu_SetWidth(DropDownsiplayerchoose, 85)
UIDropDownMenu_SetButtonWidth(DropDownsiplayerchoose, 105)
UIDropDownMenu_SetSelectedID(DropDownsiplayerchoose, pssichose1)
UIDropDownMenu_JustifyText(DropDownsiplayerchoose, "LEFT")
end









function opensicombarchoose(notchange)
if not DropDownsicombarchoose then
CreateFrame("Frame", "DropDownsicombarchoose", PSFmainfrainsavedinfo, "UIDropDownMenuTemplate")
end

DropDownsicombarchoose:ClearAllPoints()
DropDownsicombarchoose:SetPoint("TOPLEFT", 105, -35)
DropDownsicombarchoose:Show()


local num=0
local segodnya=0
local tab1={pcicccombat4}
if pssisavedbossinfo[pssichose1] and #pssisavedbossinfo[pssichose1]>0 then
	table.wipe(tab1)
	local text=""
	local _, month, day, year = CalendarGetDate()
	if month<10 then month="0"..month end
	if day<10 then day="0"..day end
	--if year>2000 then year=year-2000 end
	local text=month.."/"..day.."/"..year
	for o=1,#pssisavedbossinfo[pssichose1] do
    local trykill=""
    if pssisavedbossinfo[pssichose1][o][4] and string.len(pssisavedbossinfo[pssichose1][o][4])>1 then
      trykill=" "..pssisavedbossinfo[pssichose1][o][4]
    end
    local dateifneed=""
		if string.find(pssisavedbossinfo[pssichose1][o][2],text) then
      dateifneed=", "..string.sub(pssisavedbossinfo[pssichose1][o][2],1,string.find(pssisavedbossinfo[pssichose1][o][2],",")-1)
      segodnya=1
    else
      dateifneed=", "..pssisavedbossinfo[pssichose1][o][2]
    end
		table.insert(tab1,pssisavedbossinfo[pssichose1][o][1].." ("..pssisavedbossinfo[pssichose1][o][3]..")"..dateifneed..trykill)
		num=num+1
	end
end


--после загрузки сменять экспорт ползунок
local maxx=num
if maxx==0 then
  maxx=1
end
getglobal("PSFmainfrainsavedinfo_Combatsvd2High"):SetText(maxx)
if segodnya==1 then
getglobal("PSFmainfrainsavedinfo_Combatsvd2Low"):SetText(pssavediexportopt6)
PSFmainfrainsavedinfo_Combatsvd2:SetMinMaxValues(0, maxx)
else
getglobal("PSFmainfrainsavedinfo_Combatsvd2Low"):SetText(1)
PSFmainfrainsavedinfo_Combatsvd2:SetMinMaxValues(1, maxx)
end
PSFmainfrainsavedinfo_Combatsvd2:SetValueStep(1)
if psicccombatexport>maxx then
  psicccombatexport=maxx
end
PSFmainfrainsavedinfo_Combatsvd2:SetValue(psicccombatexport)
psicccombqcha3()



local items = tab1
pssidropdownquantity2:SetText(pssaveditit2..", |cff00ff00"..num..":|r")


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownsicombarchoose, self:GetID())


pssichose2=self:GetID()
local pssichosetemp3=pssichose3
pssichose3=nil
opensitypereport(nil,pssichosetemp3)
--opensieventchoose()
--psreloadinfoafterdropdown()

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

if pssichose2==nil and pssisavedbossinfo[pssichose1] and #pssisavedbossinfo[pssichose1]>0 then
  pssichose2=1
end

opensitypereport(notchange)

UIDropDownMenu_Initialize(DropDownsicombarchoose, initialize)
UIDropDownMenu_SetWidth(DropDownsicombarchoose, 130)
UIDropDownMenu_SetButtonWidth(DropDownsicombarchoose, 145)
if pssichose2 then
UIDropDownMenu_SetSelectedID(DropDownsicombarchoose, pssichose2)
else
UIDropDownMenu_SetSelectedID(DropDownsicombarchoose, 1)
end
UIDropDownMenu_JustifyText(DropDownsicombarchoose, "LEFT")
end





function opensitypereport(notchange,pssichosetemp3)
if not DropDownsityperepchoose then
CreateFrame("Frame", "DropDownsityperepchoose", PSFmainfrainsavedinfo, "UIDropDownMenuTemplate")
end

DropDownsityperepchoose:ClearAllPoints()
DropDownsityperepchoose:SetPoint("TOPLEFT", 255, -35)
DropDownsityperepchoose:Show()

psprevioustype=nil
--тут проверять на приоритет по выбраному боссу
if notchange==nil then
  --получаем инфо о предыдущем боссе если оно есть
  if pstableofcurrentevents and pssichosetemp3 then
    if pstableofcurrentevents[pssichosetemp3]==pssaveityperep1 then
      psprevioustype=pssaveityperep1
    end
    if pstableofcurrentevents[pssichosetemp3]==pssaveityperep2 then
      psprevioustype=pssaveityperep2
    end
    if pstableofcurrentevents[pssichosetemp3]==pssaveityperep3 then
      psprevioustype=pssaveityperep3
    end
  end
  pssichose3=1

end

--для апдейта по ходу боя смотрим евент что был выбран
incombupdtemp=0
if notchange and pstableofcurrentevents and #pstableofcurrentevents>0 and pstableofcurrentevents[pssichose3] then
  incombupdtemp=pstableofcurrentevents[pssichose3]
end



--поиск хотя бы одной смерти или 2го евента по ходу боя

pstableofcurrentevents={}

if (pssicombatin_indexboss[pssichose1] and pssicombatin_indexboss[pssichose1][pssichose2] and (pssicombatin_indexboss[pssichose1][pssichose2][2] or (pssicombatin_damageinfo[pssichose1][pssichose2][1] and pssicombatin_damageinfo[pssichose1][pssichose2][1][1] and pssicombatin_damageinfo[pssichose1][pssichose2][1][1][1]))) then
  table.insert(pstableofcurrentevents,pssaveityperep1)
end
if (pssisavedfailaftercombat[pssichose1] and pssisavedfailaftercombat[pssichose1][pssichose2] and pssisavedfailaftercombat[pssichose1][pssichose2][1] and pssisavedfailaftercombat[pssichose1][pssichose2][1] and string.len(pssisavedfailaftercombat[pssichose1][pssichose2][1])>1) then
  table.insert(pstableofcurrentevents,pssaveityperep2)
end
if (pssidamageinf_title2[pssichose1] and pssidamageinf_title2[pssichose1][pssichose2] and pssidamageinf_title2[pssichose1][pssichose2][1]) then
  table.insert(pstableofcurrentevents,pssaveityperep3)
end


  local num=#pstableofcurrentevents

  local tabforloc={}
  if #pstableofcurrentevents==0 then
    table.insert(tabforloc,pcicccombat4)
  else
    for r=1,#pstableofcurrentevents do
      table.insert(tabforloc,pstableofcurrentevents[r])
    end
  end
  

local items = tabforloc


pssidropdownquantity3:SetText(pssaveditit3..", |cff00ff00"..num..":|r")


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownsityperepchoose, self:GetID())

--if psiccsv1~=self:GetID() then
pssichose3=self:GetID()

--смена типа боя - смена нижней панельки
pspaneldownreload(pssichose3)

pssichose4=nil

if pstableofcurrentevents[pssichose3]==pssaveityperep2 then
psiccinfosvshow(pssichose1,pssichose2)
else
opensieventchoose()
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

--выбор типа по приоритету
if notchange==nil then
  if psprevioustype then
    if pstableofcurrentevents[1] and pstableofcurrentevents[1]==psprevioustype then
      pssichose3=1
    end
    if pstableofcurrentevents[2] and pstableofcurrentevents[2]==psprevioustype then
      pssichose3=2
    end
    if pstableofcurrentevents[3] and pstableofcurrentevents[3]==psprevioustype then
      pssichose3=3
    end
    if pssichose3==nil then
      pssichose3=1
    end
  else
    if pspreviousbeforeshutdown then
    --при закрытии фрейма посл выбранный евент
      if pstableofcurrentevents[1] and pstableofcurrentevents[1]==pspreviousbeforeshutdown then
        pssichose3=1
      end
      if pstableofcurrentevents[2] and pstableofcurrentevents[2]==pspreviousbeforeshutdown then
        pssichose3=2
      end
      if pstableofcurrentevents[3] and pstableofcurrentevents[3]==pspreviousbeforeshutdown then
        pssichose3=3
      end
    else
      pssichose3=1
    end
  end
end

--для апдейта по ходу боя
if incombupdtemp and notchange and incombupdtemp~=0 then
    if pstableofcurrentevents[1] and pstableofcurrentevents[1]==incombupdtemp then
      pssichose3=1
    end
    if pstableofcurrentevents[2] and pstableofcurrentevents[2]==incombupdtemp then
      pssichose3=2
    end
    if pstableofcurrentevents[3] and pstableofcurrentevents[3]==incombupdtemp then
      pssichose3=3
    end
end

if pssavedinfoframecreate132 and GetTime()>pssavedinfoframecreate132+1 then
  pspaneldownreload(pssichose3)
end

if #pstableofcurrentevents>0 and pstableofcurrentevents[pssichose3]==pssaveityperep2 then
  psiccinfosvshow(pssichose1,pssichose2)
else
  opensieventchoose(notchange)
end


incombupdtemp=nil

UIDropDownMenu_Initialize(DropDownsityperepchoose, initialize)
UIDropDownMenu_SetWidth(DropDownsityperepchoose, 95)
UIDropDownMenu_SetButtonWidth(DropDownsityperepchoose, 115)
UIDropDownMenu_SetSelectedID(DropDownsityperepchoose, pssichose3)
UIDropDownMenu_JustifyText(DropDownsityperepchoose, "LEFT")
end



function opensieventchoose(notchange)
if not DropDownsieventchoose then
CreateFrame("Frame", "DropDownsieventchoose", PSFmainfrainsavedinfo, "UIDropDownMenuTemplate")
end

DropDownsieventchoose:ClearAllPoints()
DropDownsieventchoose:SetPoint("TOPLEFT", 370, -35)
DropDownsieventchoose:Show()


local tab1={pcicccombat4}
local num=0

--проверка евентов
if pstableofcurrentevents[pssichose3]==pssaveityperep1 then
  --по ходу боя
  if pssichose1 and pssichose2 and pssicombatin_title2[pssichose1][pssichose2] and #pssicombatin_title2[pssichose1][pssichose2]>0 then
    table.wipe(tab1)
    table.insert(tab1,psallinhronic)
    num=num+1
    for o=1,#pssicombatin_title2[pssichose1][pssichose2] do
      --проверить и убрать с фразы |s4id777|id + |snpcNAME^777|fnpc
      local ev=pssicombatin_title2[pssichose1][pssichose2][o]
      if string.find(ev,"|s4id") and string.find(ev,"|id") then
        while string.find(ev,"|s4id") do
          local spelln=GetSpellInfo(string.sub(ev,string.find(ev,"|s4id")+5,string.find(ev,"|id")-1))
          if spelln==nil then
            spelln=psiccunknown
          end
          ev=string.sub(ev,1,string.find(ev,"|s4id")-1)..spelln..string.sub(ev,string.find(ev,"|id")+3)
        end
      end
      if string.find(ev,"|snpc") and string.find(ev,"|fnpc") then
        while string.find(ev,"|snpc") do
          local aaaa=string.find(ev,"|snpc")
          if aaaa==nil then
            aaaa=1
          end
          ev=string.sub(ev,1,string.find(ev,"|snpc")-1)..string.sub(ev,string.find(ev,"|snpc")+5,string.find(ev,"%^",aaaa)-1)..string.sub(ev,string.find(ev,"|fnpc")+5)
        end
      end
      table.insert(tab1,ev)
      num=num+1
    end
  end
elseif pstableofcurrentevents[pssichose3]==pssaveityperep2 then
  --после боя нету этого типа
elseif pstableofcurrentevents[pssichose3]==pssaveityperep3 then
  --данные об уроне
  if pssichose1 and pssichose2 and pssidamageinf_title2[pssichose1][pssichose2] and #pssidamageinf_title2[pssichose1][pssichose2]>0 then
    table.wipe(tab1)
    for o=1,#pssidamageinf_title2[pssichose1][pssichose2] do
      --проверить и убрать с фразы |s4id777|id + |snpcNAME^777|fnpc
      local ev=pssidamageinf_title2[pssichose1][pssichose2][o]
      if string.find(ev,"|s4id") and string.find(ev,"|id") then
        while string.find(ev,"|s4id") do
          local spelln=GetSpellInfo(string.sub(ev,string.find(ev,"|s4id")+5,string.find(ev,"|id")-1))
          if spelln==nil then
            spelln=psiccunknown
          end
          ev=string.sub(ev,1,string.find(ev,"|s4id")-1)..spelln..string.sub(ev,string.find(ev,"|id")+3)
        end
      end
      if string.find(ev,"|snpc") and string.find(ev,"|fnpc") then
        while string.find(ev,"|snpc") do
          local aaaa=string.find(ev,"|snpc")
          if aaaa==nil then
            aaaa=1
          end
          ev=string.sub(ev,1,string.find(ev,"|snpc")-1)..string.sub(ev,string.find(ev,"|snpc")+5,string.find(ev,"%^",aaaa)-1)..string.sub(ev,string.find(ev,"|fnpc")+5)
        end
      end
      table.insert(tab1,ev)
      num=num+1
    end
  end
end


local items = tab1
pssidropdownquantity4:SetText(pssaveditit4..", |cff00ff00"..num..":|r")


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownsieventchoose, self:GetID())


pssichose4=self:GetID()

--я сменил евент, записываю в табл предпочтений
local bil=0
if pssisavedbossinfo[pssichose1] and pssisavedbossinfo[pssichose1][pssichose2] and pssisavedbossinfo[pssichose1][pssichose2][1] and pssicombatin_indexboss[pssichose1] and pssicombatin_indexboss[pssichose1][pssichose2] and #pstableofcurrentevents>0 and pstableofcurrentevents[pssichose3]==pssaveityperep1 then
  if #pssiincombeventspririty[1]>0 then
    for l=1,#pssiincombeventspririty[1] do
      if pssiincombeventspririty[1][l]==pssisavedbossinfo[pssichose1][pssichose2][1] then
        bil=1
        if pssichose4~=1 then
          pssiincombeventspririty[2][l]=pssicombatin_indexboss[pssichose1][pssichose2][pssichose4-1]
        else
          pssiincombeventspririty[2][l]=0
        end
      end
    end
  end
  if bil==0 then
    table.insert(pssiincombeventspririty[1],pssisavedbossinfo[pssichose1][pssichose2][1])
    if pssichose4~=1 then
      table.insert(pssiincombeventspririty[2],pssicombatin_indexboss[pssichose1][pssichose2][pssichose4-1])
    else
      table.insert(pssiincombeventspririty[2],0)
    end
  end
end

psreloadinfoafterdropdown()


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


if notchange==nil or pssichose4==nil then
  pssichose4=1

  if pstableofcurrentevents[pssichose3]==pssaveityperep1 then
    --по ходу боя
    if pssichose1 and pssichose2 and pssicombatin_title2[pssichose1][pssichose2] and #pssicombatin_title2[pssichose1][pssichose2]>0 then
      pssichose4=#pssicombatin_title2[pssichose1][pssichose2]+1
      --а теперь по приоритету смотрим еще
      if #pssiincombeventspririty[1]>0 then
        for l=1,#pssiincombeventspririty[1] do
          if pssiincombeventspririty[1][l]==pssisavedbossinfo[pssichose1][pssichose2][1] then
            --босс есть, ищем есть ли евент
            if pssiincombeventspririty[2][l]==0 then
              pssichose4=1
            else
              for k=1,#pssicombatin_indexboss[pssichose1][pssichose2] do
                if pssicombatin_indexboss[pssichose1][pssichose2][k]==pssiincombeventspririty[2][l] then
                  pssichose4=k+1
                end
              end
            end
          end
        end
      end
    end
  elseif pstableofcurrentevents[pssichose3]==pssaveityperep2 then
    --после боя нету этого типа
  elseif pstableofcurrentevents[pssichose3]==pssaveityperep3 then
    --данные об уроне
    if pssichose1 and pssichose2 and pssidamageinf_title2[pssichose1][pssichose2] and #pssidamageinf_title2[pssichose1][pssichose2]>0 then
      pssichose4=#pssidamageinf_title2[pssichose1][pssichose2]
    end
  end
  
else
  if pssichose4==nil then
    pssichose4=1
  end
  local max=0
  --тоже самое но проверяет возможность выбора евента, тоесть макс. который доступен, для апдейта по ходу боя
  if pstableofcurrentevents[pssichose3]==pssaveityperep1 then
    --по ходу боя
    if pssichose1 and pssichose2 and pssicombatin_title2[pssichose1][pssichose2] and #pssicombatin_title2[pssichose1][pssichose2]>0 then
      max=#pssicombatin_title2[pssichose1][pssichose2]+1
    end
  elseif pstableofcurrentevents[pssichose3]==pssaveityperep2 then
    --после боя нету этого типа
  elseif pstableofcurrentevents[pssichose3]==pssaveityperep3 then
    --данные об уроне
    if pssichose1 and pssichose2 and pssidamageinf_title2[pssichose1][pssichose2] and #pssidamageinf_title2[pssichose1][pssichose2]>0 then
      max=#pssidamageinf_title2[pssichose1][pssichose2]
    end
  end
  if max==0 then
    pssichose4=1
  elseif pssichose4>max then
    pssichose4=max
  end
end



psreloadinfoafterdropdown()

UIDropDownMenu_Initialize(DropDownsieventchoose, initialize)
UIDropDownMenu_SetWidth(DropDownsieventchoose, 140)
UIDropDownMenu_SetButtonWidth(DropDownsieventchoose, 155)
UIDropDownMenu_SetSelectedID(DropDownsieventchoose, pssichose4)
UIDropDownMenu_JustifyText(DropDownsieventchoose, "LEFT")
end



function opensiquantname()
if not DropDownsiquantname then
CreateFrame("Frame", "DropDownsiquantname", PSFmainfrainsavedinfo, "UIDropDownMenuTemplate")
end

DropDownsiquantname:ClearAllPoints()
DropDownsiquantname:SetPoint("TOPLEFT", 530, -35)
DropDownsiquantname:Show()

local items = {psiccall, "5", "7", "10", "12", "15", "17", "20"}

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownsiquantname, self:GetID())

pssichose5=self:GetID()
psiccdmgshow(pssichose1,pssichose2,pssichose4,pssichose5)

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

if pssichose5==nil then
pssichose5=4
end

UIDropDownMenu_Initialize(DropDownsiquantname, initialize)
UIDropDownMenu_SetWidth(DropDownsiquantname, 40)
UIDropDownMenu_SetButtonWidth(DropDownsiquantname, 55)
UIDropDownMenu_SetSelectedID(DropDownsiquantname, pssichose5)
UIDropDownMenu_JustifyText(DropDownsiquantname, "LEFT")
end





function opensilogchat()
if not DropDownsilogchat then
CreateFrame("Frame", "DropDownsilogchat", PSFmainfrainsavedinfo, "UIDropDownMenuTemplate")
end

DropDownsilogchat:ClearAllPoints()
DropDownsilogchat:SetPoint("TOPLEFT", 10, -390)
DropDownsilogchat:Show()

local items = bigmenuchatlist

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownsilogchat, self:GetID())

if self:GetID()>8 then
pssichatrepdef=psfchatadd[self:GetID()-8]
else
pssichatrepdef=bigmenuchatlisten[self:GetID()]
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

bigmenuchat2(pssichatrepdef)
	if bigma2num==0 then
pssichatrepdef=bigmenuchatlisten[1]
bigma2num=1
	end

UIDropDownMenu_Initialize(DropDownsilogchat, initialize)
UIDropDownMenu_SetWidth(DropDownsilogchat, 110)
UIDropDownMenu_SetButtonWidth(DropDownsilogchat, 125)
UIDropDownMenu_SetSelectedID(DropDownsilogchat, bigma2num)
UIDropDownMenu_JustifyText(DropDownsilogchat, "LEFT")
end



function pssimorebuttons()
if pssavedinfomorebutton==1 then
  pssavedinfomorebutton=0
else
  pssavedinfomorebutton=1
end
psbutclickedsavedinfo()
end


function pspaneldownreload(pssichose3)
if #pstableofcurrentevents==0 then
  DropDownsiquantname:Hide() --дамадж дан
  pssidropdownquantity5:Hide()
end
--это всегда видно
PSFmainfrainsavedinfo_edbox2:Show()

if #pstableofcurrentevents>0 then
--убираем всю нижнюю панель и под цифру подставляем нужную
PSFmainfrainsavedinfo_Button3:Hide()
PSFmainfrainsavedinfo_Button4:Hide()
PSFmainfrainsavedinfo_Button1:Hide()
PSFmainfrainsavedinfo_Button2:Hide()

psisicombattypeduring1:Hide()
psisicombattypeduring2:Hide()
psisicombattypeduring3:Hide()
psisicombattypeduring4:Hide()
psisicombattypeduring5:Hide()
PSFmainfrainsavedinfo_slid1:Hide()
PSFmainfrainsavedinfo_slid2:Hide()


DropDownsiquantname:Hide() --дамадж дан
pssidropdownquantity5:Hide()

DropDownsieventchoose:Hide() --евентс нейм, для после боя оно не нада
pssidropdownquantity4:Hide()

if pssichose3 then
  if pstableofcurrentevents[pssichose3]==pssaveityperep1 then

if PSFmainfrainsavedinfo_edbox2:GetText() and string.len(PSFmainfrainsavedinfo_edbox2:GetText())>1 then
PSFmainfrainsavedinfo_Button2:Show()
PSFmainfrainsavedinfo_Button4:Show()
else
PSFmainfrainsavedinfo_Button1:Show()
PSFmainfrainsavedinfo_Button3:Show()
end
psisicombattypeduring1:Show()
psisicombattypeduring2:Show()
psisicombattypeduring3:Show()
psisicombattypeduring4:Show()
psisicombattypeduring5:Show()
PSFmainfrainsavedinfo_slid1:Show()
PSFmainfrainsavedinfo_slid2:Show()
DropDownsieventchoose:Show() --евентс нейм
pssidropdownquantity4:Show()
  
  end
  
  if pstableofcurrentevents[pssichose3]==pssaveityperep2 then
    if PSFmainfrainsavedinfo_edbox2:GetText() and string.len(PSFmainfrainsavedinfo_edbox2:GetText())>1 then
      PSFmainfrainsavedinfo_Button2:Show()
    else
      PSFmainfrainsavedinfo_Button1:Show()
    end
  end
  
  if pstableofcurrentevents[pssichose3]==pssaveityperep3 then
    DropDownsiquantname:Show() --дамадж дан
    pssidropdownquantity5:Show()
    DropDownsieventchoose:Show() --евентс нейм
    pssidropdownquantity4:Show()
    if PSFmainfrainsavedinfo_edbox2:GetText() and string.len(PSFmainfrainsavedinfo_edbox2:GetText())>1 then
      PSFmainfrainsavedinfo_Button2:Show()
    else
      PSFmainfrainsavedinfo_Button1:Show()
    end
  end
  
end

end
end



function pscreatesavedreports3(bosss,try)
if pssavedreportcreatedforcurfight==nil then
pssavedreportcreatedforcurfight=1

if bosss==nil then
  bosss=psiccunknown
end
  
  
--запись чара
local playedpos=0

if #pssisavedfailsplayern[2]>0 then
	for i=1,#pssisavedfailsplayern[2] do
		if pssisavedfailsplayern[2][i]==UnitGUID("player") then
			playedpos=i
			pssisavedfailsplayern[1][i]=UnitName("player").." - "..GetRealmName()
		end
	end
end

if playedpos==0 then
	table.insert(pssisavedfailsplayern[2],UnitGUID("player"))
	table.insert(pssisavedfailsplayern[1],UnitName("player").." - "..GetRealmName())
	playedpos=#pssisavedfailsplayern[2]
  --новый чар добавлен в каждом типа репорта создаем новую табл
  psaddtableinreports(1)
end

pssavedplayerpos=playedpos

--запись боя
table.insert(pssisavedbossinfo[playedpos],1,{})
table.insert(pssisavedbossinfo[playedpos][1],bosss)
--создав босса также создаем новую ячейку во всех табл
psaddtableinreports(2,playedpos)

local text2=""
if pstimeofcombatstart then
  text2=pstimeofcombatstart
else
  local _, month, day, year = CalendarGetDate()
  if month<10 then month="0"..month end
  if day<10 then day="0"..day end
  --if year>2000 then year=year-2000 end
  local h,m = GetGameTime()
  if h<10 then h="0"..h end
  if m<10 then m="0"..m end
  text2=h..":"..m..", "..month.."/"..day.."/"..year
end
table.insert(pssisavedbossinfo[playedpos][1],text2)
table.insert(pssisavedbossinfo[playedpos][1],psiccinst)

table.insert(pssisavedbossinfo[playedpos][1],"") --обычно неизвестно попытка или килл еще


--создание табл для репорта после боя!
--table.insert(pssisavedfailaftercombat[playedpos],1,{}) --после боя уже готова...



--создание табл для репорта в бою
	--table.insert(pssicombatin_indexboss[playedpos][1],1,{})
	--table.insert(pssicombatin_title2[playedpos][1],1,{})
	--table.insert(pssicombatin_damageinfo[playedpos][1],1,{})
	--psdmgresetinglastfight2()
	
	--тут создавать же новые евент для смертей
	table.insert(pssicombatin_indexboss[playedpos][1],666)
  table.insert(pssicombatin_title2[playedpos][1],psdreventname)
  table.insert(pssicombatin_damageinfo[playedpos][1],{{},{},{}})



--создание табл для репорта урона
  --вроде ок




--удаление всех табл что старше чем разрешено сохранять

if #pssisavedbossinfo[playedpos]>psicccombatsavedreport then
	for i=psicccombatsavedreport+1,#pssisavedbossinfo[playedpos] do
    pssisavedbossinfo[playedpos][i]=nil
    pssisavedfailaftercombat[playedpos][i]=nil
    pssicombatin_indexboss[playedpos][i]=nil
    pssicombatin_title2[playedpos][i]=nil
    pssicombatin_damageinfo[playedpos][i]=nil
    
    --дамаг табл тоже обнулять
    pssidamageinf_indexboss[playedpos][i]=nil
    pssidamageinf_title2[playedpos][i]=nil
    pssidamageinf_additioninfo[playedpos][i]=nil
    pssidamageinf_damageinfo[playedpos][i]=nil
    pssidamageinf_switchinfo[playedpos][i]=nil
    pssidamageinf_classcolor[playedpos][i]=nil
 	end
end


end
end


function psaddtableinreports(n,p)
if n==1 then
table.insert(pssisavedfailaftercombat,{})
table.insert(pssisavedbossinfo,{})

table.insert(pssicombatin_indexboss,{})
table.insert(pssicombatin_title2,{})
table.insert(pssicombatin_damageinfo,{})

table.insert(pssidamageinf_indexboss,{})
table.insert(pssidamageinf_title2,{})
table.insert(pssidamageinf_additioninfo,{})
table.insert(pssidamageinf_damageinfo,{})
table.insert(pssidamageinf_switchinfo,{})
table.insert(pssidamageinf_classcolor,{})
end


if n==2 then
table.insert(pssisavedfailaftercombat[p],1,{})

table.insert(pssicombatin_indexboss[p],1,{})
table.insert(pssicombatin_title2[p],1,{})
table.insert(pssicombatin_damageinfo[p],1,{})

table.insert(pssidamageinf_indexboss[p],1,{})
table.insert(pssidamageinf_title2[p],1,{})
table.insert(pssidamageinf_additioninfo[p],1,{})
table.insert(pssidamageinf_damageinfo[p],1,{})
table.insert(pssidamageinf_switchinfo[p],1,{})
table.insert(pssidamageinf_classcolor[p],1,{{},{}})
end
end

function pssavedinforeset(n)
if UnitAffectingCombat("player")==nil and UnitIsDeadOrGhost("player")==nil then
if n==1 then
--все вообще удаляем
    table.wipe(pssisavedfailsplayern)
    pssisavedfailsplayern={{},{}}
    
    pssisavedfailaftercombat={}
    table.wipe(pssisavedfailaftercombat)
    pssisavedbossinfo={}
    table.wipe(pssisavedbossinfo)
    
    pssicombatin_indexboss={}
    table.wipe(pssicombatin_indexboss)
    pssicombatin_title2={}
    table.wipe(pssicombatin_title2)
    pssicombatin_damageinfo={}
    table.wipe(pssicombatin_damageinfo)
    
    pssidamageinf_indexboss={}
    table.wipe(pssidamageinf_indexboss)
    pssidamageinf_title2={}
    table.wipe(pssidamageinf_title2)
    pssidamageinf_additioninfo={}
    table.wipe(pssidamageinf_additioninfo)
    pssidamageinf_damageinfo={}
    table.wipe(pssidamageinf_damageinfo)
    pssidamageinf_switchinfo={}
    table.wipe(pssidamageinf_switchinfo)
    pssidamageinf_classcolor={}
    table.wipe(pssidamageinf_classcolor)
elseif n==2 then
--тока по выбранному нику
  if pssichose1 then
    if pssisavedfailsplayern then
      table.remove(pssisavedfailsplayern[1],pssichose1)
      table.remove(pssisavedfailsplayern[2],pssichose1)
    end
    if pssisavedbossinfo[pssichose1] then
    
      table.wipe(pssisavedfailaftercombat[pssichose1])
      table.wipe(pssisavedbossinfo[pssichose1])
      
      table.wipe(pssicombatin_indexboss[pssichose1])
      table.wipe(pssicombatin_title2[pssichose1])
      table.wipe(pssicombatin_damageinfo[pssichose1])
      
      table.wipe(pssidamageinf_indexboss[pssichose1])
      table.wipe(pssidamageinf_title2[pssichose1])
      table.wipe(pssidamageinf_additioninfo[pssichose1])
      table.wipe(pssidamageinf_damageinfo[pssichose1])
      table.wipe(pssidamageinf_switchinfo[pssichose1])
      table.wipe(pssidamageinf_classcolor[pssichose1])
      
    end
    
    PSFmainfrainsavedinfo_edbox2:SetText("")
  end
elseif n==3 then
  --тока текущий бой
  if pssichose1 and pssichose2 then
    if pssisavedbossinfo[pssichose1] and pssisavedbossinfo[pssichose1][pssichose2] then
    
      table.remove(pssisavedfailaftercombat[pssichose1],pssichose2)
      table.remove(pssisavedbossinfo[pssichose1],pssichose2)
      
      table.remove(pssicombatin_indexboss[pssichose1],pssichose2)
      table.remove(pssicombatin_title2[pssichose1],pssichose2)
      table.remove(pssicombatin_damageinfo[pssichose1],pssichose2)
      
      table.remove(pssidamageinf_indexboss[pssichose1],pssichose2)
      table.remove(pssidamageinf_title2[pssichose1],pssichose2)
      table.remove(pssidamageinf_additioninfo[pssichose1],pssichose2)
      table.remove(pssidamageinf_damageinfo[pssichose1],pssichose2)
      table.remove(pssidamageinf_switchinfo[pssichose1],pssichose2)
      table.remove(pssidamageinf_classcolor[pssichose1],pssichose2)
      
    end
    PSFmainfrainsavedinfo_edbox2:SetText("")

end
end

if n~=3 then
  pssichose1=nil --ник
end

if n~=1 then
  pssichose2=nil --босс
  pssichose3=nil --тип репорта 1 2 3
  pssichose4=nil --евент
  pssavedinfotextframe1:SetText("")
  opensiquantname()
  opensiplayers()
  opensilogchat()
  pspaneldownreload(pssichose3)
end


else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..psiccnorezetincombat)
end
end


function psupdateframewithnewinfo()
if PSFmainfrainsavedinfo:IsShown() then
  opensiplayers(1)
end
end


function psreloadinfoafterdropdown()
--отображение инфы
pssavedinfotextframe1:SetText("")
--после боя
if pssichose3 and pstableofcurrentevents[pssichose3]==pssaveityperep2 then
  psiccinfosvshow(pssichose1,pssichose2)
end
--по ходу боя
if pssichose3 and pstableofcurrentevents[pssichose3]==pssaveityperep1 then
  psiccdmgshow2(pssichose1,pssichose2,pssichose4)
end
--урон
if pssichose3 and pstableofcurrentevents[pssichose3]==pssaveityperep3 then
  psiccdmgshow(pssichose1,pssichose2,pssichose4,pssichose5)
end

end


function pssireportbut(n)
--после боя
if pssichose3 and pstableofcurrentevents[pssichose3]==pssaveityperep2 then
  if n==1 then
    psiccsavedinforeport(1)
  end
  if n==2 then
    psiccsavedinforeport(2)
  end
end
--по ходу боя
if pssichose3 and pstableofcurrentevents[pssichose3]==pssaveityperep1 then
  if n==1 then
    psciccreportdmgshown2(pssichatrepdef,pssichose1,pssichose2,pssichose4,1)
  end
  if n==2 then
    psciccreportdmgshown2(pssichatrepdef,pssichose1,pssichose2,pssichose4,2)
  end
  if n==3 then
    psciccreportdmgshown2(pssichatrepdef,pssichose1,pssichose2,pssichose4,1,1)
  end
  if n==4 then
    psciccreportdmgshown2(pssichatrepdef,pssichose1,pssichose2,pssichose4,2,1)
  end
end
--урон
if pssichose3 and pstableofcurrentevents[pssichose3]==pssaveityperep3 then
  if n==1 then
    psciccreportdmgshown(pssichatrepdef,pssichose1,pssichose2,psiccdmg4,psiccdmg5,1,2)
  end
  if n==2 then
    psciccreportdmgshown(pssichatrepdef,pssichose1,pssichose2,psiccdmg4,psiccdmg5,2,2)
  end
end
end



function pssavedinfoexport()
--pssimorebuttons()
if pssaveexpradiobutset==1 then
  --только выбранное инфо
  if pstableofcurrentevents and #pstableofcurrentevents>0 and pssichose3 and pstableofcurrentevents[pssichose3] then
    if pstableofcurrentevents[pssichose3]==pssaveityperep1 then
      --по ходу боя експорт
      psincombatinfoallfights()
    end
    if pstableofcurrentevents[pssichose3]==pssaveityperep2 then
      --после боя експорт
      pssvinfoalltog() --nn не пишется так как напрямую получаем со слайдера
    end
    if pstableofcurrentevents[pssichose3]==pssaveityperep3 then
      --данные об уроне экспорт
      psincombatinfoallfights(1)
    end
  end
elseif pssaveexpradiobutset==2 then
  --все инфо вместе НОВОЕ
  out ("NOT YET READY (all info) - the last one missing.")
else
  --только выбранный ЕВЕНТ!
  if pstableofcurrentevents and #pstableofcurrentevents>0 and pssichose3 and pstableofcurrentevents[pssichose3] then
    if pstableofcurrentevents[pssichose3]==pssaveityperep1 then
      --по ходу боя експорт
      out ("NOT YET READY (in combat - choosen event)")
      psincombatinfoallfights(3)
    end
    if pstableofcurrentevents[pssichose3]==pssaveityperep2 then
      --после боя експорт
      pssvinfoalltog()
    end
    if pstableofcurrentevents[pssichose3]==pssaveityperep3 then
      --данные об уроне экспорт
      psincombatinfoallfights(2)
    end
  end
end
end