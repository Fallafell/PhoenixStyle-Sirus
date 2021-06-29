function psdeathrepevent(type,marksource,mark,name,guid,spellid,spellname,dmg,overkill,crit,whokill,resist,block,absorbed,spellschool)

--type: 0=death, 1 - instakill, 2 - ENVIRONMENTAL_DAMAGE, 10 - normal damage


local chatname=name
if chatname and string.find(chatname,"%-") then
  if string.find(chatname," %-") then
    chatname=string.sub(chatname,1,string.find(chatname," %-")-1)
  else
    chatname=string.sub(chatname,1,string.find(chatname,"%-")-1)
  end
end

--работать должно ТОЛЬКО в рейде или парти!
local inInstance, instanceType = IsInInstance()
if instanceType=="raid" or instanceType=="party" then

--табл для сохр килла
if pskillreport==nil then
  pskillreport={{},{},{},{}} --ник, фраза в ожидании, время записи, фраза для чата
end


--общие изменения
if dmg and overkill then
  dmg=dmg-overkill
end

local whokill2=""
if whokill==nil then
  whokill=""
else
  whokill2="[|cffff0000"..psgetmarkforchat(argNEW1)..whokill.."|r]"
  whokill="["..whokill.."]"
end

local crittxt1=""
local crittxt2=""
if crit then
  crittxt1="|cffff0000"..psdrcrit.."|r "
  crittxt2="|cffff0000"..psdrcrit.."|r "
end

local resisttxt1=""
--if resist or block or absorbed then
  if resist and resist>0 then
    resisttxt1=resisttxt1..psdeathrresist..": "..psdamageceildeathrep(resist)
  end
  if block and block>0 then
    if string.len(resisttxt1)>2 then
      resisttxt1=resisttxt1..", "
    end
    resisttxt1=resisttxt1..psdeathrblock..": "..psdamageceildeathrep(block)
  end
  if absorbed and absorbed>0 then
    if string.len(resisttxt1)>2 then
      resisttxt1=resisttxt1..", "
    end
    resisttxt1=resisttxt1..psdeathrabsorb..": "..psdamageceildeathrep(absorbed)
  end
--end
if string.len(resisttxt1)>2 then
  resisttxt1=", "..resisttxt1
end

local spellsk=""
if spellschool and spellname~="Melee" then
  if spellschool==1 then
    spellsk=psspellschoolm
  elseif spellschool==2 then
    spellsk=psspellschool1
  elseif spellschool==4 then
    spellsk=psspellschool2
  elseif spellschool==8 then
    spellsk=psspellschool3
  elseif spellschool==16 then
    spellsk=psspellschool4
  elseif spellschool==32 then
    spellsk=psspellschool5
  elseif spellschool==64 then
    spellsk=psspellschool6
  elseif spellschool==3 then
    spellsk="Holystrike"
  elseif spellschool==5 then
    spellsk="Flamestrike"
  elseif spellschool==6 then
    spellsk="Holyfire"
  elseif spellschool==9 then
    spellsk="Stormstrike"
  elseif spellschool==10 then
    spellsk="Holystorm"
  elseif spellschool==12 then
    spellsk="Firestorm"
  elseif spellschool==17 then
    spellsk="Froststrike"
  elseif spellschool==18 then
    spellsk="Holyfrost"
  elseif spellschool==20 then
    spellsk="Frostfire"
  elseif spellschool==24 then
    spellsk="Froststorm"
  elseif spellschool==33 then
    spellsk="Shadowstrike"
  elseif spellschool==34 then
    spellsk="Shadowlight (Twilight)"
  elseif spellschool==36 then
    spellsk="Shadowflame"
  elseif spellschool==40 then
    spellsk="Shadowstorm (Plague)"
  elseif spellschool==48 then
    spellsk="Shadowfrost"
  elseif spellschool==65 then
    spellsk="Spellstrike"
  elseif spellschool==66 then
    spellsk="Divine"
  elseif spellschool==68 then
    spellsk="Spellfire"
  elseif spellschool==72 then
    spellsk="Spellstorm"
  elseif spellschool==80 then
    spellsk="Spellfrost"
  elseif spellschool==96 then
    spellsk="Spellshadow"
  elseif spellschool==28 then
    spellsk="Elemental"
  elseif spellschool==124 then
    spellsk="Chromatic"
  elseif spellschool==126 then
    spellsk="Magic"
  elseif spellschool==127 then
    spellsk="Chaos"
  end
end
if string.len(spellsk)>2 then
  spellsk=" ("..spellsk..")"
end


--проверка на игрока в группе или пати
psunitisplayer(guid,name)
if psunitplayertrue and psunitraidorparty(guid,name) then
  --проверка что его смерть не анонсили в течении 3 сек
   
        local anonsed=0
        if type~=0 then
          if pskillreport and pskillreport[1] and #pskillreport[1]>0 then
            for hn=1,#pskillreport[1] do
              if pskillreport[1][hn]==name and GetTime()<=pskillreport[3][hn]+2 then
                anonsed=1
              end
            end
          end
        end
        
  --не анонсилось:
  if anonsed==0 then
    --if addedtab==0 and type==0 then
    --  table.insert(pslastdeath[1],name)
    --  local tm=GetTime()
    --  table.insert(pslastdeath[2],tm)
    --end
    --получение фразы для репорта!!!!!!!!!!!!! 1 - цветное

    --если смерть = репорт с таблицы или неизвестно, если же урон то запись в табл
    --нет запрета на анонс
    local notdeath=0
    if pslastdeath and pslastdeath[1] and #pslastdeath[1]>0 then
      for mm=1,#pslastdeath[1] do
        if pslastdeath[1][mm]==name and GetTime()<pslastdeath[2][mm] then
          notdeath=1
        end
      end
    end
    if type==0 then
      if notdeath==0 then
        local dontknow=0
        local txt1=psaddcolortxt(1,name)..name..psaddcolortxt(2,name).." > |cffff0000"..psiccunknown.."|r"
        local txt2="PS "..psdieddeathrep..": "..psgetmarkforchat(mark)..psaddcolortxt(1,chatname)..chatname..psaddcolortxt(2,chatname).." > "..psiccunknown
        if pskillreport and pskillreport[1] and #pskillreport[1]>0 then
          for hn=1,#pskillreport[1] do
            if name==pskillreport[1][hn] and GetTime()<pskillreport[3][hn]+8 then
              txt1=pskillreport[2][hn]
              txt2=pskillreport[4][hn]
              dontknow=1
            end
          end
        end
        --проверка и запись посл. атаки
        if dontknow==0 then
          if pslastattack and pslastattack[1] and #pslastattack[1]>0 then
            for zxc=1,#pslastattack[1] do
              if pslastattack[1][zxc]==name and GetTime()<pslastattack[2][zxc]+1 then
                txt1=txt1.." ("..pslastdmg..": "..pslastattack[3][zxc]..")"
                txt2=txt2.." ("..pslastdmg..": "..pslastattack[4][zxc]..")"
              end
            end
          end
        end
        --проверка нет ли инфы о прижигании?
        if psprizhig1 and psprizhig1[1] and #psprizhig1[1] then
        local odin=0
          for pp=1,#psprizhig1[1] do
            if psprizhig1[1][pp]==name and GetTime()<psprizhig1[2][pp]+60 and (psprizhig1[3][pp]~=0 or psprizhig1[5][pp]~=0) and odin==0 then
              local sppri=GetSpellInfo(87023)
              odin=1
              local beforetime=GetTime()-psprizhig1[2][pp]
              if beforetime>=10 then
                beforetime=math.ceil(beforetime)
              else
                beforetime=math.ceil(beforetime*10)/10
              end
              local num=3
              if psprizhig1[3][pp]==0 then
                num=5
              end
              if string.find(txt1,sppri) then
                txt1=txt1..". |cffff0000"..pscauterizecouse.." "..sppri.."|r > "..psprizhig1[num][pp]
                txt2=txt2..". |cffff0000"..pscauterizecouse.." "..sppri.."|r > "..psprizhig1[num+1][pp]
              else
                txt1=txt1..". |cffff0000"..sppri.." "..pscauterizecouse2.."|r ("..beforetime.." "..pssec.." "..psbefore..") > "..psprizhig1[num][pp]
                txt2=txt2..". |cffff0000"..sppri.." "..pscauterizecouse2.."|r ("..beforetime.." "..pssec.." "..psbefore..") > "..psprizhig1[num+1][pp]
              end
            end
          end
        end
        --проверяем есть ли хоть 1 босс активный, если да - отправляем туда репорт!
        if psdeathrepbossnametemp==nil then
          psdeathrepfindactiveboss()
        end
        if psdeathrepbossnametemp then
          pscaststartinfo(0,txt1, -1, "id1", 666, psdreventname,psdeathrepbossnametemp,2)
        else
          table.insert(psdeathwaiting[1],txt1)
          local timeevent=GetTime()-pscombatstarttime
          table.insert(psdeathwaiting[2],timeevent)
        end
        --репорт в чат
        psreportdeathchat(txt2)
      end
    else
      local txt1=""
      local txt2="PS "..psdieddeathrep..": "..psgetmarkforchat(mark)
      txt1=txt1..psaddcolortxt(1,name)..name..psaddcolortxt(2,name).." > "
      txt2=txt2..psaddcolortxt(1,chatname)..chatname..psaddcolortxt(2,chatname).." > "
      if type==0 then
        txt1=txt1.."|cffff0000"..psiccunknown.."|r"
        txt2=txt2.."|cffff0000"..psiccunknown.."|r"
      elseif type==1 then
        txt1=txt1..spellname.." (|cffff0000"..psdrinstakill.."|r)"
        txt2=txt2.."|s4id"..spellid.."|id (|cffff0000"..psdrinstakill.."|r)"
      elseif type==2 then
        txt1=txt1..psdamageceildeathrep(dmg)..", |cffff0000"..spellname.."|r"
        txt2=txt2..psdamageceildeathrep(dmg)..", |cffff0000"..spellname.."|r"
      else
        if spellid==87023 then
          txt1=txt1..psdamageceildeathrep(dmg)..", "..spellname.." ("..psoverkill..": "..psdamageceildeathrep(overkill)..resisttxt1..")"
          if psdeathrepsavemain[8]==1 then
            resisttxt1=""
          end
          txt2=txt2..psdamageceildeathrep(dmg)..", |s4id"..spellid.."|id ("..psoverkill..": "..psdamageceildeathrep(overkill)..resisttxt1..")"
        else
          txt1=txt1..psdamageceildeathrep(dmg)..", "..spellname.." ("..psoverkill..": "..psdamageceildeathrep(overkill)..resisttxt1..") "..crittxt1..whokill..spellsk
          if psdeathrepsavemain[8]==1 then
            resisttxt1=""
          end
          if psdeathrepsavemain[7]==1 then
            whokill=""
            whokill2=""
          end
          if psdeathrepsavemain[6]==1 then
            spellsk=""
          end
          if spellid==0 then
            txt2=txt2..psdamageceildeathrep(dmg)..", melee ("..psoverkill..": "..psdamageceildeathrep(overkill)..resisttxt1..") "..crittxt2..whokill2..spellsk
          else
            txt2=txt2..psdamageceildeathrep(dmg)..", |s4id"..spellid.."|id ("..psoverkill..": "..psdamageceildeathrep(overkill)..resisttxt1..") "..crittxt2..whokill2..spellsk
          end
        end
      end
      
      --запись для реп
      local gbil=0
      if pskillreport and pskillreport[1] and #pskillreport[1]>0 then
        for gh=1,#pskillreport[1] do
          if pskillreport[1][gh]==name then
            pskillreport[2][gh]=txt1
            pskillreport[3][gh]=GetTime()
            pskillreport[4][gh]=txt2
            gbil=1
          end
        end
      end
      if gbil==0 then
        table.insert(pskillreport[1],name)
        table.insert(pskillreport[2],txt1)
        local tmm=GetTime()
        --для падения замещение сразу возможно, так как нет овердамага..
        if type==2 then
          tmm=GetTime()-2.01
        end
        table.insert(pskillreport[3],tmm)
        table.insert(pskillreport[4],txt2)
      end 
    end--type
  end
end
    
    
    


end --only raid


end



function psdeathrepfindactiveboss()
  if pswasonboss11 then
    psdeathrepbossnametemp=psbossnames[1][1]
  elseif pswasonboss12 then
    psdeathrepbossnametemp=psbossnames[1][2]
  elseif pswasonboss13 then
    psdeathrepbossnametemp=psbossnames[1][3]
  elseif pswasonboss21 then
    psdeathrepbossnametemp=psbossnames[2][1]
  elseif pswasonboss22 then
    psdeathrepbossnametemp=psbossnames[2][2]
  elseif pswasonboss23 then
    psdeathrepbossnametemp=psbossnames[2][3]
  elseif pswasonboss24 then
    psdeathrepbossnametemp=psbossnames[2][4]
  elseif pswasonboss25 then
    psdeathrepbossnametemp=psbossnames[2][5]
  elseif pswasonboss26 then
    psdeathrepbossnametemp=psbossnames[2][6]
  elseif pswasonboss31 then
    psdeathrepbossnametemp=psbossnames[3][1]
  elseif pswasonboss32 then
    psdeathrepbossnametemp=psbossnames[3][2]
  elseif pswasonboss33 then
    psdeathrepbossnametemp=psbossnames[3][3]
  elseif pswasonboss34 then
    psdeathrepbossnametemp=psbossnames[3][4]
  elseif pswasonboss35 then
    psdeathrepbossnametemp=psbossnames[3][5]
  elseif pswasonboss41 then
    psdeathrepbossnametemp=psbossnames[4][1]
  elseif pswasonboss42 then
    psdeathrepbossnametemp=psbossnames[4][2]
  elseif pswasonboss51 then
    psdeathrepbossnametemp=psbossnames[5][1]
  elseif pswasonboss52 then
    psdeathrepbossnametemp=psbossnames[5][2]
  elseif pswasonboss53 then
    psdeathrepbossnametemp=psbossnames[5][3]
  elseif pswasonboss54 then
    psdeathrepbossnametemp=psbossnames[5][4]
  elseif pswasonboss55 then
    psdeathrepbossnametemp=psbossnames[5][5]
  elseif pswasonboss56 then
    psdeathrepbossnametemp=psbossnames[5][6]
  elseif pswasonboss57 then
    psdeathrepbossnametemp=psbossnames[5][7]
  elseif pswasonboss61 then
    psdeathrepbossnametemp=psbossnames[6][1]
  elseif pswasonboss62 then
    psdeathrepbossnametemp=psbossnames[6][2]
  elseif pswasonboss63 then
    psdeathrepbossnametemp=psbossnames[6][3]
  elseif pswasonboss64 then
    psdeathrepbossnametemp=psbossnames[6][4]
  elseif pswasonboss65 then
    psdeathrepbossnametemp=psbossnames[6][5]
  elseif pswasonboss66 then
    psdeathrepbossnametemp=psbossnames[6][6]
  elseif pswasonboss67 then
    psdeathrepbossnametemp=psbossnames[6][7]
  elseif pswasonboss68 then
    psdeathrepbossnametemp=psbossnames[6][8]
  else
    psdeathrepbossnametemp=nil
  end
end

function psdeathreplastattacksave(name,frase,frase2)
local bil=0
if #pslastattack[1]>0 then
  for i=1,#pslastattack[1] do
    if pslastattack[1][i]==name then
      pslastattack[2][i]=GetTime()
      pslastattack[3][i]=frase
      pslastattack[4][i]=frase2
      bil=1
    end
  end
end
if bil==0 then
  table.insert(pslastattack[1],name)
  table.insert(pslastattack[2],GetTime())
  table.insert(pslastattack[3],frase)
  table.insert(pslastattack[4],frase2)
end
end


function psgetmarkforchat(id)
if psdeathrepsavemain[9]==1 then
  return ""
else
  if id==nil then
    return ""
  else
   -- id=string.sub(id,3)
    if id then
      id=tonumber(id)
      if id==0 then
        return ""
      elseif id==1 then
        return "{rt1}"
      elseif id==2 then
        return "{rt2}"
      elseif id==4 then
        return "{rt3}"
      elseif id==8 then
        return "{rt4}"
      elseif id==16 then
        return "{rt5}"
      elseif id==32 then
        return "{rt6}"
      elseif id==64 then
        return "{rt7}"
      elseif id==128 then
        return "{rt8}"
      else
        return ""
      end
    else
      return ""
    end
  end
end
end


--репорт в чат
function psreportdeathchat(frase)
    local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
    local pplfr=0
    if IsPartyLFG() and IsInLFGDungeon() and difficulty == 2 and instanceType == "raid" and maxPlayers == 25 then
      pplfr=1
    end
if pstoomuchrepstopforfight==nil and (UnitInRaid("player") or UnitInParty("player")) and (psmylogin==nil or (psmylogin and GetTime()>psmylogin+10)) and ((psdeathrepsavemain[5]==0 and pplfr==1) or (pplfr==0)) then
  local psnumdead=0
  local psnumdeadmax=psdeathrepsavemain[12]
  local psnumgrup=2
  local partyonly=0
	if GetRaidDifficulty()==2 or GetRaidDifficulty()==4 then
    psnumgrup=5
    psnumdeadmax=psdeathrepsavemain[13]
	end
	if UnitInRaid("player")==nil and UnitInParty("player") then
    psnumdeadmax=psdeathrepsavemain[16]
    partyonly=1
    psnumdead=psdiedinparty
	end
	
	if partyonly==0 then
    for i = 1,GetNumRaidMembers() do
      local nameee,_,subgroup,_,_,_,_,_,isDead = GetRaidRosterInfo(i)
      if nameee and ((isDead==1 or UnitIsDeadOrGhost(nameee)==1) and subgroup<=psnumgrup) then
        psnumdead=psnumdead+1
      end
    end
  end

  --количество трупов меньше чем в настройке
  if psthiscombatstoprepd==nil and psnumdead<=psnumdeadmax and ((psdeathrepsavemain[4]==1 and psthiscombatwipe==nil) or (psdeathrepsavemain[4]==0)) then
    --плей саунд
    if psdeathrepsavemain[3]==1 then
      psplaysounddr(psdeathrepsavemain[11])
    end
    
    --репорт если есть промоут либо офицер либо в настройках
    if (psdeathrepsavemain[2]==1 and partyonly==0) or (psdeathrepsavemain[14]==1 and partyonly==1) then
      if (psdeathrepsavemain[10]=="sebe" and partyonly==0) or (psdeathrepsavemain[15]=="sebe" and partyonly==1) then
        frase=psspellfilter(frase)
        print (frase) --не тест!
      elseif (((psdeathrepsavemain[10]=="raid" or psdeathrepsavemain[10]=="raid_warning") and IsRaidOfficer()==nil and psfnopromrep==false and psdeathrepsavemain[1]==0) and partyonly==0) then
      else
        --можем репортить
        --проверяем, не запрещена ли отправка в этот чат другим аддоном
        --print ("тест: "..psspellfilter(frase)) --ыытест
        frase=psremovecolor(frase)
        frase=psspellfilter(frase)
        if string.find(frase,"|cffff0000") then
          while string.find(frase,"|cffff0000") do
            frase=string.sub(frase,1,string.find(frase,"|cffff0000")-1)..string.sub(frase,string.find(frase,"|cffff0000")+10)
            if string.find(frase,"|r") then
              frase=string.sub(frase,1,string.find(frase,"|r")-1)..string.sub(frase,string.find(frase,"|r")+2)
            end
          end
        end

      --psdeathreportantispam == 0 репорт через 0.5 сек
      --psdeathreportantispam нил репорт через 2 сек
      --psdeathreportantispam цифра больше 0 - запрет на репорт до этого времени
      --666Имя++Чат
      --666Имя^^++Чат - быстрый репорт, при виде такого, даже если права выше = я блокируюсь
      
        if psdethrepwaittab1==nil then
          --psdethrepwaittab1=GetTime()+2 --время когда репорт присваивается ПОЗЖЕ
          psdethrepwaittab2={} --фразы для репорта
        end
        local myname=UnitName("player")
        if IsRaidOfficer() then
          myname="0"..myname
        end
        if psdeathreportantispam==nil or (psdeathreportantispam~=0 and GetTime()>psdeathreportantispam) then
          if psdethrepwaittab1==nil then
            psdethrepwaittab1=GetTime()+2
          end
          table.insert(psdethrepwaittab2,frase)
          local cha=psdeathrepsavemain[10]
          if partyonly==1 then
            cha=psdeathrepsavemain[15]
          end
          SendAddonMessage("PSaddon", "666"..myname.."++"..cha, "raid")
        elseif psdeathreportantispam==0 then
          if psdethrepwaittab1==nil then
            psdethrepwaittab1=GetTime()+0.3
          end
          table.insert(psdethrepwaittab2,frase)
          local cha=psdeathrepsavemain[10]
          if partyonly==1 then
            cha=psdeathrepsavemain[15]
          end
          SendAddonMessage("PSaddon", "666"..myname.."^^++"..cha, "raid")
        end
      end
    end
  else
    psthiscombatstoprepd=1
  end
end
end


function psunitraidorparty(guid,name)
if UnitInParty(name) then
  return true
else
  if UnitInRaid(name) then
    return true
  else
    if UnitInRaid("player") then
      local B = tonumber(guid:sub(5,5), 16)
      local maskedB = B % 8
      if maskedB and maskedB==0 then
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
end