SlashCmdList['RELOADUI'] = function() ReloadUI() end
SLASH_RELOADUI1 = '/rl'
SLASH_RELOADUI2 = '/кд'
SLASH_RELOADUI3 = '/reloadui'

function PhoenixStyle_OnLoad()

pslocalem()
if GetLocale()=="deDE" or GetLocale()=="ruRU" or GetLocale()=="zhTW" or GetLocale()=="zhCN" or GetLocale()=="frFR" or GetLocale()=="koKR" or GetLocale()=="esES" or GetLocale()=="esMX" or GetLocale()=="ptBR" then
pslocale()
end


	psversion=1.58201


	psverstiptext="alpha"
	if string.len(psversion)==6 then
		psverstiptext="beta"
	elseif string.len(psversion)<6 then
		psverstiptext="release"
	end
	
	if psbossmodnoalphavar==nil then psbossmodnoalphavar=1 end
	
	--новый сейвд
	if psicccombatsavedreport==nil then psicccombatsavedreport=25 end
  if pssavedinfomorebutton==nil then pssavedinfomorebutton=0 end
  if pssavedinfocheckexport==nil then pssavedinfocheckexport={1,1,1,0} end
  if psicccombatexport==nil then psicccombatexport=0 end
  if pssichatrepdef==nil then pssichatrepdef="raid" end
  if pssiincombeventspririty==nil then pssiincombeventspririty={{},{}} end --предпочтения евентов
  if pssaveexpradiobutset==nil then pssaveexpradiobutset=1 end
  
  if pstrackbadsummons==nil then pstrackbadsummons=1 end
  
  --pets tracker
  if pspetstableok==nil then pspetstableok={{},{},{},{},{}} end --pet guid, player guid, time summoned, player name, guardian=1 pet=2
  if psmergepets==nil then psmergepets=1 end

	if PS_Settings==nil then PS_Settings = {PSMinimapPos = -16} end
	if psminibutenabl==nil then psminibutenabl=true end
	timertopull=0
	howmuchwaitpull=0
	pspullactiv=0
	timetocheck=0
	timeeventr=0
	truemark={"false","false","false","false","false","false","false","false"}
	autorefmark=false
	psfnotoffvar=0
	pszapuskdelayphasing=0
	pszapuskdelayphasing_2=0
	pszapuskdelayphasing_3=0
	psfontssetdef={12,13}

	psmylogin=GetTime()
	psiccinst="0"
	psdifflastfight=0
	pscombatstarttime=GetTime()
	if pssaaddon_12==nil then pssaaddon_12={1,1,1} end
	if psbossmodelshow==nil then psbossmodelshow=1 end
	if psdeathrepsavemain==nil then psdeathrepsavemain={0,1,0,1,0,0,0,1,0,"raid",1,3,6,1,"party",2,1,0} end
	if psautoinvsave==nil then psautoinvsave={1,1,1,0,3,{psautoinvtxtdef1,psautoinvtxtdef2,psautoinvtxtdef3,psautoinvtxtdef4},{},{},0,psannouncephrase,1} end --7 это промоут, 8 мл, 9 - спамить ли фразу при инвайте ги, 10 фраза для анонса, 11 - ценность добычи
	if psautoinvraiddiffsave==nil then psautoinvraiddiffsave={1,1} end
	psdrsounds={"iCreateCharacterA.wav","alarmclockbeeps1.ogg","Xylo.ogg","SheepDeath.wav", "WispPissed1.wav", "igQuestFailed","AuctionWindowOpen","AuctionWindowClose"}
	psdrsounds2={"Sound\\interface\\","2","2","Sound\\Creature\\Sheep\\","Sound\\Event Sounds\\Wisp\\","1","1","1"} --1 игра, 2 файл



	if pssisavedfailaftercombat==nil then pssisavedfailaftercombat={} end
	if pssisavedfailsplayern==nil then pssisavedfailsplayern={{},{}} end
	if pssisavedbossinfo==nil then pssisavedbossinfo={} end
	
--damage count variabiles
if pssidamageinf_indexboss==nil then pssidamageinf_indexboss={} end
if pssidamageinf_title2==nil then pssidamageinf_title2={} end
if pssidamageinf_additioninfo==nil then pssidamageinf_additioninfo={} end
if pssidamageinf_damageinfo==nil then pssidamageinf_damageinfo={} end
if pssidamageinf_switchinfo==nil then pssidamageinf_switchinfo={} end
if pssidamageinf_classcolor==nil then pssidamageinf_classcolor={} end

--in combat count variabiles
if pssicombatin_indexboss==nil then pssicombatin_indexboss={} end
if pssicombatin_title2==nil then pssicombatin_title2={} end
if pssicombatin_damageinfo==nil then pssicombatin_damageinfo={} end


--переменные для онапдейт функции, что трекерят кики
psincombattrack1_bossid={}
psincombattrack2_timecaststart={}
psincombattrack3_timestopcheck={} --прекращается чек спеллов
psincombattrack4_eventidtoinsert={}
psincombattrack5_whokiked={}
psincombattrack6_timekiked={}
psincombattrack7_whocasted={}
psincombattrack8_timecasted={}
psincombattrack9_bossspellname={}
psincombattrack10_redtimeifmorethen={} --но если не 0, 0 значит что не получили инфо
psincombattrack11_writeinfoinmodule={} --время когда инфо записывается в модуль
psincombattrack12_useallinterrupts={}  --если 1 то все интерапты и станы чекаются, если 0 то это босс,
psincombattrack13_showwaskikedornot={} --1 - для синестры, где сложно понять сбит ли каст, не отображать это слово "НЕ СБИТ" 0 - стандарт
psincombattrack14_nameofthecurrentcast={} --название текущего каста, для сравнение закончил ли он его кастить!!
psincombattrack15_castid={} --ид текущего каста, при интерапте проверять его ли прервали, иначе в попытки
psincombattrack16_additionaltext={} --текст что будет добавляться после спелла (урон что нанес спелл и тп)


--прекаст киков
psprecast1={} --текущее время кика
psprecast2={} --кто кикал
psprecast3={} --чем кикал
psprecast4={} --в кого кикал - ГУИД
psprecast5={} --приписка, типа МИСС АБСОРБ
psprecast6={} -- тип прекаста, "0" - для боссов, "1" - спелаплай и отбрасывание


--прекаст интерапта ок!
preinterrupt1={} --время чека
preinterrupt2={} --кто кикал
preinterrupt3={} --чем кикал (спелл - время)
preinterrupt4={} --в кого кикал

--чек интерапта после стана
psinterbystan1={} --время чека
psinterbystan2={} --ид босса
psinterbystan3={} --уверен что каст был сбит
psinterbystan4={} --название спела


--чек таргетов для SA аддона
ps_sa_checktarg1={} --время когда проверять таргет
ps_sa_checktarg2={} --босс ГУИД кого проверяем
ps_sa_checktarg3={} --если не найду таргет, речек делать через стока сек
ps_sa_checktarg4={} --текст что будет отправлен дальше
ps_sa_checktarg5={} --блокировка что будет перенаправлена
ps_sa_checktarg6={} --важный ли репорт или нет


--BossMod`s Versions
psbossmods1={} --BossMod`s name
psbossmods2={} --Version
psbossmods3={} --Name
psbossmods4={} --additional version info or 0
psbossmods5={} --GetTime() if more than 4 hours = no boss mod


--дес репортер
pslastattack={{},{},{},{}}--имя время фраза, фраза чат
psdiedinparty=0


--табл посл репортов смертей
pslastdeath={{},{}}--name,time - will not be report until this time
--табл репортов смертей еще не внесенных в модуль
psdeathwaiting={{},{}}--string to insert, timeevent


psdeathgriplocal=GetSpellInfo(49560)



--cataclysm data
pslocations={752,754,758,773,800,824}
pslocationnamesdef={"Baradin Hold","Blackwing Descent","The Bastion of Twilight","Throne of the Four Winds","Firelands", "Dragon Soul"}
psaddontoload={"PhoenixStyleMod_CataMiniRaids","PhoenixStyleMod_CataMiniRaids","PhoenixStyleMod_CataMiniRaids","PhoenixStyleMod_CataMiniRaids","PhoenixStyleMod_Firelands","PhoenixStyleMod_DragonSoul"}

psbossnamesdef={{"Argaloth","Occu'thar", "Alizabal, Mistress of Hate"},{"Magmaw","Omnitron Defense System","Maloriak","Atramedes","Chimaeron","Nefarian"},{"Halfus Wyrmbreaker","Valiona & Theralion","Twilight Ascendant Council","Cho'gall","Sinestra"},{"Conclave of Wind", "Al'Akir"},{"Beth'tilac", "Lord Rhyolith","Alysrazor","Shannox","Baleroc","Majordomo Staghelm","Ragnaros"},{"Morchok","Warlord Zon'ozz","Yor'sahj the Unsleeping","Hagara the Stormbinder","Ultraxion","Warmaster Blackhorn","Spine of Deathwing","Madness of Deathwing"}}
psbossid={{{47120},{52363},{55869}},{{41570},{0,42180,42166,42178,42179},{41378},{41442},{43296},{41376}},{{44600},{0,45992,45993},{0,43735,43686,43687,43688,43689},{43324},{45213}},{{0,45871,45870,45872},{46753}},{{52498},{52558},{52530},{53691},{53494},{52571},{52409}},{{55265},{55308},{55312},{55689},{55294},{56427},{0,53879, 56598, 55870},{0,53879}}}
ps_modelid={{{35426},{35904},{21252}},{{37993},{32688},{33186},{34547},{33308},{32716}},{{34816},{34812},{35064},{34576},{34335}},{{35232},{35248}},{{38227},{38629},{38446},{38448},{38628},{37953},{37875}},{{39094},{39138},{39101},{39318},{39099},{39399},{35268},{40087}}}

--options for SayAnnouncer
ps_saoptions_def={{},{{},{1,1,1,1},{},{1,1},{},{1}},{{},{1,1,0},{1,0},{1}},{{},{1}},{{},{},{},{1,1},{1},{1},{1}}, {{},{1},{},{1,1},{},{1},{},{}}}
ps_sa_id={{},{{},{92037,91433,92053,80157},{},{78092,92702},{},{79339}},{{},{95641,92878,92900},{92075,92067},{93180}},{{},{89668}},{{},{},{},{99836,99839},{99516},{100206},{98164}},{{},{"104600|AddComm"..psiccheroic},{},{109541,109325},{},{108046},{},{}}} --не забыть дефалт добавить вкл/выкл
--"106794|AddComm"..psmainbutdragonsoul1

if psraidchats3==nil then psraidchats3={"raid","sebe","sebe"} end



--может тут таблица, в которой 0 если не загружено, и при загрузке в нее вставляется кусок кода

psraidoptionson={{},{},{},{},{}} --если переменная не таблица
psraidoptionstxt={{},{},{},{},{}}

psraidoptionschat={{},{},{},{},{}}


--при загрузке каты:
--для каждого рейда отдельная переменная, + ТАК ЖЕ Сделать и с чатом


psiccschet1=0
psiccschet2=0
psiccschet3=0
psiccschet4=0
psiccschet5=0
psiccschet6=0


	pscurrentzoneid=0
	psmsgtimestart=0
	psmsgtimestart42=0
	psmsgtimestart43=0
	psmsgwaiting=0
	psmsgwaiting42=0
	psmsgwaiting43=0
	psmsgmychat=""
	psmsgmychat42=""
	psmsgmychat43=""
	pscanannouncetable={}
	pscanannouncetable42={}
	pscanannouncetable43={}
	psannouncewait={}
	psannouncewait42={}
	psannouncewait43={}
	psnotanonsemore=0
	psnotanonsemorenormal=0
	psnotanonsemorenormal2=0
	bigmenuchatlisten={"raid", "raid_warning", "officer", "party", "guild", "say", "yell", "sebe"}
	lowmenuchatlisten={"party", "officer", "guild", "say", "yell", "sebe"}
	vezaxname = {}
	vezaxcrash = {}
	vezaxname2 = {}
	vezaxcrash2 = {}
	vezaxname3 = {}
	vezaxcrash3 = {}
	vezaxname4 = {}
	vezaxcrash4 = {}
	vezaxname5 = {}
	vezaxcrash5 = {}
	vezaxname6 = {}
	vezaxcrash6 = {}
	vezaxname7 = {}
	vezaxcrash7 = {}
	vezaxname8 = {}
	vezaxcrash8 = {}
	vezaxname9 = {}
	vezaxcrash9 = {}
	vezaxname10 = {}
	vezaxcrash10 = {}
	vezaxname11 = {}
	vezaxcrash11 = {}
	psbossbugs={}
if (psdamagename==nil) then psdamagename = {} end
if (psdamagevalue==nil) then psdamagevalue = {} end
if (psdamageraz==nil) then psdamageraz = {} end

if (psdamagename2==nil) then psdamagename2 = {} end
if (psdamagevalue2==nil) then psdamagevalue2 = {} end

if (psdamagename3==nil) then psdamagename3 = {} end
if (psdamagevalue3==nil) then psdamagevalue3 = {} end
	if psoldvern==nil then psoldvern=0 end
	if psversionday==nil then psversionday=0 end
	if psraidoptionsnumers==nil then psraidoptionsnumers={2,0,4,8,5,7,10,20} end
	if psrscafterfightrep==nil then psrscafterfightrep={0,0} end

	SLASH_PHOENIXSTYLEFAILBOT1 = "/fen"
	SLASH_PHOENIXSTYLEFAILBOT2 = "/фс"
	SLASH_PHOENIXSTYLEFAILBOT3 = "/phoenix"
	SLASH_PHOENIXSTYLEFAILBOT4 = "/phoenixstyle"
	SLASH_PHOENIXSTYLEFAILBOT5 = "/фен"
	SLASH_PHOENIXSTYLEFAILBOT6 = "/феникс"
	SLASH_PHOENIXSTYLEFAILBOT7 = "/ps"
	SlashCmdList["PHOENIXSTYLEFAILBOT"] = PhoenixStyleFailbot_Command




	if(secrefmark == nil) then secrefmark = 1 end
	if(thisaddononoff == nil) then thisaddononoff=true end
	if(thisaddonwork==nil) then thisaddonwork=true end
	if(psfnopromrep==nil) then psfnopromrep=false end
	if pssetmarknew==nil then pssetmarknew={{},{},{},{},{},{},{},{}} end

	PhoenixStyleFailbot:RegisterEvent("PLAYER_REGEN_DISABLED")
	PhoenixStyleFailbot:RegisterEvent("PLAYER_REGEN_ENABLED")
	PhoenixStyleFailbot:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	PhoenixStyleFailbot:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_ADDON")
	PhoenixStyleFailbot:RegisterEvent("PLAYER_ALIVE")
	PhoenixStyleFailbot:RegisterEvent("ADDON_LOADED")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_PARTY")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_RAID")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_RAID_WARNING")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_OFFICER")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_GUILD")
	PhoenixStyleFailbot:RegisterEvent("PLAYER_TARGET_CHANGED")
	PhoenixStyleFailbot:RegisterEvent("CHANNEL_UI_UPDATE")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_SAY")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_YELL")
	PhoenixStyleFailbot:RegisterEvent("PLAYER_ENTERING_WORLD")
	PhoenixStyleFailbot:RegisterEvent("RAID_ROSTER_UPDATE")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_WHISPER")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_BN_WHISPER")
	PhoenixStyleFailbot:RegisterEvent("CHAT_MSG_SYSTEM")
	PhoenixStyleFailbot:RegisterEvent("PARTY_INVITE_REQUEST")
	



	ps_sa_waitfilter={0,0}

end





function PSF_OnUpdate()

	local curtime = GetTime()



--delete pet after 2 sec
if pspettodelete2 and curtime>pspettodelete2 then
pspettodelete2=nil
for j=1,#pspettodelete1 do
  if pspetstableok[1] and #pspetstableok[1]>0 then
    for i,petguid in ipairs(pspetstableok[1]) do
      if petguid == pspettodelete1[j] then
        table.remove(pspetstableok[1],i)
        table.remove(pspetstableok[2],i)
        table.remove(pspetstableok[3],i)
        table.remove(pspetstableok[4],i)
        table.remove(pspetstableok[5],i)
        --print ("минус пет")
      end
    end
  end
end
pspettodelete1=nil
end

--report death
if psdethrepwaittab1 and curtime>psdethrepwaittab1 then
  if curtime>psdethrepwaittab1+5 then
    psdethrepwaittab1=nil
    psdethrepwaittab2=nil
  else
    psdethrepwaittab1=nil
    if psdeathreportantispam==nil or psdeathreportantispam==0 or (psdeathreportantispam~=0 and curtime>psdeathreportantispam) then
      --проверка нет ли слишком много смертей (мгновенный вайп)
      local psnumdead=0
      local psnumdeadmax=psdeathrepsavemain[12]
      if psnumdeadmax<5 then
        psnumdeadmax=6
      end
      local psnumgrup=2
      if GetRaidDifficulty()==2 or GetRaidDifficulty()==4 then
        psnumgrup=5
        psnumdeadmax=psdeathrepsavemain[13]
        if psnumdeadmax<10 then
          psnumdeadmax=11
        end
      end
      if UnitInRaid("player")==nil and UnitInParty("player") then
        psnumdead=psdiedinparty
      else
        for i = 1,GetNumRaidMembers() do
          local nameee,_,subgroup,_,_,_,_,_,isDead = GetRaidRosterInfo(i)
          if nameee and ((isDead==1 or UnitIsDeadOrGhost(nameee)==1) and subgroup<=psnumgrup) then
            psnumdead=psnumdead+1
          end
        end
      end
      if psnumdead>=psnumdeadmax or #psdethrepwaittab2>=5 then
        --слишком много смертей, репортим ТОЛЬКО СЕБЕ
        pssendchatmsg("sebe",psdethrepwaittab2)
        psdethrepwaittab2=nil
        pstoomuchrepstopforfight=1
      else
        --репортим
        local cha=psdeathrepsavemain[10]
        if UnitInRaid("player")==nil and UnitInParty("player") then
          cha=psdeathrepsavemain[15]
        end
        pssendchatmsg(cha,psdethrepwaittab2)
        psdethrepwaittab2=nil
        psdeathreportantispam=0
      end
    end
    psdethrepwaittab2=nil
  end
end

--remove death rep
if tabltemppriest then
  for i=1,#tabltemppriest[2] do
    if tabltemppriest[2][i] and curtime>tabltemppriest[2][i]+1.5 then
      table.remove(tabltemppriest[1],i)
      table.remove(tabltemppriest[2],i)
    end
  end
  if tabltemppriest[1]==nil or (tabltemppriest[1] and #tabltemppriest[1]==0) then
    tabltemppriest=nil
  end
end

if psprizhig1 then
  for i=1,#psprizhig1[2] do
    if psprizhig1[2][i] and curtime>psprizhig1[2][i]+60 then
      table.remove(psprizhig1[1],i)
      table.remove(psprizhig1[2],i)
      table.remove(psprizhig1[3],i)
      table.remove(psprizhig1[4],i)
      table.remove(psprizhig1[5],i)
      table.remove(psprizhig1[6],i)
    end
  end
  if psprizhig1[1]==nil or (psprizhig1[1] and #psprizhig1[1]==0) then
    psprizhig1=nil
  end
end

--delay for export
if psreportthinkdelay and curtime>psreportthinkdelay then
psreportthinkdelay=nil
if psreportthinkdelayonlythisevent1 and GetTime()<psreportthinkdelayonlythisevent1+2 then
  psafterdelaysta(psreportthinkdelayonlythisevent2,psreportthinkdelayonlythisevent3)
else
  psafterdelaysta()
end
end
if psreportthinkdelay2 and curtime>psreportthinkdelay2 then
psreportthinkdelay2=nil
if psreportthinkdelayonlythisevent1 and GetTime()<psreportthinkdelayonlythisevent1+2 then
  psafterdelaysta2(psreportthinkdelayonlythisevent2)
else
  psafterdelaysta2()
end
end

--reload boss mod ver for dxe
if psreloadbossmodwind and curtime>psreloadbossmodwind then
psreloadbossmodwind=nil
if PSFbossmodframe:IsShown() then
	psbossmodframeopen()
end
end

--boss Mods check ver

if psrecheckbossmin40 and curtime>psrecheckbossmin40 then
psrecheckbossmin40=nil
	if UnitAffectingCombat("player") then
		if UnitInRaid("player") then
			psrecheckbossmin40=GetTime()+10
		end
	else
		local inInstance, instanceType = IsInInstance()
		if instanceType=="raid" then
			SendAddonMessage("D4", "H\t", "RAID")
			SendAddonMessage("BigWigs", "VQ:0", "RAID")
			SendAddonMessage("RW2", "^1^SReqVersionInfo^^", "RAID")
			--SendAddonMessage("DXE", "^1^SRequestAddOnVersion^^", "RAID")
			SendAddonMessage("DXE","DXEVersionRequest","RAID")
		end
	end
end

--restore timer after relog
if psdelayfortimerrestore and curtime>psdelayfortimerrestore then
psdelayfortimerrestore=nil
  local _, month, day, year = CalendarGetDate()
  if month<10 then month="0"..month end
  if day<10 then day="0"..day end
  local oggi=month.."/"..day.."/"..year

  if pstimerafterrelog[4]==oggi and GetTime()-pstimerafterrelog[1]<pstimerafterrelog[3]-5 and UnitInRaid("player") then
    --restore timers
    local secs=math.ceil(pstimerafterrelog[3]-(GetTime()-pstimerafterrelog[1]))
    if secs<1800 then
      if(DBM)then
        DBM:CreatePizzaTimer(secs, pstimerafterrelog[2])
      end
      --other bossmods:
    end
  else
    pstimerafterrelog=nil
  end
end

--срочный конверт в рейд при реинвайте
if psneedconvertquick and curtime>psneedconvertquick then
	if curtime>psneedconvertquick+40 then
		psneedconvertquick=nil
		psneedinvitethem=nil
	end
	if GetNumPartyMembers()>0 and IsPartyLeader() then
		ConvertToRaid()
		psneedchangediff=curtime+0.5
		psneedconvertquick=nil
		psconvertedinv=GetTime()+1
		pschangequalityitems=GetTime()+1
	end
	if UnitInRaid("player") then
		psneedconvertquick=nil
	end
end

if psneedchangediff and curtime>psneedchangediff and pschangediffonetime==nil then
psneedchangediff=nil
if pswhatdiff then
pschangediffonetime=1
SetRaidDifficulty(pswhatdiff)
end
end

--инвайт остальных
if psconvertedinv and curtime>psconvertedinv then
psconvertedinv=nil
psignorforsec5=GetTime()
if psneedinvitethem and #psneedinvitethem>0 and UnitInRaid("player") and (IsRaidOfficer() or IsRaidLeader()) then
	for i=1,#psneedinvitethem do
		InviteUnit(psneedinvitethem[i])
	end
end
end


if psleavepartydelay and curtime>psleavepartydelay then
psleavepartydelay=nil
LeaveParty()
end


--реинвайт по списку
if pswaitlisttoreinvitet and curtime>pswaitlisttoreinvitet then
pswaitlisttoreinvitet=nil
psignorforsec5=GetTime()
if #pswaitlisttoreinvite>0 then
	if (UnitInRaid("player") and (IsRaidOfficer() or IsRaidLeader())) or (GetNumPartyMembers()>0 and IsPartyLeader()) or (GetNumPartyMembers()==0 and UnitInRaid("player")==nil) then
		local howmuch=0
			if GetNumPartyMembers()>0 and UnitInRaid("player")==nil then
				howmuch=GetNumPartyMembers()
			end
			if UnitInRaid("player") then
				howmuch=-100
			end
		if GetNumPartyMembers()>0 and IsPartyLeader() and #pswaitlisttoreinvite>4 then
			ConvertToRaid()
		end
		for i=1,#pswaitlisttoreinvite do
			howmuch=howmuch+1
			if howmuch==5 then
				psneedconvertquick=GetTime()-1
				psneedinvitethem={}
			end
			if howmuch<5 then
				InviteUnit(pswaitlisttoreinvite[i])
			else
				table.insert(psneedinvitethem,pswaitlisttoreinvite[i])
			end
		end
		if howmuch>4 then
			out ("|cff99ffffPhoenixStyle|r - 4 "..format(psinvtxtwaitforacc,howmuch))
		end
	end
end
end

--смена лута
if pschangequalityitems and curtime>pschangequalityitems and (psdelayafterqual==nil or (psdelayafterqual and curtime>psdelayafterqual)) then
	pschangequalityitems=nil
	if psautoinvsave[11] and psautoinvsave[11]>1 and psonetimechanlootfdf==nil then
		psonetimechanlootfdf=1
		SetLootThreshold(psautoinvsave[11])
		psdelayafterqual=curtime
	end
end


--инвайт по ранку
if psinviteonrankgo and curtime>psinviteonrankgo then
psinviteonrankgo=nil
	local guildCount=GetNumGuildMembers()
	local howmuch=0
			if GetNumPartyMembers()>0 and UnitInRaid("player")==nil then
				howmuch=GetNumPartyMembers()
			end
			if UnitInRaid("player") then
				howmuch=-100
				pswhatdiff=psautoinvraiddiffsave[2]
				if pswhatdiff==5 then
					pswhatdiff=nil
				end
				psneedchangediff=GetTime()
				pschangequalityitems=GetTime()+1
			end
	psignorforsec5=GetTime()
psneedinvitethem={}
for j=1,#psrankstoinvite do
	for i=1, guildCount do
		local name, rank, rankIndex, _, _, _, _, _, online = GetGuildRosterInfo(i)
		if ps_i_h and online and ((rankIndex<psrankstoinvite[j] and ps_i_h==1) or (ps_i_h==2 and rankIndex==psrankstoinvite[j]-1)) and name~=UnitName("player") then --не равно, потому что ранк индекс начинается от 0, а мы считали от 1
			howmuch=howmuch+1
			if howmuch==5 then
				pswhatdiff=psautoinvraiddiffsave[2]
				if pswhatdiff==5 then
					pswhatdiff=nil
				end
				psneedconvertquick=GetTime()-1
			end
			if howmuch<5 then
				InviteUnit(name)
			else
				table.insert(psneedinvitethem,name)
			end
		end
	end
	if howmuch>4 then
		out ("|cff99ffffPhoenixStyle|r - 4 "..format(psinvtxtwaitforacc,howmuch))
	end
end
if #psneedinvitethem==0 then
	psneedinvitethem=nil
end

psrankstoinvite=nil
end




--если нельзя получать версию через рейд чат, а только через приваты - пользоваться функцией что закомментил
if psdelaybossmodchecktemp and curtime>psdelaybossmodchecktemp then
local inInstance, instanceType = IsInInstance()
if instanceType=="raid" then
	psdelaybossmodchecktemp=nil
	if IsAddOnLoaded("DBM-Core")==nil then
		SendAddonMessage("D4", "H\t", "RAID")
	end
	if IsAddOnLoaded("BigWigs")==nil then
		SendAddonMessage("BigWigs", "VQ:0", "RAID")
	end
	if IsAddOnLoaded("RaidWatch")==nil then
		SendAddonMessage("RW2", "^1^SReqVersionInfo^^", "RAID")
	end
		--у ДХе не проверяю установку ибо плохо работает пересылка версий и так
		--SendAddonMessage("DXE", "^1^SRequestAddOnVersion^^", "RAID")
		SendAddonMessage("DXE","DXEVersionRequest","RAID")

	psrecheckbossmin40=GetTime()+41
end
end



--SA чек версия
if sa_delayforwaiting and curtime>sa_delayforwaiting then
sa_delayforwaiting=nil


local txt=""
if #sa_raidrosteronline>0 then
table.sort (sa_raidrosteronline)
	for i=1,#sa_raidrosteronline do
		txt=txt..sa_raidrosteronline[i]
		if i==#sa_raidrosteronline then
			txt=txt.."."
		else
			txt=txt..", "
		end
	end
end
if string.len (txt)>1 then
print ("|cffff0000"..psmain_sainfo2.."|r ("..#sa_raidrosteronline.."): "..txt)
end
txt=""
if #sa_raidrosteroffline>0 then
table.sort (sa_raidrosteroffline)
	for j=1,#sa_raidrosteroffline do
		txt=txt..sa_raidrosteroffline[j]
		if j==#sa_raidrosteroffline then
			txt=txt.."."
		else
			txt=txt..", "
		end
	end
end
if string.len (txt)>1 then
print ("|cffff0000"..psmain_sainfo3.."|r ("..#sa_raidrosteroffline.."): "..txt)
end

sa_raidrosteronline=nil
sa_raidrosteroffline=nil
sa_raidwithaddons=nil
end


--чек таргетов для SA аддона:
if #ps_sa_checktarg1>0 then
	local i=1
	while i<=#ps_sa_checktarg1 do
		if ps_sa_checktarg1[i] and curtime>ps_sa_checktarg1[i] then
			local targetfound="0"
			for ttg=1,GetNumRaidMembers() do
				if UnitGUID("raid"..ttg.."-target") and targetfound=="0" then
					local a1=UnitGUID("raid"..ttg.."-target")
					if a1==ps_sa_checktarg2[i] then
						if UnitName("raid"..ttg.."-target-target") and UnitInRaid(UnitName("raid"..ttg.."-target-target")) then
							targetfound=UnitName("raid"..ttg.."-target-target")
						end
					end
				end
			end
			if targetfound=="0" then
				if UnitGUID("focus") and UnitGUID("focus")==ps_sa_checktarg2[i] then
					if UnitName("focus-target") and UnitInRaid(UnitName("focus-target")) then
						targetfound=UnitName("focus-target")
					end
				end
			end
			local kl=0
			if targetfound=="0" and ps_sa_checktarg3[i]>0 then
				ps_sa_checktarg1[i]=GetTime()+ps_sa_checktarg3[i]
				ps_sa_checktarg3[i]=0
				kl=1
			elseif targetfound~="0" then
				ps_sa_sendinfo(targetfound, ps_sa_checktarg4[i], ps_sa_checktarg5[i], ps_sa_checktarg6[i], nil)
			end
			if kl==0 then
				table.remove(ps_sa_checktarg1,i)
				table.remove(ps_sa_checktarg2,i)
				table.remove(ps_sa_checktarg3,i)
				table.remove(ps_sa_checktarg4,i)
				table.remove(ps_sa_checktarg5,i)
				table.remove(ps_sa_checktarg6,i)
			end
			i=1000
		end
	i=i+1
	end
end

if psdelayofcheck and curtime>psdelayofcheck then
psdelayofcheck=nil
if UnitInRaid("player") then
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
SendAddonMessage("PSaddon", "17"..psversion, "raid")
end
end
end


--чек баг боссов
if pscheckbusboss1 and curtime>pscheckbusboss1 then
pscheckbusboss1=nil
if UnitIsDeadOrGhost("player")==nil and UnitName("boss1") and UnitName("boss1")~="" and IsInInstance() and UnitAffectingCombat("player")==nil then
pscheckbusboss2=curtime+7
end
end

if pscheckbusboss2 and curtime>pscheckbusboss2 then
pscheckbusboss2=nil
pscheckbusboss1=nil
if UnitIsDeadOrGhost("player")==nil and UnitName("boss1") and UnitName("boss1")~="" and IsInInstance() and UnitAffectingCombat("player")==nil then

local id2=UnitGUID("boss1")
local id=tonumber(string.sub(id2,-12,-9),16)
	local bloc=0
	SetMapToCurrentZone()
	for d=1,#pslocations do
		if pslocations[d]==GetCurrentMapAreaID() then
			bloc=1
		end
	end
	if bossbugreportrl==nil and bloc==1 then
		bossbugreportrl=1
		local txt="Blizzard bug: one of the bosses didn't die and stuck his info in the client. |cff00ff00It's suggested to restart your game client|r. Otherwise addon may not see next bosses."
		if id~=42347 then
			txt=txt.." Please, report me where you got this error and ID: "..id
		end
		if GetLocale()=="ruRU" then
			txt="Blizzard bug: один из боссов не совсем умер и завис в памяти клиента. Аддон может не определять следующих боссов, |cff00ff00рекомендуется перезапустить Ваш клиент|r."
			if id~=42347 then
				txt=txt.." Пожалуйста, сообщите мне в каком месте вы получили эту ошибку и ID: "..id
			end
		end
		--ыытест для фаерлендов не нужен нам анонс, тока для магмаря
		if id==42347 then
			out("|cff99ffffPhoenixStyle|r - |cffff0000"..psattention.."|r "..txt)
		end
	end

local bil=0

if #psbossbugs>0 then
	for i=1,#psbossbugs do
		if psbossbugs[i]==id then
			bil=1
		end
	end
end

--ыытест тут проверка добавления багованых боссов
if id>0 then
	for ii=1,#psbossid do
		for j=1,#psbossid[ii] do
			for t=1,#psbossid[ii][j] do
				if psbossid[ii][j][t]==id then
					bil=1
				end
			end
		end
	end
end



if bil==0 then
table.insert(psbossbugs,id)
end
end
end

if pscheckbossincombat and curtime>pscheckbossincombat+2 then
pscheckbossincombat=curtime
local id=0
if UnitGUID("boss1") then
	id=tonumber(string.sub(UnitGUID("boss1"),-12,-9),16)
end
local bil=0
if #psbossbugs>0 then
	for i=1,#psbossbugs do
		if psbossbugs[i]==id then
			bil=1
		end
	end
end

if UnitGUID("boss1") and bil==0 and UnitName("boss1")~="" then
else
pscheckbossincombat=nil
end
end


if pszonechangedalldel and curtime>pszonechangedalldel+3 then
pszonechangedalldel=nil

local a1, a2, a3, a4, a5 = GetInstanceInfo()
if UnitInRaid("player") or a2=="raid" then
SetMapToCurrentZone()
end
for i=1,#pslocations do
	if pslocations[i]==GetCurrentMapAreaID() then
		pslocationnames[i]=GetRealZoneText()
		pscurrentzoneid=i
	end
end

pszonechangedall()

end


--пуллтаймер онапдейт
if pspullactiv then

if(timertopull>0 or pspullactiv==1)then


	if (DelayTimepull == nil)then
		DelayTimepull = GetTime()+howmuchwaitpull
	end


		if (curtime >= DelayTimepull) then
			local someerrorsecpull=curtime-DelayTimepull

if timertopull==0 then
SendChatMessage(">>> "..psattack.." <<<", "raid_warning")
pspullactiv=0
timertopull=0
DelayTimepull=nil
else
			SendChatMessage(psattackin.." "..timertopull.." "..pssec, "raid_warning")
end
			

if timertopull >14.2 then
DelayTimepull = DelayTimepull-someerrorsecpull+5
timertopull=10
elseif timertopull>9.2 then
DelayTimepull = DelayTimepull-someerrorsecpull+3
timertopull=7
elseif timertopull >6.2 then
DelayTimepull = DelayTimepull-someerrorsecpull+2
timertopull=5

elseif timertopull >5.5 then
DelayTimepull = DelayTimepull-someerrorsecpull+2
timertopull=4

elseif timertopull >4.2 then
DelayTimepull = DelayTimepull-someerrorsecpull+2
timertopull=3

elseif timertopull >3.2 then
DelayTimepull = DelayTimepull-someerrorsecpull+1
timertopull=3

elseif timertopull >2.2 then
DelayTimepull = DelayTimepull-someerrorsecpull+1
timertopull=2
elseif timertopull >1.2 then
DelayTimepull = DelayTimepull-someerrorsecpull+1
timertopull=1
elseif timertopull >0.2 then
DelayTimepull = DelayTimepull-someerrorsecpull+1
timertopull=0
pspullactiv=1
else
timertopull=0


end --timertopull>17


		end
end
end --конец по пулу

if pscheckdatay and GetTime()>pscheckdatay then
pscheckdatay=nil
if psaddoninstalledsins==nil then
local _, month, day, year = CalendarGetDate()
if year==2010 and month==10 and day<30 then
psaddoninstalledsins="..."
else
psaddoninstalledsins=day.."/"..month.."/"..year
end
end
end


--задержка аннонса

if psmsgtimestart42>0 and curtime>psmsgtimestart42+0.4 then
psmsgtimestart42=0
if psmsgmychat42=="BATTLEGROUND" then
  SendAddonMessage("PhoenixStyle", "myname:"..psnamemsgsend.."++mychat:"..psmsgmychat42.."++", "BATTLEGROUND")
else
  SendAddonMessage("PhoenixStyle", "myname:"..psnamemsgsend.."++mychat:"..psmsgmychat42.."++", "RAID")
end
end

if psmsgtimestart43>0 and curtime>psmsgtimestart43+0.4 then
psmsgtimestart43=0
if psmsgmychat43=="BATTLEGROUND" then
  SendAddonMessage("PhoenixStyle", "myname:"..psnamemsgsend.."++mychat:"..psmsgmychat43.."++", "BATTLEGROUND")
else
  SendAddonMessage("PhoenixStyle", "myname:"..psnamemsgsend.."++mychat:"..psmsgmychat43.."++", "RAID")
end
end


if psmsgtimestart>0 and curtime>psmsgtimestart+0.4 then
psmsgtimestart=0

--тут отправка в аддон канал инфы

local chattt="RAID"
if psmsgmychat=="BATTLEGROUND" then
  chattt="BATTLEGROUND"
end

	if pssendinterboj==nil then
SendAddonMessage("PhoenixStyle", "myname:"..psnamemsgsend.."++mychat:"..psmsgmychat.."++", chattt)
	else
SendAddonMessage("PhoenixStyle", "myname:"..psnamemsgsend.."++mychat:"..psmsgmychat.."++fightend++", chattt)
	end

end




--Допанонсы
if psmsgwaiting42>0 and curtime>psmsgwaiting42+1.7 then
psmsgwaiting42=0
table.sort(pscanannouncetable42)
--тут аннонс и обнуление всех таблиц


if pscanannouncetable42[1]==psnamemsgsend then

pssendchatmsg(psmsgmychat42,psannouncewait42)

end

table.wipe(psannouncewait42)
table.wipe(pscanannouncetable42)
psanounsesrazuchek=nil

end

--Допанонсы
if psmsgwaiting43>0 and curtime>psmsgwaiting43+1.7 then
psmsgwaiting43=0
table.sort(pscanannouncetable43)
--тут аннонс и обнуление всех таблиц

if pscanannouncetable43[1]==psnamemsgsend then

pssendchatmsg(psmsgmychat43,psannouncewait43)

end

table.wipe(psannouncewait43)
table.wipe(pscanannouncetable43)
psanounsesrazuchek=nil

end


if psmsgwaiting>0 and curtime>psmsgwaiting+2.7 then

if curtime-(psmsgwaiting+2.7)>2 then
psmsgwaiting=GetTime()+2
else

psmsgwaiting=0
table.sort(pscanannouncetable)
--тут аннонс и обнуление всех таблиц

if pscanannouncetable[1]==psnamemsgsend then

pssendchatmsg(psmsgmychat,psannouncewait)

local _, instanceType, pppl, _, maxPlayers, dif = GetInstanceInfo()
--репорт для РСК аддона инфы после боя НЕ В ЛФР
if IsAddOnLoaded("RaidSlackCheck") then
  if IsPartyLFG() and IsInLFGDungeon() and instanceType == "raid" and maxPlayers == 25 then
  else
    if psrscafterfightrep[1]==1 then
      rscrepnortafretcom1(psmsgmychat)
    end
    if psrscafterfightrep[1]==2 then
      rscrepnortafretcom2(psmsgmychat)
    end
    if psrscafterfightrep[2]==1 then
      rscrepnopot(psmsgmychat)
    end
  end
end

end

table.wipe(psannouncewait)
table.wipe(pscanannouncetable)
psanounsesrazuchek=nil

end


end

--конец задержки аннонсов



--autoref marks


if (autorefmark) then

if (curtime>timeeventr) then
if(IsRaidOfficer()==1) then

		local timetocheck=0
		if psdelaydeathcheck==nil or (psdelaydeathcheck and GetTime()>psdelaydeathcheck+5) then
			psdelaydeathcheck=GetTime()
			timetocheck=1
		end

		for i=1,8 do
		if truemark[i]=="true" then
			local metka=0
			for ij=1,#pssetmarknew[i] do
				if metka==0 and pssetmarknew[i][ij] and UnitExists(pssetmarknew[i][ij]) then
					if timetocheck==1 then
						local oj=1
						while oj<=GetNumRaidMembers() do
							local name2, _, _, _, _, _, _, online, isDead = GetRaidRosterInfo(oj)

							if name2 and pssetmarknew[i][ij] and string.lower(name2)==string.lower(pssetmarknew[i][ij]) then
								if online==nil then
									psdelaydeathcheck=GetTime()-10
								end
								if (online and isDead==nil and UnitIsDeadOrGhost(name2)==nil) then
									if GetRaidTargetIndex(pssetmarknew[i][ij])==nil or (GetRaidTargetIndex(pssetmarknew[i][ij]) and GetRaidTargetIndex(pssetmarknew[i][ij])~=i) then
										SetRaidTarget(pssetmarknew[i][ij], i)
									end
									metka=1
									ij=98
								end
								oj=96
							end
							oj=oj+1
						end
					else
						if UnitIsDeadOrGhost(pssetmarknew[i][ij])==nil then
							if GetRaidTargetIndex(pssetmarknew[i][ij])==nil or (GetRaidTargetIndex(pssetmarknew[i][ij]) and GetRaidTargetIndex(pssetmarknew[i][ij])~=i) then
								SetRaidTarget(pssetmarknew[i][ij], i)
							end
							metka=1
							ij=98
						end
					end
				end
			end
		end
		end


else
if (spammvar==nil) then
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..psmarkserror)
spammvar=1
end
--отключаю
PSF_buttonoffmark()
end
timeeventr=curtime+secrefmark
end
end

--мое инфо
if psshushinfo then
if curtime>psshushinfo then
psshushinfo=nil
end
end


if psunmarkallraiders and curtime>psunmarkallraiders then
psunmarkallraiders=nil
if(IsRaidOfficer()==1) then

for i = 1,GetNumRaidMembers() do local name = GetRaidRosterInfo(i)
	if UnitExists(name) and GetRaidTargetIndex(name) and GetRaidTargetIndex(name)>0 then
		SetRaidTarget(name, 0)
	end
end

end
end

--запись евентов в ин комбат модуль
if #psincombattrack11_writeinfoinmodule>0 then
	if psdelayincmb==nil then psdelayincmb=GetTime()+0.3
	end
	if GetTime()>psdelayincmb then
		psdelayincmb=psdelayincmb+0.3
		local i=1
		while i<=#psincombattrack11_writeinfoinmodule do
			if psincombattrack11_writeinfoinmodule[i] and GetTime()>psincombattrack11_writeinfoinmodule[i] then
				psdelayincmb=GetTime()


--ыытест ЕСЛИ ИСПРАВЛЯЮ ТУТ ЧТО-то ПИШУ ТАКОЕ ЖЕ В МОДУЛЕ УИ фрейм функ



				for j=1,#pssicombatin_indexboss[pssavedplayerpos][1] do
					if pssicombatin_indexboss[pssavedplayerpos][1][j]==psincombattrack4_eventidtoinsert[i] then
						table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][2],(psincombattrack2_timecaststart[i]-pscombatstarttime))
						if #pssicombatin_damageinfo[pssavedplayerpos][1][j][3]>0 then
							table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][3],pssicombatin_damageinfo[pssavedplayerpos][1][j][3][#pssicombatin_damageinfo[pssavedplayerpos][1][j][3]]+1)
						else
							table.insert(pssicombatin_damageinfo[pssavedplayerpos][1][j][3],1)
						end
						local txt=""
						local ttt=""
						txt=format(psincombattrack9_bossspellname[i],pssicombatin_damageinfo[pssavedplayerpos][1][j][3][#pssicombatin_damageinfo[pssavedplayerpos][1][j][3]]).." "
						txt=txt..psincombattrack16_additionaltext[i]
						if #psincombattrack5_whokiked[i]>0 then
							if psincombattrack5_whokiked[i][1]=="1" then
								txt=txt.."|cff00ff00"..psinterrupted3.."|r. "
							elseif psincombattrack5_whokiked[i][1]=="2" then
								txt=txt.."|cffff0000"..psinterrupted4.."|r. "
							elseif psincombattrack5_whokiked[i][1]=="3" then
								txt=txt..psinterrupted6..". "
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
						i=1000
--обновл фрейма если открыт
  psupdateframewithnewinfo()

					end
				end
			end
		i=i+1
		end
	end
end

--преинтерпат чек!
if #preinterrupt1>0 then
	if curtime>preinterrupt1[1] then
		for i=1,#psincombattrack1_bossid do
			if psincombattrack1_bossid[i]==preinterrupt4[1] then
				if #psincombattrack5_whokiked[i]==0 then
					local bb=0
					for nm=1,GetNumRaidMembers() do
						if bb==0 then
							if UnitGUID("raid"..nm.."-target") and UnitGUID("raid"..nm.."-target")==preinterrupt4[1] then
								local _,_,_,_,_,endTime = UnitCastingInfo("raid"..nm.."-target")
								if endTime then
									bb=1
								else
									bb=2
								end
							end
						end
					end
					--каста уже нет, значит прекик был киком!
					if bb==2 then

						if #psincombattrack7_whocasted[i]>0 then
							table.insert(psincombattrack5_whokiked[i],"1") --сбит прекастом
							table.insert(psincombattrack6_timekiked[i],"1")
						else
							table.insert(psincombattrack5_whokiked[i],"2") --сбит но хз кем
							table.insert(psincombattrack6_timekiked[i],"2")
						end

						if psincombattrack3_timestopcheck[i]>GetTime()+1.5 then
							psincombattrack3_timestopcheck[i]=GetTime()+1.5
						end

					end
				end
			end
		end
	table.remove(preinterrupt1,1)
	table.remove(preinterrupt2,1)
	table.remove(preinterrupt3,1)
	table.remove(preinterrupt4,1)
	end
end

--чек на сбитие станом!
if #psinterbystan1>0 then
	if curtime>psinterbystan1[1] then
		for i=1,#psincombattrack1_bossid do
			if psincombattrack1_bossid[i]==psinterbystan2[1] then
				if #psincombattrack5_whokiked[i]==0 then
					local bb=0
					if psinterbystan3[i]==1 then
						bb=2
					end
					if bb==0 then
					for nm=1,GetNumRaidMembers() do
						if bb==0 then
							local name2 = GetRaidRosterInfo(nm)
							local gggid=UnitGUID(name2)
							if gggid and gggid==psinterbystan2[1] then
								local sp2,_,_,_,_,endTime = UnitCastingInfo("raid"..nm)
								if endTime and sp2 and sp2==psinterbystan4[1] then
									--bb=1
								else
									bb=2
								end
							end
							if bb==0 then
							if UnitGUID("raid"..nm.."-target") and UnitGUID("raid"..nm.."-target")==psinterbystan2[1] then
								local sp2,_,_,_,_,endTime = UnitCastingInfo("raid"..nm.."-target")
								if endTime and sp2 and sp2==psinterbystan4[1] then
									bb=1
								else
									bb=2
								end
							end
							end
						end
					end
					end
					--каста уже нет, значит прекик был киком!
					if bb==2 then

							table.insert(psincombattrack5_whokiked[i],"3") --сбит
							table.insert(psincombattrack6_timekiked[i],"3")


						if psincombattrack3_timestopcheck[i]>GetTime()+1.5 then
							psincombattrack3_timestopcheck[i]=GetTime()+1.5
						end
					end
				end
			end
		end
	table.remove(psinterbystan1,1)
	table.remove(psinterbystan2,1)
	table.remove(psinterbystan3,1)
	table.remove(psinterbystan4,1)
	end
end




end






function PhoenixStyle_OnEvent(self,event,...)


if(lalaproverka==nil)then
--chechtekzone()
pszonechangedalldel=GetTime()-3
lalaproverka=1
end


if event == "COMBAT_LOG_EVENT_UNFILTERED" then

local arg1, arg2, arg3,arg4,arg5,arg6,argNEW1,arg7,arg8,arg9,argNEW2,arg10,arg11,arg12,arg13,arg14, arg15,arg16,arg17,arg18,arg19 = ...


--ыытест дописать еще другие рейды
if arg2=="UNIT_DIED" then

	local id=tonumber(string.sub(arg7,-12,-9),16)
	local bil2=0
if id~=0 then

	if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids") then
		--1 - 4 потому что эти модули загружены, для других цифры иные
		for i=1,4 do
			for j=1,#psbossid[i] do
				for t=1,#psbossid[i][j] do
					if psbossid[i][j][t]==id then
						bil2=1
					end
				end
			end
		end
		if bil2==1 then
				psiccwipereport()
		end
	end

	bil2=0

	if IsAddOnLoaded("PhoenixStyleMod_Firelands") then
		--5 потому что эти модули загружены, для других цифры иные
			for j=1,#psbossid[5] do
				for t=1,#psbossid[5][j] do
					if psbossid[5][j][t]==id then
						bil2=1
					end
				end
			end
		if bil2==1 then
				psiccwipereport_2()
		end
	end

	bil2=0

	if IsAddOnLoaded("PhoenixStyleMod_DragonSoul") then
		--6 потому что эти модули загружены, для других цифры иные
			for j=1,#psbossid[6] do
				for t=1,#psbossid[6][j] do
					if psbossid[6][j][t]==id then
						bil2=1
					end
				end
			end
		if bil2==1 then
				psiccwipereport_3()
		end
	end



end

	--при смерти магмаря или головы - добавлять обоих в блек лист! баг боссов
	if id==41570 or id==42347 then
		local magb=0
		psmagmawcantrelease=1
		if #psbossbugs>0 then
			for k=1,#psbossbugs do
				if psbossbugs[k]==41570 then
					magb=1
				end
			end
		end
		if magb==0 then
			table.insert(psbossbugs,41570)
		end
		magb=0
		if #psbossbugs>0 then
			for k=1,#psbossbugs do
				if psbossbugs[k]==42347 then
					magb=1
				end
			end
		end
		if magb==0 then
			table.insert(psbossbugs,42347)
		end
	end





	--обнуление таймера при смерти игрока
	if UnitInRaid(arg8) and not UnitIsFeignDeath(arg8) then
    local B = tonumber(arg7:sub(5,5), 16)
    local maskedB = B % 8
    if maskedB and maskedB==0 then
      pswipecheckdelay=GetTime()-1
    end

  end
    --может умер пет? проверим!
    if pspetstableok[1] and #pspetstableok[1]>0 then
      for i,petguid in ipairs(pspetstableok[1]) do
        if petguid == arg7 then
          --удалять петов через 2 сек
          if pspettodelete1==nil then
            pspettodelete1={}
          end
          table.insert(pspettodelete1,arg7)
          pspettodelete2=GetTime()+2
        end
      end
    end
	--end
	
	if psunitraidorparty(arg7,arg8) and not UnitIsFeignDeath(arg8) then
    --отправка в дес репорт инфо о смерти
    if UnitInRaid("player")==nil and UnitInParty("player") then
      if psdiedinparty then
        psdiedinparty=psdiedinparty+1
      end
    end
    psdeathrepevent(0,argNEW1,argNEW2,arg8,arg7)
  end


end

--мрут тотемы
if arg2=="UNIT_DESTROYED" and arg7 then
    if pspetstableok[1] and #pspetstableok[1]>0 then
      for i,petguid in ipairs(pspetstableok[1]) do
        if petguid == arg7 then
          --удалять петов через 2 сек
          if pspettodelete1==nil then
            pspettodelete1={}
          end
          table.insert(pspettodelete1,arg7)
          pspettodelete2=GetTime()+2
        end
      end
    end
end

--десрепорт записи инфо
--pslastattack={{},{},{},{}}--имя время фраза
--другие типа смертей, и анонсы
if arg2=="SPELL_INSTAKILL" then
  psdeathrepevent(1,argNEW1,argNEW2,arg8,arg7,arg10,arg11)
  psdeathreplastattacksave(arg8,arg11.." (|cffff0000"..psdrinstakill.."|r)","|s4id"..arg10.."|id (|cffff0000"..psdrinstakill.."|r)")
end
if arg2=="ENVIRONMENTAL_DAMAGE" then
  local aarg12=arg12
  if aarg12==0 then
    aarg12=-1
  end
  psdeathrepevent(2,argNEW1,argNEW2,arg8,arg7,0,arg10,arg11,aarg12)
  psdeathreplastattacksave(arg8,psdamageceildeathrep(arg11)..", |cffff0000"..arg10.."|r",psdamageceildeathrep(arg11)..", |cffff0000"..arg10.."|r")
end
if arg2=="SWING_DAMAGE" then
  if ((arg11 and arg11>=0) or (arg15 and arg15>10000)) then
    --проверяем если на прижигании 3ка пуста, то записываем
    if psprizhig1 and psprizhig1[1] and #psprizhig1[1]>0 then
      for i=1,#psprizhig1[1] do
        if psprizhig1[1][i]==arg8 and GetTime()<psprizhig1[2][i]+0.8 and psprizhig1[3][i]==0 then
          local who=""
          if arg5 then
            who=" ["..arg5.."]"
          end
          local dmg=arg10-arg11
          local overk=arg11
          if arg11<0 then
            overk=arg15
          end
          psprizhig1[3][i]=psdamageceildeathrep(dmg)..", Melee ("..psoverkill..": "..psdamageceildeathrep(overk)..")"..who
          if psdeathrepsavemain[7]==1 then
            who=""
          elseif arg5 then
            who=" [|cffff0000"..psgetmarkforchat(argNEW1)..arg5.."|r]"
          end
          psprizhig1[4][i]=psdamageceildeathrep(dmg)..", Melee ("..psoverkill..": "..psdamageceildeathrep(overk)..")"..who
        end
      end
    end
  end
  if arg11 and arg11>=0 then
    psdeathrepevent(10,argNEW1,argNEW2,arg8,arg7,0,"Melee",arg10,arg11,arg16,arg5,arg13,arg14,arg15,arg12)
  else
    local crittxt1=""
    local crittxt2=""
    if arg16 then
      crittxt1=" |cffff0000"..psdrcrit.."|r "
      crittxt2=" "..psdrcrit.." "
    end
    local who=""
    local who2=""
    if arg5 then
      who=" ["..arg5.."]"
      who2=" [|cffff0000"..arg5.."|r]"
    end
    if psdeathrepsavemain[7]==1 then
      who2=""
    end
    psdeathreplastattacksave(arg8,psdamageceildeathrep(arg10)..", Melee"..crittxt1..who,psdamageceildeathrep(arg10)..", Melee"..crittxt2..who2)
  end
end
if (arg2=="SPELL_DAMAGE" or arg2=="SPELL_PERIODIC_DAMAGE" or arg2=="RANGE_DAMAGE" or arg2=="DAMAGE_SHIELD") then
  if ((arg14 and arg14>=0) or (arg18 and arg18>10000)) then
    --проверяем если на прижигании 3ка пуста, то записываем
    if psprizhig1 and psprizhig1[1] and #psprizhig1[1]>0 then
      for i=1,#psprizhig1[1] do
        if psprizhig1[1][i]==arg8 and GetTime()<psprizhig1[2][i]+0.8 and psprizhig1[3][i]==0 then
          local who=""
          if arg5 then
            who=" ["..arg5.."]"
          end
          local dmg=arg13-arg14
          local overk=arg14
          if arg14<0 then
            overk=arg18
          end
          psprizhig1[3][i]=psdamageceildeathrep(dmg)..", "..arg11.." ("..psoverkill..": "..psdamageceildeathrep(overk)..")"..who
          if psdeathrepsavemain[7]==1 then
            who=""
          elseif arg5 then
            who=" [|cffff0000"..psgetmarkforchat(argNEW1)..arg5.."|r]"
          end
          psprizhig1[4][i]=psdamageceildeathrep(dmg)..", |s4id"..arg10.."|id ("..psoverkill..": "..psdamageceildeathrep(overk)..")"..who
        end
      end
    end
  end
  if arg14 and arg14>=0 then
    psdeathrepevent(10,argNEW1,argNEW2,arg8,arg7,arg10,arg11,arg13,arg14,arg19,arg5,arg16,arg17,arg18,arg15)
  else
    local crittxt1=""
    local crittxt2=""
    if arg19 then
      crittxt1=" |cffff0000"..psdrcrit.."|r "
      crittxt2=" "..psdrcrit.." "
    end
    local who=""
    local who2=""
    if arg5 and arg10~=87023 then
      who=" ["..arg5.."]"
      who2=" [|cffff0000"..arg5.."|r]"
    end
    if psdeathrepsavemain[7]==1 then
      who2=""
    end
    psdeathreplastattacksave(arg8,psdamageceildeathrep(arg13)..", "..arg11..""..crittxt1..who, psdamageceildeathrep(arg13)..", |s4id"..arg10.."|id"..crittxt2..who2)
  end
end


--не отображать смерть после окончания ангела
if arg2=="SPELL_AURA_REMOVED" and arg10==27827 then
  local bil=0
  if #pslastdeath[1]>0 then
    for i=1,#pslastdeath[1] do
      if pslastdeath[1][i] and pslastdeath[1][i]==arg8 then
        pslastdeath[2][i]=GetTime()+1.8
        bil=1
      end
    end
  end
  if bil==0 then
    table.insert(pslastdeath[1],arg8)
    local tm=GetTime()+1.8
    table.insert(pslastdeath[2],tm)
  end
end

--появляется ангел, в течении 1 сек все абсорбы = смерть репорт!
if arg2=="SPELL_AURA_APPLIED" and arg10==27827 then
if tabltemppriest==nil then
  tabltemppriest={{},{}}
end

--если есть в ожидании фраза тогда репортим без записи...
local zhd=0
if pskillreport and pskillreport[1] and #pskillreport[1]>0 then
  for i=1,#pskillreport[1] do
    if pskillreport[1][i]==arg8 and GetTime()<pskillreport[3][i]+5 then
      zhd=1
        if psdeathrepbossnametemp then
          pscaststartinfo(0,pskillreport[2][i], -1, "id1", 666, psdreventname,psdeathrepbossnametemp,2)
          psdeathrepbossnametemp=nil
        else
          table.insert(psdeathwaiting[1],pskillreport[2][i])
          local timeevent=GetTime()-pscombatstarttime
          table.insert(psdeathwaiting[2],timeevent)
        end
        psreportdeathchat(pskillreport[4][i])
    end
  end
end
if zhd==0 then
  table.insert(tabltemppriest[1],arg8)
  local tm=GetTime()
  table.insert(tabltemppriest[2],tm)
end
end

--спелл мисс и свинг мисс, если есть в табл - это причина смерти, запись и анонс
if (arg2=="SPELL_MISSED" or arg2=="SPELL_PERIODIC_MISSED" or arg2=="RANGE_MISSED" or arg2=="DAMAGE_SHIELD_MISSED") and arg13=="ABSORB" then

--прист
if tabltemppriest and tabltemppriest[1] and #tabltemppriest[1]>0 then
  local bil=0
  for i=1,#tabltemppriest[1] do
    if tabltemppriest[1][i]==arg8 and GetTime()<tabltemppriest[2][i]+1.5 then
      bil=1
    end
  end
  if bil==1 then
    --текст что записываем в табл ожидания и симуляция смерти
    local spspirit=GetSpellInfo(27827)
    local who=""
    if arg5 then
      who=" ["..arg5.."]"
    end
    local txt1=psaddcolortxt(1,arg8)..arg8..psaddcolortxt(2,arg8).." > "..psdamageceildeathrep(arg15)..", "..arg11..who.." (|cffff0000"..psabsorbedby.." "..spspirit.."|r)"
    if psdeathrepsavemain[7]==1 then
      who=""
    end
    local txt2="PS "..psdieddeathrep..": "..psgetmarkforchat(argNEW2)..psaddcolortxt(1,arg8)..arg8..psaddcolortxt(2,arg8).." > "..psdamageceildeathrep(arg15)..", |s4id"..arg10.."|id"..who.." (|cffff0000"..psabsorbedby.."|r |s4id27827|id)"
    
if pskillreport==nil then
  pskillreport={{},{},{},{}} --ник, фраза в ожидании, время записи, фраза для чата
end

    table.insert(pskillreport[1],arg8)
    table.insert(pskillreport[2],txt1)
    local tmmm2=GetTime()-0.01
    table.insert(pskillreport[3],tmmm2)
    table.insert(pskillreport[4],txt2)
    psdeathrepevent(0,argNEW1,argNEW2,arg8,arg7)
  end
  
  
end
--маг
if psprizhig1 and psprizhig1[1] and #psprizhig1[1]>0 then
  for i=1,#psprizhig1[1] do
    if psprizhig1[1][i]==arg8 and GetTime()<psprizhig1[2][i]+1.5 and psprizhig1[3][i]==0 then
      local who=""
      if arg5 then
        who=" ["..arg5.."]"
      end
      psprizhig1[3][i]=psdamageceildeathrep(arg15)..", "..arg11..who
      if psdeathrepsavemain[7]==1 then
        who=""
      elseif arg5 then
        who=" [|cffff0000"..psgetmarkforchat(argNEW1)..arg5.."|r]"
      end
      psprizhig1[4][i]=psdamageceildeathrep(arg15)..", "..arg11..who
      psprizhig1[5][i]=0
      psprizhig1[6][i]=0
    end
  end
end

end

if arg2=="SWING_MISSED" then --and arg10=="ABSORB"

--прист
if tabltemppriest and tabltemppriest[1] and #tabltemppriest[1]>0 then
  local bil=0
  for i=1,#tabltemppriest[1] do
    if tabltemppriest[1][i]==arg8 and GetTime()<tabltemppriest[2][i]+1.5 then
      bil=1
    end
  end
  if bil==1 then
    --текст что записываем в табл ожидания и симуляция смерти
    local spspirit=GetSpellInfo(27827)
    local who=""
    if arg5 then
      who=" ["..arg5.."]"
    end
    local txt1=psaddcolortxt(1,arg8)..arg8..psaddcolortxt(2,arg8).." > "..psdamageceildeathrep(arg12)..", Melee"..who.." (|cffff0000"..psabsorbedby.." "..spspirit.."|r)"
    if psdeathrepsavemain[7]==1 then
      who=""
    end
    local txt2="PS "..psdieddeathrep..": "..psgetmarkforchat(argNEW2)..psaddcolortxt(1,arg8)..arg8..psaddcolortxt(2,arg8).." > "..psdamageceildeathrep(arg12)..", Melee"..who.." (|cffff0000"..psabsorbedby.."|r |s4id27827|id)"

if pskillreport==nil then
  pskillreport={{},{},{},{}} --ник, фраза в ожидании, время записи
end

    table.insert(pskillreport[1],arg8)
    table.insert(pskillreport[2],txt1)
    local tmmm2=GetTime()-0.01
    table.insert(pskillreport[3],tmmm2)
    table.insert(pskillreport[4],txt2)
    psdeathrepevent(0,argNEW1,argNEW2,arg8,arg7)
  end
  
end

--маг
if psprizhig1 and psprizhig1[1] and #psprizhig1[1]>0 then
  for i=1,#psprizhig1[1] do
    if psprizhig1[1][i]==arg8 and GetTime()<psprizhig1[2][i]+1.5 and psprizhig1[3][i]==0 then
      local who=""
      if arg5 then
        who=" ["..arg5.."]"
      end
      psprizhig1[3][i]=psdamageceildeathrep(arg12)..", Melee"..who
      if psdeathrepsavemain[7]==1 then
        who=""
      elseif arg5 then
        who=" [|cffff0000"..psgetmarkforchat(argNEW1)..arg5.."|r]"
      end
      psprizhig1[4][i]=psdamageceildeathrep(arg12)..", Melee"..who
      psprizhig1[5][i]=0
      psprizhig1[6][i]=0
    end
  end
end

end


--прижигание
if arg2=="SPELL_AURA_APPLIED" and arg10==87023 then
if psprizhig1==nil then
  psprizhig1={{},{},{},{},{},{}} --имя время фраза, фраза чат, фраза с ласт атаки запасная, фраза с ласт атаки запасная в чат
end
--сначало проверяем уже записанное в табл
local bil=0
if pskillreport and pskillreport[1] and #pskillreport[1]>0 then
  for i=1,#pskillreport[1] do
    if pskillreport[1][i] and arg8==pskillreport[1][i] and GetTime()<pskillreport[3][i]+2 then
      bil=1
      table.insert(psprizhig1[1],arg8)
      local tm=GetTime()
      table.insert(psprizhig1[2],tm)
      local as=pskillreport[2][i]
      if string.find (as,">") then
        as=string.sub(as,string.find (as,">")+2)
      end
      table.insert(psprizhig1[4],as)
      if string.find(as,"{rt") then
        as=string.sub(as,1,string.find(as,"{rt")-1)..string.sub(as,string.find(as,"{rt")+4)
      end
      table.insert(psprizhig1[3],as)
      table.insert(psprizhig1[5],0)
      table.insert(psprizhig1[6],0)
      
      table.remove(pskillreport[1],i)
      table.remove(pskillreport[2],i)
      table.remove(pskillreport[3],i)
      table.remove(pskillreport[4],i)
    end
  end
end
if bil==0 then
  table.insert(psprizhig1[1],arg8)
  local tm=GetTime()
  table.insert(psprizhig1[2],tm)
  table.insert(psprizhig1[3],0)
  table.insert(psprizhig1[4],0)
  local aa=0
  if pslastattack and pslastattack[1] and #pslastattack[1]>0 then
    for i=1,#pslastattack[1] do
      if pslastattack[1][i]==arg8 and GetTime()<=pslastattack[2][i]+1.5 then
        table.insert(psprizhig1[5],pslastattack[3][i])
        table.insert(psprizhig1[6],pslastattack[4][i])
        aa=1
      end
    end
  end
  if aa==0 then
    table.insert(psprizhig1[5],0)
    table.insert(psprizhig1[6],0)
  end
end
end


--запись посл. атаки












--трекер петов
if arg2=="SPELL_SUMMON" and arg4 and arg7 and UnitInRaid("player") then
  local bil=0
  local plguid, plname=psgetpetownerguid(arg4,arg5)
  psunitisplayer(plguid,plname)
  if psunitplayertrue or bit.band(arg9, COMBATLOG_OBJECT_TYPE_PET) > 0 then
    for i,petguid in ipairs(pspetstableok[1]) do
      if petguid == arg7 then
        --double pets 
        if pspetstableok[2][i]~=plguid then
          out ("PHOENIX STYLE ERROR: Pet with name: >> "..arg8.." << got more than 1 owner! Let me know it`s name please!")
        end
        pspetstableok[3][i]=GetTime()
        bil=1
      end
    end
    if bil==0 then
      table.insert(pspetstableok[1],arg7)
      table.insert(pspetstableok[2],plguid)
      table.insert(pspetstableok[3],GetTime())
      table.insert(pspetstableok[4],plname)
      --print ("добавил пета: "..arg8)--ыытест
      if arg10==87426 then
        table.insert(pspetstableok[5],3)
      elseif bit.band(arg9, COMBATLOG_OBJECT_TYPE_PET)>0 then
        table.insert(pspetstableok[5],2)
      else
        table.insert(pspetstableok[5],1)
      end
    end
  end
end



--other abilities to found a pet
if arg2=="DAMAGE_SPLIT" and arg10==25228 and UnitInRaid("player") then
  local bil=0
  local plguid, plname=psgetpetownerguid(arg4,arg5)
  psunitisplayer(plguid,plname)
  if psunitplayertrue or bit.band(arg9, COMBATLOG_OBJECT_TYPE_PET) > 0 then
    for i,petguid in ipairs(pspetstableok[1]) do
      if petguid == arg7 then
         --double pets 
         if pspetstableok[2][i]~=plguid then
          out ("PHOENIX STYLE ERROR: Pet with name: >> "..arg8.." << got more than 1 owner! Let me know it`s name please!")
        end
        pspetstableok[3][i]=GetTime()
        bil=1
      end
    end
    if bil==0 then
      table.insert(pspetstableok[1],arg7)
      table.insert(pspetstableok[2],plguid)
      table.insert(pspetstableok[3],GetTime())
      table.insert(pspetstableok[4],plname)
      if bit.band(arg9, COMBATLOG_OBJECT_TYPE_PET)>0 then
        table.insert(pspetstableok[5],2)
      else
        table.insert(pspetstableok[5],1)
      end
    end
  end
end

if arg2=="SPELL_AURA_APPLIED" and arg10==136 then
  local bil=0
  local plguid, plname=psgetpetownerguid(arg4,arg5)
  psunitisplayer(plguid,plname)
  if psunitplayertrue or bit.band(arg9, COMBATLOG_OBJECT_TYPE_PET) > 0 then
    for i,petguid in ipairs(pspetstableok[1]) do
      if petguid == arg7 then
         --double pets 
         if pspetstableok[2][i]~=plguid then
          out ("PHOENIX STYLE ERROR: Pet with name: >> "..arg8.." << got more than 1 owner! Let me know it`s name please!")
        end
        pspetstableok[3][i]=GetTime()
        bil=1
      end
    end
    if bil==0 then
      table.insert(pspetstableok[1],arg7)
      table.insert(pspetstableok[2],plguid)
      table.insert(pspetstableok[3],GetTime())
      table.insert(pspetstableok[4],plname)
      if bit.band(arg9, COMBATLOG_OBJECT_TYPE_PET)>0 then
        table.insert(pspetstableok[5],2)
      else
        table.insert(pspetstableok[5],1)
      end
    end
  end
end





--железная дорога и худовара хрень
if arg2=="SPELL_CREATE" and (arg10==49844 or arg10==61031) and pstrackbadsummons==1 then
  psunitisplayer(arg4,arg5)
  local a1,a2=IsInInstance()
  if psunitplayertrue and (UnitInRaid("player") or UnitInParty("player")) then
    if a2=="raid" then
      pszapuskanonsa("raid", "{rt8} PhoenixStyle: "..arg5.." > "..arg11)
    end
    if a2=="party" then
      pszapuskanonsa("party", "{rt8} PhoenixStyle: "..arg5.." > "..arg11)
    end
    if a2=="pvp" then
      pszapuskanonsa("BATTLEGROUND", "{rt8} PhoenixStyle: "..arg5.." > "..arg11)
    end
  end
end



if arg2=="SPELL_INTERRUPT" then


if #psincombattrack1_bossid>0 then
	for i=1,#psincombattrack1_bossid do
		if psincombattrack1_bossid[i]==arg7 and GetTime()<psincombattrack3_timestopcheck[i] then
		--проверка на ИД каста, иначе это запишется в попытку!!
		if psincombattrack15_castid[i]==arg13 or psincombattrack15_castid[i]==0 then
			local bil=0
			for j=1,#psincombattrack5_whokiked[i] do
				if psincombattrack5_whokiked[i][j]==arg5 then
					bil=1
				end
			end
			if bil==0 then
				for j=1,#psincombattrack7_whocasted[i] do
					if psincombattrack7_whocasted[i][j] and psincombattrack7_whocasted[i][j]==arg5 then
						table.remove(psincombattrack7_whocasted[i],j)
						table.remove(psincombattrack8_timecasted[i],j)
					end
				end
			end

			if bil==0 then
				--если время больше чем 90% то красным пишем
				local timesbit=math.ceil((GetTime()-psincombattrack2_timecaststart[i])*10)/10
				if psincombattrack10_redtimeifmorethen[i]~=0 and GetTime()>psincombattrack10_redtimeifmorethen[i] then
					timesbit="|cffff0000"..timesbit.."|r"
				end

				--bnbn=1

				--удаляем сбития прекиками и прекастами
				if psincombattrack5_whokiked[i][1]=="1" or psincombattrack5_whokiked[i][1]=="2" or psincombattrack5_whokiked[i][1]=="3" then
					table.remove(psincombattrack5_whokiked[i],1)
					table.remove(psincombattrack6_timekiked[i],1)
				end

				if #psincombattrack5_whokiked[i]>0 then
					table.insert(psincombattrack7_whocasted[i],arg5)
					table.insert(psincombattrack8_timecasted[i],(arg11..", "..(math.ceil((GetTime()-psincombattrack2_timecaststart[i])*10)/10)))
				else
					table.insert(psincombattrack5_whokiked[i],arg5)
					table.insert(psincombattrack6_timekiked[i],(arg11..", "..timesbit))
				end
			end
		if psincombattrack3_timestopcheck[i]>GetTime()+1.5 then
			psincombattrack3_timestopcheck[i]=GetTime()+1.5
		end
		--если сбили но уже другой каст то это попытка!
		else
			local bil=0
			for j=1,#psincombattrack7_whocasted[i] do
				if psincombattrack7_whocasted[i][j]==arg5 then
					bil=1
				end
			end
			if #psincombattrack5_whokiked>0 then
				for j=1,#psincombattrack5_whokiked[i] do
					if psincombattrack5_whokiked[i][j]==arg5 then
						bil=1
					end
				end
			end
			if bil==0 then
				--если время больше чем 90% то красным пишем, ТОЛЬКО если точно проверяем не для боссов!
				local timesbit=math.ceil((GetTime()-psincombattrack2_timecaststart[i])*10)/10

				if psincombattrack10_redtimeifmorethen[i]~=0 and GetTime()>psincombattrack10_redtimeifmorethen[i] and psincombattrack12_useallinterrupts[i]==2 then
					timesbit="|cffff0000"..timesbit.."|r"
				end
				table.insert(psincombattrack7_whocasted[i],arg5)
				table.insert(psincombattrack8_timecasted[i],(arg11..", "..timesbit))
				bnbn=1
			end
		end
		end
	end

end
end


if arg2=="SPELL_CAST_SUCCESS" and (arg10==47476 or arg10==57994 or arg10==2139 or arg10==6552 or arg10==26090 or arg10==72 or arg10==47528 or arg10==85285 or arg10==34490 or arg10==24259 or arg10==19647 or arg10==31935 or arg10==41378 or arg10==80964 or arg10==80965 or arg10==78675) then
local bnbn=0
if #psincombattrack1_bossid>0 then
	for i=1,#psincombattrack1_bossid do
		if psincombattrack1_bossid[i]==arg7 and GetTime()<psincombattrack3_timestopcheck[i] then
			local bil=0
			for j=1,#psincombattrack7_whocasted[i] do
				if psincombattrack7_whocasted[i][j]==arg5 then
					bil=1
				end
			end
			if #psincombattrack5_whokiked>0 then
				for j=1,#psincombattrack5_whokiked[i] do
					if psincombattrack5_whokiked[i][j]==arg5 then
						bil=1
					end
				end
			end
			if bil==0 then
				--если время больше чем 90% то красным пишем, ТОЛЬКО если точно проверяем не для боссов!
				local timesbit=math.ceil((GetTime()-psincombattrack2_timecaststart[i])*10)/10

				if psincombattrack10_redtimeifmorethen[i]~=0 and GetTime()>psincombattrack10_redtimeifmorethen[i] and psincombattrack12_useallinterrupts[i]==2 then
					timesbit="|cffff0000"..timesbit.."|r"
				end
				table.insert(psincombattrack7_whocasted[i],arg5)
				table.insert(psincombattrack8_timecasted[i],(arg11..", "..timesbit))
				bnbn=1
			end
		end
	end
end
if bnbn==0 then
table.insert(psprecast1,1,GetTime())
table.insert(psprecast2,1,arg5 or "unknown")
table.insert(psprecast3,1,arg11 or "unknown")
table.insert(psprecast4,1,arg7 or "unknown")
table.insert(psprecast5,1,"0")
table.insert(psprecast6,1,"0")
psprecast1[31]=nil
psprecast2[31]=nil
psprecast3[31]=nil
psprecast4[31]=nil
psprecast5[31]=nil
psprecast6[31]=nil
end
end

if arg2=="SPELL_MISSED" and (arg10==57994 or arg10==2139 or arg10==6552 or arg10==26090 or arg10==72 or arg10==47528 or arg10==85285 or arg10==34490 or arg10==24259 or arg10==19647 or arg10==31935 or arg10==41378 or arg10==80964 or arg10==80965) then
local bnbn=0
if #psincombattrack1_bossid>0 then
	for i=1,#psincombattrack1_bossid do
		if psincombattrack1_bossid[i]==arg7 and GetTime()<psincombattrack3_timestopcheck[i] then
			local bil=0
			for j=1,#psincombattrack7_whocasted[i] do
				if psincombattrack7_whocasted[i][j]==arg5 then
					psincombattrack8_timecasted[i][j]=arg11..", "..(math.ceil((GetTime()-psincombattrack2_timecaststart[i])*10)/10).." - "..arg13
					bnbn=1
				end
			end
		end
	end
end
if bnbn==0 then
table.insert(psprecast1,1,GetTime())
table.insert(psprecast2,1,arg5 or "unknown")
table.insert(psprecast3,1,arg11 or "unknown")
table.insert(psprecast4,1,arg7 or "unknown")
table.insert(psprecast5,1,arg13 or "unknown")
table.insert(psprecast6,1,"0")
psprecast1[31]=nil
psprecast2[31]=nil
psprecast3[31]=nil
psprecast4[31]=nil
psprecast5[31]=nil
psprecast6[31]=nil
end
end

--1 интерапт норм и другие станом!
if (pscheckprecastnotboss or #psincombattrack1_bossid>0) and arg2=="SPELL_AURA_APPLIED" and (arg10==91807 or arg10==30283 or arg10==8122 or arg10==12355 or arg10==31661 or arg10==19503 or arg10==88625 or arg10==118 or arg10==61721 or arg10==28272 or arg10==61305 or arg10==28271 or arg10==853 or arg10==1776 or arg10==1833 or arg10==408 or arg10==2094 or arg10==47476 or arg10==82691 or arg10==44572 or arg10==22703 or arg10==89766 or arg10==605 or arg10==64044 or arg10==12809 or arg10==46968 or arg10==3355 or arg10==33786 or arg10==58861 or arg10==22570 or arg10==5211 or arg10==710 or arg10==24394 or arg10==51209 or arg10==2637 or arg10==9005 or arg10==2812 or arg10==6770 or arg10==76780 or arg10==51514 or arg10==39796 or arg10==93986 or arg10==6789 or arg10==54786 or arg10==5782 or arg10==5484 or arg10==6358 or arg10==5246 or arg10==85388 or arg10==30217 or arg10==67769 or arg10==30216 or arg10==13327 or arg10==56 or arg10==20549 or arg10==28730 or arg10==25046 or arg10==33390 or arg10==50613 or arg10==69179 or arg10==80483 or arg10==7922 or arg10==20253 or arg10==18498 or arg10==19386 or arg10==15487 or arg10==9484 or arg10==50519 or arg10==1513 or arg10==91800 or arg10==91797 or arg10==83047 or arg10==87204 or arg10==10326 or arg10==20066 or arg10==13181) then
local bnbn=0
if #psincombattrack1_bossid>0 then
	for i=1,#psincombattrack1_bossid do
		if psincombattrack1_bossid[i]==arg7 and GetTime()<psincombattrack3_timestopcheck[i] then
			local bil=0
			for j=1,#psincombattrack7_whocasted[i] do
				if psincombattrack7_whocasted[i][j]==arg5 then
					bil=1
				end
			end
			if #psincombattrack5_whokiked>0 then
				for j=1,#psincombattrack5_whokiked[i] do
					if psincombattrack5_whokiked[i][j]==arg5 then
						bil=1
					end
				end
			end
			if bil==0 then
				--если время больше чем 90% то красным пишем, ТОЛЬКО если точно проверяем не для боссов!
				local timesbit=math.ceil((GetTime()-psincombattrack2_timecaststart[i])*10)/10

				if psincombattrack10_redtimeifmorethen[i]~=0 and GetTime()>psincombattrack10_redtimeifmorethen[i] and psincombattrack12_useallinterrupts[i]==2 then
					timesbit="|cffff0000"..timesbit.."|r"
				end

				table.insert(psincombattrack7_whocasted[i],arg5)
				table.insert(psincombattrack8_timecasted[i],(arg11..", "..timesbit))
				bnbn=1

				if psincombattrack10_redtimeifmorethen[i]>0 and psincombattrack10_redtimeifmorethen[i]>GetTime()+0.4 then
					local nbil=0
					if #psinterbystan2>0 then
						for nb=1,#psinterbystan2 do
							if psinterbystan2[nb]==psincombattrack1_bossid[i] then
								nbil=1
							end
						end
					end
					if nbil==0 then
						table.insert(psinterbystan1,GetTime()+0.2)
						table.insert(psinterbystan2,psincombattrack1_bossid[i])
						table.insert(psinterbystan3,0)
						table.insert(psinterbystan4,psincombattrack14_nameofthecurrentcast[i])
					end
				end
			end
		end
	end
end
if bnbn==0 then
table.insert(psprecast1,1,GetTime())
table.insert(psprecast2,1,arg5 or "unknown")
table.insert(psprecast3,1,arg11 or "unknown")
table.insert(psprecast4,1,arg7 or "unknown")
table.insert(psprecast5,1,"0")
table.insert(psprecast6,1,"1")
psprecast1[31]=nil
psprecast2[31]=nil
psprecast3[31]=nil
psprecast4[31]=nil
psprecast5[31]=nil
psprecast6[31]=nil
end

end



--интерапты с кривыми ИД (хватка смерти), отбрасывание через урон или промах с абсорбом, ТОЛЬКо при вкл не босс типе

if arg2=="SPELL_AURA_APPLIED" and (arg11==psdeathgriplocal) then
local bnbn=0
if #psincombattrack1_bossid>0 then
	for i=1,#psincombattrack1_bossid do
		if psincombattrack1_bossid[i]==arg7 and GetTime()<psincombattrack3_timestopcheck[i] and (psincombattrack12_useallinterrupts[i]==1 or psincombattrack12_useallinterrupts[i]==2) then
			local bil=0
			for j=1,#psincombattrack7_whocasted[i] do
				if psincombattrack7_whocasted[i][j]==arg5 then
					bil=1
				end
			end
			if #psincombattrack5_whokiked>0 then
				for j=1,#psincombattrack5_whokiked[i] do
					if psincombattrack5_whokiked[i][j]==arg5 then
						bil=1
					end
				end
			end
			if bil==0 then
				--если время больше чем 90% то красным пишем, ТОЛЬКО если точно проверяем не для боссов!
				local timesbit=math.ceil((GetTime()-psincombattrack2_timecaststart[i])*10)/10

				if psincombattrack10_redtimeifmorethen[i]~=0 and GetTime()>psincombattrack10_redtimeifmorethen[i] and psincombattrack12_useallinterrupts[i]==2 then
					timesbit="|cffff0000"..timesbit.."|r"
				end

				table.insert(psincombattrack7_whocasted[i],arg5)
				table.insert(psincombattrack8_timecasted[i],(arg11..", "..timesbit))
				bnbn=1
				if psincombattrack10_redtimeifmorethen[i]>0 and psincombattrack10_redtimeifmorethen[i]>GetTime()+1 then
					local nbil=0
					if #psinterbystan2>0 then
						for nb=1,#psinterbystan2 do
							if psinterbystan2[nb]==psincombattrack1_bossid[i] then
								nbil=1
							end
						end
					end
					if nbil==0 then
						table.insert(psinterbystan1,GetTime()+0.5)
						table.insert(psinterbystan2,psincombattrack1_bossid[i])
						table.insert(psinterbystan3,0)
						table.insert(psinterbystan4,psincombattrack14_nameofthecurrentcast[i])
					end
				end
			end
		end
	end
end
if bnbn==0 then
table.insert(psprecast1,1,GetTime())
table.insert(psprecast2,1,arg5 or "unknown")
table.insert(psprecast3,1,arg11 or "unknown")
table.insert(psprecast4,1,arg7 or "unknown")
table.insert(psprecast5,1,"0")
table.insert(psprecast6,1,"1")
psprecast1[31]=nil
psprecast2[31]=nil
psprecast3[31]=nil
psprecast4[31]=nil
psprecast5[31]=nil
psprecast6[31]=nil
end
end

if (arg2=="SPELL_DAMAGE" or (arg2=="SPELL_MISSED" and arg13 and arg13=="ABSORB")) and (arg10==61391 or arg10==51490 or arg10==82207 or arg10==6360) then
local bnbn=0
if #psincombattrack1_bossid>0 then
	for i=1,#psincombattrack1_bossid do
		if psincombattrack1_bossid[i]==arg7 and GetTime()<psincombattrack3_timestopcheck[i] and (psincombattrack12_useallinterrupts[i]==1 or psincombattrack12_useallinterrupts[i]==2) then
			local bil=0
			for j=1,#psincombattrack7_whocasted[i] do
				if psincombattrack7_whocasted[i][j]==arg5 then
					bil=1
				end
			end
			if #psincombattrack5_whokiked>0 then
				for j=1,#psincombattrack5_whokiked[i] do
					if psincombattrack5_whokiked[i][j]==arg5 then
						bil=1
					end
				end
			end
			if bil==0 then
				--если время больше чем 90% то красным пишем, ТОЛЬКО если точно проверяем не для боссов!
				local timesbit=math.ceil((GetTime()-psincombattrack2_timecaststart[i])*10)/10

				if psincombattrack10_redtimeifmorethen[i]~=0 and GetTime()>psincombattrack10_redtimeifmorethen[i] and psincombattrack12_useallinterrupts[i]==2 then
					timesbit="|cffff0000"..timesbit.."|r"
				end

				table.insert(psincombattrack7_whocasted[i],arg5)
				table.insert(psincombattrack8_timecasted[i],(arg11..", "..timesbit))
				bnbn=1
				if psincombattrack10_redtimeifmorethen[i]>0 and psincombattrack10_redtimeifmorethen[i]>GetTime()+1 then
					local nbil=0
					if #psinterbystan2>0 then
						for nb=1,#psinterbystan2 do
							if psinterbystan2[nb]==psincombattrack1_bossid[i] then
								nbil=1
							end
						end
					end
					if nbil==0 then
						table.insert(psinterbystan1,GetTime()+0.5)
						table.insert(psinterbystan2,psincombattrack1_bossid[i])
						table.insert(psinterbystan3,0)
						table.insert(psinterbystan4,psincombattrack14_nameofthecurrentcast[i])
					end
				end
			end
		end
	end
end
if bnbn==0 then
table.insert(psprecast1,1,GetTime())
table.insert(psprecast2,1,arg5 or "unknown")
table.insert(psprecast3,1,arg11 or "unknown")
table.insert(psprecast4,1,arg7 or "unknown")
table.insert(psprecast5,1,"0")
table.insert(psprecast6,1,"1")
psprecast1[31]=nil
psprecast2[31]=nil
psprecast3[31]=nil
psprecast4[31]=nil
psprecast5[31]=nil
psprecast6[31]=nil
end
end


else

--другие евенты


local arg1, arg2, arg3,arg4,arg5,arg6,_,_,_,_,_,_,arg13 = ...

if event=="CHANNEL_UI_UPDATE" then
if PSFmainchated:IsShown() then
openremovechat()
openaddchat()
else
	PhoenixStyleFailbot:UnregisterEvent("CHANNEL_UI_UPDATE")
end
end

if event == "PLAYER_ALIVE" then
psbilresnut=GetTime()
pscheckbusboss1=GetTime()+5
pscheckbusboss2=nil
end


if event =="CHAT_MSG_YELL" then
if arg2 and arg2==UnitName("player") then
	ps_sa_waitfilter[2]=GetTime()+1.5
end
end

if event =="CHAT_MSG_SAY" then
if arg2 and arg2==UnitName("player") then
	ps_sa_waitfilter[1]=GetTime()+1.5
end
end

if event =="PLAYER_ENTERING_WORLD" then
if type(RegisterAddonMessagePrefix) == "function" then
RegisterAddonMessagePrefix ("SAver")
RegisterAddonMessagePrefix ("SAver2")
RegisterAddonMessagePrefix ("PSaddmod")
RegisterAddonMessagePrefix ("PhoenixStyle")
RegisterAddonMessagePrefix ("PSaddon")

RegisterAddonMessagePrefix ("BigWigs")
RegisterAddonMessagePrefix ("D4")
RegisterAddonMessagePrefix ("RW2")
RegisterAddonMessagePrefix ("DXE")


--10 PhoenixStyle-p --добавлено: 10
--11 PSstop
--12 PhoenixStyle_i   12info
--13 PSverwhips
--14 PSverwhips2
--15 PhoenixStyle_i2
--16 PS-marksoff 16off
--17 PS-myvers

--10 PScmrChima - "10"UnitName("player") --into PSaddmod



end
end


if event=="PLAYER_TARGET_CHANGED" then

if pscurrentzoneid and pscurrentzoneid>0 then
if UnitGUID("target") then
local aa=tonumber(string.sub(UnitGUID("target"),-12,-9),16)
	for i=1,#psbossid[pscurrentzoneid] do
		if psbossid[pscurrentzoneid][i][1]~=0 then
			if psbossid[pscurrentzoneid][i][1]==aa then
				psbossnames[pscurrentzoneid][i]=UnitName("target")
			end
		end
	end
end

end
end


if event == "CHAT_MSG_ADDON" then

if arg1=="BigWigs" then
if string.find(arg2,"VR:") or string.find(arg2,"VRA:") or string.find(arg2,"VRB:") then
local a=tonumber(string.sub(arg2,4))
local b=0
if string.find(arg2,"VRA:") then
a=tonumber(string.sub(arg2,5))
b=" (alpha)"
end
if string.find(arg2,"VRB:") then
a=tonumber(string.sub(arg2,5))
b=" (beta)"
end
local bil=0
if a==nil then
	a=0
end
if #psbossmods3>0 then
	for i=1,#psbossmods3 do
		if psbossmods3[i]==arg4 and psbossmods1[i]==arg1 then
			bil=1
			psbossmods2[i]=a
			psbossmods5[i]=GetTime()
			psbossmods4[i]=b
		end
	end
end
if bil==0 then
	table.insert(psbossmods1,arg1)
	table.insert(psbossmods2,a)
	table.insert(psbossmods3,arg4)
	table.insert(psbossmods4,b)
	table.insert(psbossmods5,GetTime())
end
end
end

if arg1=="D4" then
local bname="DBM"
local a1=arg2
local nn=0
local in1=0
local in2=0
while a1 do
	if string.find(a1,"\t") then
		nn=nn+1
		if nn==1 then
			if string.sub(a1,1,string.find(a1,"\t")-1)~="V" then
				a1=nil
			end
		end
		if nn==2 then
			in1=tonumber(string.sub(a1,1,string.find(a1,"\t")-1))
		end
		if nn==4 then
			in2=" ("..string.sub(a1,1,string.find(a1,"\t")-1)..")"
		end
		if a1 then
			a1=string.sub(a1,string.find(a1,"\t")+1)
		end
	else
		a1=nil
	end
end
if in1==nil then
	in1=0
end
if in1~=0 and in2~=0 then
local bil=0
if #psbossmods3>0 then
	for i=1,#psbossmods3 do
		if psbossmods3[i]==arg4 and psbossmods1[i]==bname then
			bil=1
			psbossmods2[i]=in1
			psbossmods4[i]=in2
			psbossmods5[i]=GetTime()
		end
	end
end
if bil==0 then
	table.insert(psbossmods1,bname)
	table.insert(psbossmods2,in1)
	table.insert(psbossmods3,arg4)
	table.insert(psbossmods4,in2)
	table.insert(psbossmods5,GetTime())
end
end

end

--DXE ^1^SAllVersionsBroadcast^Saddon,614^^
if arg1=="DXE" then
if string.find(arg2,"VersionsBroadcast") then

local t1=string.find(arg2,"Saddon")
t1=tonumber(t1)
t1=t1+7
local t2=string.find(arg2,"%^",t1)
t2=tonumber(t2)
t2=t2-1

local a=tonumber(string.sub(arg2,t1,t2))

if a==nil then
	a=0
end
local bil=0
if #psbossmods3>0 then
	for i=1,#psbossmods3 do
		if psbossmods3[i]==arg4 and psbossmods1[i]==arg1 then
			bil=1
			psbossmods2[i]=a
			psbossmods5[i]=GetTime()
			psbossmods4[i]=0
		end
	end
end
if bil==0 then
	table.insert(psbossmods1,arg1)
	table.insert(psbossmods2,a)
	table.insert(psbossmods3,arg4)
	table.insert(psbossmods4,0)
	table.insert(psbossmods5,GetTime())
end
end
end


--DXE [14:19:25] DXEVersionReply:615
if arg1=="DXE" then
if string.find(arg2,"DXEVersionReply") then

local t1=string.find(arg2,"nReply")
t1=tonumber(t1)
t1=t1+7
local t2=0
if string.find(arg2,"%^",t1) then
	t2=string.find(arg2,"%^",t1)
	t2=tonumber(t2)
	t2=t2-1
end

local a=0
if t2>0 then
	a=tonumber(string.sub(arg2,t1,t2))
else
	a=tonumber(string.sub(arg2,t1))
end

if a==nil then
	a=0
end
local bil=0
if #psbossmods3>0 then
	for i=1,#psbossmods3 do
		if psbossmods3[i]==arg4 and psbossmods1[i]==arg1 then
			bil=1
			psbossmods2[i]=a
			psbossmods5[i]=GetTime()
			psbossmods4[i]=0
		end
	end
end
if bil==0 then
	table.insert(psbossmods1,arg1)
	table.insert(psbossmods2,a)
	table.insert(psbossmods3,arg4)
	table.insert(psbossmods4,0)
	table.insert(psbossmods5,GetTime())
end
end
end


if arg1=="RW2" then
local bname="RaidWatch2"
if string.find(arg2,"IncGuildVersionInfo") or string.find(arg2,"IncVersionInfo") then
local a1=string.sub(arg2,2)
local nn=0
local in1=0
local in2=0
while a1 do
	if string.find(a1,"%^") then
		if string.find(a1,"%^%^")==1 then
			a1=nil
		end
		nn=nn+1
		if nn==3 then
			in1=tonumber(string.sub(a1,1,string.find(a1,"%^")-1))
		end
		if nn==4 then
			in2=string.sub(a1,1,string.find(a1,"%^")-1)
			if in2~="0" then
				in2="r"..in2
			end
		end
		if nn==5 then
			if in2=="0" then
				in2=""
			end
			in2=in2.." ("..string.sub(a1,1,string.find(a1,"%^")-1)..")"
		end
		if a1 then
			a1=string.sub(a1,string.find(a1,"%^")+2)
		end
	else
		a1=nil
	end
end


if in1~=0 and in2~=0 then
local bil=0
if #psbossmods3>0 then
	for i=1,#psbossmods3 do
		if psbossmods3[i]==arg4 and psbossmods1[i]==bname then
			bil=1
			psbossmods2[i]=in1
			psbossmods4[i]=in2
			psbossmods5[i]=GetTime()
		end
	end
end
if bil==0 then
	table.insert(psbossmods1,bname)
	table.insert(psbossmods2,in1)
	table.insert(psbossmods3,arg4)
	table.insert(psbossmods4,in2)
	table.insert(psbossmods5,GetTime())
end
end


end
end



--11:05:40 <Deadly Boss Mods> Шурш: 4.81 alpha (r5689)

--11:05:40 <Deadly Boss Mods> Тестыы: 4.75 alpha (r5539)


--получение данных о запущенном таймере!
if arg1=="PSaddon" and arg2 and string.sub(arg2,1,2)=="20" then
local tname=string.sub(arg2,3,string.find(arg2,"%^")-1)
local ttime=tonumber(string.sub(arg2,string.find(arg2,"%^")+1))
if tname and ttime then
  local _, month, day, year = CalendarGetDate()
  if month<10 then month="0"..month end
  if day<10 then day="0"..day end
  local oggi=month.."/"..day.."/"..year
  pstimerafterrelog={GetTime(),tname,ttime,oggi} --время запуска, название, время длит., дата
end
end


--получение данных при задержке аннонса1
if arg1=="PhoenixStyle" and psmsgwaiting>0 then
local _,psstriniz1=string.find(arg2, "mychat:")
if psstriniz1==nil then else
local psstrfine1=string.find(arg2, "++", psstriniz1)
if string.lower(string.sub(arg2, psstriniz1+1, psstrfine1-1))==string.lower(psmsgmychat) or (string.sub(arg2, psstriniz1+1, psstrfine1-1)=="raid" and psmsgmychat=="raid_warning") or (string.sub(arg2, psstriniz1+1, psstrfine1-1)=="raid_warning" and psmsgmychat=="raid")  then

--вырезаем ник
local _,psstriniz2=string.find(arg2, "myname:")
if psstriniz2==nil then else
local psstrfine2=string.find(arg2, "++", psstriniz2)

local psbililinet=0
for i,getcrash in ipairs(pscanannouncetable) do 
if getcrash == string.sub(arg2, psstriniz2+1, psstrfine2-1) then psbililinet=1
end end
if(psbililinet==0)then
table.insert(pscanannouncetable,string.sub(arg2, psstriniz2+1, psstrfine2-1))
end

end
end
end
end
--конец получения данных о аннонсе1

--стоп аддона
if arg1=="PSaddon" and arg2 and string.sub(arg2,1,2)=="11" and string.sub(arg2,3,3)=="1" and (arg4=="Шуршик" or arg4=="Шурши" or arg4=="Шурш") then
if UnitName("player")~= arg4 and thisaddonwork then
out("|cff99ffffPhoenixStyle|r - "..psaddonmy.." |cffff0000"..psaddonoff.."|r.")
thisaddonwork=false
end
end

--стоп аддона до релога
if arg1=="PSaddon" and arg2 and string.sub(arg2,1,2)=="11" and string.sub(arg2,3,3)=="2" and arg3=="WHISPER" then
if thisaddonwork then
out("|cff00ff00"..arg4.."|r: |cff99ffffPhoenixStyle|r - "..psaddonmy.." |cffff0000"..psaddonoff.."|r.")
out("|cff00ff00"..arg4.."|r: addon will be re-enabled after your relog")
pstemporarystop=1
end
end


--дес репорт, проверка на возможность отпр. репорт
if arg1=="PSaddon" and arg2 and string.sub(arg2,1,3)=="666" and arg4~=UnitName("player") then
--print ("получаю сообщ от "..arg4..": "..arg2)
local chat=string.sub(arg2,string.find(arg2,"++")+2)
local name=string.sub(arg2,4,string.find(arg2,"++")-1)
--print (chat)
if (UnitInRaid("player") and (chat==psdeathrepsavemain[10] or ((chat=="raid" or chat=="raid_warning") and (psdeathrepsavemain[10]=="raid" or psdeathrepsavemain[10]=="raid_warning")))) or (UnitInRaid("player")==nil and chat==psdeathrepsavemain[15]) then
  --чат совпал, кто главнее?
  local myname=UnitName("player")
  if IsRaidOfficer() then
    myname="0"..myname
  end
  local tab={myname}
  table.insert(tab,name)
  table.sort(tab)
  if tab[1]==name then
    --запрет на репорт 3 минуты
    psdeathreportantispam=GetTime()+180
  end
  if string.find(arg2,"%^") then
    --запрет так как один уже быстро репортит все..
    psdeathreportantispam=GetTime()+180
  end
end
end

--получение данных при задержке аннонса2
if arg1=="PhoenixStyle" and psmsgwaiting42>0 then

local _,psstriniz1=string.find(arg2, "mychat:")
if psstriniz1==nil then else
local psstrfine1=string.find(arg2, "++", psstriniz1)
if string.lower(string.sub(arg2, psstriniz1+1, psstrfine1-1))==string.lower(psmsgmychat42) or (string.sub(arg2, psstriniz1+1, psstrfine1-1)=="raid" and psmsgmychat42=="raid_warning") or (string.sub(arg2, psstriniz1+1, psstrfine1-1)=="raid_warning" and psmsgmychat42=="raid")  then

--вырезаем ник
local _,psstriniz2=string.find(arg2, "myname:")
if psstriniz2==nil then else
local psstrfine2=string.find(arg2, "++", psstriniz2)

local psbililinet=0
for i,getcrash in ipairs(pscanannouncetable42) do 
if getcrash == string.sub(arg2, psstriniz2+1, psstrfine2-1) then psbililinet=1
end end
if(psbililinet==0)then
table.insert(pscanannouncetable42,string.sub(arg2, psstriniz2+1, psstrfine2-1))
end

end
end
end
end
--конец получения данных о аннонсе2

--получение данных при задержке аннонса3
if arg1=="PhoenixStyle" and psmsgwaiting43>0 then

local _,psstriniz1=string.find(arg2, "mychat:")
if psstriniz1==nil then else
local psstrfine1=string.find(arg2, "++", psstriniz1)
if string.lower(string.sub(arg2, psstriniz1+1, psstrfine1-1))==string.lower(psmsgmychat43) or (string.sub(arg2, psstriniz1+1, psstrfine1-1)=="raid" and psmsgmychat43=="raid_warning") or (string.sub(arg2, psstriniz1+1, psstrfine1-1)=="raid_warning" and psmsgmychat43=="raid")  then

--вырезаем ник
local _,psstriniz2=string.find(arg2, "myname:")
if psstriniz2==nil then else
local psstrfine2=string.find(arg2, "++", psstriniz2)

local psbililinet=0
for i,getcrash in ipairs(pscanannouncetable43) do 
if getcrash == string.sub(arg2, psstriniz2+1, psstrfine2-1) then psbililinet=1
end end
if(psbililinet==0)then
table.insert(pscanannouncetable43,string.sub(arg2, psstriniz2+1, psstrfine2-1))
end

end
end
end
end
--конец получения данных о аннонсе3



--аддон аннонсит конец боя
if arg1=="PhoenixStyle" then
if string.find(arg2, "fightend") then
psnotanonsemore=GetTime()
local _,psstriniz1=string.find(arg2, "mychat:")
local psstrfine1=string.find(arg2, "++", psstriniz1)
psnotanonsemorechat=string.lower(string.sub(arg2, psstriniz1+1, psstrfine1-1))
end
end

if arg1=="PhoenixStyle" then
local _,psstriniz1=string.find(arg2, "mychat:")
local psstrfine1=string.find(arg2, "++", psstriniz1)
if (psmsgwaiting42==0 or (psmsgwaiting42>0 and psmsgmychat42~=string.lower(string.sub(arg2, psstriniz1+1, psstrfine1-1)))) and (psmsgwaiting43==0 or (psmsgwaiting43>0 and psmsgmychat43~=string.lower(string.sub(arg2, psstriniz1+1, psstrfine1-1)))) then
	if GetTime()>psnotanonsemorenormal+2 then
psnotanonsemorenormal=GetTime()
psnotanonsemorenormalchat=string.lower(string.sub(arg2, psstriniz1+1, psstrfine1-1))
	else
psnotanonsemorenormal2=GetTime()
psnotanonsemorenormalchat2=string.lower(string.sub(arg2, psstriniz1+1, psstrfine1-1))
	end
end
end
--конец

--получение инфы о запуске таймера
if arg1=="PSaddon" and arg2 and string.sub(arg2,1,2)=="10" then
if arg4==UnitName("player") then else

pstimeruraid=GetTime()+tonumber(string.sub(arg2,3))

end
end
--конец


--отправка моей инфы
if arg1=="PSaddon" and arg2=="12info" then
local psa1=0
local psa2=0
local psa3=0
local psa4=""
local psa5=0
local psa6=""
local psa7="0"
if IsAddOnLoaded("Boss_shieldsmonitor") then
psa7=bsmversion or 1
end
if thisaddonwork then psa1=1 end
if thisaddononoff then psa2=1 end
if psfnopromrep then psa3=1 end
if rscversion then psa5=rscversion end
psa4=psraidchats3[1]..psraidchats3[2]..psraidchats3[3]
if GetLocale() then
psa6=GetLocale()
end
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
SendAddonMessage("PSaddon", "15PS "..UnitName("player").." v."..psversion.." "..psa1..psa2..psa3..pssaaddon_12[2].." rsc:"..psa5.." bsm:"..psa7.." chat:"..psa4..", "..psa6.." installed: "..psaddoninstalledsins, arg3)
end
end

if arg1=="PSaddon" and arg2 and string.sub(arg2,1,2)=="13" and arg3=="WHISPER" then
local psa1=0
local psa2=0
local psa3=0
local psa4=""
local psa5=0
local psa6=""
local psa7="0"
if IsAddOnLoaded("Boss_shieldsmonitor") then
psa7=bsmversion or 1
end
if thisaddonwork then psa1=1 end
if thisaddononoff then psa2=1 end
if psfnopromrep then psa3=1 end
if rscversion then psa5=rscversion end
psa4=psraidchats3[1]..psraidchats3[2]..psraidchats3[3]
if GetLocale() then
psa6=GetLocale()
end
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
SendAddonMessage("PSaddon", "14PS "..UnitName("player").." v."..psversion.." "..psa1..psa2..psa3..pssaaddon_12[2].." rsc:"..psa5.." bsm:"..psa7.." chat:"..psa4..", "..psa6.." installed: "..psaddoninstalledsins, "WHISPER", arg4)
end
end

if arg1=="PSaddon" and arg2 and string.sub(arg2,1,2)=="14" and arg3=="WHISPER" then
print(string.sub(arg2,3))
end


--получение моей инфы
if arg1=="PSaddon" and arg2 and string.sub(arg2,1,2)=="15" and psshushinfo then
if arg4==UnitName("player") then else
print(string.sub(arg2,3))
end
end


--отключение автомарок
if arg1=="PSaddon" and arg2=="16off" then
psautoupmarkssetoff()
end

if arg1=="PSaddon" and arg2 and string.sub(arg2,1,2)=="17" then

if tonumber(string.sub(arg2,3))>psversion then

		if tonumber(string.sub(arg2,3))-psversion>0.0007 then
	if psverschech2==nil and UnitAffectingCombat("player")==nil then
	psverschech2=1
psoldvern=tonumber(string.sub(arg2,3))
if psoldvern>psversion then
PSFmain3_Textoldv:Show()
end
if tonumber(string.sub(arg2,3))-psversion>0.004 then
print ("|cff99ffffPhoenixStyle|r - "..psnewversfound2)
else
local _, _, day = CalendarGetDate()
if psversionday==day then else
local tip="alpha"
if string.len (string.sub(arg2,3))==6 then
tip="beta"
elseif string.len (string.sub(arg2,3))<=5 then
tip="release"
end
print ("|cff99ffffPhoenixStyle|r - "..psnewversfound.." "..tonumber(string.sub(arg2,3)).." ("..tip.."). >> http://www.phoenixstyle.com <<")
psversionday=day
end
end
	end
		elseif tonumber(string.sub(arg2,3))-psversion>0.00008 then

	if psverschech2==nil and UnitAffectingCombat("player")==nil then
	psverschech2=1
psoldvern=tonumber(string.sub(arg2,3))
if psoldvern>psversion then
PSFmain3_Textoldv:Show()
end

local _, _, day = CalendarGetDate()
if psversionday==day then else

local tip="alpha"
if string.len (string.sub(arg2,3))==6 then
tip="beta"
elseif string.len (string.sub(arg2,3))<=5 then
tip="release"
end

print ("|cff99ffffPhoenixStyle|r - "..psnewversfound.." "..tonumber(string.sub(arg2,3)).." ("..tip.."). >> http://www.phoenixstyle.com <<")
psversionday=day
end
	end


		end


elseif tonumber(string.sub(arg2,3))<psversion then
if pslastsendbinf==nil or (pslastsendbinf and GetTime()>pslastsendbinf+60) then
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
SendAddonMessage("PSaddon", "17"..psversion, arg3)
pslastsendbinf=GetTime()
end
end
end
end


if arg1=="SAver" then
	if pssaaddon_12[2]==1 and pssaaddon_12[3]==1 and IsAddOnLoaded("SayAnnouncer")==nil then
		SendAddonMessage("SAver2", "0PS", "WHISPER", arg4)
	end
end


--получение данных о версии аддона SA
if arg1=="SAver2" and sa_delayforwaiting then
local bil=0
for i=1,#sa_raidwithaddons do
	if string.lower(sa_raidwithaddons[i])==string.lower(arg4) then
		bil=1
	end
end
if bil==0 then
	table.insert(sa_raidwithaddons,arg4)
end

if #sa_raidrosteronline>0 then
for j=1,#sa_raidrosteronline do
	if sa_raidrosteronline[j] and string.lower(sa_raidrosteronline[j])==string.lower(arg4) then
		table.remove(sa_raidrosteronline,j)
	end
end
end

if #sa_raidrosteroffline>0 then
for k=1,#sa_raidrosteroffline do
	if sa_raidrosteroffline[k] and string.lower(sa_raidrosteroffline[k])==string.lower(arg4) then
		table.remove(sa_raidrosteroffline,k)
	end
end
end


end
--


end


if event=="PLAYER_REGEN_ENABLED" then
pscheckbossincombat=GetTime()
pscheckbusboss1=GetTime()+5
pscheckbusboss12=nil
pscmrdelayofbosccheck=nil --ыытест с модуля катамр, при конце боя стопать поиск босса в бою
pscmrdelayofbosccheck_2=nil --ыытест с модуля firelands, при конце боя стопать поиск босса в бою
pscmrdelayofbosccheck_3=nil
end
	


if event == "PLAYER_REGEN_DISABLED" then
pscheckprecastnotboss=nil

--psbilresnut

local a1, a2, a3, a4, a5 = GetInstanceInfo()
if UnitInRaid("player") or a2=="raid" then
SetMapToCurrentZone()
end

if (psbilresnut and GetTime()<psbilresnut+3) or pscheckbossincombat then
else
--not triggered after res

pssavedreportcreatedforcurfight=nil
pssavedplayerpos=nil
psdiedinparty=0
psdeathrepbossnametemp=nil
psthiscombatstoprepd=nil
pstoomuchrepstopforfight=nil

--время начала боя
local _, month, day, year = CalendarGetDate()
if month<10 then month="0"..month end
if day<10 then day="0"..day end
--if year>2000 then year=year-2000 end
local h,m = GetGameTime()
if h<10 then h="0"..h end
if m<10 then m="0"..m end
pstimeofcombatstart=h..":"..m..", "..month.."/"..day.."/"..year


--начался бой, проверяем всех петов рейда и обновляем таблицу.
if #pspetstableok[1]>0 then
local ss=1
  while ss<=#pspetstableok[1] do
    if pspetstableok[3][ss] and ((GetTime()>pspetstableok[3][ss]+400 and pspetstableok[5][ss]==1) or (GetTime()>pspetstableok[3][ss]+30 and pspetstableok[5][ss]==3) or (GetTime()>pspetstableok[3][ss]+6000)) then
      table.remove(pspetstableok[1],ss)
      table.remove(pspetstableok[2],ss)
      table.remove(pspetstableok[3],ss)
      table.remove(pspetstableok[4],ss)
      table.remove(pspetstableok[5],ss)
      ss=ss-1
    end
    ss=ss+1
  end
end
for j=1,GetNumRaidMembers() do
  if UnitGUID("raidpet"..j) then
    local bil=0
    if #pspetstableok[1]>0 then
      for m=1,#pspetstableok[1] do
        if pspetstableok[1][m]==UnitGUID("raidpet"..j) then
          bil=1
          pspetstableok[3][m]=GetTime()
          pspetstableok[2][m]=UnitGUID("raid"..j)
          --local a1,a2=UnitName("raid"..j)
          --if a2 then
          --  a1=a1.."-"..a2
          --end
          --pspetstableok[4][m]=a1
          pspetstableok[5][m]=2
        end
      end
    end
    if bil==0 then
      table.insert(pspetstableok[1],UnitGUID("raidpet"..j))
      table.insert(pspetstableok[2],UnitGUID("raid"..j))
      table.insert(pspetstableok[3],GetTime())
      local a1,a2=UnitName("raid"..j)
      if a2 then
        a1=a1.."-"..a2
      end
      local psname = GetRaidRosterInfo(j)
      if a1~=psname then
        local a3=UnitName("raid"..j)
        if string.find(psname,a3) then
          a1=psname
        end
      end        
      table.insert(pspetstableok[4],a1)
      table.insert(pspetstableok[5],2)
    end
  end
end


psiccschet1=0
psiccschet2=0
psiccschet3=0
psiccschet4=0
psiccschet5=0
psiccschet6=0

psthiscombatwipe=nil

psdeathwaiting=nil
psdeathwaiting={{},{}}--string to insert, timeevent

	psnewbossforincombmod=nil
	pscombatstarttime=GetTime()


	timetocheck=0
	psfnotoffvar=0
	psanonceinst=nil
if psbossblock and GetTime()-psbossblock>8 then
psbossblock=nil
end
	pszapuskdelayphasing=0
	pszapuskdelayphasing_2=0
	pszapuskdelayphasing_3=0


psdifflastfight=0
psiccinst="0"
local _, instanceType, pppl, _, maxPlayers, dif = GetInstanceInfo()

if pppl and (pppl==1 or pppl==3) then
psiccinst="10"
psdifflastfight=10
end
if pppl and (pppl==2 or pppl==4) then
psiccinst="25"
psdifflastfight=25
--ыытест
if IsPartyLFG() and IsInLFGDungeon() and instanceType == "raid" and maxPlayers == 25 then
  psiccinst="25, LFR"
end
end
if pppl and (pppl==3 or pppl==4) then
psiccinst=psiccinst..", "..psiccheroic
psheroiccombat=1
else
psheroiccombat=nil
end


end
end


if event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_WARNING" or event == "CHAT_MSG_OFFICER" or event == "CHAT_MSG_GUILD" then

if arg1 then
if string.lower(arg1)=="вайп" or string.lower(arg1)=="wipe" or string.lower(arg1)=="dfqg" or string.lower(arg1)=="цшзу" or string.lower(arg1)=="wipe." or string.lower(arg1)=="!wipe" or string.lower(arg1)=="вайпаемся" or string.lower(arg1)=="вайп." or string.lower(arg1)=="ваип" then

local psgood=0

	for i = 1,GetNumRaidMembers() do local name,rank = GetRaidRosterInfo(i)
	if (rank > 0 and arg2==name) then psgood=1 end end

if psgood==1 then
if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids") then psiccwipereport("wipe", "try", nil, "checkforwipe") end
if IsAddOnLoaded("PhoenixStyleMod_Firelands") then psiccwipereport_2("wipe", "try", nil, "checkforwipe") end
if IsAddOnLoaded("PhoenixStyleMod_DragonSoul") then psiccwipereport_3("wipe", "try", nil, "checkforwipe") end
end



end
end

end


if event == "CHAT_MSG_WHISPER" then
psinvonwhisper(arg1,arg2)
end

if event == "CHAT_MSG_BN_WHISPER" then
psinvonwhisper(arg1,arg2,arg13)
end




if event == "CHAT_MSG_SYSTEM" then

if psignorforsec5 and GetTime()<psignorforsec5+5 then
if arg1 and string.find(arg1,psignorsystemmessage1) then
return false;
end
end

end


--принятие инвайта от друзей и ги
if event == "PARTY_INVITE_REQUEST" then
if psautoinvsave[4]==1 then
	local IsFriend = function(name)
		for i=1,GetNumFriends() do if(GetFriendInfo(i)==name) then return true end end
		if(IsInGuild()) then for i=1, GetNumGuildMembers() do if(GetGuildRosterInfo(i)==name) then return true end end end
		local b,a=BNGetNumFriends() for i=1,a do local a1,a2,a3,a4=BNGetFriendInfo(i) if a4==name then return true end end
	end
	local nameinv=arg1
	if string.find(nameinv, "%-") then
		nameinv=string.sub(nameinv,1,string.find(nameinv, "%-")-1)
	end
	if(IsFriend(nameinv)) then
		AcceptGroup()
		print("|cff99ffffPhoenixStyle|r - "..format(psinviteaccepted, arg1)..".")
			for i = 1, 4 do
				local frame = _G["StaticPopup"..i]
				if(frame:IsVisible() and frame.which=="PARTY_INVITE") then
					frame.inviteAccepted = 1
					StaticPopup_Hide("PARTY_INVITE")
					return
				end
			end
	end
end
end








if event == "ZONE_CHANGED_NEW_AREA" then
pszonechangedalldel=GetTime()
psdethrepwaittab1=nil
psdethrepwaittab2=nil --death rep reset after zone change.
end

if event=="RAID_ROSTER_UPDATE" then
if psdelayfortimerrestore and psdelayfortimerrestore>3 then
  psdelayfortimerrestore=GetTime()+3
end
if ffgfkngn==nil then
  ffgfkngn=1
  psdelayofcheck=GetTime()+10
end

if UnitInRaid("player") and psiwasinraid==nil and psdelaybossmodcheck then
  psiwasinraid=1
  psdelaybossmodcheck=nil
  psjoininraidtime=GetTime()
  psdeathreportantispam=nil --при инвайте в рейд переменная сбрасывается на дес репорт
  -- pets remove after invite
  if pspetstableok and #pspetstableok[1]>0 then
    local i=1
    while i<=#pspetstableok[1] do
      if pspetstableok[3][i] and (GetTime()<pspetstableok[3][i] or (GetTime()>pspetstableok[3][i]+30 and pspetstableok[5][i]==3) or GetTime()>pspetstableok[3][i]+3000) then
        table.remove(pspetstableok[1],i)
        table.remove(pspetstableok[2],i)
        table.remove(pspetstableok[3],i)
        table.remove(pspetstableok[4],i)
        table.remove(pspetstableok[5],i)
        i=i-1
      end
      i=i+1
    end
  end
end

if UnitInRaid("player")==nil then
  psiwasinraid=nil
  psdelaybossmodcheck=nil
end


if psdelaybossmodcheck==nil or (psdelaybossmodcheck and GetTime()>psdelaybossmodcheck+3600) then
  psdelaybossmodcheck=GetTime()
  psdelaybossmodchecktemp=GetTime()+10
end


--автопромоут до асиста
if psautoinvsave[7] and #psautoinvsave[7]>0 then
	if UnitInRaid("player") and IsRaidLeader() then
		for i=1,#psautoinvsave[7] do
			if UnitInRaid(psautoinvsave[7][i]) then
				local bil=0
				if psunitspromotedalready==nil then
					psunitspromotedalready={}
					for k=1,GetNumRaidMembers() do
						local name, rank = GetRaidRosterInfo(k)
						if rank and (rank==1 or rank==2) then
							for n=1,#psautoinvsave[7] do
								if psautoinvsave[7][n]==string.lower(name) then
									table.insert(psunitspromotedalready,psautoinvsave[7][n])
								end
							end
						end
					end
				end


				if #psunitspromotedalready>0 then
					for j=1,#psunitspromotedalready do
						if psunitspromotedalready[j]==psautoinvsave[7][i] then
							bil=1
						end
					end
				end
				if bil==0 then
					PromoteToAssistant(psautoinvsave[7][i])
					table.insert(psunitspromotedalready,psautoinvsave[7][i])
				end
			end
		end
	end
end

--автосет мла! раз за сессию
if psmlnoadd==nil and psautoinvsave[8] and #psautoinvsave[8]>0 and (psdelayafterqual==nil or (psdelayafterqual and GetTime()>psdelayafterqual)) then
	if UnitInRaid("player") and IsRaidLeader() then
    local ok=0
		for i=1,#psautoinvsave[8] do
			if ok==0 and (UnitInRaid(psautoinvsave[8][i])) then
          SetLootMethod("master", psautoinvsave[8][i])
          psmlnoadd=1
          ok=1
			end
		end
		if psonetimechanlootfdf==nil and psautoinvsave[11] then
			if psautoinvsave[11]>1 then
				if (psdelayafterqual==nil or (psdelayafterqual and GetTime()>psdelayafterqual)) then
					psonetimechanlootfdf=1
					SetLootThreshold(psautoinvsave[11])
					psdelayafterqual=GetTime()
				end
			else
				psonetimechanlootfdf=1
			end
		end
	end
end



end


if event == "ADDON_LOADED" then

if arg1=="PhoenixStyle" then

if pstimerafterrelog then
  psdelayfortimerrestore=GetTime()+50
end

if pssaaddon_12 and pssaaddon_12[3]==nil then
	pssaaddon_12[3]=1
end

--перевод дефолтных в постоянные табл
if pslocationnames==nil then pslocationnames={} end
for i=1,#pslocationnamesdef do
	if pslocationnames[i]==nil then pslocationnames[i]=pslocationnamesdef[i] end
end

if psbossnames==nil then psbossnames={} end
for i=1,#psbossnamesdef do
	if psbossnames[i]==nil then
	table.insert(psbossnames,{})
	end

	for j=1,#psbossnamesdef[i] do
		if psbossnames[i][j]==nil then
			psbossnames[i][j]=psbossnamesdef[i][j]
		end
	end
end


if psfontsset==nil then psfontsset={} end
for t=1,#psfontssetdef do
	if psfontsset[t]==nil then
		psfontsset[t]=psfontssetdef[t]
	end
end

pslocationnamesdef=nil
psbossnamesdef=nil

-- pets
if pspetstableok and #pspetstableok[1]>0 then
  local i=1
  while i<=#pspetstableok[1] do
    if pspetstableok[3][i] and (GetTime()<pspetstableok[3][i] or GetTime()>pspetstableok[3][i]+3600 or (GetTime()>pspetstableok[3][i]+400 and pspetstableok[5][i]==1) or (GetTime()>pspetstableok[3][i]+30 and pspetstableok[5][i]==3)) then
      table.remove(pspetstableok[1],i)
      table.remove(pspetstableok[2],i)
      table.remove(pspetstableok[3],i)
      table.remove(pspetstableok[4],i)
      table.remove(pspetstableok[5],i)
      i=i-1
    end
    i=i+1
  end
end


--ыытест временно, всунем новую опцию
if psdeathrepsavemain[16]==nil then
  psdeathrepsavemain[16]=2
end
if psdeathrepsavemain[17]==nil then
  psdeathrepsavemain[17]=1
end
if psdeathrepsavemain[18]==nil then
  psdeathrepsavemain[18]=1
end

PSFmain2_Text:SetPoint("TOPLEFT",50,10)


local psrcstxt = PSFmain2:CreateFontString()
psrcstxt:SetWidth(180)
psrcstxt:SetHeight(25)
psrcstxt:SetFont(GameFontNormal:GetFont(), 15)
psrcstxt:SetPoint("TOPLEFT",75,-135) ---345
psrcstxt:SetJustifyH("LEFT")
psrcstxt:SetJustifyV("TOP")
psrcstxt:SetText("|cff00ff00RSC:")

psrcstxt2 = PSFmain2:CreateFontString()
psrcstxt2:SetWidth(180)
psrcstxt2:SetHeight(25)
psrcstxt2:SetFont(GameFontNormal:GetFont(), 15)
psrcstxt2:SetPoint("TOPLEFT",1,-55) ---250
psrcstxt2:SetJustifyH("CENTER")
psrcstxt2:SetJustifyV("TOP")
psrcstxt2:SetText("|cff00ff00"..psfailstracker)

psversionsaved2=psversion


local psrcstxt2 = PSFmain3:CreateFontString()
psrcstxt2:SetWidth(480)
psrcstxt2:SetHeight(55)
psrcstxt2:SetFont(GameFontNormal:GetFont(), 20)
psrcstxt2:SetPoint("BOTTOMRIGHT",-30,10)
psrcstxt2:SetJustifyH("RIGHT")
psrcstxt2:SetJustifyV("TOP")
psrcstxt2:SetText("www.phoenixstyle.com")


if PSFmain2_Text then
PSFmain2_Text:SetFont(GameFontNormal:GetFont(), 14)
end

--SA перевод дефолтных
if ps_saoptions==nil then ps_saoptions={} end
for i=1,#ps_saoptions_def do
	if ps_saoptions[i]==nil then ps_saoptions[i]={} end
	if #ps_saoptions_def[i]>0 then
		for j=1,#ps_saoptions_def[i] do
			if ps_saoptions[i][j]==nil then ps_saoptions[i][j]={} end
			if #ps_saoptions_def[i][j]>0 then
				for k=1,#ps_saoptions_def[i][j] do
					if ps_saoptions[i][j][k]==nil then
						ps_saoptions[i][j][k]=ps_saoptions_def[i][j][k]
					end
				end
			end
		end
	end
end
ps_saoptions_def=nil



pscheckdatay=GetTime()+10

local t = PSFmain3:CreateFontString()
t:SetWidth(515)
t:SetHeight(45)
t:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t:SetPoint("TOPLEFT",217,-292)
t:SetText(psbuttonrezallsave2)
t:SetJustifyH("LEFT")
t:SetJustifyV("CENTER")



if psoldvern>psversion then
PSFmain3_Textoldv:Show()
end

psnastdelay=GetTime()+3

PSFmain3_Textver:SetText("ver-"..psversion.." ("..psverstiptext..")")

psmapbuttreflesh()

psupdateleftbuttonsstyle()

end
end










end --combat text







end --конец основной функции аддона







--==============================МЕНЮ===================================


function PhoenixStyleFailbot_Command(msg)
	local cmd, subCmd = PhoenixStyleFailbot_GetCmd(msg)


	if(string.lower(cmd)=="пулл" or string.lower(cmd)=="pull" or string.lower(cmd)=="атака" or string.lower(cmd)=="ataka" or string.lower(cmd)=="attack" or string.lower(cmd)=="pul" or string.lower(cmd)=="пул") then
			local val, crp = PhoenixStyleFailbot_GetCmd(subCmd)
			if (val=="2" or val=="3" or val=="4" or val=="5" or val=="6" or val=="7" or val=="8" or val=="9" or val=="10" or val=="11" or val=="12" or val=="13" or val=="14" or val=="15" or val=="16" or val=="17" or val=="18" or val=="19" or val=="20") then
if(IsRaidOfficer()==1) then
if pspullactiv==0 and thisaddonwork and pstemporarystop==nil then

	timertopull=tonumber(val)

end
psfpullbegin()
else

out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..pserrornotofficer)
end --конец проверки на промоут



else

if pspullactiv==1 then
psfcancelpull()
else
print("|cff99ffffPhoenixStyle|r - "..pserrormenutimer1.."\n "..pserrormenutimer2)
end
end

	--конец пулла

	--перерыв
	elseif(string.lower(cmd)=="перерыв" or string.lower(cmd)=="пицца" or string.lower(cmd)=="pereriv" or string.lower(cmd)=="break" or string.lower(cmd)=="pizza" or string.lower(cmd)=="afk" or string.lower(cmd)=="афк") then
			local val, crp = PhoenixStyleFailbot_GetCmd(subCmd)
			if (val=="2" or val=="3" or val=="4" or val=="5" or val=="6" or val=="7" or val=="8" or val=="9" or val=="10" or val=="11" or val=="12" or val=="13" or val=="14" or val=="15" or val=="16" or val=="17" or val=="18" or val=="19" or val=="20" or val=="21" or val=="22" or val=="23" or val=="24" or val=="25" or val=="26" or val=="27" or val=="28" or val=="29" or val=="30" or val=="1") then
				local timer2=tonumber(val)
				PSFbeginpereriv(timer2,1)
			end

	elseif(string.lower(cmd)=="таймер" or string.lower(cmd)=="timer" or string.lower(cmd)=="time" or string.lower(cmd)=="bar") then
			local val, crp = PhoenixStyleFailbot_GetCmd(subCmd)
			if val and crp then
        crp=tonumber(crp)
        if val and crp then
          pstimermake(val,crp)
        end
			end

	elseif(string.lower(cmd)=="rezet" or string.lower(cmd)=="reset" or string.lower(cmd)=="resetpos" or string.lower(cmd)=="резет" or string.lower(cmd)=="сбросить" or string.lower(cmd)=="res" or string.lower(cmd)=="rez") then

	PSFmain1:ClearAllPoints()
	PSFmain1:SetPoint("CENTER",UIParent,"CENTER")
PSFmain1:Hide()
PSFmain2:Hide()
PSF_closeallpr()

PSFmain1:Show()
PSFmain2:Show()
PSFmain3:Show()
PSFmain2_Button3:SetAlpha(0.3)

	--wipe
	elseif(string.lower(cmd)=="wipe" or string.lower(cmd)=="вайп" or string.lower(cmd)=="результат" or string.lower(cmd)=="dfqg" or string.lower(cmd)=="цшзу" or string.lower(cmd)=="ваип") then


--ыытест
if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids") then psiccwipereport("wipe", "try", nil, "checkforwipe") end
if IsAddOnLoaded("PhoenixStyleMod_Firelands") then psiccwipereport_2("wipe", "try", nil, "checkforwipe") end
if IsAddOnLoaded("PhoenixStyleMod_DragonSoul") then psiccwipereport_3("wipe", "try", nil, "checkforwipe") end




	else
	

PSFmain1:Hide()
PSFmain2:Hide()
PSF_closeallpr()

PSFmain1:Show()
PSFmain2:Show()
PSFmain3:Show()
PSFmain2_Button3:SetAlpha(0.3)

if psshowsavedinfofirst then
  psbutclickedsavedinfo()
end





	end
end

function PhoenixStyleFailbot_GetCmd(msg)
	if(msg) then
		local a,b,c = strfind(msg, "(%S+)")
		if(a) then
			return c, strsub(msg, b+2)
		else	
			return ""
		end
	end
end


function PSF_buttonaddon()
PSF_closeallpr()
PSFmain3:Show()
PSFmain2_Button3:SetAlpha(0.3)
end

function PSF_buttonautomark()
PSF_closeallpr()
PSFmain2_Button4:SetAlpha(0.3)
PSFmain4_Button20:Hide()
PSFmain4_Button22:Hide()
PSFmain4_Button210:Hide()
PSFmain4_Button212:Hide()
PSFmain4_Textmark1:Hide()
PSFmain4_Textmark2:Hide()
psfautomarldraw()
PSFmain4:Show()
if(autorefmark) then PSFmain4_Button22:Show() PSFmain4_Button212:Show() PSFmain4_Textmark1:Show() else PSFmain4_Button20:Show() PSFmain4_Button210:Show() PSFmain4_Textmark2:Show() end
framewasinuse2=1

end

function PSF_buttontimers()
PSF_closeallpr()
PSFmain2_Button5:SetAlpha(0.3)
if(thisaddonwork)then
PSFmain5:Show()
psftimecrepol()
framewasinuse3=1
else
PSFmain10:Show()
end
end

function PSF_buttonspellid()
PSF_closeallpr()
PSFmain2_Button51:SetAlpha(0.3)
if(thisaddonwork)then
PSFmainspellidframe:Show()
PSF_buttonspellidcreate()
else
PSFmain10:Show()
end
end


function PSF_buttonraids()
PSF_closeallpr()
PSFmain2_Button7:SetAlpha(0.3)
if(thisaddonwork)then

PSFmainic1:Show()
psfloadalltextures()
else
PSFmain10:Show()
end
end


function PSF_rscopen(oo)
PSF_closeallpr()
if rscversion and rscversion>1.09 then

if oo==1 then
PSFmain2_ButtonRA2:SetAlpha(0.3)
rscwindow2()
end

if oo==2 then
PSFmain2_ButtonRA3:SetAlpha(0.3)
rscwindow3()
end


else
PSFerrorframeuniq:Show()

if psftxterruniq==nil then
	psftxterruniq = PSFerrorframeuniq:CreateFontString()
	psftxterruniq:SetFont(GameFontNormal:GetFont(), 15)
	psftxterruniq:SetWidth(555)
	psftxterruniq:SetHeight(100)
	psftxterruniq:SetJustifyH("CENTER")
	psftxterruniq:SetJustifyV("TOP")
	psftxterruniq:SetPoint("CENTER",0,50)
end

psftxterruniq:SetText(psfneedrscaddon.." |cffff0000"..psfneedrscaddonver11.."|r\n\n"..psraaddonanet2)

end
end

function PSF_potionscheck(nn)

if nn then
PSF_buttonsaveexit()
PSFmain1:Show()
PSFmain2:Show()
else
PSF_closeallpr()
PSFmain2_ButtonRA1:SetAlpha(0.3)
end


PSFpotioncheckframe:Show()
PSFpotioncheckframe_CheckButton1:Hide()
PSFpotioncheckframe_CheckButton2:Hide()
PSFpotioncheckframe_Button10:Hide()
PSFpotioncheckframe_Button11:Hide()
PSFpotioncheckframe_ButtonHS:Hide()
PSFpotioncheckframe_ButtonHS2:Hide()
PSFpotioncheckframe_CheckButton3:Hide()
PSFpotioncheckframe_Button20:Hide()
PSFpotioncheckframe_Button30:Hide()
PSFpotioncheckframe_Button40:Hide()

if rscversion then
psfpotioncheckshow()
end
end



-----------------------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------
function PSF_buttonulda()
PSF_closeallpr()
if(thisaddonwork)then
if IsAddOnLoaded("PhoenixStyleMod_Ulduar")==nil then
LoadAddOn("PhoenixStyleMod_Ulduar")
if IsAddOnLoaded("PhoenixStyleMod_Ulduar") then
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..psleftmenu5.."!")
end
end

if IsAddOnLoaded("PhoenixStyleMod_Ulduar") then
PSF_buttonulda2()
else
PSF_closeallpr()
PSFmain12:Show()
end
else
PSFmain10:Show()
end
end


function PSF_buttonkolizei()
PSF_closeallpr()
if(thisaddonwork)then
if IsAddOnLoaded("PhoenixStyleMod_Coliseum")==nil then
LoadAddOn("PhoenixStyleMod_Coliseum")
if IsAddOnLoaded("PhoenixStyleMod_Coliseum") then
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..psleftmenu6.."!")
end
end

if IsAddOnLoaded("PhoenixStyleMod_Coliseum") then
PSF_buttonkolizei2()
else
PSF_closeallpr()
PSFmain12:Show()
end
else
PSFmain10:Show()
end
end

function PSF_buttonicecrown()
PSF_closeallpr()
if(thisaddonwork)then
if IsAddOnLoaded("PhoenixStyleMod_Icecrown")==nil then
LoadAddOn("PhoenixStyleMod_Icecrown")
if IsAddOnLoaded("PhoenixStyleMod_Icecrown") then
	if psicgalochki[1][1]==0 then else
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..psleftmenu7.."!")
	end
end
end

if IsAddOnLoaded("PhoenixStyleMod_Icecrown") then
PSF_buttonicecrown2()
else
PSF_closeallpr()
PSFmain12:Show()
end
else
PSFmain10:Show()
end
end

---------------------------------------------
-----------------------------------------------------------
-----------------------------------------------------------

function PSF_closeallpr()
-------------------------------

if IsAddOnLoaded("PhoenixStyleMod_Coliseum") then PSF_closeallprColiseum() end
if IsAddOnLoaded("PhoenixStyleMod_Ulduar") then PSF_closeallprUlduar() end
if IsAddOnLoaded("PhoenixStyleMod_Icecrown") then PSF_closeallpricecrown() end
-----------------------------
PSFmain3:Hide()
PSFmain4:Hide()
PSFmain5:Hide()
PSFmain10:Hide()
PSFmain12:Hide()
PSFmainchated:Hide()
PSFmainfontchange:Hide()
PSFmainrano:Hide()
PSFpotioncheckframe:Hide()
PSFerrorframeuniq:Hide()
PSFrscflask:Hide()
PSFrscbuff:Hide()
PSFmainic1:Hide()
PSFthanks:Hide()
PSFthanks2:Hide()
PSFraidopt:Hide()
PSFmainspellidframe:Hide()
PSF_saframe:Hide()
PSFbossmodframe:Hide()
PSFdeathreport:Hide()
PSFautoinvframe:Hide()
PSFmainfrainsavedinfo:Hide()


--бутонам возвращаем альфу
PSFmain2_Button3:SetAlpha(1)
PSFmain2_Button4:SetAlpha(1)
PSFmain2_Button5:SetAlpha(1)
PSFmain2_Button51:SetAlpha(1)
PSFmain2_Button112:SetAlpha(1)
PSFmain2_Button52:SetAlpha(1)
PSFmain2_Button53:SetAlpha(1)
PSFmain2_Button54:SetAlpha(1)
PSFmain2_Button7:SetAlpha(1)
PSFmain2_Button71:SetAlpha(1)
PSFmain2_ButtonRA1:SetAlpha(1)
PSFmain2_ButtonRA2:SetAlpha(1)
PSFmain2_ButtonRA3:SetAlpha(1)
PSFmain2_ButtonRA:SetAlpha(1)

------------------------------------


end

function out(text)
DEFAULT_CHAT_FRAME:AddMessage(text)
UIErrorsFrame:AddMessage(text, 1.0, 1.0, 0, 1, 10)
end

function psout(n,text)
if n~=1 then
  DEFAULT_CHAT_FRAME:AddMessage(text)
end
UIErrorsFrame:AddMessage(text, 1.0, 0, 0, 1, 5)
end

function PSFifreporton()
if (PSFmain3_CheckButton1:GetChecked()) then
		if(thisaddononoff)then
			else
			thisaddononoff=true
			out("|cff99ffffPhoenixStyle|r - "..pswarnings.." |cff00ff00"..pswarningson.."|r.")
			end
			else
			if(thisaddononoff)then
			out("|cff99ffffPhoenixStyle|r - "..pswarnings.." |cffff0000"..pswarningsoff.."|r.")
			thisaddononoff=false
		end
	end
psmapbuttreflesh()
end

function PSFminimaponoff()
if (PSFmain3_CheckButton4:GetChecked()) then
psminibutenabl=true
else
psminibutenabl=false
PS_MinimapButton:Hide()
end
psmapbuttreflesh()
end

function psautomarchangeno(numr)
truemark[numr]="false"
table.wipe(pssetmarknew[numr])
psautoupok[numr]:SetText("|cffff0000-|r")
end

--СОХРАНИЕ ИЗМЕНЕНИЙ
function PSF_buttonsaveexit()
if (framewasinuse2)then
  if psfautomebtable then
    for uu=1,8 do
      if psfautomebtable[uu]:GetText() == "" then psautomarchangeno(uu) else
        psmarksisinraid(psfautomebtable[uu]:GetText(), 0, uu)
      end
    end
  end
  psdatrumark=0
  for i=1,8 do
    if truemark[i]=="true" then
      psdatrumark=1
    end
  end
  if(autorefmark and psdatrumark==0) then
    autorefmark=false
    out("|cff99ffffPhoenixStyle|r - "..psmarkreflesh.." |cffff0000"..psmarkrefleshoff.."|r.")
  end
end


if rscframeuse3 then
  rscsavenicks3()
  rscframeuse3=nil
end


--если сейвд инфо был открыт то откроем его еще раз
if PSFmainfrainsavedinfo:IsShown() then
  psshowsavedinfofirst=1
  if pstableofcurrentevents and pssichose3 then
    if pstableofcurrentevents[pssichose3]==pssaveityperep1 then
      pspreviousbeforeshutdown=pssaveityperep1
    end
    if pstableofcurrentevents[pssichose3]==pssaveityperep2 then
      pspreviousbeforeshutdown=pssaveityperep2
    end
    if pstableofcurrentevents[pssichose3]==pssaveityperep3 then
      pspreviousbeforeshutdown=pssaveityperep3
    end
  end
else
  psshowsavedinfofirst=nil
  pspreviousbeforeshutdown=nil
end

PSF_closeallpr()
PSFmain1:Hide()
PSFmain2:Hide()
framewasinuse2=nil
framewasinuse3=nil
framewasinuse4=nil
framewasinuse5=nil
framewasinuse8=nil
framewasinuse9=nil
rscframeuse1=nil

end


--НАСТРОЙКА данных при загрузке окна настроек
function PSF_showoptions()
	if showopttime1==nil then
showopttime1=1
if psfchatadd==nil then psfchatadd={} end
bigmenuchatlist = {
pschatlist1,
pschatlist2,
pschatlist3,
pschatlist4,
pschatlist5,
pschatlist6,
pschatlist7,
pschatlist8,
}
lowmenuchatlist = {
pschatlist4,
pschatlist3,
pschatlist5,
pschatlist6,
pschatlist7,
pschatlist8,
}

if #psfchatadd>0 then
for i=1,#psfchatadd do
table.insert(bigmenuchatlist,psfchatadd[i])
table.insert(lowmenuchatlist,psfchatadd[i])
end
end

	end

	framewasinuse2=nil
	framewasinuse3=nil
	framewasinuse4=nil
	framewasinuse5=nil
	framewasinuse8=nil --номерация дальше совпадает
	framewasinuse9=nil

if (thisaddononoff) then PSFmain3_CheckButton1:SetChecked() else PSFmain3_CheckButton1:SetChecked(false) end
if (thisaddonwork) then PSFmain3_CheckButton2:SetChecked() else PSFmain3_CheckButton2:SetChecked(false) end
if (psfnopromrep) then PSFmain3_CheckButton3:SetChecked() else PSFmain3_CheckButton3:SetChecked(false) end
if (psminibutenabl) then PSFmain3_CheckButton4:SetChecked() else PSFmain3_CheckButton4:SetChecked(false) end

if (psrscafterfightrep[1]==1) then PSFmain3_CheckButton11:SetChecked() else PSFmain3_CheckButton11:SetChecked(false) end
if (psrscafterfightrep[1]==2) then PSFmain3_CheckButton12:SetChecked() else PSFmain3_CheckButton12:SetChecked(false) end
if (psrscafterfightrep[2]==1) then PSFmain3_CheckButton13:SetChecked() else PSFmain3_CheckButton13:SetChecked(false) end
if (pstrackbadsummons==1) then PSFmain3_CheckButton14:SetChecked() else PSFmain3_CheckButton14:SetChecked(false) end

local s1=GetSpellInfo(61031)
local s2=GetSpellInfo(49844)
getglobal(PSFmain3_CheckButton14:GetName().."Text"):SetText(pstrackbadtext.." "..s1..", "..s2)


if psfautomebtable then
for uy=1,8 do
local nicks=""
if #pssetmarknew[uy]>0 then
     for h=1,#pssetmarknew[uy] do
          if string.len(nicks)>1 then
               nicks=nicks..", "
          end
          nicks=nicks..pssetmarknew[uy][h]
     end
end
psfautomebtable[uy]:SetText(nicks)
end
end

end

function PSFpotsafterfight(i)
if i==3 then
	if (PSFmain3_CheckButton13:GetChecked()) then
		psrscafterfightrep[2]=1
	else
		psrscafterfightrep[2]=0
	end
end
if i==1 then
	if (PSFmain3_CheckButton11:GetChecked()) then
		psrscafterfightrep[1]=1
	else
		psrscafterfightrep[1]=0
	end
end
if i==2 then
	if (PSFmain3_CheckButton12:GetChecked()) then
		psrscafterfightrep[1]=2
	else
		psrscafterfightrep[1]=0
	end
end

if (psrscafterfightrep[1]==1) then PSFmain3_CheckButton11:SetChecked() else PSFmain3_CheckButton11:SetChecked(false) end
if (psrscafterfightrep[1]==2) then PSFmain3_CheckButton12:SetChecked() else PSFmain3_CheckButton12:SetChecked(false) end
if (psrscafterfightrep[2]==1) then PSFmain3_CheckButton13:SetChecked() else PSFmain3_CheckButton13:SetChecked(false) end

end


function PSFvkladdon()
	if (PSFmain3_CheckButton2:GetChecked()) then
		if(thisaddonwork)then
			else
			thisaddonwork=true
			out("|cff99ffffPhoenixStyle|r - "..psaddonmy.." |cff00ff00"..psaddonon2.."|r.")
			pszonechangedall()
			end
		else
			if(thisaddonwork)then
			out("|cff99ffffPhoenixStyle|r - "..psaddonmy.." |cffff0000"..psaddonoff.."|r.")
			thisaddonwork=false
			psmylogin=GetTime()
			if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids") then psiccwipereport() end
			if IsAddOnLoaded("PhoenixStyleMod_Firelands") then psiccwipereport_2() end
			if IsAddOnLoaded("PhoenixStyleMod_DragonSoul") then psiccwipereport_3() end
		end
end
psmapbuttreflesh()
end

function PSFrepnopromchange()
	if (PSFmain3_CheckButton3:GetChecked()) then
		if(psfnopromrep)then
			else
			psfnopromrep=true
			out("|cff99ffffPhoenixStyle|r - "..psaddonrepnoprom2)
			end
			else
			if(psfnopromrep)then
			out("|cff99ffffPhoenixStyle|r - "..psaddonrepnoprom3)
			psfnopromrep=false
		end
end end

function bigmenuchat2(bigma2)
bigma2num=0
for i,cchat in ipairs(bigmenuchatlisten) do 
if string.lower(cchat) == string.lower(bigma2) then bigma2num=i
end end
if bigma2num==0 then
for i,cchat in ipairs(psfchatadd) do 
if string.lower(cchat) == string.lower(bigma2) then bigma2num=i+8
end end
end
end

function lowmenuchat2(bigma2)
lowma2num=0
for i,cchat in ipairs(lowmenuchatlisten) do 
if string.lower(cchat) == string.lower(bigma2) then lowma2num=i
end end
if lowma2num==0 then
for i,cchat in ipairs(psfchatadd) do 
if string.lower(cchat) == string.lower(bigma2) then lowma2num=i+6
end end
end
end


function PSF_RAaddon()
PSF_closeallpr()
PSFmain2_ButtonRA:SetAlpha(0.3)
if IsAddOnLoaded("RaidAchievement")==nil then
--нету аддона
PSFmainrano:Show()

else
--есть аддон

PSF_buttonsaveexit()

PSFeamain1:Show()
PSFeamain2:Show()
PSFeamain3:Show()
openrasound1()
openrasound2()

end

end



function vezaxsort1()
local vzxnn= # vezaxname
while vzxnn>1 do
if vezaxcrash[vzxnn]>vezaxcrash[vzxnn-1] then
local vezaxtemp1=vezaxcrash[vzxnn-1]
local vezaxtemp2=vezaxname[vzxnn-1]
vezaxcrash[vzxnn-1]=vezaxcrash[vzxnn]
vezaxname[vzxnn-1]=vezaxname[vzxnn]
vezaxcrash[vzxnn]=vezaxtemp1
vezaxname[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort2()
local vzxnn= # vezaxname2
while vzxnn>1 do
if vezaxcrash2[vzxnn]>vezaxcrash2[vzxnn-1] then
local vezaxtemp1=vezaxcrash2[vzxnn-1]
local vezaxtemp2=vezaxname2[vzxnn-1]
vezaxcrash2[vzxnn-1]=vezaxcrash2[vzxnn]
vezaxname2[vzxnn-1]=vezaxname2[vzxnn]
vezaxcrash2[vzxnn]=vezaxtemp1
vezaxname2[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort3()
local vzxnn= # vezaxname3
while vzxnn>1 do
if vezaxcrash3[vzxnn]>vezaxcrash3[vzxnn-1] then
local vezaxtemp1=vezaxcrash3[vzxnn-1]
local vezaxtemp2=vezaxname3[vzxnn-1]
vezaxcrash3[vzxnn-1]=vezaxcrash3[vzxnn]
vezaxname3[vzxnn-1]=vezaxname3[vzxnn]
vezaxcrash3[vzxnn]=vezaxtemp1
vezaxname3[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort4()
local vzxnn= # vezaxname4
while vzxnn>1 do
if vezaxcrash4[vzxnn]>vezaxcrash4[vzxnn-1] then
local vezaxtemp1=vezaxcrash4[vzxnn-1]
local vezaxtemp2=vezaxname4[vzxnn-1]
vezaxcrash4[vzxnn-1]=vezaxcrash4[vzxnn]
vezaxname4[vzxnn-1]=vezaxname4[vzxnn]
vezaxcrash4[vzxnn]=vezaxtemp1
vezaxname4[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort5()
local vzxnn= # vezaxname5
while vzxnn>1 do
if vezaxcrash5[vzxnn]>vezaxcrash5[vzxnn-1] then
local vezaxtemp1=vezaxcrash5[vzxnn-1]
local vezaxtemp2=vezaxname5[vzxnn-1]
vezaxcrash5[vzxnn-1]=vezaxcrash5[vzxnn]
vezaxname5[vzxnn-1]=vezaxname5[vzxnn]
vezaxcrash5[vzxnn]=vezaxtemp1
vezaxname5[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort6()
local vzxnn= # vezaxname6
while vzxnn>1 do
if vezaxcrash6[vzxnn]>vezaxcrash6[vzxnn-1] then
local vezaxtemp1=vezaxcrash6[vzxnn-1]
local vezaxtemp2=vezaxname6[vzxnn-1]
vezaxcrash6[vzxnn-1]=vezaxcrash6[vzxnn]
vezaxname6[vzxnn-1]=vezaxname6[vzxnn]
vezaxcrash6[vzxnn]=vezaxtemp1
vezaxname6[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort7()
local vzxnn= # vezaxname7
while vzxnn>1 do
if vezaxcrash7[vzxnn]>vezaxcrash7[vzxnn-1] then
local vezaxtemp1=vezaxcrash7[vzxnn-1]
local vezaxtemp2=vezaxname7[vzxnn-1]
vezaxcrash7[vzxnn-1]=vezaxcrash7[vzxnn]
vezaxname7[vzxnn-1]=vezaxname7[vzxnn]
vezaxcrash7[vzxnn]=vezaxtemp1
vezaxname7[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort8()
local vzxnn= # vezaxname8
while vzxnn>1 do
if vezaxcrash8[vzxnn]>vezaxcrash8[vzxnn-1] then
local vezaxtemp1=vezaxcrash8[vzxnn-1]
local vezaxtemp2=vezaxname8[vzxnn-1]
vezaxcrash8[vzxnn-1]=vezaxcrash8[vzxnn]
vezaxname8[vzxnn-1]=vezaxname8[vzxnn]
vezaxcrash8[vzxnn]=vezaxtemp1
vezaxname8[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort9()
local vzxnn= # vezaxname9
while vzxnn>1 do
if vezaxcrash9[vzxnn]>vezaxcrash9[vzxnn-1] then
local vezaxtemp1=vezaxcrash9[vzxnn-1]
local vezaxtemp2=vezaxname9[vzxnn-1]
vezaxcrash9[vzxnn-1]=vezaxcrash9[vzxnn]
vezaxname9[vzxnn-1]=vezaxname9[vzxnn]
vezaxcrash9[vzxnn]=vezaxtemp1
vezaxname9[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort10()
local vzxnn= # vezaxname10
while vzxnn>1 do
if vezaxcrash10[vzxnn]>vezaxcrash10[vzxnn-1] then
local vezaxtemp1=vezaxcrash10[vzxnn-1]
local vezaxtemp2=vezaxname10[vzxnn-1]
vezaxcrash10[vzxnn-1]=vezaxcrash10[vzxnn]
vezaxname10[vzxnn-1]=vezaxname10[vzxnn]
vezaxcrash10[vzxnn]=vezaxtemp1
vezaxname10[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end

function vezaxsort11()
local vzxnn= # vezaxname11
while vzxnn>1 do
if vezaxcrash11[vzxnn]>vezaxcrash11[vzxnn-1] then
local vezaxtemp1=vezaxcrash11[vzxnn-1]
local vezaxtemp2=vezaxname11[vzxnn-1]
vezaxcrash11[vzxnn-1]=vezaxcrash11[vzxnn]
vezaxname11[vzxnn-1]=vezaxname11[vzxnn]
vezaxcrash11[vzxnn]=vezaxtemp1
vezaxname11[vzxnn]=vezaxtemp2
end
vzxnn=vzxnn-1
end
end



function reportafterboitwotab(inwhichchat, bojinterr, tabln, tablc, qq, maxpers,iccsv,norep,norep2)

if (tabln==nil or tabln=={}) then tabln = {} end
if (tablc==nil or tablc=={}) then tablc = {} end
local vzxnn= # tabln
local pstochki=""
if(vzxnn>0)then
if maxpers==nil then
if psdifflastfight==0 or psdifflastfight==25 then
	if norep then
		maxpers=psraidoptionsnumers[8]
	else
		maxpers=psraidoptionsnumers[6]
	end
else
	if norep then
		maxpers=psraidoptionsnumers[7]
	else
		maxpers=psraidoptionsnumers[5]
	end
end
end
if vzxnn>maxpers then vzxnn=maxpers pstochki=",..." else pstochki="." end
for i = 1,vzxnn do

--обрезание ника
local pname=tabln[i]
if norep==nil then
  pname=psnoservername(pname)
end

if i==vzxnn then
		if norep then
			strochkavezcrash=strochkavezcrash..psaddcolortxt(1,tabln[i])..pname..psaddcolortxt(2,tabln[i]).." ("..tablc[i]..")"..pstochki
		else
			strochkavezcrash=strochkavezcrash..pname.." ("..tablc[i]..")"..pstochki
		end
		if norep2==nil then
			pszapuskanonsa(inwhichchat, strochkavezcrash, bojinterr,nil,iccsv,norep)
		end
else
		if norep then
			strochkavezcrash=strochkavezcrash..psaddcolortxt(1,tabln[i])..pname..psaddcolortxt(2,tabln[i]).." ("..tablc[i].."), "
		else
			strochkavezcrash=strochkavezcrash..pname.." ("..tablc[i].."), "
		end
end
end
end

end


function pscheckwipe1(num10,num25)
if num10==nil then num10=psraidoptionsnumers[3] end
if num25==nil then num25=psraidoptionsnumers[4] end


local psnumdead=0
pswipetrue=nil

if pswipecheckdelay==nil or (pswipecheckdelay and GetTime()>pswipecheckdelay) then
pswipecheckdelay=GetTime()+5


local psnumgrup=2
	if GetRaidDifficulty()==2 or GetRaidDifficulty()==4 then
	psnumgrup=5
	end
for i = 1,GetNumRaidMembers() do
  local nameee,_,subgroup,_,_,_,_,_,isDead = GetRaidRosterInfo(i)
  if nameee and ((isDead==1 or UnitIsDeadOrGhost(nameee)==1) and subgroup<=psnumgrup) then
    psnumdead=psnumdead+1
  end
end

if ((psnumgrup==2 and psnumdead>=num10) or (psnumgrup==5 and psnumdead>=num25)) then
pswipetrue=1
psthiscombatwipe=1
end


end --delay

end


function addtotwotables(nicktoadd)

local bililine=0
for i,getcrash in ipairs(vezaxname) do 
if getcrash == nicktoadd then vezaxcrash[i]=vezaxcrash[i]+1 bililine=1
end end
if(bililine==0)then
table.insert(vezaxname,nicktoadd) 
table.insert(vezaxcrash,1) 
end

end

function addtotwotables2(nicktoadd)

local bililine=0
for i,getcrash in ipairs(vezaxname2) do 
if getcrash == nicktoadd then vezaxcrash2[i]=vezaxcrash2[i]+1 bililine=1
end end
if(bililine==0)then
table.insert(vezaxname2,nicktoadd) 
table.insert(vezaxcrash2,1) 
end

end

function addtotwotables3(nicktoadd)

local bililine=0
for i,getcrash in ipairs(vezaxname3) do 
if getcrash == nicktoadd then vezaxcrash3[i]=vezaxcrash3[i]+1 bililine=1
end end
if(bililine==0)then
table.insert(vezaxname3,nicktoadd) 
table.insert(vezaxcrash3,1) 
end

end


function addtotwotables4(nicktoadd)

local bililine=0
for i,getcrash in ipairs(vezaxname4) do 
if getcrash == nicktoadd then vezaxcrash4[i]=vezaxcrash4[i]+1 bililine=1
end end
if(bililine==0)then
table.insert(vezaxname4,nicktoadd) 
table.insert(vezaxcrash4,1) 
end

end


function addtotwotables5(nicktoadd,q)
if q==nil then q=1 end

local bililine=0
for i,getcrash in ipairs(vezaxname5) do 
if getcrash == nicktoadd then vezaxcrash5[i]=vezaxcrash5[i]+q bililine=1
end end
if(bililine==0)then
table.insert(vezaxname5,nicktoadd) 
table.insert(vezaxcrash5,q) 
end

end

function addtotwotables6(nicktoadd,q)
if q==nil then q=1 end

local bililine=0
for i,getcrash in ipairs(vezaxname6) do 
if getcrash == nicktoadd then vezaxcrash6[i]=vezaxcrash6[i]+q bililine=1
end end
if(bililine==0)then
table.insert(vezaxname6,nicktoadd) 
table.insert(vezaxcrash6,q) 
end

end

function addtotwotables7(nicktoadd,q)
if q==nil then q=1 end

local bililine=0
for i,getcrash in ipairs(vezaxname7) do 
if getcrash == nicktoadd then vezaxcrash7[i]=vezaxcrash7[i]+q bililine=1
end end
if(bililine==0)then
table.insert(vezaxname7,nicktoadd) 
table.insert(vezaxcrash7,q) 
end

end

function addtotwotables8(nicktoadd)

local bililine=0
for i,getcrash in ipairs(vezaxname8) do 
if getcrash == nicktoadd then vezaxcrash8[i]=vezaxcrash8[i]+1 bililine=1
end end
if(bililine==0)then
table.insert(vezaxname8,nicktoadd) 
table.insert(vezaxcrash8,1) 
end

end

function addtotwotables9(nicktoadd)

local bililine=0
for i,getcrash in ipairs(vezaxname9) do 
if getcrash == nicktoadd then vezaxcrash9[i]=vezaxcrash9[i]+1 bililine=1
end end
if(bililine==0)then
table.insert(vezaxname9,nicktoadd) 
table.insert(vezaxcrash9,1) 
end

end

function addtotwotables10(nicktoadd)

local bililine=0
for i,getcrash in ipairs(vezaxname10) do 
if getcrash == nicktoadd then vezaxcrash10[i]=vezaxcrash10[i]+1 bililine=1
end end
if(bililine==0)then
table.insert(vezaxname10,nicktoadd) 
table.insert(vezaxcrash10,1) 
end

end

function addtotwotables11(nicktoadd)

local bililine=0
for i,getcrash in ipairs(vezaxname11) do 
if getcrash == nicktoadd then vezaxcrash11[i]=vezaxcrash11[i]+1 bililine=1
end end
if(bililine==0)then
table.insert(vezaxname11,nicktoadd) 
table.insert(vezaxcrash11,1) 
end

end


function chechtekzone()

--ыытест тут прописывать лод при релоге в зоне

--КАТА Т1
local a1, a2, a3, a4, a5 = GetInstanceInfo()
if UnitInRaid("player") or a2=="raid" then
SetMapToCurrentZone()
end
if GetCurrentMapAreaID()==754 or GetCurrentMapAreaID()==758 or GetCurrentMapAreaID()==773 or GetCurrentMapAreaID()==752 then
if IsAddOnLoaded("PhoenixStyleMod_CataMiniRaids")==nil and wascmrtryload==nil then
wascmrtryload=1
local loaded, reason = LoadAddOn("PhoenixStyleMod_CataMiniRaids")
if loaded then
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
else
print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." PhoenixStyleMod_CataMiniRaids! "..pscheckmodenabl)
end
end
end

--КАТА Т2
local a1, a2, a3, a4, a5 = GetInstanceInfo()
if UnitInRaid("player") or a2=="raid" then
SetMapToCurrentZone()
end
if GetCurrentMapAreaID()==pslocations[5] then
if IsAddOnLoaded("PhoenixStyleMod_Firelands")==nil and wascmrtryload_2==nil then
wascmrtryload_2=1
local loaded, reason = LoadAddOn("PhoenixStyleMod_Firelands")
if loaded then
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
else
print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." PhoenixStyleMod_Firelands! "..pscheckmodenabl)
end
end
end

--КАТА Т3
local a1, a2, a3, a4, a5 = GetInstanceInfo()
if UnitInRaid("player") or a2=="raid" then
SetMapToCurrentZone()
end
if GetCurrentMapAreaID()==pslocations[6] then
if IsAddOnLoaded("PhoenixStyleMod_DragonSoul")==nil and wascmrtryload_3==nil then
wascmrtryload_3=1
local loaded, reason = LoadAddOn("PhoenixStyleMod_DragonSoul")
if loaded then
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
else
print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." PhoenixStyleMod_DragonSoul! "..pscheckmodenabl)
end
end
end



end

function psfnotofficer()
if (psfnotoffvar==0)then
psfnotoffvar=1
print("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..psfnotofficerspam)
end
end


function addtotridamagetables(nicktoadd, damagetoadd, count)


local bililine=0
for i,getcrash in ipairs(psdamagename) do 
if getcrash == nicktoadd then psdamagevalue[i]=psdamagevalue[i]+damagetoadd psdamageraz[i]=psdamageraz[i]+count bililine=1
end end
if(bililine==0)then
table.insert(psdamagename,nicktoadd) 
table.insert(psdamagevalue,damagetoadd)
table.insert(psdamageraz,count)
end

end

function addtotwodamagetables(nicktoadd, damagetoadd)

local bililine=0
for i,getcrash in ipairs(psdamagename2) do 
if getcrash == nicktoadd then psdamagevalue2[i]=psdamagevalue2[i]+damagetoadd bililine=1
end end
if(bililine==0)then
table.insert(psdamagename2,nicktoadd) 
table.insert(psdamagevalue2,damagetoadd)
end

end

function addtotwodamagetables3(nicktoadd, damagetoadd)


local bililine=0
for i,getcrash in ipairs(psdamagename3) do 
if getcrash == nicktoadd then psdamagevalue3[i]=psdamagevalue3[i]+damagetoadd bililine=1
end end
if(bililine==0)then
table.insert(psdamagename3,nicktoadd) 
table.insert(psdamagevalue3,damagetoadd)
end

end

function psdamagetritablsort1()
local vzxnnw= # psdamagename
while vzxnnw>1 do
if psdamagevalue[vzxnnw]>psdamagevalue[vzxnnw-1] then
local vezaxtempv1=psdamagevalue[vzxnnw-1]
local vezaxtempv2=psdamagename[vzxnnw-1]
local vezaxtempv3=psdamageraz[vzxnnw-1]
psdamagevalue[vzxnnw-1]=psdamagevalue[vzxnnw]
psdamagename[vzxnnw-1]=psdamagename[vzxnnw]
psdamageraz[vzxnnw-1]=psdamageraz[vzxnnw]
psdamagevalue[vzxnnw]=vezaxtempv1
psdamagename[vzxnnw]=vezaxtempv2
psdamageraz[vzxnnw]=vezaxtempv3
end
vzxnnw=vzxnnw-1
end
end

function psdamagetwotablsort1()
local vzxnnw= # psdamagename2
while vzxnnw>1 do
if psdamagevalue2[vzxnnw]>psdamagevalue2[vzxnnw-1] then
local vezaxtempv1=psdamagevalue2[vzxnnw-1]
local vezaxtempv2=psdamagename2[vzxnnw-1]
psdamagevalue2[vzxnnw-1]=psdamagevalue2[vzxnnw]
psdamagename2[vzxnnw-1]=psdamagename2[vzxnnw]
psdamagevalue2[vzxnnw]=vezaxtempv1
psdamagename2[vzxnnw]=vezaxtempv2
end
vzxnnw=vzxnnw-1
end
end

function psdamagetwotablsort3()
local vzxnnw= # psdamagename3
if psdamagename3 and # psdamagename3>1 then
while vzxnnw>1 do
if psdamagevalue3[vzxnnw]>psdamagevalue3[vzxnnw-1] then
local vezaxtempv1=psdamagevalue3[vzxnnw-1]
local vezaxtempv2=psdamagename3[vzxnnw-1]
psdamagevalue3[vzxnnw-1]=psdamagevalue3[vzxnnw]
psdamagename3[vzxnnw-1]=psdamagename3[vzxnnw]
psdamagevalue3[vzxnnw]=vezaxtempv1
psdamagename3[vzxnnw]=vezaxtempv2
end
vzxnnw=vzxnnw-1
end
end
end


function reportfromtridamagetables(inwhichchat,maxpers,qq,bojinterr,iccra,norep,noquantity)

if (psdamagename==nil or psdamagename=={}) then psdamagename = {} end
if (psdamagevalue==nil or psdamagevalue=={}) then psdamagevalue = {} end
if (psdamageraz==nil or psdamageraz=={}) then psdamageraz = {} end
local psinfoshieldtempdamage=""
local vzxnn= # psdamagename
local pstochki=""
if maxpers==nil then
if psdifflastfight==0 or psdifflastfight==25 then
	if norep then
		maxpers=psraidoptionsnumers[8]
	else
		maxpers=psraidoptionsnumers[6]
	end
else
	if norep then
		maxpers=psraidoptionsnumers[7]
	else
		maxpers=psraidoptionsnumers[5]
	end
end
end
if(vzxnn>0)then
if vzxnn>maxpers then vzxnn=maxpers pstochki=",..." else pstochki="." end
for i = 1,vzxnn do


local pname=psdamagename[i]
if norep==nil then
  pname=psnoservername(psdamagename[i])
end


			if psdamagevalue[i] and psdamagevalue[i]>0 then

		psinfoshieldtempdamage=psdamageceil(psdamagevalue[i])

			end

if i==vzxnn then

			if psdamagevalue[i] and psdamagevalue[i]>0 then
        local raz=""
        if noquantity==nil then
          raz=" - "..psdamageraz[i]
        end
    if norep then
      strochkadamageout=strochkadamageout..psaddcolortxt(1,psdamagename[i])..pname..psaddcolortxt(2,psdamagename[i]).." ("..psinfoshieldtempdamage..raz..")"..pstochki
    else
      strochkadamageout=strochkadamageout..pname.." ("..psinfoshieldtempdamage..raz..")"..pstochki
    end
			end
		pszapuskanonsa(inwhichchat, strochkadamageout,bojinterr,nil,iccra,norep)

else
			if psdamagevalue[i] and psdamagevalue[i]>0 then
        local raz=""
        if noquantity==nil then
          raz=" - "..psdamageraz[i]
        end
    if norep then
      strochkadamageout=strochkadamageout..psaddcolortxt(1,psdamagename[i])..pname..psaddcolortxt(2,psdamagename[i]).." ("..psinfoshieldtempdamage..raz.."), "
    else
      strochkadamageout=strochkadamageout..pname.." ("..psinfoshieldtempdamage..raz.."), "
    end
			end
end
end
end

end


function reportfromtwodamagetables(inwhichchat, qq, dmggood, numrrep, bojinterr,iccra,norep)

if (psdamagename2==nil or psdamagename2=={}) then psdamagename2 = {} end
if (psdamagevalue2==nil or psdamagevalue2=={}) then psdamagevalue2 = {} end
local vzxnn= # psdamagename2
local psinfoshieldtempdamage=""
local pstochki=""
if numrrep==nil then
if psdifflastfight==0 or psdifflastfight==25 then
	if norep then
		numrrep=psraidoptionsnumers[8]
	else
		numrrep=psraidoptionsnumers[6]
	end
else
	if norep then
		numrrep=psraidoptionsnumers[7]
	else
		numrrep=psraidoptionsnumers[5]
	end
end
end
if(vzxnn>0)then
if numrrep then else numrrep=18 end
if vzxnn>numrrep then vzxnn=numrrep pstochki=",..." else pstochki="." end
for i = 1,vzxnn do

local pname=psdamagename2[i]
if norep==nil then
  pname=psnoservername(psdamagename2[i])
end

			if dmggood==nil or psdamagevalue2[i]>dmggood then
        psinfoshieldtempdamage=psdamageceil(psdamagevalue2[i])
			end

if i==vzxnn then

			if dmggood==nil or psdamagevalue2[i]>dmggood then
if norep then
strochkadamageout=strochkadamageout..psaddcolortxt(1,psdamagename2[i])..pname..psaddcolortxt(2,psdamagename2[i]).." ("..psinfoshieldtempdamage..")"..pstochki
else
strochkadamageout=strochkadamageout..pname.." ("..psinfoshieldtempdamage..")"..pstochki
end
			end

		pszapuskanonsa(inwhichchat, strochkadamageout, bojinterr,nil,iccra,norep)
else

			if dmggood==nil or psdamagevalue2[i]>dmggood then
if norep then
	strochkadamageout=strochkadamageout..psaddcolortxt(1,psdamagename2[i])..pname..psaddcolortxt(2,psdamagename2[i]).." ("..psinfoshieldtempdamage.."), "
else
	strochkadamageout=strochkadamageout..pname.." ("..psinfoshieldtempdamage.."), "
end
			end

end



end
end

end

function reportfromtwodamagetables3(inwhichchat, qq, dmggood, numrrep, bojinterr, iccra,norep)

if (psdamagename3==nil or psdamagename3=={}) then psdamagename3 = {} end
if (psdamagevalue3==nil or psdamagevalue3=={}) then psdamagevalue3 = {} end
local vzxnn= # psdamagename3
local psinfoshieldtempdamage=""
local pstochki=""
if numrrep==nil then
if psdifflastfight==0 or psdifflastfight==25 then
	if norep then
		numrrep=psraidoptionsnumers[8]
	else
		numrrep=psraidoptionsnumers[6]
	end
else
	if norep then
		numrrep=psraidoptionsnumers[7]
	else
		numrrep=psraidoptionsnumers[5]
	end
end
end
if(vzxnn>0)then
if vzxnn>numrrep then vzxnn=numrrep pstochki=",..." else pstochki="." end
for i = 1,vzxnn do

			if dmggood==nil or psdamagevalue3[i]>dmggood then

	psinfoshieldtempdamage=psdamageceil(psdamagevalue3[i])


			end

if i==vzxnn then

			if dmggood==nil or psdamagevalue3[i]>dmggood then
if norep then
strochkadamageout=strochkadamageout..psaddcolortxt(1,psdamagename3[i])..psdamagename3[i]..psaddcolortxt(2,psdamagename3[i]).." ("..psinfoshieldtempdamage..")"..pstochki
else
strochkadamageout=strochkadamageout..psdamagename3[i].." ("..psinfoshieldtempdamage..")"..pstochki
end
			end

		pszapuskanonsa(inwhichchat, strochkadamageout, bojinterr,nil,iccra,norep)
else
			if dmggood==nil or psdamagevalue3[i]>dmggood then
if norep then
	strochkadamageout=strochkadamageout..psaddcolortxt(1,psdamagename3[i])..psdamagename3[i]..psaddcolortxt(2,psdamagename3[i]).." ("..psinfoshieldtempdamage.."), "
else
	strochkadamageout=strochkadamageout..psdamagename3[i].." ("..psinfoshieldtempdamage.."), "
end
			end

end
end
end

end


function pszapuskanonsa(kudarep, chtorep, bojinterr, vajnreport, addicc, norep)

--saving boss info for icc module
if addicc then

  local playerid=0
  for vv=1,#pssisavedfailsplayern[2] do
    if pssisavedfailsplayern[2][vv]==UnitGUID("player") then
      playerid=vv
    end
  end

  chtorep=psspellfilter2(chtorep)

  if playerid>0 then
    table.insert(pssisavedfailaftercombat[playerid][1],chtorep)
  end
end

if norep==nil then


if thisaddononoff and kudarep and chtorep then

chtorep=psspellfilter(chtorep)
--chtorep=psremovecolor(chtorep)

--new 4 lines
if((kudarep=="raid" or kudarep=="raid_warning") and IsRaidOfficer()==nil and psfnopromrep==false) then
psfnotofficer()
kudarep="sebe"
end

if kudarep=="sebe" then

if (string.find(chtorep, "{")==1) then
	if (string.find(chtorep, "} ")) then
		DEFAULT_CHAT_FRAME:AddMessage("- "..string.sub(chtorep, string.find(chtorep, "}")+2))
	else
		DEFAULT_CHAT_FRAME:AddMessage("- "..string.sub(chtorep, string.find(chtorep, "}")+1))
	end
else
DEFAULT_CHAT_FRAME:AddMessage(chtorep)
end

else

  if (bojinterr and ((GetTime()<psnotanonsemore+70 and psnotanonsemorechat and (psnotanonsemorechat==kudarep or (psnotanonsemorechat=="raid_warning" and kudarep=="raid") or (psnotanonsemorechat=="raid" and kudarep=="raid_warning"))) or GetTime()<psmylogin+180)) then
	else

		if ((bojinterr==nil or bojinterr==false) and (GetTime()<psnotanonsemorenormal+2 and psnotanonsemorenormalchat and (psnotanonsemorenormalchat==kudarep or (psnotanonsemorenormalchat=="raid_warning" and kudarep=="raid") or (psnotanonsemorenormalchat=="raid" and kudarep=="raid_warning")))) then
		else

      if ((bojinterr==nil or bojinterr==false) and (GetTime()<psnotanonsemorenormal2+2 and psnotanonsemorenormalchat2 and (psnotanonsemorenormalchat2==kudarep or (psnotanonsemorenormalchat2=="raid_warning" and kudarep=="raid") or (psnotanonsemorenormalchat2=="raid" and kudarep=="raid_warning")))) then
      else

        --проверка нестандартного чата
        local bililine=0
        for i,cc in ipairs(bigmenuchatlisten) do
          if cc == kudarep then
            bililine=1
          end
        end
        if kudarep=="BATTLEGROUND" then
          bililine=1
        end

        if bililine==0 then
          if GetChannelName(kudarep)==0 then
            JoinPermanentChannel(kudarep)
            ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, kudarep)
          end
        end

        if (bililine==1 or (bililine==0 and GetChannelName(kudarep)>0)) then

--3 Типа анонсов, после боя, по ходу боя в 1 канал, по ходу боя в 2 канал

--после боя
          if bojinterr then

            if psmsgwaiting==0 then
              if bojinterr then pssendinterboj=1 else pssendinterboj=nil
              end
              if vajnreport then psanounsesrazuchek=1
              end
              psmsgtimestart=GetTime()
              psmsgwaiting=GetTime()
              psmsgmychat=kudarep --мой чат в который идет аннонс
              psnamemsgsend=UnitName("player")
              if UnitName("player")=="Шуршик" or UnitName("player")=="Шурши" or UnitName("player")=="Шурш" then psnamemsgsend="00"..psnamemsgsend end
              if IsRaidOfficer()==1 then psnamemsgsend="0"..psnamemsgsend end
                table.wipe(pscanannouncetable)
                table.insert(pscanannouncetable, psnamemsgsend)
              end

              if pssetcrossbeforereport1 and GetTime()<pssetcrossbeforereport1+1 then
                if psraidoptionsnumers[1]==2 then
                  table.insert (psannouncewait, "{rt7} "..chtorep)
                elseif psraidoptionsnumers[1]==1 then
                  table.insert (psannouncewait, "{rt7} "..chtorep)
                  pssetcrossbeforereport1=nil
                else
                  table.insert (psannouncewait, chtorep)
                end
              else
                table.insert (psannouncewait, chtorep)
              end

            elseif (psmsgwaiting42==0 and (psmsgwaiting43==0 or (psmsgwaiting43>0 and psmsgmychat43~=kudarep))) or (psmsgwaiting42>0 and psmsgmychat42==kudarep) then

if psmsgwaiting42==0 then
if vajnreport then psanounsesrazuchek=1 end
psmsgtimestart42=GetTime()
psmsgwaiting42=GetTime()
psmsgmychat42=kudarep
psnamemsgsend=UnitName("player")
if UnitName("player")=="Шуршик" or UnitName("player")=="Шурши" or UnitName("player")=="Шурш" then psnamemsgsend="00"..psnamemsgsend end
if IsRaidOfficer()==1 then psnamemsgsend="0"..psnamemsgsend end
table.wipe(pscanannouncetable42)
table.insert(pscanannouncetable42, psnamemsgsend)
end

table.insert (psannouncewait42, chtorep)


            else

if psmsgwaiting43==0 then
if vajnreport then psanounsesrazuchek=1 end
psmsgtimestart43=GetTime()
psmsgwaiting43=GetTime()
psmsgmychat43=kudarep
psnamemsgsend=UnitName("player")
if UnitName("player")=="Шуршик" or UnitName("player")=="Шурши" or UnitName("player")=="Шурш" then psnamemsgsend="00"..psnamemsgsend end
if IsRaidOfficer()==1 then psnamemsgsend="0"..psnamemsgsend end
table.wipe(pscanannouncetable43)
table.insert(pscanannouncetable43, psnamemsgsend)
end

table.insert (psannouncewait43, chtorep)

            end
          end
        end
      end
		end

--else
--psfnotofficer()
  end
--end--ыытест переделка для селф репорта

end --thisaddononoff

end --norep

end




function PS_MinimapButton_Reposition()
	PS_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(PS_Settings.PSMinimapPos)),(80*sin(PS_Settings.PSMinimapPos))-52)
end

function PS_MinimapButton_DraggingFrame_OnUpdate()

	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70
	ypos = ypos/UIParent:GetScale()-ymin-70

	PS_Settings.PSMinimapPos = math.deg(math.atan2(ypos,xpos))
	PS_MinimapButton_Reposition()
end

--arg1="LeftButton", "RightButton"
function PS_MinimapButton_OnClick()

GameTooltip:Hide()

if PSFmain1:IsShown() then
  PSF_buttonsaveexit()
else
  PSFmain1:Hide()
  PSFmain2:Hide()
  PSF_closeallpr()
  PSFmain1:Show()
  PSFmain2:Show()
  PSFmain3:Show()
  PSFmain2_Button3:SetAlpha(0.3)
  if psshowsavedinfofirst then
    psbutclickedsavedinfo()
  end
end

end


function PS_MinimapButton_OnEnter(self)
	if (self.dragging) then
		return
	end
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_LEFT")
	PS_MinimapButton_Details(GameTooltip)
end


function PS_MinimapButton_Details(tt, ldb)
	tt:SetText("PhoenixStyle")

end

function psver(cchat)
pscheck(1,cchat)
end

function pscheck(nr,cchat)
psshushinfo=GetTime()+7
local psa1=0
local psa2=0
local psa3=0
local psa4=""
local psa5=0
local psa6=""
local psa7="0"
if IsAddOnLoaded("Boss_shieldsmonitor") then
psa7=bsmversion or 1
end
if thisaddonwork then psa1=1 end
if thisaddononoff then psa2=1 end
if psfnopromrep then psa3=1 end
if rscversion then psa5=rscversion end
psa4=psraidchats3[1]..psraidchats3[2]..psraidchats3[3]
if GetLocale() then
psa6=GetLocale()
end
print ("PS "..UnitName("player").." v."..psversion.." "..psa1..psa2..psa3..pssaaddon_12[2].." rsc:"..psa5.." bsm:"..psa7.." chat:"..psa4..", "..psa6.." installed: "..psaddoninstalledsins)
if nr then
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
if cchat==nil then
SendAddonMessage("PSaddon", "12info", "raid")
else
SendAddonMessage("PSaddon", "12info", cchat)
end
end
end
end

function psmapbuttreflesh()
if pstextffgdgdf==nil then
pstextffgdgdf=1

tpsicon = PS_MinimapButton:CreateTexture(nil,"MEDIUM")
tpsicon:SetTexture("Interface\\AddOns\\PhoenixStyle\\icon_phoenix_e")
tpsicon:SetWidth(21)
tpsicon:SetHeight(21)
tpsicon:SetPoint("TOPLEFT",7,-6)
PS_MinimapButton.texture = tpsicon
end


	if psminibutenabl then
PS_MinimapButton:Show()

	if IsAddOnLoaded("SexyMap") then
	else
	PS_MinimapButton_Reposition()
	end

if thisaddononoff and thisaddonwork then
tpsicon:SetTexture("Interface\\AddOns\\PhoenixStyle\\icon_phoenix_e")
else
tpsicon:SetTexture("Interface\\AddOns\\PhoenixStyle\\icon_phoenix_d")
end
	else
	PS_MinimapButton:Hide()
	end
end


function psfautomarldraw()
if psfautomarkdaw1==nil then
psfautomarkdaw1=1
PSFmain4_Timerref:SetValue(secrefmark)

psfautomebtable={}
local psebf1 = CreateFrame("EditBox", "pseb1", PSFmain4,"InputBoxTemplate")
pseditframecreat(psebf1,-130,1)
local psebf2 = CreateFrame("EditBox", "pseb2", PSFmain4,"InputBoxTemplate")
pseditframecreat(psebf2,-155,2)
local psebf3 = CreateFrame("EditBox", "pseb3", PSFmain4,"InputBoxTemplate")
pseditframecreat(psebf3,-180,3)
local psebf4 = CreateFrame("EditBox", "pseb4", PSFmain4,"InputBoxTemplate")
pseditframecreat(psebf4,-205,4)
local psebf5 = CreateFrame("EditBox", "pseb5", PSFmain4,"InputBoxTemplate")
pseditframecreat(psebf5,-230,5)
local psebf6 = CreateFrame("EditBox", "pseb6", PSFmain4,"InputBoxTemplate")
pseditframecreat(psebf6,-255,6)
local psebf7 = CreateFrame("EditBox", "pseb7", PSFmain4,"InputBoxTemplate")
pseditframecreat(psebf7,-280,7)
local psebf8 = CreateFrame("EditBox", "pseb8", PSFmain4,"InputBoxTemplate")
pseditframecreat(psebf8,-305,8)

local t2 = PSFmain4:CreateFontString()
t2:SetWidth(420)
t2:SetHeight(400)
t2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t2:SetPoint("TOPLEFT",280,-25)
t2:SetText(psautomarktxtinf.."\r\n\r\n\r\n\r\n"..psautomarnewinfo)
t2:SetJustifyH("LEFT")
t2:SetJustifyV("TOP")


local t3 = PSFmain4:CreateFontString()
t3:SetWidth(720)
t3:SetHeight(40)
t3:SetFont(GameFontNormal:GetFont(), psfontsset[2])
t3:SetPoint("TOPLEFT",20,-394)
t3:SetText(psmainmarkgetm)
t3:SetJustifyH("LEFT")
t3:SetJustifyV("BOTTOM")

psautoupok={}

local psautoupok1 = PSFmain4:CreateFontString()
table.insert(psautoupok,psautoupok1)
psautoupok2 = PSFmain4:CreateFontString()
table.insert(psautoupok,psautoupok2)
psautoupok3 = PSFmain4:CreateFontString()
table.insert(psautoupok,psautoupok3)
psautoupok4 = PSFmain4:CreateFontString()
table.insert(psautoupok,psautoupok4)
psautoupok5 = PSFmain4:CreateFontString()
table.insert(psautoupok,psautoupok5)
psautoupok6 = PSFmain4:CreateFontString()
table.insert(psautoupok,psautoupok6)
psautoupok7 = PSFmain4:CreateFontString()
table.insert(psautoupok,psautoupok7)
psautoupok8 = PSFmain4:CreateFontString()
table.insert(psautoupok,psautoupok8)



for i=1,8 do
local t = PSFmain4:CreateTexture(nil,"OVERLAY")
t:SetTexture("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcon_"..i)
t:SetPoint("TOPLEFT",27,-106-i*25)
t:SetWidth(20)
t:SetHeight(20)
psautoupokfunc(psautoupok[i],i)
end
end
end

function psautoupokfunc(ttt,y)
ttt:SetWidth(80)
ttt:SetHeight(40)
ttt:SetFont(GameFontNormal:GetFont(), 13)
ttt:SetPoint("TOPLEFT",230,-108-25*y)
ttt:SetText("|cffff0000-|r")
ttt:SetJustifyH("LEFT")
ttt:SetJustifyV("TOP")
end


function pseditframecreat(a,b,nr)
a:SetAutoFocus(false)
a:SetHeight(20)
a:SetWidth(170)
a:SetPoint("TOPLEFT", 57, b)
a:Show()
a:SetScript("OnTabPressed", function(self) if psfautomebtable[nr+1] then psfautomebtable[nr+1]:SetFocus() psfautomebtable[nr+1]:HighlightText() else psfautomebtable[1]:SetFocus() psfautomebtable[1]:HighlightText() end end )
a:SetScript("OnEnterPressed", function(self) psautomarunfoc() end )

local nicks=""
if #pssetmarknew[nr]>0 then
	for h=1,#pssetmarknew[nr] do
		if string.len(nicks)>1 then
			nicks=nicks..", "
		end
		nicks=nicks..pssetmarknew[nr][h]
	end
end

a:SetText(nicks)
table.insert(psfautomebtable,a)
end

function psautoupmarkssetoff()
if (autorefmark) then
timeeventr=0
PSF_buttonoffmark()
end
end

function psmarksoff(where)
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
if where==nil then
SendAddonMessage("PSaddon", "16off", "raid")
else
SendAddonMessage("PSaddon", "16off", where)
end
end
end

function psfpotioncheckshow()
rscframeuse1=1
PSFpotioncheckframe_Text1:Hide()
PSFpotioncheckframe_Text2:Hide()
PSFpotioncheckframe_Text3:Hide()
PSFpotioncheckframe_CheckButton1:Show()
PSFpotioncheckframe_CheckButton2:Show()
PSFpotioncheckframe_CheckButton3:Show()
if rscversion and rscversion>1.004 then
PSFpotioncheckframe_Buttonrezet:Show()
end
rsc_showoptions()
rscrefleshinfo(1)
if rsclocpot16==nil then
out("|cff99ffffPhoenixStyle|r - |cffff0000"..pserror.."|r "..psrscoldvers)
end

end


function psslidertimerefmark()
secrefmark = PSFmain4_Timerref:GetValue()
local text=""
if GetLocale() == "ruRU" then
text=psmarkinfo1.." "..secrefmark.." "..pssec
else
text=psmarkinfo1.." "..secrefmark
end
PSFmain4_Textin:SetText(text)
if (autorefmark) then
timeeventr=GetTime()+secrefmark
end
end

function pszonechangedall()
chechtekzone()

	if psverschech1==nil then
psverschech1=1
if (UnitInRaid("player")) then
local inInstance, instanceType = IsInInstance()
if instanceType~="pvp" then
SendAddonMessage("PSaddon", "17"..psversion, "raid")
end
end

if IsInGuild() then
SendAddonMessage("PSaddon", "17"..psversion, "guild")
end
	end
end

function PSF_marksoffsetaut()
if autorefmark then
PSF_buttonoffmark()
end
if psunmarkallraiders==nil then
psunmarkallraiders=GetTime()+1
end
end


function psunitisplayer(id,name)
psunitplayertrue=nil

if UnitInRaid(name) then
psunitplayertrue=1
elseif id then


	local B = tonumber(id:sub(5,5), 16)
	local maskedB = B % 8
	if maskedB and maskedB==0 then
		psunitplayertrue=1
	end

end
end


--дроп даун для SA аддона
function opensadrop()
if not DropDownMenusadropaddon then
CreateFrame("Frame", "DropDownMenusadropaddon", PSF_saframe, "UIDropDownMenuTemplate")
end

DropDownMenusadropaddon:ClearAllPoints()
DropDownMenusadropaddon:SetPoint("TOPLEFT", 7, -70)
DropDownMenusadropaddon:Show()

--psmenuchoose1

local items={pschatlist6,pschatlist7}


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenusadropaddon, self:GetID())

pssaaddon_12[1]=self:GetID()

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


UIDropDownMenu_Initialize(DropDownMenusadropaddon, initialize)
UIDropDownMenu_SetWidth(DropDownMenusadropaddon, 155)
UIDropDownMenu_SetButtonWidth(DropDownMenusadropaddon, 170)
UIDropDownMenu_SetSelectedID(DropDownMenusadropaddon,pssaaddon_12[1])
UIDropDownMenu_JustifyText(DropDownMenusadropaddon, "LEFT")
end


function opensaybossad()
if not DropDownMenusaybossad then
CreateFrame("Frame", "DropDownMenusaybossad", PSF_saframe, "UIDropDownMenuTemplate")
end

DropDownMenusaybossad:ClearAllPoints()
DropDownMenusaybossad:SetPoint("TOPLEFT", 8, -190)
DropDownMenusaybossad:Show()

local items=pslocationnames
SetMapToCurrentZone()
ps_sa_menuchoose1=#ps_sa_id
for t=1,#pslocations do
	if pslocations[t]==GetCurrentMapAreaID() then
		ps_sa_menuchoose1=t
	end
end

ps_sa_showbossopt()

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenusaybossad, self:GetID())

if ps_sa_menuchoose1~=self:GetID() then
ps_sa_menuchoose1=self:GetID()
ps_sa_showbossopt()
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

ps_sa_showbossopt()

UIDropDownMenu_Initialize(DropDownMenusaybossad, initialize)
UIDropDownMenu_SetWidth(DropDownMenusaybossad, 160)
UIDropDownMenu_SetButtonWidth(DropDownMenusaybossad, 175)
UIDropDownMenu_SetSelectedID(DropDownMenusaybossad,ps_sa_menuchoose1)
UIDropDownMenu_JustifyText(DropDownMenusaybossad, "LEFT")
end



function openbossic()
if not DropDownMenubossic then
CreateFrame("Frame", "DropDownMenubossic", PSFmainic1, "UIDropDownMenuTemplate")
end

DropDownMenubossic:ClearAllPoints()
DropDownMenubossic:SetPoint("TOPLEFT", 8, -40)
DropDownMenubossic:Show()

--psmenuchoose1

local items=pslocationnames
SetMapToCurrentZone()
for t=1,#pslocations do
	if pslocations[t]==GetCurrentMapAreaID() then
		psmenuchoose1=t
		pscheckbossinthissec=GetTime()
	end
end


local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenubossic, self:GetID())

if psmenuchoose1~=self:GetID() then
psmenuchoose1=self:GetID()
psmenuchoose2=1
openbossic2()
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


UIDropDownMenu_Initialize(DropDownMenubossic, initialize)
UIDropDownMenu_SetWidth(DropDownMenubossic, 160)
UIDropDownMenu_SetButtonWidth(DropDownMenubossic, 175)
UIDropDownMenu_SetSelectedID(DropDownMenubossic,psmenuchoose1)
UIDropDownMenu_JustifyText(DropDownMenubossic, "LEFT")
end

function openbossic2()
if not DropDownMenubossic2 then
CreateFrame("Frame", "DropDownMenubossic2", PSFmainic1, "UIDropDownMenuTemplate")
end

DropDownMenubossic2:ClearAllPoints()
DropDownMenubossic2:SetPoint("TOPLEFT", 208, -40)
DropDownMenubossic2:Show()

--psmenuchoose1



local items=psbossnames[psmenuchoose1]

if pscheckbossinthissec and GetTime()<pscheckbossinthissec+0.5 then
	if GetNumRaidMembers()>0 then
		local bil=0
		for g=1,GetNumRaidMembers() do
			if bil==0 and UnitName("raid"..g.."-target") then
				local a=tonumber(string.sub(UnitGUID("raid"..g.."-target"),-12,-9),16)
				for f=1,#psbossid[psmenuchoose1] do
					for d=1,#psbossid[psmenuchoose1][f] do
						if psbossid[psmenuchoose1][f][d]==a and psbossid[psmenuchoose1][f][d]~=0 then
							bil=f
						end
					end
				end
				if bil>0 then
					psmenuchoose2=bil
				end
			end
		end
	end
end

if psmenuchoose2>#psbossnames[psmenuchoose1] then
psmenuchoose2=1
end

psupdatemenugo()

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownMenubossic2, self:GetID())

if psmenuchoose2~=self:GetID() then
psmenuchoose2=self:GetID()
psupdatemenugo()
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


UIDropDownMenu_Initialize(DropDownMenubossic2, initialize)
UIDropDownMenu_SetWidth(DropDownMenubossic2, 160)
UIDropDownMenu_SetButtonWidth(DropDownMenubossic2, 175)
UIDropDownMenu_SetSelectedID(DropDownMenubossic2,psmenuchoose2)
UIDropDownMenu_JustifyText(DropDownMenubossic2, "LEFT")
end



function openchatic()
if not DropDownchatic then
CreateFrame("Frame", "DropDownchatic", PSFmainic1, "UIDropDownMenuTemplate")
end

DropDownchatic:ClearAllPoints()
DropDownchatic:SetPoint("TOPLEFT", 590, -10)
DropDownchatic:Show()

local items = bigmenuchatlist

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownchatic, self:GetID())

if self:GetID()>8 then
psraidchats3[1]=psfchatadd[self:GetID()-8]
else
psraidchats3[1]=bigmenuchatlisten[self:GetID()]
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

bigmenuchat2(psraidchats3[1])
if bigma2num==0 then
psraidchats3[1]=bigmenuchatlisten[1]
bigma2num=1
end

UIDropDownMenu_Initialize(DropDownchatic, initialize)
UIDropDownMenu_SetWidth(DropDownchatic, 85)
UIDropDownMenu_SetButtonWidth(DropDownchatic, 100)
UIDropDownMenu_SetSelectedID(DropDownchatic, bigma2num)
UIDropDownMenu_JustifyText(DropDownchatic, "LEFT")
end


function openchatic2()
if not DropDownchatic2 then
CreateFrame("Frame", "DropDownchatic2", PSFmainic1, "UIDropDownMenuTemplate")
end

DropDownchatic2:ClearAllPoints()
DropDownchatic2:SetPoint("TOPLEFT", 590, -33)
DropDownchatic2:Show()

local items = bigmenuchatlist

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownchatic2, self:GetID())

if self:GetID()>8 then
psraidchats3[2]=psfchatadd[self:GetID()-8]
else
psraidchats3[2]=bigmenuchatlisten[self:GetID()]
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

bigmenuchat2(psraidchats3[2])
if bigma2num==0 then
psraidchats3[2]=bigmenuchatlisten[1]
bigma2num=1
end

UIDropDownMenu_Initialize(DropDownchatic2, initialize)
UIDropDownMenu_SetWidth(DropDownchatic2, 85)
UIDropDownMenu_SetButtonWidth(DropDownchatic2, 100)
UIDropDownMenu_SetSelectedID(DropDownchatic2, bigma2num)
UIDropDownMenu_JustifyText(DropDownchatic2, "LEFT")
end


function openchatic3()
if not DropDownchatic3 then
CreateFrame("Frame", "DropDownchatic3", PSFmainic1, "UIDropDownMenuTemplate")
end

DropDownchatic3:ClearAllPoints()
DropDownchatic3:SetPoint("TOPLEFT", 590, -56)
DropDownchatic3:Show()

local items = bigmenuchatlist

local function OnClick(self)
UIDropDownMenu_SetSelectedID(DropDownchatic3, self:GetID())

if self:GetID()>8 then
psraidchats3[3]=psfchatadd[self:GetID()-8]
else
psraidchats3[3]=bigmenuchatlisten[self:GetID()]
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

bigmenuchat2(psraidchats3[3])
if bigma2num==0 then
psraidchats3[3]=bigmenuchatlisten[1]
bigma2num=1
end

UIDropDownMenu_Initialize(DropDownchatic3, initialize)
UIDropDownMenu_SetWidth(DropDownchatic3, 85)
UIDropDownMenu_SetButtonWidth(DropDownchatic3, 100)
UIDropDownMenu_SetSelectedID(DropDownchatic3, bigma2num)
UIDropDownMenu_JustifyText(DropDownchatic3, "LEFT")
end



	local ps_updateFrame = CreateFrame("Frame")
	local function onUpdate(self, elapsed)
		local x, y = GetCursorPosition()
		local scale = UIParent:GetEffectiveScale()
		x, y = x / scale, y / scale
		GameTooltip:SetPoint("BOTTOMLEFT", nil, "BOTTOMLEFT", x + 5, y + 2)
	end

	local function ps_onHyperlinkClick(self, data, link)

		if IsShiftKeyDown() then
			if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then
				ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..link)
			else
				ChatFrame_OpenChat(link)
			end
		end

	end

	local function ps_onHyperlinkEnter(self, data, link)
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetHyperlink(data)
		GameTooltip:Show()
		ps_updateFrame:SetScript("OnUpdate", onUpdate)
	end

	local function ps_onHyperlinkLeave(self, data, link)
		GameTooltip:Hide()
		ps_updateFrame:SetScript("OnUpdate", nil)
	end





function psfloadalltextures()
if psicctablecifr==nil then



--цифры
psicctablecifr={} --цифры
psicctableradiobut={}
psicctableradiobut[1]={} --радио1
psicctableradiobut[2]={} --радио2
psicctableradiobut[3]={} --радио3
psiccchbtfr={} --чекбатоны
psiccchbtfrtxt={}--текст

local c = PSFmainic1:CreateFontString()
c:SetFont(GameFontNormal:GetFont(), 13)
c:SetPoint("TOPLEFT",-15,-20)
c:SetWidth(250)
c:SetHeight(20)
c:SetJustifyH("CENTER")
c:SetJustifyV("TOP")
c:SetText(psmenuchangtx1)

local c = PSFmainic1:CreateFontString()
c:SetFont(GameFontNormal:GetFont(), 13)
c:SetPoint("TOPLEFT",185,-20)
c:SetWidth(250)
c:SetHeight(20)
c:SetJustifyH("CENTER")
c:SetJustifyV("TOP")
c:SetText(psmenuchangtx2)


for jj=1,17 do
local c = PSFmainic1:CreateFontString()
c:SetFont(GameFontNormal:GetFont(), 15)
c:SetPoint("TOPLEFT",50,-67-22*jj)
c:SetWidth(30)
c:SetHeight(15)
c:SetJustifyH("LEFT")
table.insert(psicctablecifr, c)

--radio buttons
local r = CreateFrame("CheckButton", nil, PSFmainic1, "SendMailRadioButtonTemplate")
r:SetPoint("TOPLEFT", 12, -66-jj*22)
r:SetScript("OnClick", function(self) psiccradiobuttchange(1,jj) end )
table.insert(psicctableradiobut[1], r)

local t = CreateFrame("CheckButton", nil, PSFmainic1, "SendMailRadioButtonTemplate")
t:SetPoint("TOPLEFT", 24, -66-jj*22)
t:SetScript("OnClick", function(self) psiccradiobuttchange(2,jj) end )
table.insert(psicctableradiobut[2], t)

local t = CreateFrame("CheckButton", nil, PSFmainic1, "SendMailRadioButtonTemplate")
t:SetPoint("TOPLEFT", 36, -66-jj*22)
t:SetScript("OnClick", function(self) psiccradiobuttchange(3,jj) end )
table.insert(psicctableradiobut[3], t)

--checkbuttons
local q = CreateFrame("CheckButton", nil, PSFmainic1, "OptionsCheckButtonTemplate")
q:SetWidth("25")
q:SetHeight("25")
q:SetPoint("TOPLEFT", 59, -62-jj*22)
q:SetScript("OnClick", function(self) PSFcheckic(jj) end )
table.insert(psiccchbtfr, q)



	local c = CreateFrame("SimpleHTML", nil, PSFmainic1)
	c:SetHeight(30)
	c:SetFont(GameFontNormal:GetFont(), psfontsset[1])
	c:SetPoint("TOPLEFT",83,-68-22*jj)
	c:SetScript("OnHyperlinkClick", ps_onHyperlinkClick)
	c:SetScript("OnHyperlinkEnter", ps_onHyperlinkEnter)
	c:SetScript("OnHyperlinkLeave", ps_onHyperlinkLeave)
	c:SetText("")
	c:SetWidth(650)
	c:SetHeight(30)
  c:SetFrameStrata("FULLSCREEN")

	c:SetJustifyH("LEFT")
	c:SetJustifyV("CENTER")
	c:Show()

table.insert(psiccchbtfrtxt, c)

--тут вставлять картинку босса

if ps_modelframe==nil then
	ps_modelframe = CreateFrame("PlayerModel", nil, PSFmainic1)
	ps_modelframe:SetPoint("BOTTOMRIGHT", PSFmainic1, "BOTTOMRIGHT", -11, 11)
	ps_modelframe:SetWidth(300)
	ps_modelframe:SetHeight(230)
	ps_modelframe:SetPortraitZoom(0.4)
	ps_modelframe:SetRotation(0)
	ps_modelframe:SetClampRectInsets(0, 0, 24, 0)
	ps_modelframe:Show()
	ps_modelframe:SetSequence(4)
	ps_modelframe:SetFrameStrata("DIALOG")
	PSFmain1_Button2:SetFrameStrata("FULLSCREEN")
end
	ps_modelframe:SetDisplayInfo(0)



end




psmenuchoose1=1
psmenuchoose2=1




end

openchatic()
openchatic2()
openchatic3()

--обновлять дропдун меню ТУТ
openbossic()
openbossic2()

end

function PSFcheckic(nrmenu)
--ыытест тут новые добавлять опции к новым патчам
--ыытест для т1 каты ката
if psmenuchoose1==1 or psmenuchoose1==2 or psmenuchoose1==3 or psmenuchoose1==4 then
	if psraidoptionsont1[psmenuchoose1][psmenuchoose2] and psraidoptionsont1[psmenuchoose1][psmenuchoose2][nrmenu] then
		if psraidoptionsont1[psmenuchoose1][psmenuchoose2][nrmenu]==1 then
			psraidoptionsont1[psmenuchoose1][psmenuchoose2][nrmenu]=0 else psraidoptionsont1[psmenuchoose1][psmenuchoose2][nrmenu]=1
		end
	else
		--SA плай изменений
		local whichsais=0
		for i=1,nrmenu do
			if psraidoptionsont1[psmenuchoose1][psmenuchoose2][i]==nil then
				whichsais=whichsais+1
			end
		end
		if ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais] then
			if ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]==1 then
				ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]=0
			else
				ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]=1
			end
		end
	end
end

--ыытест для т2 каты ката
if psmenuchoose1==5 then
	if psraidoptionsont2[1][psmenuchoose2] and psraidoptionsont2[1][psmenuchoose2][nrmenu] then
		if psraidoptionsont2[1][psmenuchoose2][nrmenu]==1 then
			psraidoptionsont2[1][psmenuchoose2][nrmenu]=0
		else
			psraidoptionsont2[1][psmenuchoose2][nrmenu]=1
		end
	else
		--SA плай изменений
		local whichsais=0
		for i=1,nrmenu do
			if psraidoptionsont2[1][psmenuchoose2][i]==nil then
				whichsais=whichsais+1
			end
		end
		if ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais] then
			if ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]==1 then
				ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]=0
			else
				ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]=1
			end
		end
	end
end

--ыытест для т3 каты ката
if psmenuchoose1==6 then
	if psraidoptionsont3[1][psmenuchoose2] and psraidoptionsont3[1][psmenuchoose2][nrmenu] then
		if psraidoptionsont3[1][psmenuchoose2][nrmenu]==1 then
			psraidoptionsont3[1][psmenuchoose2][nrmenu]=0
		else
			psraidoptionsont3[1][psmenuchoose2][nrmenu]=1
		end
	else
		--SA плай изменений
		local whichsais=0
		for i=1,nrmenu do
			if psraidoptionsont3[1][psmenuchoose2][i]==nil then
				whichsais=whichsais+1
			end
		end
		if ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais] then
			if ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]==1 then
				ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]=0
			else
				ps_saoptions[psmenuchoose1][psmenuchoose2][whichsais]=1
			end
		end
	end
end

--общее
if psraidoptionson[psmenuchoose1][psmenuchoose2][nrmenu] then
if psraidoptionson[psmenuchoose1][psmenuchoose2][nrmenu]==1 then
	psraidoptionson[psmenuchoose1][psmenuchoose2][nrmenu]=0
else
	psraidoptionson[psmenuchoose1][psmenuchoose2][nrmenu]=1
end
end
end



function psiccradiobuttchange(aa,bb)
--ыытест для т1 каты ката
if psmenuchoose1==1 or psmenuchoose1==2 or psmenuchoose1==3 or psmenuchoose1==4 then
psicctableradiobut[1][bb]:SetChecked(false)
psicctableradiobut[2][bb]:SetChecked(false)
psicctableradiobut[3][bb]:SetChecked(false)
psraidoptionschatt1[psmenuchoose1][psmenuchoose2][bb]=aa
psicctableradiobut[aa][bb]:SetChecked()
if aa==1 then
psicctablecifr[bb]:SetText("|cff00ff001|r")
elseif aa==2 then
psicctablecifr[bb]:SetText("|cffff00002|r")
elseif aa==3 then
psicctablecifr[bb]:SetText("|CFFFFFF003|r")
end
end

--ыытест для т2 каты ката
if psmenuchoose1==5 then
psicctableradiobut[1][bb]:SetChecked(false)
psicctableradiobut[2][bb]:SetChecked(false)
psicctableradiobut[3][bb]:SetChecked(false)
psraidoptionschatt2[1][psmenuchoose2][bb]=aa
psicctableradiobut[aa][bb]:SetChecked()
if aa==1 then
psicctablecifr[bb]:SetText("|cff00ff001|r")
elseif aa==2 then
psicctablecifr[bb]:SetText("|cffff00002|r")
elseif aa==3 then
psicctablecifr[bb]:SetText("|CFFFFFF003|r")
end
end

--ыытест для т3 каты ката
if psmenuchoose1==6 then
psicctableradiobut[1][bb]:SetChecked(false)
psicctableradiobut[2][bb]:SetChecked(false)
psicctableradiobut[3][bb]:SetChecked(false)
psraidoptionschatt3[1][psmenuchoose2][bb]=aa
psicctableradiobut[aa][bb]:SetChecked()
if aa==1 then
psicctablecifr[bb]:SetText("|cff00ff001|r")
elseif aa==2 then
psicctablecifr[bb]:SetText("|cffff00002|r")
elseif aa==3 then
psicctablecifr[bb]:SetText("|CFFFFFF003|r")
end
end

psraidoptionschat[psmenuchoose1][psmenuchoose2][bb]=aa
end


function psspryatatvseic()
for jj=1,17 do
psicctablecifr[jj]:SetText(" ")
psicctableradiobut[1][jj]:Hide()
psicctableradiobut[2][jj]:Hide()
psicctableradiobut[3][jj]:Hide()
psiccchbtfr[jj]:Hide()
psiccchbtfrtxt[jj]:SetText(" ")
end
end


function psupdatemenugo()
psspryatatvseic()
PSFmainic1_Buttonloadmod:Hide()
PSFmainic1_Buttonrez:Show()

if ps_modelframe then
	ps_modelframe:ClearModel()
end


if IsAddOnLoaded(psaddontoload[psmenuchoose1]) then

if psbossmodelshow and psbossmodelshow==1 and ps_modelid and ps_modelid[psmenuchoose1] and ps_modelid[psmenuchoose1][psmenuchoose2][1] then
	ps_modelframe:SetDisplayInfo(ps_modelid[psmenuchoose1][psmenuchoose2][1] or 0)
end


if psraidoptionson[psmenuchoose1][psmenuchoose2] then
for i=1,#psraidoptionson[psmenuchoose1][psmenuchoose2] do
	if psraidoptionschat[psmenuchoose1][psmenuchoose2][i]==nil or (psraidoptionschat[psmenuchoose1][psmenuchoose2][i] and psraidoptionschat[psmenuchoose1][psmenuchoose2][i]==0) then
	else
		psicctableradiobut[1][i]:SetChecked(false)
		psicctableradiobut[2][i]:SetChecked(false)
		psicctableradiobut[3][i]:SetChecked(false)
		if psraidoptionschat[psmenuchoose1][psmenuchoose2][i]==1 then
			psicctablecifr[i]:SetText("|cff00ff001|r")
			psicctableradiobut[1][i]:SetChecked()
		elseif psraidoptionschat[psmenuchoose1][psmenuchoose2][i]==2 then
			psicctablecifr[i]:SetText("|cffff00002|r")
			psicctableradiobut[2][i]:SetChecked()
		else
			psicctablecifr[i]:SetText("|CFFFFFF003|r")
			psicctableradiobut[3][i]:SetChecked()
		end
		psicctableradiobut[1][i]:Show()
		psicctableradiobut[2][i]:Show()
		psicctableradiobut[3][i]:Show()
	end
	psiccchbtfr[i]:Show()
	if psraidoptionson[psmenuchoose1][psmenuchoose2][i] and psraidoptionson[psmenuchoose1][psmenuchoose2][i]==1 then
		psiccchbtfr[i]:SetChecked()
	else
		psiccchbtfr[i]:SetChecked(false)
	end
	if psraidoptionstxt[psmenuchoose1][psmenuchoose2][i] then
		psiccchbtfrtxt[i]:SetText(psraidoptionstxt[psmenuchoose1][psmenuchoose2][i])
	end
end


end


	if ps_saoptions[psmenuchoose1] and ps_saoptions[psmenuchoose1][psmenuchoose2] and #ps_saoptions[psmenuchoose1][psmenuchoose2]>0 then
		local n=1
		if psraidoptionson[psmenuchoose1] and psraidoptionson[psmenuchoose1][psmenuchoose2] then
			n=#psraidoptionson[psmenuchoose1][psmenuchoose2]+1
		end
		for i=1,#ps_saoptions[psmenuchoose1][psmenuchoose2] do
			--если нет места то не пишем
			if n<18 then
			if ps_saoptions[psmenuchoose1][psmenuchoose2][i] and ps_saoptions[psmenuchoose1][psmenuchoose2][i]==1 then
				psiccchbtfr[n]:SetChecked()
			else
				psiccchbtfr[n]:SetChecked(false)
			end
			if ps_saoptions[psmenuchoose1][psmenuchoose2][i] then
				local a1=""
				if pssaaddon_12[2]==1 then
					a1=psmain_sadenfifenabl2
				else
					a1="|cffff0000"..psmain_sadenfifenabl1.."|r"
				end
				local spellid=""
				local comm=""
				if ps_sa_id[psmenuchoose1][psmenuchoose2][i] and string.find(ps_sa_id[psmenuchoose1][psmenuchoose2][i],"|AddComm") then
          spellid=string.sub(ps_sa_id[psmenuchoose1][psmenuchoose2][i],0,string.find(ps_sa_id[psmenuchoose1][psmenuchoose2][i],"|AddComm")-1)
          comm=psspellfilter(", "..string.sub(ps_sa_id[psmenuchoose1][psmenuchoose2][i],string.find(ps_sa_id[psmenuchoose1][psmenuchoose2][i],"|AddComm")+8))
        else
          spellid=ps_sa_id[psmenuchoose1][psmenuchoose2][i]
        end

				psiccchbtfrtxt[n]:SetText("|cff00ff00SayAnnouncer|r > "..ps_getspelllink(spellid)..comm.." - "..a1)
			end
			psiccchbtfr[n]:Show()
			n=n+1
			end
		end
	end
			

else
PSFmainic1_Buttonloadmod:Show()
PSFmainic1_Buttonrez:Hide()
end

end



function psloadmodulemanual()

if IsAddOnLoaded(psaddontoload[psmenuchoose1])==nil then
local loaded = LoadAddOn(psaddontoload[psmenuchoose1])
if loaded then
print("|cff99ffffPhoenixStyle|r - "..psmoduleload.." "..pslastmoduleloadtxt.."!")
psupdatemenugo()
else
print("|cff99ffffPhoenixStyle|r - "..psmodulenotload.." "..psaddontoload[psmenuchoose1].."! "..pscheckmodenabl)
end
end

end

function psiccoptraidf()
PSF_closeallpr()
PSFraidopt:Show()

if PSFraidoptdraw==nil then
PSFraidoptdraw=1


psiccbytimtxtd212 = PSFraidopt:CreateFontString()
psiccbytimtxtd212:SetWidth(260)
psiccbytimtxtd212:SetHeight(40)
psiccbytimtxtd212:SetFont(GameFontNormal:GetFont(), psfontsset[2])
psiccbytimtxtd212:SetPoint("TOPLEFT",512,-260)
psiccbytimtxtd212:SetJustifyH("CENTER")
psiccbytimtxtd212:SetJustifyV("TOP")
getglobal("PSFraidopt_Combatsvd1High"):SetText("40")
getglobal("PSFraidopt_Combatsvd1Low"):SetText("3")
PSFraidopt_Combatsvd1:SetMinMaxValues(3, 40)
PSFraidopt_Combatsvd1:SetValueStep(1)
PSFraidopt_Combatsvd1:SetValue(psicccombatsavedreport)
psicccombqcha22()


local s3=CreateFrame("Slider","slideropt3",PSFraidopt,"OptionsSliderTemplate")
local s4=CreateFrame("Slider","slideropt4",PSFraidopt,"OptionsSliderTemplate")
local s5=CreateFrame("Slider","slideropt5",PSFraidopt,"OptionsSliderTemplate")
local s6=CreateFrame("Slider","slideropt6",PSFraidopt,"OptionsSliderTemplate")
local s7=CreateFrame("Slider","slideropt7",PSFraidopt,"OptionsSliderTemplate")
local s8=CreateFrame("Slider","slideropt8",PSFraidopt,"OptionsSliderTemplate")

pssliderstablraidopt={s3,s4,s5,s6,s7,s8}

local temp1={35,235,35,235,35,235}
local temp2={-70,-70,-170,-170,-270,-270}
local temp3={1,1,2,3,3,5}
local temp4={7,15,10,25,10,25}

for i=1,6 do
pssliderstablraidopt[i]:SetWidth(145)
pssliderstablraidopt[i]:SetHeight(16)
pssliderstablraidopt[i]:SetPoint("TOPLEFT",temp1[i],temp2[i])
getglobal(pssliderstablraidopt[i]:GetName().."High"):SetText(temp4[i])
getglobal(pssliderstablraidopt[i]:GetName().."Low"):SetText(temp3[i])
getglobal(pssliderstablraidopt[i]:GetName().."Text"):SetText(psraidoptionsnumers[i+2])
pssliderstablraidopt[i]:SetMinMaxValues(temp3[i], temp4[i])
pssliderstablraidopt[i]:SetValueStep(1)
pssliderstablraidopt[i]:SetValue(psraidoptionsnumers[i+2])
pssliderstablraidopt[i]:SetScript("OnValueChanged", function (self) psraidoptionsnumers[i+2]=self:GetValue() getglobal(self:GetName().."Text"):SetText(psraidoptionsnumers[i+2]) end )

local s = PSFraidopt:CreateFontString()
s:SetWidth(180)
s:SetHeight(20)
s:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s:SetPoint("TOPLEFT",temp1[i]-15,temp2[i]-8)
s:SetJustifyH("CENTER")
s:SetJustifyV("BOTTOM")
if temp1[i]==temp1[1] then
s:SetText(format(psmaindeathrepforppl,10))
else
s:SetText(format(psmaindeathrepforppl,25))
end



end

local temptxt1={psmainraidopttxt5,psmainraidopttxt6,psmainraidopttxt7,psmainraidopttxt8,psmainraidopttxt9,psmainraidopttxt10,psmainraidopttxt11}
local temptxt2={-10,-110,-210,-310}

for i=1,4 do
local s = PSFraidopt:CreateFontString()
s:SetWidth(710)
s:SetHeight(42)
s:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s:SetPoint("TOPLEFT",22,temptxt2[i])
s:SetJustifyH("LEFT")
s:SetJustifyV("BOTTOM")
s:SetText(temptxt1[i])
end

--radio buttons
local r1 = CreateFrame("CheckButton", nil, PSFraidopt, "SendMailRadioButtonTemplate")
local r2 = CreateFrame("CheckButton", nil, PSFraidopt, "SendMailRadioButtonTemplate")
local r3 = CreateFrame("CheckButton", nil, PSFraidopt, "SendMailRadioButtonTemplate")

psrbuttablraidopt={r1,r2,r3}

for i=1,3 do
psrbuttablraidopt[i]:SetPoint("TOPLEFT", 17, -344-i*15)
psrbuttablraidopt[i]:SetWidth("16")
psrbuttablraidopt[i]:SetHeight("16")
psrbuttablraidopt[i]:SetScript("OnClick", function(self) psraidoptionsnumers[1]=i psrbuttablraidopt[1]:SetChecked(false) psrbuttablraidopt[2]:SetChecked(false) psrbuttablraidopt[3]:SetChecked(false) psrbuttablraidopt[i]:SetChecked() end )

--text
local s = PSFraidopt:CreateFontString()
s:SetWidth(700)
s:SetHeight(23)
s:SetFont(GameFontNormal:GetFont(), psfontsset[1])
s:SetPoint("TOPLEFT",36,-340-i*15)
s:SetJustifyH("LEFT")
s:SetText(temptxt1[i+4])
end
psrbuttablraidopt[psraidoptionsnumers[1]]:SetChecked()


--boss model options
local che1 = CreateFrame("CheckButton", nil, PSFraidopt, "OptionsCheckButtonTemplate")
che1:SetPoint("TOPLEFT", 17, -424)
che1:SetWidth("25")
che1:SetHeight("25")
che1:SetScript("OnClick", function(self) if psbossmodelshow==1 then psbossmodelshow=0 else psbossmodelshow=1 end end )
if psbossmodelshow==1 then
che1:SetChecked()
else
che1:SetChecked(false)
end

--text
local s = PSFraidopt:CreateFontString()
s:SetWidth(700)
s:SetHeight(23)
s:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s:SetPoint("TOPLEFT",40,-425)
s:SetJustifyH("LEFT")
s:SetText(psmainraidopttxtmodel)

--pets merge
local che2 = CreateFrame("CheckButton", nil, PSFraidopt, "OptionsCheckButtonTemplate")
che2:SetPoint("TOPLEFT", 17, -444)
che2:SetWidth("25")
che2:SetHeight("25")
che2:SetScript("OnClick", function(self) if psmergepets==1 then psmergepets=0 else psmergepets=1 end end )
if psmergepets==1 then
che2:SetChecked()
else
che2:SetChecked(false)
end

--text
local s2 = PSFraidopt:CreateFontString()
s2:SetWidth(700)
s2:SetHeight(23)
s2:SetFont(GameFontNormal:GetFont(), psfontsset[2])
s2:SetPoint("TOPLEFT",40,-445)
s2:SetJustifyH("LEFT")
s2:SetText("|cff00ff00NEW!|r "..pspetsmergetxt)



end
end

function psroptreset()
psraidoptionsnumers={2,0,4,8,5,7,10,20}
for i=1,3 do
psrbuttablraidopt[i]:SetChecked(false)
end
psrbuttablraidopt[psraidoptionsnumers[1]]:SetChecked()

for i=3,8 do
pssliderstablraidopt[i-2]:SetValue(psraidoptionsnumers[i])
getglobal(pssliderstablraidopt[i-2]:GetName().."Text"):SetText(psraidoptionsnumers[i])
end
end




function psiccinfosvshow(nr1,nr2)
if pssavedinfotextframe1 and nr1 and nr2 then

  --тут нужно: проверить что инфо существует и потом уже отображать его, так как nr1 может значить как ник так и нет данных

  local norm=0
  if #pssisavedfailsplayern[2]==0 or #pssisavedfailaftercombat[nr1][nr2]==0 then
    norm=1
    pssavedinfotextframe1:SetText(pcicccombat4)
  end
  if norm==0 then
  local text=""
    for i=1,#pssisavedfailaftercombat[nr1][nr2] do
      if string.find(pssisavedfailaftercombat[nr1][nr2][i],"{")==1 then
        if string.find(pssisavedfailaftercombat[nr1][nr2][i],"} ") then
          text=text.."- "..string.sub(pssisavedfailaftercombat[nr1][nr2][i],string.find(pssisavedfailaftercombat[nr1][nr2], "} ")+2).."\n\r"
        else
          text=text.."- "..string.sub(pssisavedfailaftercombat[nr1][nr2][i],string.find(pssisavedfailaftercombat[nr1][nr2], "}")+1).."\n\r"
        end
      else
        text=text.."- "..pssisavedfailaftercombat[nr1][nr2][i].."\n\r"
      end
    end
    if string.len(text)>5 then
      --убираем ИД и НПЦ
      text=psrestorelinksforexport2(text,1)
      pssavedinfotextframe1:SetText(text)
    else
      pssavedinfotextframe1:SetText(pcicccombat4)
    end
  end
end
end


function psiccsavedinforeport(nn)
--nn - 1 в чат, 2 в приват

local chattt=chat or pssichatrepdef
if pssichose1==nil then
	pssichose1=1
	if #pssisavedfailsplayern[2]>0 then
	for i=1,#pssisavedfailsplayern[2] do
		if pssisavedfailsplayern[2][i]==UnitGUID("player") then
			pssichose1=i
		end
	end
	end
end
if pssichose2==nil then pssichose2=1 end

if #pssisavedfailaftercombat[pssichose1][pssichose2]>0 then

local txtboss=psiccinfoabsv.." "



local text=""
local _, month, day, year = CalendarGetDate()
if month<10 then month="0"..month end
if day<10 then day="0"..day end
--if year>2000 then year=year-2000 end
local text=month.."/"..day.."/"..year


		local slojn=""
		if pssisavedbossinfo[pssichose1][pssichose2][3] and string.len(pssisavedbossinfo[pssichose1][pssichose2][3])>1 then
			slojn=" ("..pssisavedbossinfo[pssichose1][pssichose2][3]..")"
		end

		if string.find(pssisavedbossinfo[pssichose1][pssichose2][2], text) then
			txtboss=txtboss..pssisavedbossinfo[pssichose1][pssichose2][1]..slojn..", "..string.sub(pssisavedbossinfo[pssichose1][pssichose2][2],1,string.find(pssisavedbossinfo[pssichose1][pssichose2][2],",")-1)
		else
			txtboss=txtboss..pssisavedbossinfo[pssichose1][pssichose2][1]..slojn..", "..pssisavedbossinfo[pssichose1][pssichose2][2]
		end

local tbltorep={}
table.insert(tbltorep, txtboss)
for i=1,#pssisavedfailaftercombat[pssichose1][pssichose2] do
	if pssisavedfailaftercombat[pssichose1][pssichose2][i] then
		local a11=pssisavedfailaftercombat[pssichose1][pssichose2][i]
		a11=psrestorelinksforexport2(a11,2)
		local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372","|cff999999"}
		for km=1,#tablecolor do
			if string.find (a11, tablecolor[km]) then
				local ll=string.find (a11, tablecolor[km])
				while string.find (a11, tablecolor[km]) do
					a11=string.sub(a11,1,string.find (a11, tablecolor[km])-1)..string.sub(a11,string.find (a11, tablecolor[km])+10)
				end
				if string.find (a11, "|r",ll) then
					while string.find (a11, "|r",ll) do
						a11=string.sub(a11,1,string.find (a11, "|r",ll)-1)..string.sub(a11,string.find (a11, "|r",ll)+2)
					end
				end
			end
		end

		table.insert(tbltorep, a11)
	end
end

if nn==1 then
pssendchatmsg(chattt,tbltorep)
end
if nn==2 then
pssendchatmsg("whisper",tbltorep,PSFmainfrainsavedinfo_edbox2:GetText())
end


end
PSFmainfrainsavedinfo_edbox2:ClearFocus()
end


function pssendchatmsg(chat,tbl,nick)

if chat=="sebe" then
for t=1,#tbl do
	if string.len(tbl[t])>0 then
		print (tbl[t])
	end
end


else

local txt1=""
local txt2=""
local txt3=""

for ee=1,#tbl do
	txt1=""
	txt2=""
	txt3=""

	local texttoconvert=tbl[ee]

  if string.len(texttoconvert)<=255 then
    txt1=texttoconvert
  else
    --берем 1 часть строчки и ищем в ней посл пробел либо запятую, но не раньше 120 знаков, иначе текущий вариант
    local ph=string.sub(texttoconvert,1,255)
    local lastfound1=120
    local maxtocheck=256
    --если мы находим разорванный спелл то ищем пробел ДО него
    local n1=0 --начало последнего нашли
    local n2=0 --конец последнего нашли
    local m1=0 --сколько начальных
    local m2=0 --сколько концов
    --ищем начало
    
    if string.find(ph, "|cff71d5ff|Hspell") then
      while string.find(ph, "|cff71d5ff|Hspell",n1) do
        if string.find(ph, "|cff71d5ff|Hspell",n1) then
          n1=string.find(ph, "|cff71d5ff|Hspell",n1)+5
          m1=m1+1
        end
      end
    end
    --ищем конец
    if string.find(ph, "|h|r") then
      while string.find(ph, "|h|r",n2) do
        if string.find(ph, "|h|r",n2) then
          n2=string.find(ph, "|h|r",n2)+2
          m2=m2+1
        end
      end
    end
    if m1>m2 then --начал больше чем концов, спелл разорван, ограничиваем
      maxtocheck=n1-4
    end
    local limitreach=0
    if string.find(ph, " ", lastfound1+1) then
      while (string.find(ph, " ", lastfound1+1) and limitreach==0) do
        if string.find(ph, " ", lastfound1+1)<maxtocheck then
          lastfound1=string.find(ph, " ", lastfound1+1)
        else
          limitreach=1
        end
      end
    end
    if lastfound1>120 then
      --нашли пробел
      txt2=string.sub(texttoconvert,lastfound1+1)
      txt1=string.sub(texttoconvert,1,lastfound1-1)
      --теперь делаем тоже со 2
      if string.len(txt2)>255 then
        local ph=string.sub(txt2,1,255)
        local lastfound1=120
        local maxtocheck=256
        --если мы находим разорванный спелл то ищем пробел ДО него
        local n1=0 --начало последнего нашли
        local n2=0 --конец последнего нашли
        local m1=0 --сколько начальных
        local m2=0 --сколько концов
        --ищем начало
        if string.find(ph, "|cff71d5ff|Hspell") then
          while string.find(ph, "|cff71d5ff|Hspell",n1) do
            if string.find(ph, "|cff71d5ff|Hspell",n1) then
              n1=string.find(ph, "|cff71d5ff|Hspell",n1)+5
              m1=m1+1
            end
          end
        end
        --ищем конец
        if string.find(ph, "|h|r") then
          while string.find(ph, "|h|r",n2) do
            if string.find(ph, "|h|r",n2) then
              n2=string.find(ph, "|h|r",n2)+2
              m2=m2+1
            end
          end
        end
        if m1>m2 then --начал больше чем концов, спелл разорван, ограничиваем
          maxtocheck=n1-4
        end
        local limitreach=0
        if string.find(ph, " ", lastfound1+1) then
          while (string.find(ph, " ", lastfound1+1) and limitreach==0) do
            if string.find(ph, " ", lastfound1+1)<maxtocheck then
              lastfound1=string.find(ph, " ", lastfound1+1)
            else
              limitreach=1
            end
          end
        end
        if lastfound1>120 then
          txt3=string.sub(txt2,lastfound1+1)
          txt2=string.sub(txt2,1,lastfound1-1)
        else
          txt3=string.sub(txt2,255)
          txt2=string.sub(txt2,1,254)
        end
      end
    else
      txt2=string.sub(texttoconvert,255)
      txt1=string.sub(texttoconvert,1,254)
      --если 2 больше все равно
      if string.len(txt2)>255 then
        local ph=string.sub(txt2,1,255)
        local lastfound1=120
        local maxtocheck=256
        --если мы находим разорванный спелл то ищем пробел ДО него
        local n1=0 --начало последнего нашли
        local n2=0 --конец последнего нашли
        local m1=0 --сколько начальных
        local m2=0 --сколько концов
        --ищем начало
        if string.find(ph, "|cff71d5ff|Hspell") then
          while string.find(ph, "|cff71d5ff|Hspell",n1) do
            if string.find(ph, "|cff71d5ff|Hspell",n1) then
              n1=string.find(ph, "|cff71d5ff|Hspell",n1)+5
              m1=m1+1
            end
          end
        end
        --ищем конец
        if string.find(ph, "|h|r") then
          while string.find(ph, "|h|r",n2) do
            if string.find(ph, "|h|r",n2) then
              n2=string.find(ph, "|h|r",n2)+2
              m2=m2+1
            end
          end
        end
        if m1>m2 then --начал больше чем концов, спелл разорван, ограничиваем
          maxtocheck=n1-4
        end
        local limitreach=0
        if string.find(ph, " ", lastfound1+1) then
          while (string.find(ph, " ", lastfound1+1) and limitreach==0) do
            if string.find(ph, " ", lastfound1+1)<maxtocheck then
              lastfound1=string.find(ph, " ", lastfound1+1)
            else
              limitreach=1
            end
          end
        end
        if lastfound1>120 then
          txt3=string.sub(txt2,lastfound1+1)
          txt2=string.sub(txt2,1,lastfound1-1)
        else
          txt3=string.sub(txt2,255)
          txt2=string.sub(txt2,1,254)
        end
      end
    end
  end


if chat=="whisper" then

local bna=GetAutoCompletePresenceID(nick)

if bna then
if string.len(txt1)>0 then
BNSendWhisper(bna, txt1)
end
if string.len(txt2)>0 then
BNSendWhisper(bna, txt2)
end
if string.len(txt3)>0 then
BNSendWhisper(bna, txt3)
end
else
if string.len(txt1)>0 then
SendChatMessage(txt1, "WHISPER", nil, nick)
end
if string.len(txt2)>0 then
SendChatMessage(txt2, "WHISPER", nil, nick)
end
if string.len(txt3)>0 then
SendChatMessage(txt3, "WHISPER", nil, nick)
end
end

else

local bililine=0
for i,cc in ipairs(bigmenuchatlisten) do 
if string.lower(cc) == string.lower(chat) then bililine=1
end end

if chat=="BATTLEGROUND" then
bililine=1
end


	if bililine==1 then

if string.len(txt1)>0 then
SendChatMessage(txt1, chat)
end
if string.len(txt2)>0 then
SendChatMessage(txt2, chat)
end
if string.len(txt3)>0 then
SendChatMessage(txt3, chat)
end


	else

local nrchatmy=GetChannelName(chat)
		if nrchatmy>0 then

if string.len(txt1)>0 then
SendChatMessage(txt1, "CHANNEL",nil,nrchatmy)
end
if string.len(txt2)>0 then
SendChatMessage(txt2, "CHANNEL",nil,nrchatmy)
end
if string.len(txt3)>0 then
SendChatMessage(txt3, "CHANNEL",nil,nrchatmy)
end
		else
			JoinPermanentChannel(chat)
			ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, chat)
		end
	end
end
end
if psanounsesrazuchek==1 then psanonceinst=1 end
end
end


function psiccallrezet()
if psiccrezdelay==nil or (psiccrezdelay and GetTime()>psiccrezdelay+10) then
out("|cff99ffffPhoenixStyle|r - |cffff0000"..psattention.."|r "..psiccrezonemore)
psiccrezdelay=GetTime()
else


--ыытест ката мини рейды
if psmenuchoose1>0 and psmenuchoose1<5 then

table.wipe(psraidoptionsont1[psmenuchoose1])
table.wipe(psraidoptionschatt1[psmenuchoose1])

pscmrpassvariables()


table.wipe(psraidoptionson[psmenuchoose1])
table.wipe(psraidoptionschat[psmenuchoose1])

local i=psmenuchoose1
	if psraidoptionson[i]==nil then psraidoptionson[i]={}
	end
	for j=1,#psraidoptionsont1[i] do
		if psraidoptionson[i][j]==nil then
			psraidoptionson[i][j]={}
		end
		for t=1,#psraidoptionsont1[i][j] do
			if psraidoptionson[i][j][t]==nil then
				psraidoptionson[i][j][t]=psraidoptionsont1[i][j][t]
			end
		end
	end



	if psraidoptionschat[i]==nil then psraidoptionschat[i]={}
	end
	for j=1,#psraidoptionschatt1[i] do
		if psraidoptionschat[i][j]==nil then
			psraidoptionschat[i][j]={}
		end
		for t=1,#psraidoptionschatt1[i][j] do
			if psraidoptionschat[i][j][t]==nil then
				psraidoptionschat[i][j][t]=psraidoptionschatt1[i][j][t]
			end
		end
	end




end

--ыытест firelands
if psmenuchoose1==5 then

--в 5ую табл вставляю 1ую табл с модуля
table.wipe(psraidoptionsont2[1])
table.wipe(psraidoptionschatt2[1])

pscmrpassvariables_2()


table.wipe(psraidoptionson[psmenuchoose1])
table.wipe(psraidoptionschat[psmenuchoose1])

local i=psmenuchoose1
	if psraidoptionson[i]==nil then psraidoptionson[i]={}
	end
	for j=1,#psraidoptionsont2[1] do
		if psraidoptionson[i][j]==nil then
			psraidoptionson[i][j]={}
		end
		for t=1,#psraidoptionsont2[1][j] do
			if psraidoptionson[i][j][t]==nil then
				psraidoptionson[i][j][t]=psraidoptionsont2[1][j][t]
			end
		end
	end


	if psraidoptionschat[i]==nil then psraidoptionschat[i]={}
	end
	for j=1,#psraidoptionschatt2[1] do
		if psraidoptionschat[i][j]==nil then
			psraidoptionschat[i][j]={}
		end
		for t=1,#psraidoptionschatt2[1][j] do
			if psraidoptionschat[i][j][t]==nil then
				psraidoptionschat[i][j][t]=psraidoptionschatt2[1][j][t]
			end
		end
	end


end

--ыытест dragon soul
if psmenuchoose1==6 then

--в 5ую табл вставляю 1ую табл с модуля
table.wipe(psraidoptionsont3[1])
table.wipe(psraidoptionschatt3[1])

pscmrpassvariables_3()


table.wipe(psraidoptionson[psmenuchoose1])
table.wipe(psraidoptionschat[psmenuchoose1])

local i=psmenuchoose1
	if psraidoptionson[i]==nil then psraidoptionson[i]={}
	end
	for j=1,#psraidoptionsont3[1] do
		if psraidoptionson[i][j]==nil then
			psraidoptionson[i][j]={}
		end
		for t=1,#psraidoptionsont3[1][j] do
			if psraidoptionson[i][j][t]==nil then
				psraidoptionson[i][j][t]=psraidoptionsont3[1][j][t]
			end
		end
	end


	if psraidoptionschat[i]==nil then psraidoptionschat[i]={}
	end
	for j=1,#psraidoptionschatt3[1] do
		if psraidoptionschat[i][j]==nil then
			psraidoptionschat[i][j]={}
		end
		for t=1,#psraidoptionschatt3[1][j] do
			if psraidoptionschat[i][j][t]==nil then
				psraidoptionschat[i][j][t]=psraidoptionschatt3[1][j][t]
			end
		end
	end


end

--ыытест другие инсты тут

psupdatemenugo()


out("|cff99ffffPhoenixStyle|r - "..format(psiccrezcompl,pslocationnames[psmenuchoose1]))
out("|cff99ffffPhoenixStyle|r - "..format(psiccrezcompl,pslocationnames[psmenuchoose1]))

end
end


function psiccsavinginf(bosss,try,nrr)

--если вайп перезаписался на килл:
if try==nil and nrr==2 then
local playedpos=0

--проверка меня и с каким работаем

if #pssisavedfailsplayern[2]>0 then
	for i=1,#pssisavedfailsplayern[2] do
		if pssisavedfailsplayern[2][i]==UnitGUID("player") then
			playedpos=i
			pssisavedfailsplayern[1][i]=UnitName("player").." - "..GetRealmName()
		end
	end
end


if pssisavedbossinfo[playedpos] and pssisavedbossinfo[playedpos][1] and pssisavedbossinfo[playedpos][1][4] then
  pssisavedbossinfo[playedpos][1][4]=psicctxtkill
end

pssisavedfailaftercombat[playedpos][1]={}
table.wipe (pssisavedfailaftercombat[playedpos][1])



else
--запись
pscreatesavedreports3(bosss,try)
end --килл после вайпа

local playedpos=0

--проверка меня и с каким работаем

if #pssisavedfailsplayern[2]>0 then
	for i=1,#pssisavedfailsplayern[2] do
		if pssisavedfailsplayern[2][i]==UnitGUID("player") then
			playedpos=i
			pssisavedfailsplayern[1][i]=UnitName("player").." - "..GetRealmName()
		end
	end
end

if try then
pssisavedbossinfo[playedpos][1][4]=psicctxttry
else
pssisavedbossinfo[playedpos][1][4]=psicctxtkill
end


end


function psiccrefsvin()
psupdateframewithnewinfo()
end


function pssvinfoalltog()
if pssisavedfailaftercombat[pssichose1] and #pssisavedfailaftercombat[pssichose1]>0 then
  local txttoshow=""
  local added=0

if pssavedinfocheckexport[4]==1 then
  txttoshow=txttoshow.."[html] <div style=\"background:#070707;border:1px solid #333;padding:15px;\">"
end

txttoshow=txttoshow.."PhoenixStyle - "..pssaveityperep2

local maxcomb=#pssisavedbossinfo[pssichose1]

	local text=""
	local _, month, day, year = CalendarGetDate()
	if month<10 then month="0"..month end
	if day<10 then day="0"..day end
	--if year>2000 then year=year-2000 end
	local text=month.."/"..day.."/"..year
	
  if psicccombatexport==0 then
    txttoshow=txttoshow.." ("..pssavediexportopt6..", "..text.."):\n\n"
    maxcomb=0
    for o=1,#pssisavedbossinfo[pssichose1] do
      if string.find(pssisavedbossinfo[pssichose1][o][2],text) then
        maxcomb=maxcomb+1
      end
    end
  else
    txttoshow=txttoshow..":\n\n"
    if psicccombatexport<maxcomb then
      maxcomb=psicccombatexport
    end
  end
  
if maxcomb>0 then

for i=1,maxcomb do

	local slojn=""
	if pssisavedbossinfo[pssichose1][i][3]~="0" then
		slojn=" ("..pssisavedbossinfo[pssichose1][i][3]..")"
	end

	if i>1 then txttoshow=txttoshow.."\r\n\r\n" end

	txttoshow=txttoshow..psiccinfoabsv.." "
        local a1=""
        local a2=""
        if pssavedinfocheckexport[1]==1 then
          a1="[B][color=orange]"
          a2="[/color][/B]"
        end
	if string.find(pssisavedbossinfo[pssichose1][i][2], text) then
		txttoshow=txttoshow..a1..pssisavedbossinfo[pssichose1][i][1]..a2..slojn..", "..string.sub(pssisavedbossinfo[pssichose1][i][2],1,string.find(pssisavedbossinfo[pssichose1][i][2],",")-1)
	else
		txttoshow=txttoshow..a1..pssisavedbossinfo[pssichose1][i][1]..a2..slojn..", "..pssisavedbossinfo[pssichose1][i][2]
	end
	txttoshow=txttoshow.." "..pssisavedbossinfo[pssichose1][i][4].."\n"
	
	added=1

	local somethingadded=0

	for u=1,#pssisavedfailaftercombat[pssichose1][i] do
		if pssisavedfailaftercombat[pssichose1][i][u] then
			somethingadded=1
			local failt=pssisavedfailaftercombat[pssichose1][i][u]
			if (string.find(failt, "{")==1) then
				if (string.find(failt, "} ")) then
					failt="- "..psrestorelinksforexport(string.sub(failt, string.find(failt, "} ")+2)).."\n"
				else
					failt="- "..psrestorelinksforexport(string.sub(failt, string.find(failt, "}")+1)).."\n"
				end
			else
				failt="- "..psrestorelinksforexport(failt).."\n"
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
      txttoshow=txttoshow..failt
		end
	end

	if somethingadded==0 then
		txttoshow=txttoshow..pcicccombat4.."\n"
	end


end --for i

else
txttoshow=txttoshow..pcicccombat4.."\n"
added=1
end

    if pssavedinfocheckexport[2]==1 then
      --все меняем в цвете --смена ТОЛЬКО красного и зеленого будет по ходу создания текста если эта откл

      local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372","|cff00ff00","|cffff0000","|CFFFFFF00","|cff71d5ff","|cff999999"}
      local tablecolor2={"#C79C6E","#C41F3B","#F58CBA","#FFFFFF","#0070DE","#FF7D0A","#FFF569","#69CCF0","#9482C9","#ABD473","green","red","orange","black","grey"}
      for i=1,#tablecolor do
        txttoshow=string.gsub(txttoshow, tablecolor[i], "[color="..tablecolor2[i].."]")
      end
      txttoshow=string.gsub(txttoshow, "|r", "[/color]")
    else
      --откл, но вырезать цвета нужно
      local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372","|cff00ff00","|cffff0000","|CFFFFFF00","|cff71d5ff","|cff999999"}
      for i=1,#tablecolor do
        txttoshow=string.gsub(txttoshow, tablecolor[i], "")
      end
      txttoshow=string.gsub(txttoshow, "|r", "")
    end
    --если отключены ссылки то нужно удалить всю хрень с ИД и НПЦ
    if pssavedinfocheckexport[3]==0 then
      txttoshow=psrestorelinksforexport2(txttoshow)
    end

if added==1 then
  if pssavedinfocheckexport[4]==1 then
    txttoshow=txttoshow.."</div>[/html]"
  end
  pssavedinfotextframe1:SetText(txttoshow)
else
  pssavedinfotextframe1:SetText(pcicccombat4)
end

PSFmainfrainsavedinfo_Button1:Hide()
PSFmainfrainsavedinfo_Button2:Hide()
pssavedinfotextframe1:SetFocus()
pssavedinfotextframe1:HighlightText()

end
end




function ps_getspelllink(id)
if id then
local msg=""
if GetSpellInfo(id) then
	msg="\124cff71d5ff\124Hspell:"..id.."\124h["..GetSpellInfo(id).."]\124h\124r"
else
	msg="[id:"..id.."]"
end
return msg
end
end


function psspellfilter(msg)
local i=0
while i==0 do
	if string.find(msg,"|sid") then
		local id=tonumber(string.sub(msg,string.find(msg,"|sid")+4,string.find(msg,"|id")-1))
		if GetSpellInfo(id) then
			msg=string.sub(msg,1,string.find(msg,"|sid")-1).."\124cff71d5ff\124Hspell:"..id.."\124h["..GetSpellInfo(id).."]\124h\124r"..string.sub(msg,string.find(msg,"|id")+3)
		else
			msg=string.sub(msg,1,string.find(msg,"|sid")-1).."[id:"..id.."]"..string.sub(msg,string.find(msg,"|id")+3)
		end
	else
		i=1
	end
end


i=0
while i==0 do
	local txt={psoptiontypeofreport1..":",psoptiontypeofreport2..":",psoptiontypeofreport3..":",psoptiontypeofreport4..":"}
	if string.find(msg,"|tip") then
		local id=tonumber(string.sub(msg,string.find(msg,"|tip")+4,string.find(msg,"|tip")+4))
		if id then
			msg=string.sub(msg,1,string.find(msg,"|tip")-1)..txt[id]..string.sub(msg,string.find(msg,"|tip")+5)
		end
	else
		i=1
	end
end

i=0

while i==0 do
	if string.find(msg,"|s4id") then
		local msg2=string.sub(msg,string.find(msg,"|s4id")+5,string.find(msg,"|id")-1)
		local tablid={}
		while string.len(msg2)>1 do
			if string.find(msg2, " ") and string.find(msg2, " ")==1 then
				msg2=string.sub(msg2,2)
			end
			if string.find(msg2,",") then
				local aa1=tonumber(string.sub(msg2,1,string.find(msg2,",")-1))
				table.insert(tablid,aa1)
				msg2=string.sub(msg2,string.find(msg2,",")+1)
			else
				table.insert(tablid,tonumber(msg2))
				msg2=""
			end
		end
		if #tablid==0 then
			table.insert(tablid,9999999)
		end
		if #tablid==1 then
			table.insert(tablid,tablid[1])
		end
		if #tablid<4 then
			table.insert(tablid,tablid[1])
			table.insert(tablid,tablid[2])
		end
		local dif=GetRaidDifficulty()

		if GetSpellInfo(tablid[dif]) then
			msg=string.sub(msg,1,string.find(msg,"|s4id")-1).."\124cff71d5ff\124Hspell:"..tablid[dif].."\124h["..GetSpellInfo(tablid[dif]).."]\124h\124r"..string.sub(msg,string.find(msg,"|id")+3)
		else
			msg=string.sub(msg,1,string.find(msg,"|s4id")-1).."[id:"..tablid[dif].."]"..string.sub(msg,string.find(msg,"|id")+3)
		end
	else
		i=1
	end
end


return msg
end


function psspellfilter2(msg) --для сохранения после боя, вырезаем и оставляем ток нужный ИД
local i=0

if msg then

while i==0 do
	if string.find(msg,"|s4id") then
		local msg2=string.sub(msg,string.find(msg,"|s4id")+5,string.find(msg,"|id")-1)
		local tablid={}
		while string.len(msg2)>1 do
			if string.find(msg2, " ") and string.find(msg2, " ")==1 then
				msg2=string.sub(msg2,2)
			end
			if string.find(msg2,",") then
				local aa1=tonumber(string.sub(msg2,1,string.find(msg2,",")-1))
				table.insert(tablid,aa1)
				msg2=string.sub(msg2,string.find(msg2,",")+1)
			else
				table.insert(tablid,tonumber(msg2))
				msg2=""
			end
		end
		if #tablid==0 then
			table.insert(tablid,9999999)
		end
		if #tablid==1 then
			table.insert(tablid,tablid[1])
		end
		if #tablid<4 then
			table.insert(tablid,tablid[1])
			table.insert(tablid,tablid[2])
		end
		local dif=GetRaidDifficulty()

    msg=string.sub(msg,1,string.find(msg,"|s4id")-1).."|s5id"..tablid[dif].."|od"..string.sub(msg,string.find(msg,"|id")+3)
	else
		i=1
	end
end

	if string.find(msg,"|s5id") then
    while string.find(msg,"|s5id") do
      msg=string.gsub(msg, "|s5id", "|s4id")
    end
  end
	if string.find(msg,"|od") then
    while string.find(msg,"|od") do
      msg=string.gsub(msg, "|od", "|id")
    end
  end


return msg

else
return msg
end
end


function psaddcolortxt(nr,name)
if name then

if nr==2 then
	--if UnitInRaid(name) then
		return "|r"
	--else
	--	return "|r" --для цвет петов тест
	--end
end

if nr==1 then

local numpl=0
if string.len(name)>42 and string.find(name,"%-") then
  name=string.sub(name,1,string.find(name,"%-")-1)
  if name and string.len(name)>42 then
    numpl=10
  end
  for j=1,GetNumRaidMembers() do
    local a1=UnitName("raid"..j)
    if a1 and name==a1 then
      numpl=numpl+1
    end
  end
elseif string.len(name)>42 then
  numpl=10
end

if numpl>1 then
  return "|cff999999"
else


--print ("111111111111")
	if UnitInRaid(name) or UnitInParty(name) then
	--print ("inraid")
		local rsccodeclass=0
		local _, rsctekclass = UnitClass(name)
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
    end
			local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372", "|cff999999"}
			if rsccodeclass==0 then
				return "|cff999999" --для цвет петов
			else
				return tablecolor[rsccodeclass]
			end
		end
	else
		return "|cff999999" --цвет петов
	end
end
end
end
end

function psremovecolor(a)
if a then
local tablecolor={"|CFFC69B6D","|CFFC41F3B","|CFFF48CBA","|CFFFFFFFF","|CFF1a3caa","|CFFFF7C0A","|CFFFFF468","|CFF68CCEF","|CFF9382C9","|CFFAAD372","|cff00ff00","|cffff0000","|CFFFFFF00","|cff999999"}
for km=1,#tablecolor do
	if string.find (a, tablecolor[km]) then
		while string.find (a, tablecolor[km]) do
			a=string.sub(a,1,string.find (a, tablecolor[km])-1)..string.sub(a,string.find (a, tablecolor[km])+10)
		end
	end
end
if string.find(a, "|r") then
	--local beg=1
	--local beg2=1
	while string.find(a, "|r") do
		--if string.find(a, "|h") then
		--	beg2=string.find(a, "|h")
		--end
		--beg=string.find(a, "|r",beg)
		--if beg<beg2+3 then
		--	a=a
		--	beg=beg+2
		--	beg2=beg2+2
		--else
		a=string.sub(a,1,string.find (a, "|r")-1)..string.sub(a,string.find (a, "|r")+2)
		--end
	end
end
return a
end
end


function pscheckslowdebuff(id)
--тру если есть дебафф, false нету
local idofslow={1714,58604,50274,5761,73975,31589}
local bil=0
local debil=0
for i = 1,GetNumRaidMembers() do
	if UnitGUID("raid"..i.."-target") and UnitGUID("raid"..i.."-target")==id and bil==0 then
		bil=1
		for j=1,#idofslow do
			local debname=GetSpellInfo(idofslow[j])
			if UnitDebuff("raid"..i.."-target", debname) then
				debil=1
			end
		end
	end
end
if bil==0 or debil==1 then
	return true
else
	return false
end
end

function psdamageceil(dmg)
if dmg==nil then
	return ""
else
	local he=0

	if (string.len(dmg)) > 6 then
		local maxnumcif=string.len(dmg)-6
		local dopcif=tonumber(string.sub(dmg, maxnumcif+1, maxnumcif+2))
		he=string.sub(dmg, 1, string.len(dmg)-6)
		if dopcif and dopcif>0 then
      if string.len(dopcif)==1 then
        dopcif="0"..dopcif
      end
			he=he.."."..dopcif
		end
		he=he.."M"


	elseif (string.len(dmg)) > 3 then
		he=string.sub(dmg, 1, string.len(dmg)-3)
		he=he.."k"
	else
		he=dmg
	end
	return he
end
end


function psdamageceildeathrep(dmg)
if dmg==nil then
	return ""
else
	local he=0

	if (string.len(dmg)) > 6 then
		local maxnumcif=string.len(dmg)-6
		local dopcif=tonumber(string.sub(dmg, maxnumcif+1, maxnumcif+2))
		he=string.sub(dmg, 1, string.len(dmg)-6)
		if dopcif and dopcif>0 then
      if string.len(dopcif)==1 then
        dopcif="0"..dopcif
      end
			he=he.."."..dopcif
		end
		he=he.."M"


	elseif (string.len(dmg)) > 3 then
    if dmg>=30000 then
      he=string.sub(dmg, 1, string.len(dmg)-3)
      he=he.."k"
    else
      dmg=dmg*10
      he=string.sub(dmg, 1, string.len(dmg)-3)
      he=he/10
      he=he.."k"
    end
	else
		he=dmg
	end
	return he
end
end


function psnoservername(pname)
if pname and string.find(pname,"%-") then
  if string.find(pname," %-") then
    pname=string.sub(pname,1,string.find(pname," %-")-1)
  else
    pname=string.sub(pname,1,string.find(pname,"%-")-1)
  end
  return pname
elseif pname then
  return pname
else
  return "???"
end
end


function psupdateleftbuttonsstyle()

PSFmain2_Button3:SetNormalTexture(1)
PSFmain2_Button3:SetPushedTexture(1)

PSFmain2_Button4:SetNormalTexture(1)
PSFmain2_Button4:SetPushedTexture(1)

PSFmain2_Button5:SetNormalTexture(1)
PSFmain2_Button5:SetPushedTexture(1)

PSFmain2_Button51:SetNormalTexture(1)
PSFmain2_Button51:SetPushedTexture(1)

PSFmain2_Button112:SetNormalTexture(1)
PSFmain2_Button112:SetPushedTexture(1)

PSFmain2_Button52:SetNormalTexture(1)
PSFmain2_Button52:SetPushedTexture(1)

PSFmain2_Button53:SetNormalTexture(1)
PSFmain2_Button53:SetPushedTexture(1)

PSFmain2_Button54:SetNormalTexture(1)
PSFmain2_Button54:SetPushedTexture(1)

PSFmain2_Button7:SetNormalTexture(1)
PSFmain2_Button7:SetPushedTexture(1)

PSFmain2_Button71:SetNormalTexture(1)
PSFmain2_Button71:SetPushedTexture(1)

PSFmain2_ButtonRA1:SetNormalTexture(1)
PSFmain2_ButtonRA1:SetPushedTexture(1)

PSFmain2_ButtonRA2:SetNormalTexture(1)
PSFmain2_ButtonRA2:SetPushedTexture(1)

PSFmain2_ButtonRA3:SetNormalTexture(1)
PSFmain2_ButtonRA3:SetPushedTexture(1)

PSFmain2_ButtonRA:SetNormalTexture(1)
PSFmain2_ButtonRA:SetPushedTexture(1)

end


function psgetpetownerguid(arg4,name) --for summoning, may be pet was summoned by pet (for totems)
local bil="0"
local bil2="0"
if #pspetstableok[1]>0 then
  for i=1,#pspetstableok[1] do
    if pspetstableok[1][i]==arg4 then --тот кто вызывал сам пет
      bil=pspetstableok[2][i]
      bil2=pspetstableok[4][i]
    end
  end
  if bil~="0" then
    for i=1,#pspetstableok[1] do
      if pspetstableok[1][i]==bil then --тот кто вызывал перед этим сам пет
        bil=pspetstableok[2][i]
        bil2=pspetstableok[4][i]
      end
    end
  end
end

if bil=="0" then
  return arg4,name
else
  return bil,bil2
end
end

function psgetpetownername(guid, name, flag) --for damage, if pet return player name or pet name
if psmergepets==1 and flag and (bit.band(flag, COMBATLOG_OBJECT_TYPE_PET) > 0 or bit.band(flag, COMBATLOG_OBJECT_TYPE_GUARDIAN)>0) then
  local bil="0"
  if #pspetstableok[1]>0 then
    local i=1
    while i<=#pspetstableok[1] do
      if pspetstableok[1][i]==guid then --это был пет и мы нашли хозяина - ЕГО ИМЯ
        bil=pspetstableok[4][i]
        i=10000
      end
      i=i+1
    end
  end
  if bil=="0" then
    return name
  else
    return bil
  end
else
  return name
end
end

function psgetpetownername2(guid, name, flag) --for damage, pet with owner TOGETHER
if psmergepets==1 and flag and (bit.band(flag, COMBATLOG_OBJECT_TYPE_PET) > 0 or bit.band(flag, COMBATLOG_OBJECT_TYPE_GUARDIAN)>0) then
  local bil="0"
  if #pspetstableok[1]>0 then
    local i=1
    while i<=#pspetstableok[1] do
      if pspetstableok[1][i]==guid then --это был пет и мы нашли хозяина - ЕГО ИМЯ
        bil=name.." <"..pspetstableok[4][i]..">"
        i=10000
      end
      i=i+1
    end
  end
  if bil=="0" then
    return name
  else
    return bil
  end
else
  return name
end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function psfchatsendreports(chat, nnn1, nnn2, nnn3, nnn4, nnn5, nnn6, nnn7, nnn8, nnn9, nnn10,nnn11,nnn12, whisp)
if nnn1==nil then nnn1=" " end
if nnn2==nil then nnn2=" " end
if nnn3==nil then nnn3=" " end
if nnn4==nil then nnn4=" " end
if nnn5==nil then nnn5=" " end
if nnn6==nil then nnn6=" " end
if nnn7==nil then nnn7=" " end
if nnn8==nil then nnn8=" " end
if nnn9==nil then nnn9=" " end
if nnn10==nil then nnn10=" " end
if nnn11==nil then nnn11=" " end
if nnn12==nil then nnn12=" " end
local nnn={nnn1,nnn2,nnn3,nnn4,nnn5,nnn6,nnn7,nnn8,nnn9,nnn10,nnn11,nnn12}
for i=1,12 do
if string.len(nnn[i])>3 then

if chat=="sebe" then
DEFAULT_CHAT_FRAME:AddMessage(nnn[i])
elseif chat=="whisper" then

SendChatMessage(nnn[i], "WHISPER", nil, whisp)

else
local bililine=0
for i,cc in ipairs(bigmenuchatlisten) do 
if cc == chat then bililine=1
end end


	if bililine==1 then

		SendChatMessage(nnn[i], chat)
	else


local nrchatmy=GetChannelName(chat)
		if nrchatmy==0 then
	JoinPermanentChannel(chat)
	ChatFrame_AddChannel(DEFAULT_CHAT_FRAME, chat)
	nrchatmy=GetChannelName(chat)
		end
if nrchatmy>0 then
SendChatMessage(nnn[i], "CHANNEL",nil,nrchatmy)
end

	end
end


end
end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------



local psfiltercolorsinchat = CreateFrame("FRAME", "psfiltercolorsinchat_Frame");


psfiltercolorsinchat_Frame:RegisterEvent("ADDON_LOADED")
psfiltercolorsinchat_Frame:SetScript("OnEvent", function(frame, evt, addon)

--main filtering function
local psfilter = function(_,event,msg,player,...)
local chanid, found, modify = select(5, ...), 0, nil
if psdeathrepsavemain[17] and psdeathrepsavemain[17]==1 then
	if string.find(msg, "PS "..psdieddeathrep..":") then
    local colorchoosed="|cffff0000"
    if psdeathrepsavemain[18]==1 then
      colorchoosed="|cff00ff00"
    end
    msg, found = string.gsub(msg, "PS "..psdieddeathrep..":", colorchoosed.."PS "..psdieddeathrep..":|r")
    --смена цвета для игрока
    local r1,r2=string.find(msg,colorchoosed.."PS "..psdieddeathrep..":|r")
    if string.find(msg," >") then
      local r3=string.find(msg," >")
      local addto=2
      local metka=""
      if string.find(msg,"{rt") then
        local par=string.find(msg,"{rt")
        if par and par<r3+5 then
          addto=7
          metka=string.sub(msg,par,par+4)
        end
      end
      local name=string.sub(msg,r2+addto,r3-1)
      msg=string.sub(msg,1,r2+1)..metka..psaddcolortxt(1,name)..name..psaddcolortxt(2,name)..string.sub(msg,r3)
    end
    if string.find(msg," %[") then
      local a=string.find(msg," %[")
      if string.find(msg,"%]",a) then
        local b=string.find(msg,"%]",a)
        msg=string.sub(msg,1,a+1)..colorchoosed..string.sub(msg,a+2,b-1).."|r"..string.sub(msg,b)
        if string.find(msg," %[") then
          a=string.find(msg," %[")
          if string.find(msg,"%]",a) then
            b=string.find(msg,"%]",a)
            if string.find(msg," %[",b) then
              a=string.find(msg," %[",b)
              if string.find(msg,"%]",a) then
                b=string.find(msg,"%]",a)
                msg=string.sub(msg,1,a+1)..colorchoosed..string.sub(msg,a+2,b-1).."|r"..string.sub(msg,b)
              end
            end
          end
        end
      end
    end
    if string.find(msg,psdrcrit) then
      msg, found = string.gsub(msg, psdrcrit, colorchoosed..psdrcrit.."|r")
    end
    if found > 0 then modify = true end
  end
	--if string.find(msg, "тест") then
  --  msg, found = string.gsub(msg, "тест", colorchoosed.."ТЕСТ|r")
  -- if found > 0 then modify = true end
  --end
end
  if modify then
    return false, msg, player, ...
	end
end


	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", psfilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", psfilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", psfilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", psfilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", psfilter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", psfilter)

	frame:SetScript("OnEvent", nil)
	frame:UnregisterEvent("ADDON_LOADED")
end)