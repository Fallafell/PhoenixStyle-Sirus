function psiccdmgshow(play,ar1,ar2,ar3)
if pssavedinfotextframe1 then
if ar1==nil or ar2==nil then
pssavedinfotextframe1:SetText(pcicccombat4)
else

pssavedinfotextframe1:SetText(" ")

--определяем тип боя
if (pssidamageinf_indexboss[play][ar1][ar2]>0 and pssidamageinf_indexboss[play][ar1][ar2]<9) or pssidamageinf_indexboss[play][ar1][ar2]==44 then

if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids")==nil then
local loaded, reason = LoadAddOn("PhoenixStyleMod_CataMiniRaids")
if loaded then
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
else
print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." PhoenixStyleMod_CataMiniRaids!")
pssavedinfotextframe1:SetText(pserroronloadindmoddmgshow..": PhoenixStyleMod_CataMiniRaids")
end
end

if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids") then
psdamageshow_cmr(play,ar1,ar2,ar3)
end

end

--определяем тип боя
if (pssidamageinf_indexboss[play][ar1][ar2]>199 and pssidamageinf_indexboss[play][ar1][ar2]<399) then

--if IsAddOnLoaded("PhoenixStyleMod_Firelands")==nil then
--local loaded, reason = LoadAddOn("PhoenixStyleMod_Firelands")
--if loaded then
--print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
--else
--print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." PhoenixStyleMod_Firelands!")
--pssavedinfotextframe1:SetText(pserroronloadindmoddmgshow..": PhoenixStyleMod_Firelands")
--end
--end

--if IsAddOnLoaded("PhoenixStyleMod_Firelands") then
--psdamageshow_2(play,ar1,ar2,ar3)
--end

if IsAddOnLoaded("PhoenixStyleMod_DragonSoul")==nil then
local loaded, reason = LoadAddOn("PhoenixStyleMod_DragonSoul")
if loaded then
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
else
print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." PhoenixStyleMod_DragonSoul!")
pssavedinfotextframe1:SetText(pserroronloadindmoddmgshow..": PhoenixStyleMod_DragonSoul")
end
end

if IsAddOnLoaded("PhoenixStyleMod_DragonSoul") then
psdamageshow_3(play,ar1,ar2,ar3)
end

end


end
end
end



function psciccreportdmgshown(chat,play,ar1,ar2,ar3,reptype,quant,zapusk)
PSFmainfrainsavedinfo_edbox2:ClearFocus()
if ar1==nil then ar1=pssichose2 end
if ar2==nil then ar2=pssichose4 end
if ar3==nil then ar3=pssichose5 end

if ar1 and ar2 then

if (pssidamageinf_indexboss[play][ar1][ar2]>0 and pssidamageinf_indexboss[play][ar1][ar2]<9) or pssidamageinf_indexboss[play][ar1][ar2]==44 then
if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids") then
psdamagerep_cmr(chat,play,ar1,ar2,ar3,reptype,quant,zapusk)
end
end

--if (pssidamageinf_indexboss[play][ar1][ar2]>199 and pssidamageinf_indexboss[play][ar1][ar2]<299) then
--if IsAddOnLoaded("PhoenixStyleMod_Firelands") then
--psdamagerep_2(chat,play,ar1,ar2,ar3,reptype,quant,zapusk)
--end
--end

if (pssidamageinf_indexboss[play][ar1][ar2]>199 and pssidamageinf_indexboss[play][ar1][ar2]<399) then
if IsAddOnLoaded("PhoenixStyleMod_DragonSoul") then
psdamagerep_3(chat,play,ar1,ar2,ar3,reptype,quant,zapusk)
end
end


end
end




--инфо по ходу боя







function ps_stringadstimesort()
local vzxnn= #ps_stringadsname
while vzxnn>1 do
if ps_stringadstime[vzxnn]<ps_stringadstime[vzxnn-1] then
local vezaxtemp1=ps_stringadstime[vzxnn-1]
local vezaxtemp2=ps_stringadsname[vzxnn-1]
ps_stringadstime[vzxnn-1]=ps_stringadstime[vzxnn]
ps_stringadsname[vzxnn-1]=ps_stringadsname[vzxnn]
ps_stringadstime[vzxnn]=vezaxtemp1
ps_stringadsname[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end





function psiccdmgshow2(play,ar1,ar2,starthl,endhl)
if pssavedinfotextframe1 then

PSFmainfrainsavedinfo_slid1:Show()
PSFmainfrainsavedinfo_slid2:Show()
PSFmainfrainsavedinfo_edbox2:Show()
psisicombattypeduring1:Show()
psisicombattypeduring2:Show()
psisicombattypeduring3:Show()
psisicombattypeduring4:Show()
psisicombattypeduring5:Show()



if PSFmainfrainsavedinfo_Button1:IsShown()==nil and PSFmainfrainsavedinfo_Button2:IsShown()==nil and PSFmainfrainsavedinfo_Button3:IsShown()==nil and PSFmainfrainsavedinfo_Button4:IsShown()==nil then
PSFmainfrainsavedinfo_edbox2:SetText("")
PSFmainfrainsavedinfo_Button1:Show()
PSFmainfrainsavedinfo_Button2:Show()
end


pssavedinfotextframe1:ClearFocus()
if ar1==nil or ar2==nil then

pssavedinfotextframe1:SetText(pcicccombat4)
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

else

if ar2 then
ar2=ar2-1
end

local hl1=0
local hl2=0

pssavedinfotextframe1:SetText(" ")

		local text=""
		local _, month, day, year = CalendarGetDate()
		if month<10 then month="0"..month end
		if day<10 then day="0"..day end
		--if year>2000 then year=year-2000 end
		local text=month.."/"..day.."/"..year

if starthl then

if pssisavedbossinfo[play][ar1][2] and string.find(pssisavedbossinfo[play][ar1][2],text) then
	local aa1=pssisavedbossinfo[play][ar1][1]..", "..string.sub(pssisavedbossinfo[play][ar1][2],1,string.find(pssisavedbossinfo[play][ar1][2],",")-1)
	table.insert(pspartoftextofkicks,"PS: "..aa1.." - "..pspartreploc)
else
	table.insert(pspartoftextofkicks,"PS: "..pssisavedbossinfo[play][ar1][1]..", "..pssisavedbossinfo[play][ar1][2].." - "..pspartreploc)
end
end

--определяем тип боя, если 0, в хронологическом порядке (новый)
if pssicombatin_indexboss[play][ar1][ar2+1] and ar2==0 then

local psstrochka=""




if pssisavedbossinfo[play][ar1][2] and string.find(pssisavedbossinfo[play][ar1][2],text) then
  local aa1=pssisavedbossinfo[play][ar1][1]..", "..string.sub(pssisavedbossinfo[play][ar1][2],1,string.find(pssisavedbossinfo[play][ar1][2],",")-1)
	psstrochka="|CFFFFFF00PS: "..aa1..", "..psallinhronic.."|r\n\r"
else
	psstrochka="|CFFFFFF00PS: "..pssisavedbossinfo[play][ar1][1]..", "..pssisavedbossinfo[play][ar1][2].." - "..psallinhronic.."|r\n\r"
end


ps_stringadsname=nil
ps_stringadstime=nil
ps_stringadsname={}
ps_stringadstime={}
local ad=0


for i=1,#pssicombatin_damageinfo[play][ar1] do
	if pssicombatin_damageinfo[play][ar1][i][1] and #pssicombatin_damageinfo[play][ar1][i][1]>0 then
		for j=1,#pssicombatin_damageinfo[play][ar1][i][1] do
      if pssicombatin_indexboss[play][ar1][i] and pssicombatin_indexboss[play][ar1][i]==666 then
        table.insert(ps_stringadsname,"|cffff0000"..psdreventdeath1..":|r "..format(pssicombatin_damageinfo[play][ar1][i][1][j],pssicombatin_damageinfo[play][ar1][i][3][j]))
        table.insert(ps_stringadstime,pssicombatin_damageinfo[play][ar1][i][2][j])
        ps_stringadstimesort()
      else
        local ev=psrestorelinksforexport2(pssicombatin_damageinfo[play][ar1][i][1][j])
        table.insert(ps_stringadsname,format(ev,pssicombatin_damageinfo[play][ar1][i][3][j]))
        table.insert(ps_stringadstime,pssicombatin_damageinfo[play][ar1][i][2][j])
        ps_stringadstimesort()
      end
		end
	end
end

if starthl==nil then
psstopcheckslid12=GetTime()
getglobal("PSFmainfrainsavedinfo_slid1High"):SetText(#ps_stringadsname)
getglobal("PSFmainfrainsavedinfo_slid1Low"):SetText("1")
if #ps_stringadsname>0 then
PSFmainfrainsavedinfo_slid1:SetMinMaxValues(1, #ps_stringadsname)
else
PSFmainfrainsavedinfo_slid1:SetMinMaxValues(1, 1)
end
PSFmainfrainsavedinfo_slid1:SetValueStep(1)
PSFmainfrainsavedinfo_slid1:SetValue(1)

getglobal("PSFmainfrainsavedinfo_slid2High"):SetText(#ps_stringadsname)
getglobal("PSFmainfrainsavedinfo_slid2Low"):SetText("1")
if #ps_stringadsname>0 then
PSFmainfrainsavedinfo_slid2:SetMinMaxValues(1, #ps_stringadsname)
else
PSFmainfrainsavedinfo_slid2:SetMinMaxValues(1, 1)
end
PSFmainfrainsavedinfo_slid2:SetValueStep(1)
PSFmainfrainsavedinfo_slid2:SetValue(#ps_stringadsname)
psslidincomb12()
end

for i=1,#ps_stringadsname do
local time=""
local ltime=math.ceil(ps_stringadstime[i])
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

ad=ad+1
local ad2=""
if ad<10 then
	ad2="0"..ad
else
	ad2=ad
end

if starthl and ad>=starthl and ad<=endhl then
	table.insert(pspartoftextofkicks,time.."  ("..ad2..") "..ps_stringadsname[i])
	if hl1==0 then
		hl1=string.len(psstrochka)
	end
end


if i==#ps_stringadstime then
	psstrochka=psstrochka.."|CFFFFFF00"..time.."|r  ("..ad2..") "..ps_stringadsname[i]
	pssavedinfotextframe1:SetText(psstrochka)
else
	psstrochka=psstrochka.."|CFFFFFF00"..time.."|r  ("..ad2..") "..ps_stringadsname[i].."\n"
end

if starthl and ad>=starthl and ad<=endhl then
	hl2=string.len(psstrochka)
end

end



ps_stringadsname=nil
ps_stringadstime=nil

end



--тип боя стандартный, просто вывод инфо
if ar2>0 and pssicombatin_indexboss[play][ar1][ar2]>0 and pssicombatin_indexboss[play][ar1][ar2]<10000 then

local psstrochka=""
local ev=psrestorelinksforexport2(pssicombatin_title2[play][ar1][ar2])

if pssisavedbossinfo[play][ar1][2] and string.find(pssisavedbossinfo[play][ar1][2],text) then
  local aa1=pssisavedbossinfo[play][ar1][1]..", "..string.sub(pssisavedbossinfo[play][ar1][2],1,string.find(pssisavedbossinfo[play][ar1][2],",")-1)
	psstrochka="|CFFFFFF00PS: "..aa1..", "..ev.."|r\n\r"
else
	psstrochka="|CFFFFFF00PS: "..pssisavedbossinfo[play][ar1][1]..", "..pssisavedbossinfo[play][ar1][2]..", "..ev.."|r\n\r"
end



local maxnick=#pssicombatin_damageinfo[play][ar1][ar2][1]


if #pssicombatin_damageinfo[play][ar1][ar2][1]>0 then

if starthl==nil then
psstopcheckslid12=GetTime()
getglobal("PSFmainfrainsavedinfo_slid1High"):SetText(pssicombatin_damageinfo[play][ar1][ar2][3][#pssicombatin_damageinfo[play][ar1][ar2][3]])
getglobal("PSFmainfrainsavedinfo_slid1Low"):SetText("1")
local num=1
if pssicombatin_damageinfo[play][ar1][ar2][3][#pssicombatin_damageinfo[play][ar1][ar2][3]]>0 then
	num=pssicombatin_damageinfo[play][ar1][ar2][3][#pssicombatin_damageinfo[play][ar1][ar2][3]]
end
PSFmainfrainsavedinfo_slid1:SetMinMaxValues(1, num)
PSFmainfrainsavedinfo_slid1:SetValueStep(1)
PSFmainfrainsavedinfo_slid1:SetValue(1)

getglobal("PSFmainfrainsavedinfo_slid2High"):SetText(num)
getglobal("PSFmainfrainsavedinfo_slid2Low"):SetText("1")
local num=1
if pssicombatin_damageinfo[play][ar1][ar2][3][#pssicombatin_damageinfo[play][ar1][ar2][3]]>0 then
	num=pssicombatin_damageinfo[play][ar1][ar2][3][#pssicombatin_damageinfo[play][ar1][ar2][3]]
end
PSFmainfrainsavedinfo_slid2:SetMinMaxValues(1, num)
PSFmainfrainsavedinfo_slid2:SetValueStep(1)
PSFmainfrainsavedinfo_slid2:SetValue(num)
psslidincomb12()
end


for i = 1,maxnick do

local time=""
local ltime=math.ceil(pssicombatin_damageinfo[play][ar1][ar2][2][i])
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

local spellnametocut=""
if string.find(pssicombatin_title2[play][ar1][ar2],"|s4id") and string.find(pssicombatin_title2[play][ar1][ar2],"|id") then
  spellnametocut=GetSpellInfo(string.sub(pssicombatin_title2[play][ar1][ar2],string.find(pssicombatin_title2[play][ar1][ar2],"|s4id")+5,string.find(pssicombatin_title2[play][ar1][ar2],"|id")-1))
end

if starthl and pssicombatin_damageinfo[play][ar1][ar2][3][i]>=starthl and pssicombatin_damageinfo[play][ar1][ar2][3][i]<=endhl then
	table.insert(pspartoftextofkicks,time.."  "..format(pssicombatin_damageinfo[play][ar1][ar2][1][i],pssicombatin_damageinfo[play][ar1][ar2][3][i]))
	if hl1==0 then
		hl1=string.len(psstrochka)
	end
end

local ev=pssicombatin_damageinfo[play][ar1][ar2][1][i]

                  if spellnametocut and string.len(spellnametocut)>2 then
                    if string.find(ev,spellnametocut..":") and string.find(ev,spellnametocut..":")==1 then
                      local s1,s2=string.find(ev,spellnametocut..":")
                      if s2 then
                        ev=">"..string.sub(ev, s2+1)
                      end
                    elseif string.find(ev,spellnametocut.." %s:") and string.find(ev,spellnametocut.." %s:")==1 then
                      local s1,s2=string.find(ev,spellnametocut.." %s:")
                      if s2 then
                        ev="%s >"..string.sub(ev, s2+1)
                      end
                    elseif string.find(ev,spellnametocut.." #") and string.find(ev,spellnametocut.." #")==1 then
                      local s1,s2=string.find(ev,spellnametocut.." #")
                      if s2 then
                        local oka=0
                        if string.find(ev,":") and string.find(ev,":")<s2+3 then
                          local nr=string.sub(ev,s2+1,string.find(ev,":")-1)
                          ev="#"..nr.." >"..string.sub(ev, string.find(ev,":")+1)
                          oka=1
                        end
                        if string.find(ev,",") and string.find(ev,",")<s2+2 and oka==0 then
                          local nr=string.sub(ev,s2+1,string.find(ev,",")-1)
                          ev="#"..nr.." >"..string.sub(ev, string.find(ev,":")+1)
                        end
                      end
                    end
                  end
                  
                  ev=psrestorelinksforexport2(ev)

if i==maxnick then
	psstrochka=psstrochka.."|CFFFFFF00"..time.."|r  "..format(ev,pssicombatin_damageinfo[play][ar1][ar2][3][i])
	--я ХЗ ЧТО ЭТО!
	--if #pssidamageinf_indexboss[ar1][ar2]>1 then
	--	for tg=2,#pssidamageinf_indexboss[play][ar1][ar2] do

  --    local aa1=pssisavedbossinfo[play][ar1][1]..", "..string.sub(pssisavedbossinfo[play][ar1][2],1,string.find(pssisavedbossinfo[play][ar1][2],",")-1)
	--		if tg==2 then
	--			psstrochka=psstrochka.."\n\r"..aa1
	--		else
	--			psstrochka=psstrochka.."\n"..aa1
	--		end
	--	end
	--end
	pssavedinfotextframe1:SetText(psstrochka)
else
	psstrochka=psstrochka.."|CFFFFFF00"..time.."|r  "..format(ev,pssicombatin_damageinfo[play][ar1][ar2][3][i]).."\n"
end


if starthl and pssicombatin_damageinfo[play][ar1][ar2][3][i]>=starthl and pssicombatin_damageinfo[play][ar1][ar2][3][i]<=endhl then
	hl2=string.len(psstrochka)
end


end

end



end --стандарт тип боя


--другие типы боя



--вывод инфо
if starthl then
	if hl1>0 and hl2>0 and hl2>hl1 then
		pssavedinfotextframe1:HighlightText(hl1,hl2)
	end
end


--блокировка 2го слайдера!
if starthl==nil then
PSFmainfrainsavedinfo_slid2:Disable()
psisicombattypeduring5:SetText("|cffff0000"..psincombaddtxtlocal5.."|r")
end


end
end
end




function psciccreportdmgshown2(chat,play,ar1,ar2,reptype,partrep)
PSFmainfrainsavedinfo_edbox2:ClearFocus()

if ar1 and ar2 then
ar2=ar2-1

local tablerep={}

--репорт в хронологическом порядке:
if partrep==nil then

psiccdmgshow2(pssichose1,pssichose2,pssichose4)
local a=pssavedinfotextframe1:GetText()
--убираем: цвета классов, зеленый, красный, желтый, \r \n
if string.find(a,"\r") then
	while string.find(a,"\r") do
		a=string.sub(a,1,string.find(a,"\r")-1)..string.sub(a,string.find(a,"\r")+1)
	end
end

local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372","|cff00ff00","|cffff0000","|CFFFFFF00","|cff999999"}
for km=1,#tablecolor do
	if string.find (a, tablecolor[km]) then
		while string.find (a, tablecolor[km]) do
			a=string.sub(a,1,string.find (a, tablecolor[km])-1)..string.sub(a,string.find (a, tablecolor[km])+10)
		end
	end
end

local b=""


if string.find(a, "|r") then
	while string.find(a, "|r") do
		local aa1=string.find(a, "|r")
		local aa2=string.find(a, "|h")
		if aa2 and aa2<aa1 then
			b=b..string.sub(a,1,string.find (a, "|r")+1)
			a=string.sub(a,string.find (a, "|r")+2)
		else
			b=b..string.sub(a,1,string.find (a, "|r")-1)
			a=string.sub(a,string.find (a, "|r")+2)
		end
	end
	b=b..a
	a=""
end


a=b


--пихаем по таблицам
if a and string.len(a)>1 then
	while string.len(a)>1 do
		if string.find(a,"\n") then
			table.insert(tablerep,string.sub(a,1,string.find(a,"\n")-1))
			a=string.sub(a,string.find(a,"\n")+1)
		else
			table.insert(tablerep,a)
			a=""
		end
	end
end






end



--репорт части с хрон порядка
if ar2>=0 and partrep then

if PSFmainfrainsavedinfo_slid2:GetValue()>=PSFmainfrainsavedinfo_slid1:GetValue() then

if pspartoftextofkicks and #pspartoftextofkicks>0 then
	for i=1,#pspartoftextofkicks do
		local a=pspartoftextofkicks[i]
		local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372","|cff00ff00","|cffff0000","|CFFFFFF00","|cff999999"}
		for km=1,#tablecolor do
			if string.find (a, tablecolor[km]) then
				while string.find (a, tablecolor[km]) do
					a=string.sub(a,1,string.find (a, tablecolor[km])-1)..string.sub(a,string.find (a, tablecolor[km])+10)
				end
			end
		end
		if string.find(a, "|r") then
			while string.find(a, "|r") do
				a=string.sub(a,1,string.find (a, "|r")-1)..string.sub(a,string.find (a, "|r")+2)
			end
		end
		table.insert(tablerep,a)
	end
else
psciccreportdmgshown2(pssichatrepdef,psiccinc1,psiccinc2,reptype)
end

end


end



if #tablerep<=10 or (#tablerep>10 and psreportmorethenline15 and GetTime()<psreportmorethenline15+15) then

	if reptype then
		if reptype==1 then
			pssendchatmsg(chat,tablerep)
		end
		if reptype==2 then
			pssendchatmsg("whisper",tablerep,PSFmainfrainsavedinfo_edbox2:GetText())
		end
	end
psreportmorethenline15=nil
else
out("|cff99ffffPhoenixStyle|r - |cffff0000"..psattention.."|r "..format(psreportingmanylines,#tablerep))
psreportmorethenline15=GetTime()
end



end
end




function psafterdelaysta2(mobid)

local psstrochka=""

if pssavedinfocheckexport[4]==1 then
  psstrochka=psstrochka.."[html] <div style=\"background:#070707;border:1px solid #333;padding:15px;\">"
end

psstrochka=psstrochka.."PhoenixStyle - "..pssaveityperep3

if mobid and pssidamageinf_indexboss[pssichose1][pssichose2][pssichose4] and pssidamageinf_indexboss[pssichose1][pssichose2][pssichose4]==mobid and pssidamageinf_title2[pssichose1][pssichose2][pssichose4] and string.find(pssidamageinf_title2[pssichose1][pssichose2][pssichose4],"|snpc") then
  --получаем имя моба и ссылку!
  local evname=string.sub(pssidamageinf_title2[pssichose1][pssichose2][pssichose4],string.find(pssidamageinf_title2[pssichose1][pssichose2][pssichose4],"|snpc"),string.find(pssidamageinf_title2[pssichose1][pssichose2][pssichose4],"|fnpc")+4)
  evname=psrestorelinksforexport(evname)
  evname=psrestorelinksforexport2(evname)
  psstrochka=psstrochka.." (|cff00ff00"..psmainonly.."|r "..evname..")"
end


local text=""
local _, month, day, year = CalendarGetDate()
if month<10 then month="0"..month end
if day<10 then day="0"..day end
--if year>2000 then year=year-2000 end
text=month.."/"..day.."/"..year
if pssisavedbossinfo[pssichose1] and #pssisavedbossinfo[pssichose1]>0 then
  local maxcomb=#pssisavedbossinfo[pssichose1]
  if psicccombatexport==0 then
    psstrochka=psstrochka.." ("..pssavediexportopt6..", "..text.."):"
    maxcomb=0
    for o=1,#pssisavedbossinfo[pssichose1] do
      if string.find(pssisavedbossinfo[pssichose1][o][2],text) then
        maxcomb=maxcomb+1
      end
    end
  else
    psstrochka=psstrochka..":"
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
        bosstitle="\n\n\r"..a1..pssisavedbossinfo[pssichose1][q1][1].." ("..pssisavedbossinfo[pssichose1][q1][3]..")"..addtime..a2.."\n\n"
			end

			--урон листаем, если урона нет - босса не пишем ? если урона нет в евенте - не пишем ? босса пишем ток когда находим евент с уроном
			if pssidamageinf_indexboss[pssichose1][q1] and #pssidamageinf_indexboss[pssichose1][q1]>0 then
				for q2=1,#pssidamageinf_indexboss[pssichose1][q1] do
          local addemptyline=""
          if q2~=1 then
            addemptyline="\n\n"
          end
          --определяем в каком модуле инфо обсчитывать
          if (((pssidamageinf_indexboss[pssichose1][q1][q2]>0 and pssidamageinf_indexboss[pssichose1][q1][q2]<9) or pssidamageinf_indexboss[pssichose1][q1][q2]==44) and (mobid==nil or mobid and mobid==pssidamageinf_indexboss[pssichose1][q1][q2])) then
            --катамини рейдс
              if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids")==nil then
                local loaded, reason = LoadAddOn("PhoenixStyleMod_CataMiniRaids")
                if loaded then
                  print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
                else
                  print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." PhoenixStyleMod_CataMiniRaids!")
                  pssavedinfotextframe1:SetText(pserroronloadindmoddmgshow..": PhoenixStyleMod_CataMiniRaids")
                end
              end
              if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids") then
                local m1,m2=psdamageshow_cmr_allmerge(pssichose1,q1,q2,pssichose5,bosstitle,addemptyline)
                psstrochka=psstrochka..m1
                bosstitle=m2
              end
          end
            --драгонсоул
          if (pssidamageinf_indexboss[pssichose1][q1][q2]>199 and pssidamageinf_indexboss[pssichose1][q1][q2]<399 and (mobid==nil or (mobid and pssidamageinf_indexboss[pssichose1][q1][q2]==mobid))) then
              if IsAddOnLoaded("PhoenixStyleMod_DragonSoul")==nil then
              local loaded, reason = LoadAddOn("PhoenixStyleMod_DragonSoul")
                if loaded then
                  print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
                else
                  print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." PhoenixStyleMod_DragonSoul!")
                  pssavedinfotextframe1:SetText(pserroronloadindmoddmgshow..": PhoenixStyleMod_DragonSoul")
                end
              end
              if IsAddOnLoaded("PhoenixStyleMod_DragonSoul") then
                local m1,m2=psdamageshow_3_allmerge(pssichose1,q1,q2,pssichose5,bosstitle,addemptyline)
                psstrochka=psstrochka..m1
                bosstitle=m2
              end
          end
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