function psmoddmg_addinfodmg(arg4,dmg2,attacks,ii)

local bililine=0
for i,getcrash in ipairs(pssidamageinf_damageinfo[pssavedplayerpos][1][ii][1]) do
	if getcrash == arg4 then
		pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2][i]=pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2][i]+dmg2
		pssidamageinf_damageinfo[pssavedplayerpos][1][ii][3][i]=pssidamageinf_damageinfo[pssavedplayerpos][1][ii][3][i]+attacks
		bililine=1
	end
end
if(bililine==0)then
	table.insert(pssidamageinf_damageinfo[pssavedplayerpos][1][ii][1],arg4) 
	table.insert(pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2],dmg2)
	table.insert(pssidamageinf_damageinfo[pssavedplayerpos][1][ii][3],attacks)
end


end

function psmoddmg_sortinfodmg(ii)
local vzxnnw=#pssidamageinf_damageinfo[pssavedplayerpos][1][ii][1]
while vzxnnw>1 do
if pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2][vzxnnw]>pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2][vzxnnw-1] then
local a1=pssidamageinf_damageinfo[pssavedplayerpos][1][ii][1][vzxnnw-1]
local a2=pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2][vzxnnw-1]
local a3=pssidamageinf_damageinfo[pssavedplayerpos][1][ii][3][vzxnnw-1]
pssidamageinf_damageinfo[pssavedplayerpos][1][ii][1][vzxnnw-1]=pssidamageinf_damageinfo[pssavedplayerpos][1][ii][1][vzxnnw]
pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2][vzxnnw-1]=pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2][vzxnnw]
pssidamageinf_damageinfo[pssavedplayerpos][1][ii][3][vzxnnw-1]=pssidamageinf_damageinfo[pssavedplayerpos][1][ii][3][vzxnnw]
pssidamageinf_damageinfo[pssavedplayerpos][1][ii][1][vzxnnw]=a1
pssidamageinf_damageinfo[pssavedplayerpos][1][ii][2][vzxnnw]=a2
pssidamageinf_damageinfo[pssavedplayerpos][1][ii][3][vzxnnw]=a3
end
vzxnnw=vzxnnw-1
end
end


function psaddclasscolors()
local psgrups=5
if GetInstanceDifficulty()==1 or GetInstanceDifficulty()==3 then
psgrups=2
end

for i=1,GetNumRaidMembers() do
	local psname, _, pssubgroup = GetRaidRosterInfo(i)
	if pssubgroup <= psgrups then
		table.insert(pssidamageinf_classcolor[pssavedplayerpos][1][1],psname)

		local rsccodeclass=0
		if string.len (psname)>42 then
      psname=string.sub(psname,1,string.find(psname,"%-")-1)
    end
		local _, rsctekclass = UnitClass(psname)
			if rsctekclass then
				rsctekclass=string.lower(rsctekclass)

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
else rsccodeclass=12 --хз кто!
end
			else
        rsccodeclass=12
			end
		table.insert(pssidamageinf_classcolor[pssavedplayerpos][1][2],rsccodeclass)
	end
end

end