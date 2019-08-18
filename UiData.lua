require("base")

UiData = {}


function UiData.GetUIData()
	--添加一个前置ui界面
	local PrePixUI = require("PrePixUI")
	local MainUI=require("base_ui")
	local PreUIret = PrePixUI():show(0)
	
	if PreUIret._cancel then
		
		dialog("用户退出了脚本~", 3);
		lua_exit(); --否则退出脚本
	
	else
		print(PreUIret)
		PixConfigGlo = tonumber(PreUIret.配置切换)
		
	end
	
	local UIret=MainUI():show(0)

	print(">>>>>>>>>>>> UI返回值 >>>>>>>>>>>>>>>>>>")
	if UIret._cancel then
		
		dialog("用户退出了脚本~", 3);
		lua_exit(); --否则退出脚本
	else
		print(UIret)
		--config_func_glo = tonumber(UIret.助战选择)
		--sysLog(config_func_glo)
		
		--=============================UI参数定义==============================
		
		--自定义分辨率功能
		ResolutionIOGlo = tonumber(UIret.分辨率规划)
		LeftGlo = tonumber(UIret.分辨率左)
		RightGlo = tonumber(UIret.分辨率右)
		TopGlo = tonumber(UIret.分辨率上)
		BottomGlo = tonumber(UIret.分辨率下)
		main_func_glo = tonumber(UIret.功能选择) --0 刷free 1 喂狗粮 2 喂礼装
		ServerTypeGlo = tonumber(UIret.区服选择) --区服选择
		edit1_glo = tonumber(UIret.次数设置)--刷取次数edit1
		FreeTypeFuncGlo = tonumber(UIret.刷取方式)
		AP_recharge_func_glo = tonumber(UIret.AP补充选择)  --0 圣晶石 1黄金苹果 2白银 3青铜
		HelperAllGlo = tonumber(UIret.ALL选人)
		Helper_func_glo = tonumber(UIret.助战选择) --0 --呆毛王 小莫 大王 闪闪 水呆毛  孔明 梅林 艳后 杰克 白枪呆 纳尔逊 拉二 船长 奶光 黑狗 黑贞
		Helper_gift_func_glo = tonumber(UIret.助战礼装选择) --迦勒底午餐时光 圣夜晚餐
		Helper_mode_func_glo = tonumber(UIret.助战方式设置)  --助战方式 随便选一个 只选英灵 只选礼装 两者都要
		MaxHelperTimerGlo = tonumber(UIret.助战刷新次数) --助战刷新次数 一次 - 四次
		MaxHelperFuncGlo = tonumber(UIret.助战刷新方式设置)  --随意选一个,只选英灵,只选礼装 
		GiftMaxLvGlo = tonumber(UIret.满破礼装)
		Master_switch_func_glo = tonumber(UIret.换人礼装标识) --换人开关 是 否
		Master_switch_start_glo = tonumber(UIret.换人一)+1--换人位置设置
		Master_switch_end_glo = tonumber(UIret.换人二)+1+3
		AddFriendsGlo = tonumber(UIret.战后申请好友)--战后申请好友
		Stella_switch_func_glo = tonumber(UIret.是否启用大英雄)--大英雄换人开关 radiogroup513
		Stella_site_func_glo = tonumber(UIret.大英雄站队位置)+1 --大英雄位置

		Baoju_do_func_glo = tonumber(UIret.宝具判断) --0 - 小于1个 1-小于2个
		Card_color_func_glo = tonumber(UIret.出牌策略选择一) --红卡 蓝卡 绿卡偏重
		Card_color_func_glo2 = tonumber(UIret.出牌策略选择二)
		Card_color_func_glo3 = tonumber(UIret.出牌策略选择三)
		Card_type_func_glo = tonumber(UIret.出牌方式) -- '首卡染色', '三色卡','克制出卡','助战出卡','一人出一卡'
		level = tonumber(UIret.脚本速度)
		preGroup_func_glo = UIret.预警技能 --预警参数获取
		--第一面
		fire_in_func_1_glo = tonumber(UIret.优先集火选择一)+1 --集火左 中 右
		--buff_func_1_glo = tonumber(UIret.角色定位一)+1 --buff左 中 右
		--改为三个获取变量
		LeftLocation1_glo = tonumber(UIret.左角色定位一)+1
		MidLocation1_glo = tonumber(UIret.中角色定位一)+1
		RightLocation1_glo = tonumber(UIret.右角色定位一)+1
		
		Skill_req1_glo = tonumber(UIret.释放技能调整一)--技能释放要求
		Skill_op1_func_glo = UIret.技能设置一 --'左1', '左2', '左3', '中1','中2','中3','右1','右2','右3','宝具左','宝具中','宝具右','御主1','御主2','御主3'
		Custom1_Skill_edit_glo = UIret.自定义技能一

		--第二面
		fire_in_func_2_glo = tonumber(UIret.优先集火选择二)+1 --左 中 右
		--buff_func_2_glo = tonumber(UIret.角色定位二)+1 --左 中 右
		--改为三个获取变量
		LeftLocation2_glo = tonumber(UIret.左角色定位二)+1
		MidLocation2_glo = tonumber(UIret.中角色定位二)+1
		RightLocation2_glo = tonumber(UIret.右角色定位二)+1
		
		Skill_req2_glo = tonumber(UIret.释放技能调整二)
		Skill_op2_func_glo = UIret.技能设置二
		Custom2_Skill_edit_glo = UIret.自定义技能二
		--第三面
		fire_in_func_3_glo = tonumber(UIret.优先集火选择三)+1 --左 中 右
		--buff_func_3_glo = tonumber(UIret.角色定位三)+1 --左 中 右
		--改为三个获取变量
		LeftLocation3_glo = tonumber(UIret.左角色定位三)+1
		MidLocation3_glo = tonumber(UIret.中角色定位三)+1
		RightLocation3_glo = tonumber(UIret.右角色定位三)+1
		Skill_req3_glo = tonumber(UIret.释放技能调整三)
		Skill_op3_func_glo = UIret.技能设置三
		Custom3_Skill_edit_glo = UIret.自定义技能三



		--相关ui回调
	
	

		
		
	

	end
end
