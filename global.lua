-- 采集数据表 -- 统一存放 方便修改
global = {}
-- 安卓 720x1280

--全分辨率框架 参数
--开发分辨率
PixConfigGlo = 0

DevWidth = 1280
DevHeight = 720
ProgramSum = 0
color_default=0xffffff
base_time = 0.05
SwitchFlag = 0 --换人信号
als_refresh_flag = 1 --阿拉什换人激活位置
sw_refresh_flag = 1 --换人礼装激活位置
check_ret1 = {}
check_ret2 = {}
check_ret3 = {}

--对区服划分预留参数位置
Helper_flag_table = {}
Destruction_point = {}
Close_point = {}
All_Cancel_point = {}
Active_Gift_point = {}
--故事模式房间检测
PreGray = 0
--活动道具激活点击819,663

--活动道具使用点击
EventOSPoint = {
	
	{657,196},
	{654,349},
	{647,510},
	{819,663}
	
	
}

--AP补充检测点
APRechargePoint = {69,44}
--AP补充特征表
APRechargeTable = {

	Anchor="Middle",MainPoint={x=37,y=45},
	Area={131,21,1153,676},
	{x=209,y=207,color=0x3870a1,offset=0x404040},
	{x=275,y=229,color=0x23435f,offset=0x404040},
	{x=589,y=612,color=0xdcdcdc,offset=0x101010},
	{x=1015,y=162,color=0xf2f2f7,offset=0x101010}

}

--每日友情池抽取
NormalFriendshipPoint = {757,556}
ConfirmGetPoint = {852,565}
SummonPoint= {760,673}
--抽取结算特征
SummonOverTable = {
	Anchor="Middle",MainPoint={x=37,y=45},
	Area={418,626,735,715},
	{x=689,y=662,color=0x0eb3ed,offset=0x101010},
	{x=445,y=660,color=0x0ea3dc,offset=0x101010}

}
--礼装筛选按钮
Select_Exp_point = {975,130}
--副本点击固定点884,180
Room_Point = {884,180}
NextRommPoint = {941,440}

--气槽检测位置
Gas_Site = {{155,79},{396,80},{635,79}}
--主界面识别标识

Main_Page_table = 
 
{
	Anchor="Middle",MainPoint={x=37,y=45},
	Area={0, 0, 1279, 719},
	
	{   x=71,  y= 33, color=0xdddddd},
	{    x=42,   y= 43,color=0x191d3a},
	{  x=154,  y= 37, color=0xd8d8d8},
	{  x=100,   y= 21,  color=0xf3f3f3},
	{  x=110,    y= 68, color=0xdbdddf},
	{   x= 57,  y=  64, color=0xd7d9dc},

} 


--识别添加好友
CheckFriendsTable = {
	
	Anchor="Middle",MainPoint={x=37,y=45},
	Area={314, 58, 1006, 147},
	{  x=897,   y=93, color=0xfcfcfc},
	{  x=956,   y=90, color=0xfcfcfc},
	{  x=831,   y=85, color=0x4c4c54},
	{  x=764,  y=111, color=0x47474f},


}

--不申请好友按钮
RefusedFriendPoint = {329,619}

--申请好友按钮
AddFriendPoint = {
{931,620},
{644,561}

}

--无用点位置
UselessPoint = {974,21}
--技能确认位置
SkillComfirmPoint = {979,408}
--技能取消位置
SkillCancelPoint = {430, 424}
--发牌界面识别
PutCardTable = 

{
	Anchor="Middle",MainPoint={x=37,y=45},
	Area={1136,32,1143,38},
	{x=1139,y=35,color=0xd0d4d0,offset=0x101010}
} 
-- 开始战斗标识

Battle_confirm_table =  
{
	Anchor="Middle",MainPoint={x=1140,y=615},
	Area={800,500,1280,720},
	{x=1110,y=563,color=0x03e1fa,offset=0x131313},
	{x=1158,y=550,color=0x02e9f9,offset=0x131313},
	{x=1125,y=655,color=0x0061c4,offset=0x131313},
	{x=1195,y=663,color=0xa29178,offset=0x131313},
	{x=1233,y=608,color=0x5f4f3e,offset=0x131313}
} 


-- Attack按钮点
Attack_point = {1134,604}


--角色特征组
CharacterTable = {0,0,0}
--角色特征采集组
CharacterFlag = {
	
	
	
	{180,491},
	{488,490},
	{798,489}
	
	
	
	
}

--技能类型判断
Skill_type_auto_flag = {1114,560}
Skill_type_auto_flag2 = {1153,560}

-- 场景界面标识 常规 1 2 3面
CurrentStage = 1
BaseStageFlag = 0
BaseStageColor1 = 0
BaseStageColor2 = 0
BaseStageColor3 = 0
Stage_flag = {
	one = {

		{873,25},
		{875,27},
		{878,33}


	},

	two =  {


		{868,19},
		{878,20},
		{869,32}




	},
-- 872,25,0xe3e3e3,0x151515)
	three =  {

		
		{869,18},
		{872,25},
		{870,33}

	} 
 
}



-- 技能全局表
Skill_Site = {{66,572},{166,574},{259,580},{387,575},{482,575},
{576,576},{703,578}, {800,574}, {895,579}
}
-- 技能特征组
Skill_colors = {}
--技能全局开关(通用)
Normal_Skill_OS = {1,1,1,1,1,1,1,1,1}
-- 御主技能标识开关(通用)
Master_Skill_OS = {1,1,1}
-- 0-5延迟等级(通用)
level = 0
-- 换人礼装标识（通用） 1表示 开启 0表示关闭


-- 换人礼装位置
master_start = Master_switch_start_glo
master_end = Master_switch_end_glo
-- 核弹阿拉什 位置
Stellla = 1
refresh_flag = 1

-- 敌人位置表
Target_Site = {{43, 41},  {288,43},  {529,42}}

-- 御主位置点
Master_Skill_Point = {1194,314}
-- 御主技能点
Master_Skill_site = {{909,309},  {992,311}, {1086,313}}

-- 换人礼装坐标
Master_switch_site = {{138,345},{336,344},{542,342},{738,352},{939,346},{1139,358}}
-- 换人礼装确定按钮
Master_switch_ok = {634,630}

-- 三角色技能释放点
Get_effect = { {337,327} , {640,331} , {974,342}}
--双角色或单角色技能释放点
SingleEffect = {{448,334},{645,334}} --双人 or 单人

-- 色卡识别位置
Card_Site = {{1025,556},{1057,510}, {1098,487},{1150,483},{1204,498}}


--识别敌人位置
Target_Number_site = {{88,39},{329,39},{568,39}}


--主力助战识别位置
Helper_Color_Site = {{974,517},{1024,454},{1090,423},{1170,422},{1245,448}}
--一人打一下识别位置
One_By_One_Color_Site = {{982,546},{1020,483},{1075,449},{1145,439},{1215,455}}
--区域识别位置(已失效)
One_By_One_Color_Block = {
	{982,546,982+20,546+20},
	{1020,483,1020+20,483+20},
	{1075,449,1075+20,449+20},
	{1145,439,1145+20,439+20},
	{1215,455,1215+20,455+20}
}
-- 克制色卡识别位置
Card_Site_Counter = {{963,482},{1028,417},{1109,391},{1200,402},{1277,439}}
-- 色卡点击位置
Put_Card_Site = {{130,497},{388,503},{645,505},{902,502},{1155,508}}

-- 宝具充能检测点
Baoju_confirm_site = {{291,678}, {609,678}, {928,678},{-1,-1}}

-- 宝具点击位置
Baoju_site = {{412,206}, {639,201} , {881,194}}


-- 战斗结束标识

Battle_Over_table =  
 
{
	Anchor="Middle",MainPoint={x=96,y=190},

	Area={77,171,115,208},
	{x=84,y=182,color=0xf6cd31,offset=0x101010},
	{x=101,y=190,color=0xe0a91e,offset=0x101010},
	{x=103,y=185,color=0xebc225,offset=0x101010},

} 


-- 战斗结束固定点
Battle_Over_Point = {1121,680}


NewBattle_Over_Table = {
	Anchor="Middle",MainPoint={x=638,y=346},
	Area={87,60,1192,709},
	{x=124,y=91,color=0xe9b723,offset=0x151515},
	{x=140,y=91,color=0xe9b723,offset=0x151515},
	{x=1005,y=679,color=0xd1d1d1,offset=0x101010},
	{x=768,y=111,color=0xffffff,offset=0x101010},
	{x=868,y=111,color=0xffffff,offset=0x101010}

}
NewBattle_Over_Flag = {
	{1132,148},
	{1119,592},
	{995,75},
	{380,83}
}




Battle_Over_Flag = {
	{1193,252},
	{971,266},
	{1200,392},
	{980,458},
	{400,654},

}


--剧情下一步的特征码
NextStroyTable = {
	Anchor="Middle",MainPoint={x=638,y=346},
	Area={8,83,1278,618},
	{x=761,y=304,color=0xffff2d,offset=0x404040},
	{x=762,y=304,color=0xffff2d,offset=0x404040},
	{x=763,y=305,color=0xfff737,offset=0x404040},
	--{x=769,y=307,color=0xfff324,offset=0x404040},
	--{x=777,y=311,color=0xffd917,offset=0x404040},
	--{x=783,y=314,color=0xffcd1e,offset=0x404040},
	--{x=790,y=313,color=0xffcb2f,offset=0x404040},
	--{x=797,y=309,color=0xffe220,offset=0x404040},
	--{x=808,y=305,color=0xfff027,offset=0x404040}

}

--剧情room特征码
StoryRoomTable = {
	Anchor="Middle",MainPoint={x=638,y=346},
	Area={611,100,1237,632},
	{x=948,y=137,color=0x1f5892,offset=0x202020},
	{x=1075,y=138,color=0x133d76,offset=0x202020},
	{x=1081,y=211,color=0xbbb3a3,offset=0x202020}
}

--AP补充标识
AP_Recharge_Close = {636,617}
AP_Recharge_flag = {831,562}


--AP补充方式 对应 圣晶石 黄金果实 白银果实 青铜果实
AP_Recharge_site = {圣晶石={660,170},黄金果实={647,311},白银果实={658,470},青铜果实={653,568}}

--编队界面确认

formation_confirm_table =  
{
	 
	Anchor="Middle",MainPoint={x=781,y=81},
	Area={0,0,1280,720},
	{x=1233,y=117,color=0xeaeaea,offset=0x101010},
	{x=407,y=634,color=0x131728,offset=0x101010},
	{x=1236,y=651,color=0xf6f6f6,offset=0x101010}

} 





--默认助战选择148,269
Helper_Site_default = {148,269}
--英灵职介选择
Helper_profession_type = {all = {94,127},saber = {163,127},archer={223,125},lancer={292,125},rider={363,128},
caster={431,124},assassin={496,127},berserker={565,126},extra={633,127}}

--助战遍历滑条固定点
Helper_block_site = {{1250,182},{1250,289},{1250,372},{1250,450},{1250,493}}
--刷新助战按钮
Fresh_Helper_point = {{835,128},{842,556}}
--战斗结束下一步按钮
--Battle_Over_next_flag = {Resolution = {1137, 657, 1167, 703}, color = "0|0|0x272a5d-0x101010,-5|11|0x0d0d1f-0x101010,0|25|0x262b5b-0x101010,4|11|0xb3bbc8-0x101010"}
Battle_Over_next_table =  
{
	Anchor="Middle",MainPoint={x=1110,y=681},
	Area={949,642,1272,716},
	{x=1003,y=679,color=0xd1d1d1,offset=0x202020},
	{x=1224,y=670,color=0xdadada,offset=0x202020}
} 


Movie_flag = {1242,24}

--剧情模式识别
Movie_flag_table =  
 
 
{
	Anchor="Middle",MainPoint={x=1198,y=41},
	Area={1119,3,1276,78},
	{x=1150,y=13,color=0xfefefe,offset=0x101010},
	{x=1239,y=41,color=0xffffff,offset=0x101010}
} 


--剧情模式确定827,558
Moive_confirm_point = {827,558}
--开始战斗
Start_Game_point = {1187,680}

--狗娘喂食起准点
Get_Exp_start_point = {435,231}

--激活标记857,307  422,390  203,387
Active_Select_point = {{857,307},{422,390},{203,387},{836,636},{1158,669},{1096,679},{847,588},{898,29}}

--狗粮遍历原点
Inter_for_point = {{136,251},{136,395},{136,537}}
--狗粮亮度识别点
Scaner_for_point = {185,304}
--狗粮界面标识
--Exp_confirm_flag = {Resolution={11,19,62,63},color="0|0|0x0d0d1d-0x101010,9|-9|0x2e3768-0x101010,13|-1|0x131324-0x101010,8|9|0x272f69-0x101010,25|-1|0xd7d7d8-0x101010"}
Exp_confirm_table =  
{
	Anchor="Middle",MainPoint={x=401,y=168},
	Area={0,0,1280,720},
	{x=1030,y=678,color=0x6a6b6c,offset=0x101010},
	{x=454,y=641,color=0x233344,offset=0x101010},
	{x=154,y=46,color=0xd6d7d8,offset=0x101010}
} 

--无限池点击点
Infinity_pool_point = {409,418}

--排序按钮 1127,129
--稀有度  1067,230
--决定 855,642
--升降序 1248,137
--贩卖决定 1154,672
--销毁 845,587
--关闭639,585
Sort_point = {1127,129}
Rare_point = {1067,230}
OK_point = {855,642}
UpDown_point = {1248,137}
Sale_point = {1154,672}

Up_table =  
{
	Anchor="Middle",MainPoint={x=401,y=168},
	Area={1211,92,1279,168},
	{x=1240,y=141,color=0xf3f8fc,offset=0x101010},
	{x=1254,y=141,color=0xe7eff7,offset=0x101010},
	{x=1247,y=130,color=0xcce5ed,offset=0x101010}
} 

PutCardLagTable = {
	{136,508},
	{392,504},
	{646,501},
	{905,514},
	{1154,514}
}


--#############################英灵助战特征码###########################
Servent_name_table = {
呆毛王 =  --109,664,0xebdac1
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=184,y=259,color=0x656dae,offset=0x101010},
	{x=175,y=266,color=0x31315a,offset=0x101010},
	{x=158,y=264,color=0xfdedbb,offset=0x101010},
	{x=138,y=256,color=0x72c5a5,offset=0x101010}
} ,
 

小莫 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=135,y=254,color=0xfcfcfc,offset=0x101010},
	{x=142,y=251,color=0x143933,offset=0x101010},
	{x=142,y=255,color=0x538f71,offset=0x101010}


} ,
大王 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=115,y=235,color=0x140404,offset=0x101010},
	{x=117,y=238,color=0x833f50,offset=0x101010},
	{x=122,y=241,color=0xe1b0b8,offset=0x101010},
	{x=127,y=239,color=0xb76273,offset=0x101010}
},
 

闪闪 =  
 
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=64,y=308,color=0xffffd8,offset=0x101010},
	{x=153,y=244,color=0xd3a043,offset=0x101010},
	{x=105,y=196,color=0xfffb83,offset=0x101010},
	{x=141,y=262,color=0xfffdc7,offset=0x101010}
} ,

 
水呆毛 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=124,y=231,color=0x165860,offset=0x101010},
	{x=126,y=241,color=0x72e9b6,offset=0x101010},
	{x=131,y=243,color=0xffffff,offset=0x101010}
}, 




孔明 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=117,y=192,color=0x54655c,offset=0x101010},
	{x=191,y=192,color=0x91fcec,offset=0x101010},
	{x=108,y=300,color=0xb2baba,offset=0x101010},
	{x=146,y=272,color=0xfcf4d3,offset=0x101010}
} ,

梅林 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=182,y=234,color=0xf6f6f6,offset=0x101010},
	{x=126,y=279,color=0xf5d0d8,offset=0x101010},
	{x=188,y=257,color=0xfeefef,offset=0x101010},
	{x=63,y=291,color=0x71a2e5,offset=0x101010}
} ,
杀斯卡哈 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=136,y=255,color=0xffc396,offset=0x101010},
	{x=174,y=214,color=0xeb1e70,offset=0x101010},
	{x=119,y=297,color=0x400050,offset=0x101010},
	{x=76,y=304,color=0x2e0051,offset=0x101010}
} ,

杰克 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=138,y=267,color=0xfff1e0,offset=0x101010},
	{x=99,y=211,color=0xfff9ff,offset=0x101010},
	{x=178,y=223,color=0xdfd9e6,offset=0x101010},
	{x=95,y=294,color=0xf0f0e8,offset=0x101010}
} ,


枪斯卡哈 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=119,y=250,color=0xfff7de,offset=0x101010},
	{x=58,y=233,color=0x483758,offset=0x101010},
	{x=199,y=233,color=0x4e3595,offset=0x101010},
	{x=155,y=244,color=0xf1c1a5,offset=0x101010}
} ,

迦尔纳 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=149,y=216,color=0xfbfbf7,offset=0x101010},
	{x=87,y=262,color=0xe61410,offset=0x101010},
	{x=61,y=292,color=0x201718,offset=0x101010},
	{x=192,y=245,color=0xe7608e,offset=0x101010}
} ,

 

拉二 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=144,y=246,color=0xe3b386,offset=0x101010},
	{x=135,y=191,color=0x423c30,offset=0x101010},
	{x=60,y=255,color=0x0949b2,offset=0x101010},
	{x=157,y=281,color=0x2e2320,offset=0x101010}
} ,
 
船长 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=128,y=251,color=0xfbe3d1,offset=0x151515},
	{x=102,y=221,color=0xbfb7a7,offset=0x151515},
	{x=188,y=239,color=0xfff9f1,offset=0x151515},
	{x=203,y=237,color=0xfd719a,offset=0x151515}
} ,


奶光 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=62,y=232,color=0xecf4f4,offset=0x101010},
	{x=78,y=235,color=0x3c3455,offset=0x151515},
	{x=143,y=230,color=0xf9e9e9,offset=0x101010},
	{x=174,y=233,color=0x2d2840,offset=0x151515},
	{x=188,y=224,color=0xf1f9f9,offset=0x101010}
} ,

黑狗 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=94,y=211,color=0x543b54,offset=0x101010},
	{x=113,y=228,color=0x925037,offset=0x101010},
	{x=124,y=228,color=0x96021a,offset=0x151515},
	{x=195,y=213,color=0xbc4120,offset=0x151515}
} ,


黑贞 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=59,y=241,color=0xa670cd,offset=0x101010},
	{x=62,y=318,color=0x10006d,offset=0x101010},
	{x=137,y=262,color=0xfff9eb,offset=0x101010},
	{x=173,y=253,color=0xfaf6f0,offset=0x101010}
} ,


贞德lily =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=132,y=265,color=0xfff9f1,offset=0x101010},
	{x=94,y=289,color=0x071939,offset=0x101010},
	{x=195,y=185,color=0x10a7bd,offset=0x101010},
	{x=107,y=212,color=0xffffff,offset=0x101010}
} ,

弓凛 = 
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=128,y=275,color=0xfff9cf,offset=0x101010},
	{x=77,y=315,color=0xffd9ba,offset=0x101010},
	{x=111,y=209,color=0x171327,offset=0x101010},
	{x=111,y=303,color=0x2a0008,offset=0x101010}
} ,

黑骑呆 = 
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=111,y=278,color=0xfbfbeb,offset=0x101010},
	{x=63,y=279,color=0x135d9f,offset=0x101010},
	{x=88,y=247,color=0xe2c8cf,offset=0x101010},
	{x=181,y=299,color=0x03040c,offset=0x101010}
} ,

狂长江 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=195,y=220,color=0x58beff,offset=0x101010},
	{x=101,y=283,color=0x3557cd,offset=0x101010},
	{x=128,y=239,color=0xff36e0,offset=0x101010}
},

艳后 =
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=133,y=246,color=0xfbfbf9,offset=0x101010},
	{x=190,y=223,color=0x112222,offset=0x101010},
	{x=101,y=201,color=0x799bac,offset=0x101010}
} ,
 水尼禄 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=133,y=276,color=0xfdf4dd,offset=0x101010},
	{x=60,y=260,color=0xb59e95,offset=0x101010},
	{x=151,y=276,color=0xfff0d7,offset=0x101010},
	{x=114,y=302,color=0xa1784f,offset=0x101010}
},

R小莫 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=122,y=251,color=0xffffff,offset=0x101010},
	{x=133,y=253,color=0xf3caa9,offset=0x101010},
	{x=142,y=225,color=0xd19776,offset=0x101010},
	{x=75,y=252,color=0xa36750,offset=0x101010}
},
妖僧 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=112,y=262,color=0xffe6be,offset=0x101010},
	{x=185,y=249,color=0xfff7db,offset=0x101010},
	{x=63,y=241,color=0xffffa4,offset=0x101010},
	{x=96,y=231,color=0x000000,offset=0x101010}
},

狂金时 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=67,y=302,color=0xfcfcfc,offset=0x050505},
	{x=148,y=238,color=0xfdf5ed,offset=0x050505},
	{x=192,y=221,color=0xf7f7f7,offset=0x050505}
},

小恩 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=116,y=245,color=0xfdf5f5,offset=0x101010},
	{x=142,y=222,color=0xbdcd39,offset=0x101010},
	{x=198,y=239,color=0xe3dbd3,offset=0x101010}
},
C狐 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=106,y=254,color=0xf4c270,offset=0x101010},
	{x=122,y=228,color=0xf8a695,offset=0x121212},
	{x=134,y=261,color=0xf6e6cd,offset=0x121212}
},

北斋 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=137,y=250,color=0xfdedf5,offset=0x101010},
	{x=76,y=277,color=0x3db0ea,offset=0x101010},
	{x=173,y=242,color=0x302039,offset=0x101010}
},

BX毛 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=77,y=275,color=0x451c24,offset=0x101010},
	{x=128,y=254,color=0xffd8d8,offset=0x101010},
	{x=152,y=223,color=0xd87586,offset=0x101010}
},

BX毛 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=77,y=275,color=0x451c24,offset=0x101010},
	{x=128,y=254,color=0xffd8d8,offset=0x101010},
	{x=152,y=223,color=0xd87586,offset=0x101010}
},

武藏 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=122,y=251,color=0xfdfdd4,offset=0x101010},
	{x=70,y=270,color=0xfdeddc,offset=0x101010},
	{x=171,y=267,color=0xf44768,offset=0x151515}
},

冲田总司 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=127,y=268,color=0xfff1e0,offset=0x101010},
	{x=104,y=218,color=0xf5d4c4,offset=0x101010},
	{x=192,y=253,color=0x1f1f29,offset=0x121212}
},

花嫁尼禄 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=79,y=241,color=0xf9e9b7,offset=0x121212},
	{x=138,y=259,color=0xfff1e0,offset=0x101010},
	{x=115,y=287,color=0xa7a796,offset=0x101010}
},

阿周那 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=102,y=226,color=0x1a1a1a,offset=0x101010},
	{x=116,y=267,color=0x754c44,offset=0x101010},
	{x=183,y=248,color=0xf4f4f4,offset=0x101010}
},

特斯拉 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	
	{  x= 64,  y=236, color=0xffffff,offset=0x202020},
	{   x=91,  y=234, color=0x1d2e57,offset=0x202020},
	{  x= 119, y= 243, color=0xd8c8b7,offset=0x202020},
	{  x= 150,  y=244,color= 0xbcb4a4,offset=0x202020},

},

弓凛 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=132,y=247,color=0xfff9d0,offset=0x101010},
	{x=102,y=205,color=0x231a2b,offset=0x101010},
	{x=80,y=264,color=0xffd0af,offset=0x101010},
	{x=187,y=249,color=0xffffff,offset=0x101010}
},

白枪呆 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=63,y=241,color=0xd88e8e,offset=0x101010},
	{x=86,y=285,color=0xf5dc92,offset=0x101010},
	{x=154,y=256,color=0xfff1e9,offset=0x101010}
},
枪凛 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=111,y=258,color=0xfff1d8,offset=0x101010},
	{x=67,y=290,color=0xaf7544,offset=0x121212},
	{x=154,y=260,color=0xffffff,offset=0x101010}
},

山中老人 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=68,y=256,color=0x6f6fa9,offset=0x151515},
	{x=88,y=279,color=0x06161e,offset=0x121212},
	{x=148,y=254,color=0xb29178,offset=0x101010}
},

酒吞 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=63,y=260,color=0x3b3b3b,offset=0x101010},
	{x=117,y=296,color=0xfff1f1,offset=0x101010},
	{x=158,y=233,color=0x6a597a,offset=0x151515}
},

BB =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=70,y=242,color=0xf186e0,offset=0x101010},
	{x=131,y=252,color=0xffefe6,offset=0x101010},
	{x=127,y=219,color=0xd4abed,offset=0x101010}
},

天草 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=127,y=452,color=0xf1b78e,offset=0x101010},
	{x=82,y=458,color=0xbaa178,offset=0x101010},
	{x=102,y=412,color=0xf5f5ed,offset=0x101010}
},
伯爵 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=71,y=261,color=0xf5f5ed,offset=0x101010},
	{x=126,y=249,color=0xf5ede5,offset=0x101010},
	{x=111,y=287,color=0x797958,offset=0x101010},
	{x=111,y=303,color=0xcecebd,offset=0x151515}
},

阿比 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=93,y=243,color=0x9686a7,offset=0x101010},
	{x=112,y=264,color=0xf9f1f9,offset=0x101010},
	{x=73,y=295,color=0xa75832,offset=0x151515}
},


术尼托 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=118,y=255,color=0xc89e75,offset=0x121212},
	{x=84,y=242,color=0x7f66a1,offset=0x121212},
	{x=198,y=225,color=0xfdfded,offset=0x121212},
	{x=104,y=254,color=0xb70d0d,offset=0x121212}
},

枪狐 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=111,y=381,color=0xf5ccb3,offset=0x101010},
	{x=79,y=348,color=0xffd9d9,offset=0x151515},
	{x=134,y=340,color=0xbc605b,offset=0x151515},
	{x=152,y=376,color=0xfef78c,offset=0x151515}
},
术师匠 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=0,y=0,color=0xe7cbf7,offset=0x101010},
	{x=39,y=13,color=0xffffe7,offset=0x101010},
	{x=57,y=-31,color=0xff75c8,offset=0x151515},
	{x=120,y=-25,color=0x071759,offset=0x151515},
	{x=74,y=16,color=0xfffcd9,offset=0x151515}
},
枪奶光 =  
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=62,y=233,color=0xf9e9f1,offset=0x202020},
	{x=93,y=228,color=0x5c548b,offset=0x202020},
	{x=144,y=258,color=0xf2e2e2,offset=0x151515},
	{x=196,y=237,color=0xfde2f5,offset=0x303030}
},


}




 
--呆毛王 小莫 大王 闪闪 水呆毛  孔明 梅林 艳后 杰克 白枪呆 纳尔逊 拉二 船长 奶光 黑狗 黑贞
--#############################礼装助战特征码###########################
Gift_name_table = {
迦勒底午餐时光 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=63,y=346,color=0xedf5dc,offset=0x202020},
	{x=148,y=344,color=0xfaf2e2,offset=0x202020},
	{x=155,y=313,color=0xf3d5ca,offset=0x202020},
	{x=189,y=312,color=0x69b382,offset=0x202020}
} ,

 


万华镜 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	
	{x=61,y=319,color=0x010101,offset=0x101010},
	{x=124,y=356,color=0x101010,offset=0x101010},
	{x=143,y=351,color=0xfcb146,offset=0x101010}
} ,

达芬奇 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=57,y=349,color=0xbd8b6a,offset=0x050505},
	{x=99,y=330,color=0xfefefe,offset=0x050505},
	{x=162,y=317,color=0x183552,offset=0x050505}
},

宇宙棱镜 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=131,y=334,color=0xfde5d4,offset=0x101010},
	{x=135,y=345,color=0xfb8998,offset=0x151515},
	{x=181,y=327,color=0xffffff,offset=0x101010},
	{x=182,y=316,color=0xc4d4ed,offset=0x101010}
},

二零三零 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=63,y=341,color=0x657d86,offset=0x101010},
	{x=102,y=339,color=0x687057,offset=0x101010},
	{x=134,y=352,color=0xf9f9f9,offset=0x121212}
},


天堂之孔 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=74,y=346,color=0xafa7aa,offset=0x101010},
	{x=95,y=334,color=0xf5f5f5,offset=0x101010},
	{x=176,y=348,color=0xaa9989,offset=0x101010}
},

圣夜晚餐 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=111,y=319,color=0x3d3d45,offset=0x151515},
	{x=126,y=335,color=0xf2b8a0,offset=0x151515},
	{x=155,y=315,color=0x160e0e,offset=0x101010},
	{x=118,y=329,color=0xe19782,offset=0x151515}
},



虚数魔术 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=69,y=322,color=0x000000,offset=0x151515},
	{x=140,y=339,color=0xfdf5ed,offset=0x151515},
	{x=161,y=342,color=0x342c66,offset=0x202020}
},
黑杯 =  
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=69,y=333,color=0x372737,offset=0x101010},
	{x=117,y=311,color=0xc67a7f,offset=0x202020},
	{x=135,y=328,color=0xfff9f9,offset=0x101010}
},

--===============================圣诞节活动===========================
铃铛 = 
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=109,y=318,color=0x816060,offset=0x101010},
	{x=109,y=307,color=0xe6c480,offset=0x101010},
	{x=96,y=314,color=0xffe9d8,offset=0x101010}
} ,

蜡烛 = 
 
{
	Anchor="Middle",MainPoint={x=640,y=360},

	Area={32,173,221,719},
	{x=190,y=340,color=0xfee1b8,offset=0x101010},
	{x=186,y=348,color=0x612727,offset=0x101010},
	{x=176,y=352,color=0xcf5b5b,offset=0x101010}
},

雪宝宝 = 
 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=129,y=335,color=0x443b4c,offset=0x101010},
	{x=115,y=341,color=0x972042,offset=0x101010},
	{x=105,y=343,color=0xf7e7df,offset=0x101010}
} ,


喜羊羊 = 

{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=141,y=335,color=0xb28091,offset=0x101010},
	{x=146,y=327,color=0x8091e6,offset=0x101010},
	{x=159,y=342,color=0x8c3b6c,offset=0x101010}
} ,
	
--======================================================



--========================达芬奇赝作======================
死之艺术 = 

{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=125,y=337,color=0xffe8cf,offset=0x101010},
	{x=131,y=329,color=0xb55b10,offset=0x101010},
	{x=117,y=329,color=0xd17624,offset=0x101010}
} ,

毒蛇一艺 = 

{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=143,y=351,color=0xdeceb5,offset=0x101010},
	{x=150,y=329,color=0x363e47,offset=0x101010},
	{x=153,y=345,color=0xd3c2af,offset=0x101010}
} ,


柔软的慈爱 = 

{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=157,y=322,color=0x6c6c53,offset=0x101010},
	{x=167,y=322,color=0xdeded6,offset=0x101010},
	{x=177,y=321,color=0xffffff,offset=0x101010}
} ,

迦勒底的学者 = 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=99,y=328,color=0xfce3db,offset=0x101010},
	{x=99,y=318,color=0x320b0b,offset=0x101010},
	{x=112,y=346,color=0xa0c9fa,offset=0x101010},
	{x=137,y=329,color=0xf9f9f9,offset=0x101010}
} ,

--========================================================



--========================情人节巧克力制造==================

甜蜜之日 = 
{
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=79,y=355,color=0xf37fc0,offset=0x101010},
	{x=80,y=337,color=0xe391ec,offset=0x101010},
	{x=93,y=365,color=0xea94de,offset=0x101010},
	{x=146,y=341,color=0xc8b4fd,offset=0x101010}
} ,

法老巧克力 = {

	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=130,y=322,color=0xffe0d9,offset=0x101010},
	{x=162,y=325,color=0xe6a47b,offset=0x101010},
	{x=198,y=325,color=0x755ca7,offset=0x101010},
	{x=60,y=323,color=0xf19ea7,offset=0x101010}
},

第一次的情人节 = {

	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=106,y=328,color=0xdcaa8d,offset=0x101010},
	{x=112,y=311,color=0x31394f,offset=0x101010},
	{x=152,y=335,color=0xecb291,offset=0x101010},
	{x=204,y=311,color=0xfdefe7,offset=0x101010}


},


魔女厨房 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=100,y=341,color=0xfdf2d9,offset=0x101010},
	{x=110,y=312,color=0xe68372,offset=0x101010},
	{x=130,y=308,color=0xa8c1d9,offset=0x101010},
	{x=131,y=315,color=0xffffff,offset=0x101010}
},



--=========================================================

--=======================空之境界 复刻版====================
三重结界 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=75,y=335,color=0x172b62,offset=0x101010},
	{x=88,y=333,color=0x22112f,offset=0x101010},
	{x=98,y=336,color=0xead6d6,offset=0x101010}
},

夏日未来视 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=105,y=327,color=0x856596,offset=0x101010},
	{x=130,y=327,color=0xf1f1e9,offset=0x101010},
	{x=140,y=328,color=0x2f2d6f,offset=0x101010},
	{x=170,y=328,color=0x7aa3c3,offset=0x101010}
},

循环 =  {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=102,y=311,color=0xac8383,offset=0x101010},
	{x=115,y=335,color=0xfdecc5,offset=0x101010},
	{x=146,y=311,color=0x5e4e3d,offset=0x101010},
	{x=197,y=315,color=0xffffff,offset=0x101010}
},
斩首兔女郎 =  {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=123,y=341,color=0xfdeddc,offset=0x101010},
	{x=177,y=330,color=0xfff9f9,offset=0x101010},
	{x=186,y=321,color=0xf5bbbb,offset=0x101010},
	{x=198,y=328,color=0xbe737c,offset=0x101010}
},

--==========================================================

--=========================Saber War Lily===================
纯洁绽放 =  {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=98,y=338,color=0xfff8d8,offset=0x101010},
	{x=130,y=338,color=0xfff7df,offset=0x101010},
	{x=164,y=318,color=0xf5c492,offset=0x101010},
	{x=207,y=315,color=0x64d0f4,offset=0x101010}
},

阿尔托莉雅之星 = {

	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=93,y=337,color=0x0a1128,offset=0x101010},
	{x=110,y=335,color=0x1f284e,offset=0x101010},
	{x=154,y=341,color=0xed473c,offset=0x101010},
	{x=206,y=334,color=0xa93008,offset=0x101010}
},

巫女狐 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=67,y=318,color=0xffffff,offset=0x101010},
	{x=118,y=317,color=0xfffff0,offset=0x101010},
	{x=150,y=343,color=0xffffff,offset=0x101010},
	{x=184,y=326,color=0xe5bb79,offset=0x101010}
},

化为红莲的影之国 = { -- 点数
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=59,y=328,color=0x9c5a73,offset=0x101010},
	{x=108,y=335,color=0xfef6dd,offset=0x101010},
	{x=194,y=305,color=0x1d1d1d,offset=0x101010}
},

正射必中 = {

	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=63,y=319,color=0x594441,offset=0x101010},
	{x=102,y=326,color=0x211010,offset=0x101010},
	{x=128,y=330,color=0xb4a393,offset=0x101010},
	{x=163,y=332,color=0x6a7259,offset=0x101010},
	{x=183,y=336,color=0x75534a,offset=0x101010}
},


--=========================台服尼禄祭礼装=====================
二神三脚 = {

	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=153,y=340,color=0xffe7ce,offset=0x101010},
	{x=201,y=350,color=0x332430,offset=0x101010},
	{x=64,y=354,color=0x3b5c96,offset=0x101010},
	{x=106,y=341,color=0xffedc7,offset=0x101010}
},

为御主喝彩 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=130,y=336,color=0xf7eae4,offset=0x101010},
	{x=201,y=329,color=0x437cf8,offset=0x101010},
	{x=186,y=317,color=0x3377ff,offset=0x101010},
	{x=107,y=353,color=0x22219a,offset=0x101010}

},

--=============================三藏天竺================================
三英杰 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=135,y=337,color=0xfff7dc,offset=0x101010},
	{x=169,y=345,color=0xffddaa,offset=0x101010},
	{x=72,y=358,color=0xcc2222,offset=0x101010}

},

三色兼备 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=56,y=326,color=0x9eeba6,offset=0x101010},
	{x=166,y=335,color=0xeff191,offset=0x101010},
	{x=177,y=323,color=0xee6633,offset=0x101010}

},

九首牛魔 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=128,y=540,color=0xfffff3,offset=0x101010},
	{x=186,y=535,color=0x161e2f,offset=0x101010},
	{x=190,y=521,color=0xc9e9ed,offset=0x101010}

},


--=========================Fate Alta================================
身在图利法斯 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=156,y=344,color=0xf2c1a0,offset=0x101010},
	{x=85,y=342,color=0xcba180,offset=0x101010},
	{x=65,y=344,color=0x181818,offset=0x101010}

},

城塞的午后 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=101,y=328,color=0xddd5dd,offset=0x101010},
	{x=87,y=351,color=0xbfafbf,offset=0x101010},
	{x=161,y=358,color=0xc8969e,offset=0x101010}

},

出发前进 =  {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=85,y=346,color=0x16c4ed,offset=0x101010},
	{x=122,y=338,color=0xfddde4,offset=0x101010},
	{x=200,y=328,color=0x1af1e0,offset=0x101010}

},

去往远方的巡礼 =  {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=56,y=310,color=0xcbecec,offset=0x101010},
	{x=122,y=312,color=0xf7f7f7,offset=0x101010},
	{x=128,y=339,color=0xe5c482,offset=0x101010}

},

刹那的幸福之地 =  {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=130,y=336,color=0xc9a087,offset=0x101010},
	{x=64,y=349,color=0xfcf4db,offset=0x101010},
	{x=169,y=319,color=0xbfa79e,offset=0x101010}

},
--================================================================
--============================END===========================


--=========================明治维新================================
日轮之城 =  {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=124,y=323,color=0xf5d4bb,offset=0x101010},
	{x=153,y=325,color=0x394962,offset=0x101010},
	{x=98,y=311,color=0x441a12,offset=0x202020}

},
壬生狼 =  {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=84,y=337,color=0xd8af75,offset=0x101010},
	{x=131,y=345,color=0x2bc8d8,offset=0x101010},
	{x=160,y=315,color=0xcc9275,offset=0x101010}

},
社交界之花 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=88,y=325,color=0x1c1c24,offset=0x101010},
	{x=131,y=352,color=0xecc2a1,offset=0x101010},
	{x=172,y=344,color=0xffffff,offset=0x101010}
},


春风游步道 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=109,y=330,color=0xfff1e9,offset=0x101010},
	{x=81,y=331,color=0xdce5d4,offset=0x101010},
	{x=181,y=350,color=0xd0afd0,offset=0x101010}
},

第六天魔王 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=80,y=321,color=0xf18654,offset=0x101010},
	{x=107,y=332,color=0x270e0e,offset=0x101010},
	{x=165,y=318,color=0xf4c3c6,offset=0x151515}
},



--======================帝都圣杯战争==========================
帝都圣杯战争 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=56,y=326,color=0xf7e7ef,offset=0x202020},
	{x=102,y=326,color=0xf9bfa7,offset=0x202020},
	{x=140,y=328,color=0xe57272,offset=0x202020},
	{x=167,y=314,color=0xf5b3a3,offset=0x202020},
	{x=192,y=321,color=0xfff8b7,offset=0x151515}
},

坂本侦探事务所 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=69,y=335,color=0x0c152d,offset=0x202020},
	{x=78,y=325,color=0xe6c4af,offset=0x202020},
	{x=111,y=345,color=0xede4ce,offset=0x202020},
	{x=103,y=345,color=0xe4166f,offset=0x202020},
	{x=143,y=352,color=0xf1b8a1,offset=0x202020}
},
研磨锐牙之暗剑 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=59,y=319,color=0xd0bfaf,offset=0x151515},
	{x=100,y=318,color=0x373740,offset=0x151515},
	{x=121,y=328,color=0xe0bf9e,offset=0x151515},
	{x=157,y=332,color=0x995757,offset=0x151515}
},

白衣水手小姐 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	
	{   x=54,  y=330, color=0x3ca2d5},
	{   x=79,  y=340, color=0xffffff},
	{  x=127,  y=328, color=0xdcabab},
	{  x=169,  y=334, color=0x8a58bb},
	{  x=186,  y=321, color=0x404048},

},

--========================夏日泳装活动
海滨奢华 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	
	{  x= 99,  y=316, color=0x1cb0fa},
	{  x= 79,  y=332,color= 0xa16e6e},
	{  x=126,  y=339, color=0xcc9a9a},
	{ x= 164,  y=333, color=0x222838},
},

砂糖假期 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	

	{  x=  60, y= 343, color=0x401f17},
	{  x=  80, y= 349, color=0xe5c4a8},
	{ x=  152, y= 321,color= 0xf2b8a0},
	{ x=  177, y= 352, color=0xdb899d},

},

白色航游 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	

	
	{  x=  57,  y=326, color=0xefeff7},
	{ x=  102,  y=340, color=0xffe9d8},
	{  x= 123,  y=321, color=0xead197},
	{  x= 146,  y=338, color=0xffe9d8},


},

小小夏日 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	

	{  x=  62,   y=334,color= 0x639df7},
	{ x=  103,  y= 327,color= 0x17171d},
	{  x= 140,   y=324, color=0x798292},
	{  x= 147,   y=341, color=0xfcfce3},

},

迦勒底沙滩排球 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=70,y=349,color=0x1c87fa,offset=0x101010},
	{x=159,y=347,color=0xd59383,offset=0x202020},
	{x=184,y=341,color=0x1c87fa,offset=0x101010}
},

 Kingjokerjack = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=89,y=326,color=0xfdf8f0,offset=0x151515},
	{x=125,y=330,color=0x785757,offset=0x151515},
	{x=158,y=323,color=0x8abdde,offset=0x151515},
	{x=182,y=317,color=0xb7967d,offset=0x202020}
},

盛夏一刻 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=60,y=337,color=0x8abbdc,offset=0x151515},
	{x=115,y=334,color=0x8e6d23,offset=0x151515},
	{x=135,y=339,color=0x586916,offset=0x151515},
	{x=184,y=340,color=0xd0c8c8,offset=0x151515}
},

潜入湛蓝 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=67,y=351,color=0x1671c4,offset=0x202020},
	{x=101,y=342,color=0xfbfbfb,offset=0x151515},
	{x=142,y=332,color=0xfcdbdb,offset=0x151515},
	{x=196,y=333,color=0x1671c4,offset=0x202020}
},

--=========================夏日监狱大逃脱===================


--==========================================================


--============================END===========================

--==========================日服活动礼装====================
--========================本能寺2019=======================
鬼之茶会 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=90,y=329,color=0xf7d3ad,offset=0x101010},
	{x=142,y=347,color=0xd9bb94,offset=0x101010},
	{x=182,y=331,color=0xaba392,offset=0x121212},
	{x=203,y=321,color=0xad8a4f,offset=0x101010}
},

群雄割据 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=82,y=337,color=0xffefde,offset=0x101010},
	{x=75,y=348,color=0x210c52,offset=0x101010},
	{x=176,y=336,color=0xfff3de,offset=0x101010},
	{x=191,y=335,color=0xce8e7b,offset=0x101010}
},

军神 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=81,y=331,color=0x181c39,offset=0x101010},
	{x=132,y=334,color=0xd6aea5,offset=0x101010},
	{x=170,y=345,color=0xffe7bd,offset=0x101010},
	{x=194,y=348,color=0x2b2323,offset=0x101010}
},

腹减战 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=76,y=320,color=0xedddcc,offset=0x101010},
	{x=140,y=335,color=0x87a781,offset=0x151515},
	{x=110,y=321,color=0x212842,offset=0x101010},
	{x=182,y=342,color=0xd6a294,offset=0x111111}
},


--========================2018夏日祭复刻=======================
同人探求力 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=105,y=343,color=0xffffef,offset=0x101010},
	{x=89,y=335,color=0x293c43,offset=0x151515},
	{x=144,y=337,color=0x3f3e4f,offset=0x151515},
	{x=171,y=354,color=0xffd8b5,offset=0x151515}
},


同人活动力 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=90,y=331,color=0x4296ef,offset=0x151515},
	{x=116,y=318,color=0xffdbcb,offset=0x202020},
	{x=155,y=303,color=0x5d7687,offset=0x202020},
	{x=198,y=314,color=0xbde3f7,offset=0x151515}
},

同人空想力  = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=71,y=323,color=0x2179ef,offset=0x202020},
	{x=117,y=313,color=0xb6c0cf,offset=0x202020},
	{x=151,y=339,color=0x181018,offset=0x202020},
	{x=201,y=321,color=0x1e0c70,offset=0x202020}
},


紫票 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=88,y=346,color=0xffff9c,offset=0x151515},
	{x=114,y=321,color=0xa7782c,offset=0x303030},
	{x=131,y=342,color=0xdea26b,offset=0x202020},
	{x=159,y=333,color=0xf2ce68,offset=0x151515}
},



黄票 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=91,y=315,color=0x31618c,offset=0x202020},
	{x=136,y=315,color=0x317cb5,offset=0x202020},
	{x=163,y=315,color=0xd691b0,offset=0x202020},
	{x=200,y=321,color=0xd69aad,offset=0x202020},
	{x=156,y=340,color=0x41c1f4,offset=0x202020}
},

红票 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={32,173,221,719},
	{x=72,y=343,color=0x2d2cd8,offset=0x202020},
	{x=137,y=342,color=0xfff2db,offset=0x202020},
	{x=138,y=322,color=0xf7e2d3,offset=0x202020},
	{x=175,y=327,color=0xfaf6f8,offset=0x202020}
},


--============================END===========================




--=========================台服活动礼装======================
--=========================第二代alter复刻===================


圣者的招待 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=107,y=323,color=0x792f2f,offset=0x151515},
	{x=134,y=335,color=0xfdedcc,offset=0x101010},
	{x=150,y=344,color=0x2a1420,offset=0x151515},
	{x=202,y=321,color=0x781a17,offset=0x151515}
} ,

圣者的阅读 =  
{
	Anchor="Middle",MainPoint={x=130,y=444},
	Area={32,173,221,719},
	{x=105,y=320,color=0x070606,offset=0x101010},
	{x=68,y=332,color=0x884422,offset=0x151515},
	{x=134,y=331,color=0xfebc51,offset=0x121212},
	{x=132,y=345,color=0xfdbb58,offset=0x101010}
} ,

--===========================================================
--==============================END=========================
}

return global

