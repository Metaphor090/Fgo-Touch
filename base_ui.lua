require("Z_ui")
require("base")
function GetUI()
	DevScreen={--开发设备的参数
		Width=1280,--注意Width要大于Height,开发机分辨率是啥就填啥
		Height=720 --注意Width要大于Height,开发机分辨率是啥就填啥
	}
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	--所有UI控件使用方法请左转'Z_ui.lua'查看!
	MultConfigTxt = '配置一.dat'
	
	--这里获取用户指定的配置文件套路
	if PixConfigGlo == 0 then
		MultConfigTxt = '配置一.dat'
	
	end
	
	if PixConfigGlo == 1 then
		MultConfigTxt = '配置二.dat'
	end
	
	if PixConfigGlo == 2 then
		MultConfigTxt = '配置三.dat'
	end
	
	if PixConfigGlo == 3 then
		MultConfigTxt = '配置四.dat'
	end
	
	if PixConfigGlo == 4 then
		MultConfigTxt = '配置五.dat'
	end
	

	
	--主UI面板设置
	local myui=UI:new(DevScreen,{align="left",w=90,h=90,size=40,cancelname="取消",okname="OK",countdown=999,config=MultConfigTxt,bg="bg.jpg"})--在page中传入的size会成为所有page中所有控件的默认字体大小,同时也会成为所有page控件的最小行距
	nLog('当前的配置文件是：'..MultConfigTxt)
	--页面设置 ,size=20    ,xpos=0 横坐标间距
	local mypage1=Page:new(myui,{text="封面"})--在page中传入的size会成为page中所有控件的默认字体大小,同时也会成为page控件的最小行距(覆盖UI中的size设置)
	local mypage2=Page:new(myui,{text="基本说明",size=30})
	local mypage3=Page:new(myui,{text="系统信息",size=30})
	local mypage4=Page:new(myui,{text="详细设置",size=30})
	
	
	
	--mypage1:addQQ({text="496220561"})
	mypage1:addImage({src="FgoCover.jpg",w=90,h=100,xpos=0,ypos=5}) --,w=17,h=31
	--mypage1:addLabel({text="132314123哈哈哈",size=40,bg="255,0,0"})
	--mypage1:addLabel({text="测试UI为横屏模板,预览时请注意屏幕方向",size=20,bg="0,255,0"})
	mypage1:nextLine()
	
	
	
	mypage2:addUrl({text="详细教程点我跳转到浏览器打开",url="shimo.im/docs/GYAGWd7MOyQunUpc/"})
	mypage2:nextLine()
	mypage2:addLabel({text="第一点：使用时要确保HOME键在屏幕右侧 悬浮窗位置拉到右下角"})
	mypage2:nextLine()
	mypage2:addImage({src="Introduction1.JPG",w=90,h=90,xpos=0}) --,w=17,h=31
	mypage2:nextLine()
	mypage2:addImage({src="Introduction1-2.jpg",w=90,h=90,xpos=0}) --,w=17,h=31
	mypage2:nextLine()
	mypage2:addLabel({text="第二点：使用时要关闭再临显示"})
	mypage2:nextLine()
	mypage2:addImage({src="Introduction2.JPG",w=90,h=90,xpos=0}) --,w=17,h=31
	mypage2:nextLine()
	mypage2:addLabel({text="第三点：战斗界面设置 关闭技能确认 运行速度为两倍速"})
	mypage2:nextLine()
	mypage2:addImage({src="Introduction3-1.JPG",w=90,h=90,xpos=0}) --,w=17,h=31
	mypage2:nextLine()
	mypage2:addImage({src="Introduction3-2.JPG",w=90,h=90,xpos=0}) --,w=17,h=31
	mypage2:nextLine()
	mypage2:addLabel({text="第四点：刷图时，把要刷的图放置到第一个位置"})
	mypage2:nextLine()
	mypage2:addImage({src="Introduction4.JPG",w=90,h=90,xpos=0}) --,w=17,h=31
	--mypage2:addLine({id="QQline",ypos=2,w=50})
	mypage2:nextLine()
	
	
	--先获取各项信息再画ui
	-- ret_table = {引擎版本,{width,height},系统类别,是否越狱,cpu架构,产品型号,language,DPI,Screen_mode}
	--width.."X"..height,OS_type,Jailbroken,DPI
	resolution,OS_type,Jailbroken,DPI = Tools.GetDeviceInfo()
	--mypage3:addWeb({id="webtest",url="http://www.baidu.com",w=100,h=100})
	mypage3:addLabel({text="分辨率："..resolution})
	mypage3:nextLine()
	mypage3:addLabel({"是否越狱："..Jailbroken})
	mypage3:nextLine()
	mypage3:addLabel({"操作系统类别："..OS_type})
	mypage3:nextLine()
	mypage3:addLabel({"DPI："..DPI})

	mypage3:addLabel({"IPhoneX用户设置下面的四个参数为：274,274,0,63"})
	mypage3:nextLine()
	mypage3:addLabel({"是否开启自定义分辨率规划"})
	mypage3:nextLine()
	mypage3:addRadioGroup({id="分辨率规划",list="否,是",w=70,h=10,color="65,105,225",select=0})
	mypage3:nextLine()
	mypage3:addLabel({"自定义分辨率规划"})
	mypage3:nextLine()
	mypage3:addEdit({id="分辨率左",prompt="填写偏移量（1-999）",text="左偏移量",color="65,105,225",w=20,h=10})
	mypage3:addEdit({id="分辨率右",prompt="填写偏移量（1-999）",text="右偏移量",color="65,105,225",w=20,h=10})
	mypage3:addEdit({id="分辨率上",prompt="填写偏移量（1-999）",text="上偏移量",color="65,105,225",w=20,h=10})
	mypage3:addEdit({id="分辨率下",prompt="填写偏移量（1-999）",text="下偏移量",color="65,105,225",w=20,h=10})
	
	
	
	--设置建议
	mypage4:addImage({src="Setting0.png",w=90,h=20,xpos=0}) --,w=17,h=31
	mypage4:nextLine()
	
	--根据后续设置给出建议
	mypage4:addLabel({"开始脚本前一定要关闭技能确认按钮",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	
	mypage4:addLabel({"启用大英雄一定要设置对应大英雄的位置，不然脚本运行会出错",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addLabel({"启动换人制服一定要查看自己是否装备了换人制服，不然脚本运行会出错",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	
	--详细技能设置
	mypage4:addImage({src="Setting1.jpg",w=90,h=20,xpos=0}) --,w=17,h=31
	mypage4:nextLine()

	--区服选择 目前支持日服 或者 国服
	mypage4:addLabel({"区服选择"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="区服选择",list="国服,日服,台服",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()

	--主要功能选择 1.刷free 2.喂狗粮 3.喂礼装
	mypage4:addLabel({"主要功能选择"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="功能选择",list="自动刷故事(特异点里启动),刷剧情(free功能+跳过剧情),刷free(free本拉到第一个位置),喂狗粮(喂狗粮界面启动),喂礼装,灵基贩卖(贩卖界面),一键智能模式,无限池点击,百重塔,南瓜村,友情池召唤",select="1@2",w=90,h=50,color="255,0,0"})
	mypage4:nextLine()
	--
	--次数设置 99次
	mypage4:addLabel({"填写要执行的次数（1-999）"})
	mypage4:nextLine()
	mypage4:addEdit({id="次数设置",prompt="填写要执行的次数（1-999）",text="1",color="65,105,225",w=70,h=10})
	mypage4:nextLine()
	--free刷取方式
	mypage4:addLabel({"Free本刷取方式"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="刷取方式",list="固定刷一个Free本,下拉式刷Free本",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--AP补充选择
	mypage4:addLabel({"AP补充选择"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="AP补充选择",list="圣晶石,黄金果实,白银果实,青铜果实,自然回体(缓慢挂机)",w=70,h=23,size=20,color="65,105,225"})
	mypage4:nextLine()
	--是否在all职阶选人
	mypage4:addLabel({"是否在ALL职介选人"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="ALL选人",list="否,是",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--助战选择
	mypage4:addLabel({"助战选择"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="助战选择",list="呆毛王,小莫,大王,闪闪,水呆毛,孔明,梅林,杀斯卡哈,杰克,枪斯卡哈,迦尔纳,拉二,船长,奶光,黑狗,黑贞,贞德lily,弓凛,黑骑呆,狂长江,艳后,水尼禄,R小莫,妖僧,狂金时,小恩,C狐,北斋,BX毛,武藏,冲田总司,花嫁尼禄,阿周那,特斯拉,弓凛,白枪呆,枪凛,山中老人,酒吞,BB,天草,伯爵,阿比,术尼托,枪狐,术师匠",w=70,h=75,size=20,color="65,105,225"})
	mypage4:nextLine()
	--助战礼装选择
	mypage4:addLabel({"助战礼装选择"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="助战礼装选择",list="迦勒底午餐时光,圣夜晚餐,万华镜,达芬奇,宇宙棱镜,二零三零,天堂之孔,虚数魔术,黑杯,社交界之花,春风游步道,第六天魔王,日轮之城,壬生狼,同人探求力,同人活动力,同人空想力,紫票,黄票,红票,帝都圣杯战争,坂本侦探事务所,研磨锐牙之暗剑",w=70,h=50,size=20,color="65,105,225"})
	mypage4:nextLine()
	--助战礼装是否满破
	mypage4:addLabel({"是否选择满破礼装"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="满破礼装",list="否,是",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	
	--助战方式设置
	mypage4:addLabel({"助战方式设置"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="助战方式设置",list="随意选一个,只选英灵,只选礼装,英灵和礼装都要选",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--助战刷新超限
	mypage4:addLabel({"助战刷新失败选项"})
	mypage4:nextLine()
	mypage4:addComboBox({id="助战刷新次数",list="一次,二次,三次,四次",w=23,h=10,size=20,color="65,105,225"})
	mypage4:addComboBox({id="助战刷新方式设置",list="随意选一个,只选英灵,只选礼装",w=23,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--换人礼装标识
	mypage4:addLabel({"是否穿戴换人制服"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="换人礼装标识",list="是,否",w=70,h=10,size=20,color="65,105,225",select = 1})
	mypage4:nextLine()
	--换人礼装设置
	mypage4:addLabel({"从第几个开始换第几个"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="换人一",list="1,2,3",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="换人二",list="4,5,6",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--是否启用大英雄
	mypage4:addLabel({"是否启用大英雄"})
	mypage4:nextLine()
	mypage4:addLabel({"勾选“是”将会关闭辅助替补智能接管功能",size=20,color="255,0,0"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="是否启用大英雄",list="是,否",w=70,h=10,size=20,color="65,105,225",select = 1})
	mypage4:nextLine()
	--大英雄站队位置（注意 大英雄不能作为替补上场）
	mypage4:addLabel({"大英雄站队位置（注意 大英雄不能作为替补上场）"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="大英雄站队位置",list="左,中,右",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--宝具判断
	mypage4:addLabel({"多少敌方数量不释放宝具（最终面无效）"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="宝具判断",list="不限制,1个敌人,2个敌人",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--卡色策略
	mypage4:addLabel({"出牌策略选择"})
	mypage4:nextLine()
	mypage4:addLabel({"第一面"})
	mypage4:addComboBox({id="出牌策略选择一",list="红卡偏重,蓝卡偏重,绿卡偏重",w=20,h=10,size=20,color="65,105,225"})
	mypage4:addLabel({"第二面"})
	mypage4:addComboBox({id="出牌策略选择二",list="红卡偏重,蓝卡偏重,绿卡偏重",w=20,h=10,size=20,color="65,105,225"})
	mypage4:addLabel({"第三面"})
	mypage4:addComboBox({id="出牌策略选择三",list="红卡偏重,蓝卡偏重,绿卡偏重",w=20,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--出牌方式
	mypage4:addLabel({"出牌方式"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="出牌方式",list="首卡染色,三色卡,克制出卡,助战出卡",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--脚本延时 用于各种不同速度的设备
	mypage4:addLabel({"脚本速度"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="脚本速度",list="0级速度（最快）,1级速度",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addLabel({"战后申请好友"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="战后申请好友",list="否,是",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addImage({src="Setting2.jpg",w=90,h=20,xpos=0}) --,w=17,h=31
	mypage4:nextLine()
	--预警技能释放
	mypage4:addLabel({"预警技能释放（被集火的怪物如果气满，则优先释放以下技能）"})
	mypage4:nextLine()
	mypage4:addCheckBoxGroup({id="预警技能",list="①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3",w=70,h=20,size=20,color="65,105,225"})
	mypage4:nextLine()
	--技能设置
	--第一面
	mypage4:addLabel({"第一面技能设置",color="255,0,0",size=50})
	mypage4:nextLine()
	mypage4:addLabel({"优先集火选择"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="优先集火选择一",list="左方敌人,中方敌人,右方敌人",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addLabel({"角色定位（顺序摆放左-中-右）"})
	mypage4:nextLine()
	mypage4:addLabel({"主攻手：辅助技能都会丢给他——副攻手：技能宝具自嗨——辅助手：辅助技能都丢给主攻手",size=20,color="255,0,0"})
	mypage4:nextLine()
	mypage4:addComboBox({id="左角色定位一",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:addComboBox({id="中角色定位一",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:addComboBox({id="右角色定位一",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--mypage4:addRadioGroup({id="BUFF队友选择一",list="左方队友,中方队友,右方队友",w=70,h=10,size=20,color="65,105,225"})
	--mypage4:nextLine()
	--mypage4:addLabel({"释放技能调整"})
	--mypage4:nextLine()
	--mypage4:addRadioGroup({id="释放技能调整一",list="CD完毕释放技能,左英灵满NP释放技能,中英灵满NP释放技能,右英灵满NP释放技能",w=70,h=30,size=20,color="65,105,225"})
	--mypage4:nextLine()
	mypage4:addCheckBoxGroup({id="技能设置一",list="①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3,13宝具左,14宝具中,15宝具右",w=70,h=30,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addLabel({"自定义技能释放顺序(技能顺序格式示例：3a-4b-5a-rb-6a-8b-ca-9a-va-15a-13a-14a 宝具顺序请放到最后)",size = 20})
	mypage4:nextLine()
	mypage4:addLabel({"a表示技能好了就放|b表示主攻手np满才放)",size = 20})
	mypage4:nextLine()
	mypage4:addEdit({id="自定义技能一",prompt="技能顺序格式示例：3a-4b-5b-ra-6a-8b-ca-9b-va",color="0,0,255",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	
	--第二面
	mypage4:addLabel({"第二面技能设置",color="255,0,0",size=50})
	mypage4:nextLine()
	mypage4:addLabel({"优先集火选择"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="优先集火选择二",list="左方敌人,中方敌人,右方敌人",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addLabel({"角色定位（顺序摆放左-中-右）"})
	mypage4:nextLine()
	
	mypage4:addComboBox({id="左角色定位二",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:addComboBox({id="中角色定位二",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:addComboBox({id="右角色定位二",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--mypage4:addLabel({"释放技能调整"})
	--mypage4:nextLine()
	--mypage4:addRadioGroup({id="释放技能调整二",list="CD完毕释放技能,左英灵满NP释放技能,中英灵满NP释放技能,右英灵满NP释放技能",w=70,h=30,size=20,color="65,105,225"})
	--mypage4:nextLine()
	mypage4:addCheckBoxGroup({id="技能设置二",list="①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3,13宝具左,14宝具中,15宝具右",w=70,h=30,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addLabel({"自定义技能释放顺序(技能顺序格式示例：3a-4b-5a-rb-6a-8b-ca-9a-va-15a-13a-14a 宝具顺序请放到最后)",size = 20})
	mypage4:nextLine()
	mypage4:addLabel({"a表示技能好了就放|b表示主攻手np满才放)",size = 20})
	mypage4:nextLine()
	mypage4:addEdit({id="自定义技能二",prompt="技能顺序格式示例：3a-4b-5b-ra-6a-8b-ca-9b-va",color="0,0,255",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	
	--第三面
	mypage4:addLabel({"第三面技能设置",color="255,0,0",size=50})
	mypage4:nextLine()
	mypage4:addLabel({"优先集火选择"})
	mypage4:nextLine()
	mypage4:addRadioGroup({id="优先集火选择三",list="左方敌人,中方敌人,右方敌人",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addLabel({"主角定位（顺序摆放左-中-右）"})
	mypage4:nextLine()
	mypage4:addComboBox({id="左角色定位三",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:addComboBox({id="中角色定位三",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:addComboBox({id="右角色定位三",list="主攻手,副攻手,辅助手",w=23,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	--mypage4:addLabel({"释放技能调整"})
	--mypage4:nextLine()
	--mypage4:addRadioGroup({id="释放技能调整三",list="CD完毕释放技能,左英灵满NP释放技能,中英灵满NP释放技能,右英灵满NP释放技能",w=70,h=30,size=20,color="65,105,225"})
	--mypage4:nextLine()
	mypage4:addCheckBoxGroup({id="技能设置三",list="①左1,②左2,③左3,④中1,⑤中2,⑥中3,⑦右1,⑧右2,⑨右3,®御主1,©御主2,ⓥ御主3,13宝具左,14宝具中,15宝具右",w=70,h=30,size=20,color="65,105,225"})
	mypage4:nextLine()
	mypage4:addLabel({"自定义技能释放顺序(技能顺序格式示例：3a-4b-5a-rb-6a-8b-ca-9a-va-15a-13a-14a 宝具顺序请放到最后)",size = 20})
	mypage4:nextLine()
	mypage4:addLabel({"a表示技能好了就放|b表示主攻手np满才放)",size = 20})
	mypage4:nextLine()
	mypage4:addEdit({id="自定义技能三",prompt="技能顺序格式示例：3a-4b-5b-ra-6a-8b-ca-9b-va",color="0,0,255",w=70,h=10,size=20,color="65,105,225"})
	mypage4:nextLine()
	
	
	
	--mypage4:addCheckBoxGroup({id="多选2",list="多选选项21,多选选项22,多选选项23",select="3",w=70,h=10,color="255,0,0"})
	--单项多选框第三种返回值模式的特殊操作,用于仅有一个选项的多选框,创建时额外传入一个参数a,a可以是不为nil或false的任意值
	--mypage4:addCheckBoxGroup({a=1,id="单项多选框",list="单项多选框",select="0",w=70,h=10,color="255,0,0"})
	--mypage4:addComboBox({id="下拉2",list="下拉选项21,下拉选项22,下拉选项23",select=0,w=70,h=10})
	
	--获取myui
	
	
	return myui
	
	
end

return GetUI