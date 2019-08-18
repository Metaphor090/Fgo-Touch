require "TSLib"--使用本函数库必须在脚本开头引用并将文件放到设备 lua 目录下
require("Tools")
TsUi = {}
VersionType = "小精灵安卓" --触动精灵IOS  小精灵安卓 小精灵IOS
DefDir = "小精灵IOS"
os_type = getOSType();
if os_type == "android" then
	VersionType = "触动精灵安卓"
	orient = 0
else
	VersionType = "触动精灵IOS"
	orient = 1
end
if VersionType == "触动精灵安卓" then
	DefDir = "sdcard/TouchSprite/res/"
end
if VersionType == "触动精灵IOS" then
	DefDir = "/var/mobile/Media/TouchSprite/res/"
end
if VersionType == "小精灵安卓" then
	DefDir = "sdcard/darkyafgo/res/"
end
if VersionType == "小精灵IOS" then
	DefDir = "/var/mobile/Media/darkyafgo/res/"
end

function TsUi.GetUI()
	w,h = getScreenSize()
	if w > h then
		tx = w
		ty = h
	else
		tx = h
		ty = w
	end
	--主UI面板设置h*0.9 w*0.9
	--local myui=UI:new(DevScreen,{align="left",w=90,h=90,size=40,cancelname="取消",okname="OK",countdown=999,config="配置切换.dat",bg="bg.jpg"})--在page中传入的size会成为所有page中所有控件的默认字体大小,同时也会成为所有page控件的最小行距
	local Myui = UINew(1,'配置切换','进入详细设置','退出','uiconfig.dat',orient,999,tx*0.9,ty*0.9,'255,255,255','255,255,255',DefDir..'bg.jpg','dot',1);
	
	UILabel({text="当前已适配三服的最新活动~",color="65,105,225"});
	UILabel({text="日服：四期泳装",color="65,105,225"});
	UILabel({text="国服：夏日大逃脱",color="65,105,225"});
	UILabel({text="台服：赝作。",color="65,105,225"});
	

	
	--mypage1:addLabel({text="国服：帝都圣杯奇谭",color="65,105,225",size=30})

	UILabel(1,"当前选用的设置：")
	UICombo({num=1,id="MultConfig",list="配置一,配置二,配置三,配置四,配置五"})
	UIRet = UIShow();--如果需要自己处理，参数填 0，点取消返回值为 0，确定返回 1
	--dialog('选择的配置是:'..MultConfig)
	if UIRet == 0 then
		dialog("谢谢使用，有问题请联系作者!", 0);
		lua_exit();
	end
	
	
	--第二个面板
	local MainUi = UINew(3,'基本说明,基本设置,技能设置','开始Jio本','退出',MultConfig,orient,999,tx*0.9,ty*0.9,'255,255,255','255,255,255',DefDir..'bg.jpg','dot',1);
	--UIImage(1,DefDir.."FgoCover.jpg");
	
	UILabel(1,"第一点：使用时要确保HOME键在屏幕右侧 悬浮窗位置拉到右下角")
	UIImage(1,DefDir.."Introduction1.JPG");
	UIImage(1,DefDir.."Introduction1-2.jpg.JPG");
	UILabel(1,"第二点：使用时要关闭再临显示");
	UIImage(1,DefDir.."Introduction2.JPG");
	UILabel(1,"第三点：战斗界面设置 关闭技能确认 运行速度为两倍速");
	UIImage(1,DefDir.."Introduction3-1.JPG");
	UIImage(1,DefDir.."Introduction3-2.JPG");
	UILabel(1,"第四点：刷图时，把要刷的图放置到第一个位置");
	UIImage(1,DefDir.."Introduction4.JPG");
	
	--第三个面板
	--[[
	resolution,OS_type,Jailbroken,DPI = Tools.GetDeviceInfo()
	UILabel(3,"分辨率："..resolution);
	UILabel(3,"操作系统类别：");
	UILabel(3,"DPI：");
	UILabel(3,"IPhoneX用户设置下面的四个参数为：274,274,0,63");
	UILabel(3,"是否开启自定义分辨率规划");
	UICombo({num=3,id="分辨率规划",list="否,是"});
	UIEdit({num=3,id="分辨率左",prompt="左",width=400,nowrap=1});
	UIEdit({num=3,id="分辨率右",prompt="右",width=400});
	UIEdit({num=3,id="分辨率上",prompt="上",width=400,nowrap=1});
	UIEdit({num=3,id="分辨率下",prompt="下",width=400});
	--]]
	--第四个面板
	--设置建议
	--UIImage(2,DefDir.."Setting0.png");
	--根据后续设置给出建议
	UILabel(2,"启动换人制服一定要查看自己是否装备了换人制服，不然脚本运行会出错",15,"left","255,0,0",-1,0);
	
	--UILabel(2,"启动换人制服一定要查看自己是否装备了换人制服，不然脚本运行会出错");
	--UIImage(2,DefDir.."Setting1.jpg");
	UILabel(2,"区服选择",15,"left","205,92,92",-1,0);
	--区服选择 目前支持日服 或者 国服
	UICombo(2,"区服选择","国服,日服,台服","0","-1");
	--主要功能选择 1.刷free 2.喂狗粮 3.喂礼装
	UILabel(2,"功能选择",15,"left","205,92,92",-1,0);
	UICombo(2,"功能选择","自动刷故事(特异点里启动),刷剧情(free功能+跳过剧情),刷free(free本拉到第一个位置),夏日大逃脱Free,喂狗粮(喂狗粮界面启动),喂礼装,灵基贩卖(贩卖界面),一键智能Free,无限池点击,百重塔,友情池召唤","2","-1");
	--次数设置 99
	UILabel(2,"填写要执行的次数（1-999）",15,"left","205,92,92",-1,0);
	UIEdit({num=2,id="次数设置",prompt="填写要执行的次数（1-999）",text="1",color="65,105,225"});
	--free刷取方式
	UILabel(2,"Free本刷取方式",15,"left","205,92,92",-1,0);
	UICombo(2,"刷取方式","固定刷一个Free本,下拉式刷Free本","0","-1");
	--AP补充选择
	UILabel(2,"AP补充选择",15,"left","205,92,92",-1,0);
	UICombo(2,"AP补充选择","圣晶石,黄金果实,白银果实,青铜果实,自然回体","1","-1");
	
	--是否在all职阶选人
	UILabel(2,"是否在ALL职介选人",15,"left","205,92,92",-1,0);
	UICombo(2,"ALL选人","否,是","0","-1");

	--助战选择
	UILabel(2,"助战选择",15,"left","205,92,92",-1,0);
	UICombo({num=2,id="助战选择",list="呆毛王,小莫,大王,闪闪,水呆毛,孔明,梅林,杀斯卡哈,杰克,枪斯卡哈,迦尔纳,拉二,船长,奶光,黑狗,黑贞,贞德lily,弓凛,黑骑呆,狂长江,艳后,水尼禄,R小莫,妖僧,狂金时,小恩,C狐,北斋,BX毛,武藏,冲田总司,花嫁尼禄,阿周那,特斯拉,弓凛,白枪呆,枪凛,山中老人,酒吞,BB,天草,伯爵,阿比,术尼托,枪狐,术师匠,枪奶光",color="65,105,225"});
	--助战礼装选择
	UILabel(2,"助战礼装选择",15,"left","205,92,92",-1,0);
	UICombo({num=2,id="助战礼装选择",list="迦勒底午餐时光,圣夜晚餐,万华镜,达芬奇,宇宙棱镜,二零三零,天堂之孔,虚数魔术,黑杯,社交界之花,春风游步道,第六天魔王,日轮之城,壬生狼,铃铛,蜡烛,雪宝宝,喜羊羊,海滨奢华,白色航游,砂糖假期,小小夏日,迦勒底沙滩排球,Kingjokerjack,盛夏一刻,潜入湛蓝,死之艺术,毒蛇一艺,柔软的慈爱,迦勒底的学者",color="65,105,225"});
	--助战礼装是否满破
	UILabel(2,"是否选择满破礼装",15,"left","205,92,92",-1,0);
	UICombo(2,"满破礼装","否,是","0","-1");
	
	--助战方式设置
	UILabel(2,"助战方式设置",15,"left","205,92,92",-1,0);
	UICombo(2,"助战方式设置","随意选一个,只选英灵,只选礼装,英灵和礼装都要选","0","-1");

	--助战刷新超限
	UILabel(2,"助战刷新失败选择",15,"left","205,92,92",-1,0);
	UICombo(2,"助战刷新次数","一次失败,二次失败,三次失败","0","-1")
	UICombo(2,"助战刷新方式设置","随意选一个,只选英灵,只选礼装","0","-1")
	
	--换人礼装标识
	UILabel(2,"是否穿戴换人制服",15,"left","205,92,92",-1,0);
	UICombo(2,"换人礼装标识","是,否","1","-1");

	--换人礼装设置
	UILabel(2,"从第几个开始换第几个",15,"left","205,92,92",-1,0);
	UICombo(2,"换人一","前线左,前线中,前线右","0","-1");
	UICombo(2,"换人二","替补左,替补中,替补右","0","-1");
	
	--活动物品选择

	UILabel(2,"活动物品选择",15,"left","205,92,92",-1,0);
	UICombo(2,"活动物品选择","上,中,下,不选","3","-1");

	
	--宝具判断
	UILabel(2,"多少敌方数量不释放宝具（最终面无效）",15,"left","205,92,92",-1,0);
	UICombo(2,"宝具判断","不判断,一个敌人,两个敌人","0","-1");

	--卡色策略
	UILabel(2,"出牌卡色偏重",15,"left","205,92,92",-1,0);
	UICombo(2,"出牌策略选择一","红卡,蓝卡,绿卡","0","-1")
	--===============
	--出牌方式
	UILabel(2,"出牌方式",15,"left","205,92,92",-1,0);
	UICombo(2,"出牌方式","首卡染色,三色卡,克制出卡,助战出卡","2","-1");
	
	--脚本延时 用于各种不同速度的设备
	
	UILabel(2,"战后申请好友",15,"left","205,92,92",-1,0);
	UICombo(2,"战后申请好友","否,是","0","-1");

	--技能设置
	--UIImage(3,DefDir.."Setting2.jpg");
	--预警技能释放
	UILabel(3,"预警技能释放（被集火的怪物如果气满，则优先释放以下技能）",15,"left","205,92,92",-1,0);
	UICheck(3,"PreLeft1,PreLeft2,PreLeft3,PreMid1,PreMid2,PreMid3,PreRight1,PreRight2,PreRight3,PreMaster1,PreMaster2,PreMaster3","①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3","10",-1,0,"",1,3);
	--mypage4:addCheckBoxGroup({id="预警技能",list="①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3",w=70,h=20,size=20,color="65,105,225"})

	--技能设置
	--第一面
	UILabel(3,"第一面技能设置",20,"left","255,0,0",-1,0);
	UILabel(3,"优先集火选择",15,"left","205,92,92",-1,0);
	UICombo({num=3,id="优先集火选择一",list="敌人左,敌人中,敌人右",color="65,105,225"});
	UILabel(3,"角色定位（顺序摆放左-中-右）",15,"left","205,92,92",-1,0);
	UILabel(3,"主攻手：辅助技能都会丢给他——副攻手：技能宝具自嗨——辅助手：辅助技能都丢给主攻手",10,"left","205,92,92",-1,0);
	UICombo(3,"左角色定位一","主攻手,副攻手,辅助手","1","-1")
	UICombo(3,"中角色定位一","主攻手,副攻手,辅助手","1","-1")
	UICombo(3,"右角色定位一","主攻手,副攻手,辅助手","1","-1")

	UICheck(3,"SKOneLeft1,SKOneLeft2,SKOneLeft3,SKOneMid1,SKOneMid2,SKOneMid3,SKOneRight1,SKOneRight2,SKOneRight3,SKOneMaster1,SKOneMaster2,SKOneMaster3,SKOneBaoJu1,SKOneBaoJu2,SKOneBaoJu3","①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3,13宝具左,14宝具中,15宝具右","0@3@6@12@13@14",-1,0,"",1,3);
	--mypage4:addCheckBoxGroup({id="技能设置一",list="①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3,13宝具左,14宝具中,15宝具右",w=70,h=30,size=20,color="65,105,225"})
	UILabel(3,"自定义技能释放顺序(技能顺序格式示例：3a-4b-5a-rb-6a-8b-ca-9a-va-15a-13a-14a 宝具顺序请放到最后)",15,"left","205,92,92",-1,0);
	UILabel(3,"a表示技能好了就放|b表示主攻手np满才放",15,"left","205,92,92",-1,0);
	UIEdit({num=3,id="自定义技能一",prompt="技能顺序格式示例：3a-4b-5b-ra-6a-8b-ca-9b-va",size=20,color="65,105,225"})
	
	
	--第二面
	UILabel(3,"第二面技能设置",20,"left","255,0,0",-1,0);
	UILabel(3,"优先集火选择",15,"left","205,92,92",-1,0);
	UICombo({num=3,id="优先集火选择二",list="敌人左,敌人中,敌人右",color="65,105,225"});
	UILabel(3,"角色定位（顺序摆放左-中-右）",15,"left","205,92,92",-1,0);
	UICombo(3,"左角色定位二","主攻手,副攻手,辅助手","1","-1")
	UICombo(3,"中角色定位二","主攻手,副攻手,辅助手","1","-1")
	UICombo(3,"右角色定位二","主攻手,副攻手,辅助手","1","-1")
	UICheck(3,"SKTwoLeft1,SKTwoLeft2,SKTwoLeft3,SKTwoMid1,SKTwoMid2,SKTwoMid3,SKTwoRight1,SKTwoRight2,SKTwoRight3,SKTwoMaster1,SKTwoMaster2,SKTwoMaster3,SKTwoBaoJu1,SKTwoBaoJu2,SKTwoBaoJu3","①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3,13宝具左,14宝具中,15宝具右","0@3@6@12@13@14",-1,0,"",1,3);
	--mypage4:addCheckBoxGroup({id="技能设置一",list="①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3,13宝具左,14宝具中,15宝具右",w=70,h=30,size=20,color="65,105,225"})
	UILabel(3,"自定义技能释放顺序(技能顺序格式示例：3a-4b-5a-rb-6a-8b-ca-9a-va-15a-13a-14a 宝具顺序请放到最后)",15,"left","205,92,92",-1,0);
	UIEdit({num=3,id="自定义技能二",prompt="技能顺序格式示例：3a-4b-5b-ra-6a-8b-ca-9b-va",size=20,color="65,105,225"})
	


	
	--第三面
	UILabel(3,"第三面技能设置",20,"left","255,0,0",-1,0);
	UILabel(3,"优先集火选择",15,"left","205,92,92",-1,0);
	UICombo({num=3,id="优先集火选择三",list="敌人左,敌人中,敌人右",color="65,105,225"});
	UILabel(3,"角色定位（顺序摆放左-中-右）",15,"left","205,92,92",-1,0);
	UICombo(3,"左角色定位三","主攻手,副攻手,辅助手","1","-1")
	UICombo(3,"中角色定位三","主攻手,副攻手,辅助手","1","-1")
	UICombo(3,"右角色定位三","主攻手,副攻手,辅助手","1","-1")
	
	UICheck(3,"SKThreeLeft1,SKThreeLeft2,SKThreeLeft3,SKThreeMid1,SKThreeMid2,SKThreeMid3,SKThreeRight1,SKThreeRight2,SKThreeRight3,SKThreeMaster1,SKThreeMaster2,SKThreeMaster3,SKThreeBaoJu1,SKThreeBaoJu2,SKThreeBaoJu3","①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3,13宝具左,14宝具中,15宝具右","0@3@6@12@13@14",-1,0,"",1,3);
	UILabel(3,"自定义技能释放顺序(技能顺序格式示例：3a-4b-5a-rb-6a-8b-ca-9a-va-15a-13a-14a 宝具顺序请放到最后)",15,"left","205,92,92",-1,0);
	UIEdit({num=3,id="自定义技能三",prompt="技能顺序格式示例：3a-4b-5b-ra-6a-8b-ca-9b-va",size=20,color="65,105,225"})
	
	--PreLeft1,PreLeft2,PreLeft3
	UIRet = UIShow();--如果需要自己处理，参数填 0，点取消返回值为 0，确定返回 1
	if UIRet == 0 then
		dialog('谢谢使用，有问题请联系作者！', 0);
		lua_exit();
	else
		--把ui数据提出来
		--=============================UI参数定义==============================
		--dialog("多选框结果:".."\ncheck1="..tostring(PreLeft1).."\ncheck2="..tostring(PreLeft2).."\ncheck3="..tostring(PreLeft3), 0)	
	
		--自定义分辨率功能
		ResolutionIOGlo = 分辨率规划
		LeftGlo = tonumber(分辨率左)
		RightGlo = tonumber(分辨率右)
		TopGlo = tonumber(分辨率上)
		BottomGlo = tonumber(分辨率下)
		main_func_glo = 功能选择 --0 刷free 1 喂狗粮 2 喂礼装
		ServerTypeGlo = 区服选择--区服选择
		edit1_glo = tonumber(次数设置)--刷取次数edit1
		FreeTypeFuncGlo = 刷取方式
		AP_recharge_func_glo = AP补充选择 --0 圣晶石 1黄金苹果 2白银 3青铜
		HelperAllGlo = ALL选人
		Helper_func_glo = 助战选择 --0 --呆毛王 小莫 大王 闪闪 水呆毛  孔明 梅林 艳后 杰克 白枪呆 纳尔逊 拉二 船长 奶光 黑狗 黑贞
		Helper_gift_func_glo = 助战礼装选择 --迦勒底午餐时光 圣夜晚餐
		Helper_mode_func_glo = 助战方式设置  --助战方式 随便选一个 只选英灵 只选礼装 两者都要
		if 助战刷新次数 == "一次失败" then
			MaxHelperTimerGlo = 1
		elseif 助战刷新次数 == "二次失败" then
			MaxHelperTimerGlo = 2
		elseif 助战刷新次数 == "三次失败" then
			MaxHelperTimerGlo = 3
		end
		MaxHelperFuncGlo = 助战刷新方式设置  --随意选一个,只选英灵,只选礼装 
		GiftMaxLvGlo = 满破礼装
		Master_switch_func_glo = 换人礼装标识 --换人开关 是 否
		
		if 换人一 == "前线左"  then
			Master_switch_start_glo = 1
			
		elseif 换人一 == "前线中" then
			Master_switch_start_glo = 2
		elseif 换人一 == "前线右" then
			Master_switch_start_glo = 3
		end
	
		if 换人二 == "替补左"  then
			Master_switch_end_glo = 4
			
		elseif 换人二 == "替补中" then
			Master_switch_end_glo = 5
		elseif 换人二 == "替补右" then
			Master_switch_end_glo = 6
		end
		
		AddFriendsGlo = 战后申请好友--战后申请好友
		Stella_switch_func_glo = "否"--大英雄换人开关 radiogroup513
		Stella_site_func_glo = 2 --大英雄位置
		ActivityItemGlo = 活动物品选择--活动物品选择
		--Baoju_do_func_glo = tonumber(宝具判断) --0 - 小于1个 1-小于2个
		if 宝具判断 == "不判断" then
			Baoju_do_func_glo = 0
		elseif 宝具判断 == "一个敌人" then
			Baoju_do_func_glo = 1
		elseif 宝具判断 == "两个敌人" then
			Baoju_do_func_glo = 2
		end
		Card_color_func_glo = 出牌策略选择一 --红卡 蓝卡 绿卡偏重
		Card_color_func_glo2 = 出牌策略选择一
		Card_color_func_glo3 = 出牌策略选择一
		Card_type_func_glo = 出牌方式 -- '首卡染色', '三色卡','克制出卡','助战出卡','一人出一卡'
		level = 0
		--PreLeft1,PreLeft2,PreLeft3,PreMid1,PreMid2,PreMid3,PreRight1,PreRight2,PreRight3,PreMaster1,PreMaster2,PreMaster3
		
		PreSkillTable = {PreLeft1,PreLeft2,PreLeft3,PreMid1,PreMid2,PreMid3,PreRight1,PreRight2,PreRight3,PreMaster1,PreMaster2,PreMaster3}
		TempSkillIndex = Tools.CheckBoxToIndex(PreSkillTable)
		preGroup_func_glo = TempSkillIndex--预警参数获取
		
		--第一面
	
		if 优先集火选择一 == "敌人左"  then
			fire_in_func_1_glo = 1
			
		elseif 优先集火选择一 == "敌人中" then
			fire_in_func_1_glo = 2
		elseif 优先集火选择一 == "敌人右" then
			fire_in_func_1_glo = 3
		end
	
		--改为三个获取变量
		LeftLocation1_glo = 左角色定位一
		MidLocation1_glo = 中角色定位一
		RightLocation1_glo = 右角色定位一
		
		Skill_req1_glo = 释放技能调整一--技能释放要求
		PreSkillTable = {SKOneLeft1,SKOneLeft2,SKOneLeft3,SKOneMid1,SKOneMid2,SKOneMid3,SKOneRight1,SKOneRight2,SKOneRight3,SKOneMaster1,SKOneMaster2,SKOneMaster3,SKOneBaoJu1,SKOneBaoJu2,SKOneBaoJu3}
		TempSkillIndex = Tools.CheckBoxToIndex(PreSkillTable)
		Skill_op1_func_glo = TempSkillIndex 
		Custom1_Skill_edit_glo = 自定义技能一

		--第二面
		if 优先集火选择二 == "敌人左"  then
			fire_in_func_2_glo = 1
			
		elseif 优先集火选择二 == "敌人中" then
			fire_in_func_2_glo = 2
		elseif 优先集火选择二 == "敌人右" then
			fire_in_func_2_glo = 3
		end
		--buff_func_2_glo = tonumber(UIret.角色定位二)+1 --左 中 右
		--改为三个获取变量
		LeftLocation2_glo = 左角色定位二
		MidLocation2_glo = 中角色定位二
		RightLocation2_glo = 右角色定位二
		
		Skill_req2_glo = 释放技能调整二
		PreSkillTable = {SKTwoLeft1,SKTwoLeft2,SKTwoLeft3,SKTwoMid1,SKTwoMid2,SKTwoMid3,SKTwoRight1,SKTwoRight2,SKTwoRight3,SKTwoMaster1,SKTwoMaster2,SKTwoMaster3,SKTwoBaoJu1,SKTwoBaoJu2,SKTwoBaoJu3}
		TempSkillIndex = Tools.CheckBoxToIndex(PreSkillTable)
		Skill_op2_func_glo = TempSkillIndex
		Custom2_Skill_edit_glo = 自定义技能二
		--第三面
		
		if 优先集火选择三 == "敌人左"  then
			fire_in_func_3_glo = 1
			
		elseif 优先集火选择三 == "敌人中" then
			fire_in_func_3_glo = 2
		elseif 优先集火选择三 == "敌人右" then
			fire_in_func_3_glo = 3
		end
	
		LeftLocation3_glo = 左角色定位三
		MidLocation3_glo = 中角色定位三
		RightLocation3_glo = 右角色定位三
		Skill_req3_glo = 释放技能调整三
		PreSkillTable = {SKThreeLeft1,SKThreeLeft2,SKThreeLeft3,SKThreeMid1,SKThreeMid2,SKThreeMid3,SKThreeRight1,SKThreeRight2,SKThreeRight3,SKThreeMaster1,SKThreeMaster2,SKThreeMaster3,SKThreeBaoJu1,SKThreeBaoJu2,SKThreeBaoJu3}
		TempSkillIndex = Tools.CheckBoxToIndex(PreSkillTable)
		Skill_op3_func_glo = TempSkillIndex
		Custom3_Skill_edit_glo = 自定义技能三
		
	end
	
	
end


