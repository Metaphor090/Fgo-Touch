-- 调用 底层函数  调用层组合逻辑
require("lowfunction")

invoking = {}


-- 定义一个常量
invoking.constant = "一个常量"





--脚本刷取开始前
--这个函数开始 整合所有需要的模式 刷取模式主要有 剧情本 free本 狗娘本其实和free一起的
function invoking.Game_Start(Room_os,Helper_os,EventOS,StoryOS)
	local break_flag = 0
	
	
	
	
	if Room_os == true then
		--这里进行分支  固定刷一free 还是轮换刷
		-- 0 固定刷一个Free本 1 下拉式刷Free本
		
		if FreeTypeFuncGlo == "固定刷一个Free本" then
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(Room_Point[1],Room_Point[2])	--点击固定点Room_Point = {884,180}
		
		elseif FreeTypeFuncGlo == "下拉式刷Free本" then
			--下拉式 第一次启动点击固定点 第二次启动点击第二固定点
			if ProgramSum == 0 then 
				--第一次执行
				Tools.mSleep_level(1000,level)
				Tools.Source_Single_Click(Room_Point[1],Room_Point[2])	--点击固定点Room_Point = {884,180}
			
			else
				--多次执行941,440  NextRommPoint
				Tools.mSleep_level(1000,level)
				Tools.Source_Single_Click(NextRommPoint[1],NextRommPoint[2])	--点击固定点Room_Point = {884,180}
				
			end
		else --故事模式
		
			--先检测是否找到主线room，如果没找到则调用 搜寻map
			PreGray = lowfunction.SearchMap(PreGray)
		
			--就直接进了q
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(Room_Point[1],Room_Point[2])	--点击固定点Room_Point = {884,180}
		
		end
		
	end

	--这里加入动态判断 连续5个100 则表示静止状态了


	Tools.mSleep_level(2000,level)
	--检测是否ap足够
	AP_Recharge_confirm_ret = lowfunction.MultInterfaceCheck() --lowfunction.AP_Recharge_confirm()
	if AP_Recharge_confirm_ret == 2 then
	
		toast("AP补充开启",3)
		--如果是立即回体则调用以下
		if AP_recharge_func_glo == "自然回体" then
			
			--自然回体  --关闭按钮 然后计时711,209
			Tools.Source_Single_Click(AP_Recharge_Close[1],AP_Recharge_Close[2])
			--等待时间计时 5分钟1点 5x40 200分钟 12000
			mSleep(13000*1000)--等待时长
			return 1
			
		else
			--需要补充 type 1 圣晶石 2 黄金果实 3 白银 4青铜 5自然回体
			--dialog(AP_recharge_func_glo, 0)
			lowfunction.AP_Recharge(AP_recharge_func_glo)
		end
	else
		
	end
	
	HelperTime = 0
	while Helper_os do
		--检测助战界面
		Tools.mSleep_level(1500,level)
		Helper_confirm_ret = lowfunction.MultInterfaceCheck() --lowfunction.Helper_confirm()
		nLog("Helper_confirm_ret:"..tostring(Helper_confirm_ret))
		if Helper_confirm_ret == 1 then
		
			toast("助战开启",3)
			break
		else
			HelperTime = HelperTime + 1
			if HelperTime >=5 then
				BaseColorStr = Tools.Single_ColorStr(true,MultInterfaceCheckPoint[1],MultInterfaceCheckPoint[2])
				dialog("助战界面获取超时！,将该界面截图发给技术支持~"..tostring(BaseColorStr),0)
				break
			end
			
		end
	end
	
	--这里插入动画
	if Helper_os == true then
		--这里获取是否在all职介里选人
		--dialog(Helper_func_glo,0)
		local profession,sevent = lowfunction.Helper_Char_database(Helper_func_glo)
		if HelperAllGlo == "是" then
			profession = 'all'
		end
		--dialog(profession..','..sevent,0)
		local gift_name = lowfunction.Helper_Gift_database(Helper_gift_func_glo)
		lowfunction.Helper_Select(Helper_mode_func_glo,profession,sevent,gift_name) --选择助战
		
		
	else
		
	end
	toast("编队开启",3)

	while true do
		Tools.mSleep_level(3200,level)
		--编队界面确认
		formation_confirm_ret = lowfunction.formation_confirm()
		if formation_confirm_ret == 1 then
			--点击开始战斗1187,680 Start_Game_point
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(Start_Game_point[1],Start_Game_point[2])
			--如果遇到活动道具 那么 就 点击819,663
			if EventOS == true then
				if ActivityItemGlo == "上" then
					Tools.mSleep_level(1000,level)  
					Tools.Source_Single_Click(EventOSPoint[1][1],EventOSPoint[1][2])  
					Tools.mSleep_level(1000,level)  
					Tools.Source_Single_Click(EventOSPoint[4][1],EventOSPoint[4][2])  
				elseif ActivityItemGlo == "中" then
					Tools.mSleep_level(1000,level)  
					Tools.Source_Single_Click(EventOSPoint[2][1],EventOSPoint[2][2])  
					Tools.mSleep_level(1000,level)  
					Tools.Source_Single_Click(EventOSPoint[4][1],EventOSPoint[4][2])  
					
				elseif ActivityItemGlo == "下" then
					Tools.mSleep_level(1000,level)  
					Tools.Source_Single_Click(EventOSPoint[3][1],EventOSPoint[3][2])  
					Tools.mSleep_level(1000,level)  
					Tools.Source_Single_Click(EventOSPoint[4][1],EventOSPoint[4][2])  
				else
					Tools.mSleep_level(1000,level)  
					Tools.Source_Single_Click(EventOSPoint[4][1],EventOSPoint[4][2])  
				end
				
			end
			break
		end
	end

	--false free模式  true剧情模式
	if StoryOS == false then
		--循环检测出战斗画面
		while true do
			Tools.mSleep_level(1000,level)
			Battle_confirm_ret = lowfunction.Battle_confirm()
			if Battle_confirm_ret == 1 then
			
				--toast("准备战斗",3)
				break
			end
		
		end
		Tools.mSleep_level(1200,level)
		--开始战斗
		invoking.FightEX(StoryOS)
			
	
	else
		timer_count = 0 
		
		while true do
			Tools.mSleep_level(1000,level)
			Movie_confirm_ret = lowfunction.Movie_confirm()
			if Movie_confirm_ret == 1 then
				--检测到就点击跳过
				Tools.mSleep_level(1000,level)
				Tools.Source_Single_Click(Movie_flag[1],Movie_flag[2])
				Tools.mSleep_level(1000,level)
				
				Tools.Source_Single_Click(Moive_confirm_point[1],Moive_confirm_point[2])
			
				--toast("准备战斗",3)
				break
			else
				--持续检测5次没有的话就走下一步
				if timer_count > 30 then
					toast("获取剧情超时",3)
			
					break
				
				else
					timer_count = timer_count + 1
				end	
			end
		end
		
		--战斗界面
		--循环检测出战斗画面
		while true do
			Tools.mSleep_level(1000,level)
			Battle_confirm_ret = lowfunction.Battle_confirm()
			if Battle_confirm_ret == 1 then
				toast("开始战斗",3)
				
				break
			end
		
		end
		Tools.mSleep_level(1800,level)
		--开始战斗
		invoking.FightEX(StoryOS)
		--战斗结束 还要检测剧情模式
	end
	
	
	
	--每一次结束 清理变量垃圾
	Master_Skill_OS = {1,1,1}
	Normal_Skill_OS = {1,1,1,1,1,1,1,1,1}
	CharacterTable = {0,0,0}
	SwitchFlag = 0 --换人信号
	als_refresh_flag = 1 --阿拉什换人激活位置
	sw_refresh_flag = 1 --换人礼装激活位置
	BaseStageFlag = 0
	CurrentStage = 1
	Count_glo = Count_glo + 1
	
end


-- ruler管理器 这里生成和插入ruler
-- nr表示 cd好就释放 np表示 np满才触发  nt表示 换人操作（阿拉什专属） st表示 换人礼装专属操作
function invoking.ruler_manager()

	stage1 = lowfunction.make_command1()
	
	
	--stage1_ruler1 = {stage=1,req = "nr",skill = {No=2,Type=1,BaoJu=1,target=1}}
	
	stage2 = lowfunction.make_command2()
	
	stage3 = lowfunction.make_command3()
	ruler_table = {stage1,stage2,stage3}

	
	return ruler_table
	
end
-- FGo组合--
-- 优化版战斗
-- 基本信息
-- 技能决策
-- 出牌
function invoking.FightEX(StoryOS)
	
	fight_os = 1
	
	local target_confirm = 1
	local PreStage = 0
	--获取战场基本信息
	--获取整体技能初始化
	--初始化画面延迟参数
	Tools.mSleep_level(1000,level)
	
	Skill_colors = lowfunction.GetCurrentSkillAttribute()
	while(fight_os) do
		Baoju_do_table = {}
		local Baoju_ins_flag = 1
		
		
		stage = lowfunction.GetCurrentStage()
		
		if Stella_switch_func_glo =="否" then --这两个有其中一个激活的话则关闭智能替换技能功能
			--这里进行智能换人效果
			Tools.mSleep_level(200,level)
			lowfunction.GetCurrentCharAttribute()
		
		else
			--在这里重置阿拉什换人效果 als_refresh_flag 阿拉什标识  SwitchFlag 换人信号
			if 	als_refresh_flag == 1 and SwitchFlag == 1 then
				lowfunction.RefreshSkillCD(Stella_site_func_glo)
				SwitchFlag = 0
				als_refresh_flag = 0
			
			end
			
		end
		
		
	
		
		--这里插入动画
	
		--toast("技能计算",3)
		--toast("技能计算",1)
		--！角色存活情况
		--！御主技能cd情况
		
		-- 加载当前场景得决策规则
		
		--技能决策
		--#技能cd情况
		--#宝具充值情况
		--定义一下 决策数据包 
		-- 从者一 （nr|np） 【使用3技能  宝具】 
		--定义一项预警处理方案 如果敌人气槽满 则施放 遍历预警数组方案
		--lowfunction.SOS_Skill_Do()
		for GasIndex=1,3,1 do 
			Gas_ret = lowfunction.GetGas(GasIndex)
			
		end
		
		
		--==========================技能和宝具区域========================
		--1.区分nr 和np 来进行
		--把宝具整体提取到这里来结算 不区分  激活就放
		--如果是nr模式 先放技能再检测宝具情况
		
		for k,v in ipairs(ruler_table[stage]) do --分解命令
			--v = {stage=1,req = "nr",skill = {No=1,Type={0,0},BaoJu=1}}
			--技能使用情况
			
			--切换对象放在之前
			if PreStage == stage then
				--场景相同则不调用激活对象
				
			else
				--dialog("执行切换敌人操作")
				--Tools.Source_Single_Click(Target_Site[v["skill"]["target"]][1],Target_Site[v["skill"]["target"]][2])
				lowfunction.Select_Target(v["skill"]["target"])
				PreStage = stage
	
			end
			--每次开头进行预警计算
			local CharNo = lowfunction.GetCharNo(v["skill"]["No"])
			
			--解析阵容type
			----Type 1：主-副-辅 2：主-辅-辅 3：副-副-副
			
			if Gas_ret ~= false and Gas_ret == v["skill"]["target"] then
				--需要预警
				nLog('需要技能预警!')
				
				pre_Skill_list = lowfunction.preSkill_do(stage,v["skill"]["type"],v["skill"]["target"]) --拿到预警技能列表
				for pre_k,pre_v in ipairs(pre_Skill_list) do	
					ret = lowfunction.Skill_Do(pre_v["skill"]["No"],pre_v["skill"]["Type"],Skill_colors)
				end
				
			else
			
				nLog('不需要技能预警！')
			end
			
			if v["req"] == "nr" then --如果是nr模式 先放技能再检测宝具情况
				--指定敌人对象 每一面指定对象都不同
			   --#当前场景
			
			
			
				
				if v["skill"]["No"] ~= 13 or v["skill"]["No"] ~= 14 or v["skill"]["No"] ~= 15 then
					ret = lowfunction.Skill_Do(v["skill"]["No"],v["skill"]["Type"],Skill_colors)
				end
				
					--统一宝具检测点====
		
				if v["skill"]["No"] == 13 then
					ret2 = lowfunction.BaoJu_confirm(1)
					if ret2 == 1 then
						
						table.insert(Baoju_do_table,1)
						
					end
				end
					
				if v["skill"]["No"] == 14 then
					ret2 = lowfunction.BaoJu_confirm(2)
					if ret2 == 1 then
						
						table.insert(Baoju_do_table,2)
						
					end
				end
					
				if v["skill"]["No"] == 15 then
					ret2 = lowfunction.BaoJu_confirm(3)
					if ret2 == 1 then
						
						table.insert(Baoju_do_table,3)
						
					end
				end
	
			
		
		
				
			else --np模式的情况
					--检测某个英灵宝具充能情况 1 2 3 
					
					--这里要确定到底是谁得np满才触发 所以没触发技能释放 根据主攻手的np来核准
					--角色定位 主攻手 副攻手 辅助手
					--根据技能编号返回对应角色编号

				ret2 = lowfunction.BaoJu_confirm(v["skill"]["Type"])
				if ret2 == 1 then
					
					table.insert(Baoju_do_table,v["skill"]["Type"])
					nLog('np条件已满足!')
					--如果满足条件的np触发了 那么才激活技能释放
					--指定敌人对象 每一面指定对象都不同
				
					lowfunction.Skill_Do(v["skill"]["No"],v["skill"]["Type"],Skill_colors)
				end
				
				
			end
			
			
		
		
			
		end
		
	
		
		
		--===============================================================
		
		
		--table去重
		
		new_table = Tools.removeRepeat(Baoju_do_table)
		
		--出牌 策略 主绿 "绿卡"
		local Card_color = '红卡'
		local Card_Main_type = '首卡染色'
		local output_card_table = {}
		
		--读牌之后再激活出牌 否则识别不了
	
		toast("算卡中！",3)
		CardReadTable = invoking.Read_Card()
		
		--释放宝具之前判断一下 释放情况
		target_number = lowfunction.GetTargetNumber()
		--激活出牌界面
		lowfunction.active()
		Tools.mSleep_level(1500,level)
		--出宝具 如果拿到宝具标识 那么插入待发动宝具列表
		nLog("此时得宝具长度为"..#new_table)
		
		--先根据stage来分
		if stage == 3 then
			for k,v in ipairs(new_table) do
				lowfunction.BaoJu_do(v)
			end
		else
			if target_number > Baoju_do_func_glo then 
				for k,v in ipairs(new_table) do
					lowfunction.BaoJu_do(v)
				end
			end
			
		end
	
		
		-- 释放完宝具清空表格
		Baoju_do_table = {}
		new_table = {}
	
		PutCardColorTable = {Card_color_func_glo,Card_color_func_glo2,Card_color_func_glo3}
	
		--'首卡染色', '三色卡','克制出卡','助战出卡','一人出一卡'
		
		Card_Main_type = Card_type_func_glo
	
		if Card_Main_type == '首卡染色' or Card_Main_type == '三色卡' then
			output_card_table = lowfunction.Normal_Select_Card(CardReadTable,PutCardColorTable[stage],Card_Main_type)
		else
			output_card_table = lowfunction.Select_Card_Counter(CardReadTable)
		end
		
		
		
	

		
		lowfunction.Put_Card(output_card_table)
		
		--这里间隔5秒判断一下发牌是否完成
		lowfunction.DoPutCardOver()
		--检测战斗结束
	
		Check_Battle_Over_ret = invoking.Check_Battle_Over()
		if Check_Battle_Over_ret == 1 then
			fight_os = false
		
			toast("战斗结束",3)
		end
		

		
		
		
	end
	
	
end


--读牌选项组合
function invoking.Read_Card()
	--'首卡染色', '三色卡','克制出卡','助战出卡','一人出一卡'
	local Card_Main_type = '首卡染色'
	local Card_Counter_table = {}

	if Card_type_func_glo == '首卡染色' then
		Card_Main_type = '首卡染色'
		Card_Counter_table = lowfunction.Normal_Read_Color_Card()
	end
	
	if Card_type_func_glo == '三色卡' then
		Card_Main_type = '三色卡'
		Card_Counter_table = lowfunction.Normal_Read_Color_Card()
	end
	if Card_type_func_glo == '克制出卡' then
		Card_Main_type = '克制出卡'
		Card_Counter_table = lowfunction.Read_Card_Counter()
	end
	
	if Card_type_func_glo == '助战出卡' then
		Card_Main_type = '助战出卡'
		Card_Counter_table = lowfunction.Helper_Read_Card()
	end
	
	if Card_type_func_glo == '一人出一卡' then
		Card_Main_type = '一人出一卡'
		Card_Counter_table =lowfunction.OneByOne_Read_Card()
	end
	
	return Card_Counter_table
end


-- FGo --



-- 选卡 --

-- 这是一个大策略--

-- 暂定规则 --
function invoking.Select_Card(Card_type)
	-- 定义一个权重表 --
	
	if Card_type == "green" then
		Red_Card = 1
		Green_Card = 3
		Blue_Card = 1
	end
	
	if Card_type == "red" then
		Red_Card = 3
		Green_Card = 1
		Blue_Card = 1
	end
	
	if Card_type == "blue" then
		Red_Card = 1
		Green_Card = 1
		Blue_Card = 3
	end
	Card_Result = {}
	Card_Sum = {}
	perform_table = {}
	-- 遍历读取卡类别 --
	
	for i,val in ipairs(Card_Site) do
		ret = lowfunction.Read_Card(i)
		table.insert(Card_Result,{i,ret})
    end
	
	
	
	-- 每张卡进行积分
	for i,val in ipairs(Card_Result) do
		nLog(val[1]..val[2])
		if val[2] == "红卡" then
			type_ret = Red_Card
		end
		if val[2] == "绿卡" then
			type_ret = Green_Card
		end
		
		if val[2] == "蓝卡" then
			type_ret =  Blue_Card
		end
		table.insert(Card_Sum, type_ret)
    end
	
	
	
	-- 5选3 选取分值最高的3个

	for k,v in ipairs(Card_Sum) do
		
		if v == 3 then
			table.insert(perform_table,k) -- 插入它的序号
		end
	end
	
	-- 如果没满足则继续匹配下级
	
	if #perform_table < 3 then
	
		for k,v in ipairs(Card_Sum) do
		
			if v == 2 then
				table.insert(perform_table,k) -- 插入它的序号
			end
		end
	end
	
	-- 如果还没满足则继续匹配下级
	if #perform_table < 3 then
	
		for k,v in ipairs(Card_Sum) do
		
			if v == 1 then
				table.insert(perform_table,k) -- 插入它的序号
			end
		end
	end
	
	
	-- 输出以下performtable的值
	
	for k,v in ipairs(perform_table) do
		nLog(v) 
	
	end
	
	nLog("长度是"..#perform_table) 
	

	-- 取最后3个值 所以如果超过要修剪
	if #perform_table > 3 then
		for i=1,#perform_table-3,1 do
			table.remove(perform_table)
		end
	end
	
	for k,v in ipairs(perform_table) do
		nLog(v) 
	
	end
	
	
	-- 返回结果
	return perform_table
	
end







		
function invoking.Check_Battle_Over()
	local CheckSum = 0
	local BattleOffFlag = 0
	local checkFriendFlag = 1
	local MovieFlag = 1
	while true do
		Tools.mSleep_level(1000,level)
	
		-- 动画等待完毕 检测是否结束战斗
		--lowfunction.Battle_Over()
		BattleOffFlag = lowfunction.NewBattleOver()
		if BattleOffFlag == 1 then
			while true do
				Movie_confirm_ret = lowfunction.Movie_confirm()
				if Movie_confirm_ret == 1 and MovieFlag == 1 then
					--检测到就点击跳过
					Tools.mSleep_level(1000,level)
					Tools.Source_Single_Click(Movie_flag[1],Movie_flag[2])
					Tools.mSleep_level(1000,level)
					
					Tools.Source_Single_Click(Moive_confirm_point[1],Moive_confirm_point[2])
					MovieFlag = 0
					
				elseif lowfunction.CheckFriend() and checkFriendFlag == 1 then
					
						--申请好友界面 根据选项AddFriendsGlo
						if AddFriendsGlo == "否" then
							--点否RefusedFriendPoint
							
							Tools.mSleep_level(1000,level)
							Tools.Source_Single_Click(RefusedFriendPoint[1],RefusedFriendPoint[2])
						else
							--点是
							Tools.mSleep_level(1000,level)
							Tools.Source_Single_Click(AddFriendPoint[1][1],AddFriendPoint[1][2])
							Tools.mSleep_level(1000,level)
							Tools.Source_Single_Click(AddFriendPoint[2][1],AddFriendPoint[2][2])
							
						end
						--检查完好友那么只需要检测主界面即可
						checkFriendFlag = 0
					
				else-- 检测到战斗结束，这里要一直拖到出主界面才 关闭脚本
					ret = lowfunction.Main_Page_confirm()
					local MainFlag = 1
					if ret == 1 then
						--这里进行多次校验
						Tools.mSleep_level(2000,level)
						for i=1,3,1 do
							ret = lowfunction.Main_Page_confirm()
							if ret == 1 then
								MainFlag = MainFlag + 1
							end
							
						end
						if MainFlag >= 4 then
							return 1
						else
							Tools.mSleep_level(5000,level)
							Tools.Source_Single_Click(AddFriendPoint[1][1],AddFriendPoint[1][2])
							return 1
						end
						
						
					else
						CheckSum = CheckSum + 1
						if CheckSum > 20 then
							nLog("获取主界面超时！")
							
							toast("获取主界面超时！",3)
							ret = lowfunction.Main_Page_confirm()
							if ret == 1 then
								
							else
								--点击好友按钮RefusedFriendPoint
								Tools.mSleep_level(1000,level)
								Tools.Source_Single_Click(RefusedFriendPoint[1],RefusedFriendPoint[2])
							end
							
						end
					end
				end
			
			end
			
		else
			-- 直接检测是否有attack 没有结束那么。继续attack
			ret3 =  lowfunction.Battle_confirm()
			if ret3 == 1 then
				return 0
			end
		end                                    
	end

end


-- 喂狗粮
-- 大概流程
-- 统一筛选物品  Get_Exp_start_point  经验值 标记状态外 与强化对象不同的职介
function invoking.Get_Exp(Max_timer)
	--这里定义一下表格格式
	-- 原点 136,251 右移一格138px 
	--开启狗娘模式
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Get_Exp_start_point[1],Get_Exp_start_point[2])
	--筛选模式971,129
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Select_Exp_point[1],Select_Exp_point[2])
	
	--操作筛选  全部取消  依次选择 830,547   
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(All_Cancel_point[1],All_Cancel_point[2])
	
	--依次选择 Active_Select_point
	for k=1,4,1 do
		Tools.mSleep_level(200,level)
		Tools.Source_Single_Click(Active_Select_point[k][1],Active_Select_point[k][2])
	end
	Tools.mSleep_level(1500,level)
	--自定义喂食轮数
	for Get_Exp_timer=1,Max_timer,1 do
		if Get_Exp_timer >= 2 then
			--开启狗娘模式
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(Get_Exp_start_point[1],Get_Exp_start_point[2])
		end
		--筛选完毕 不检测交给玩家自己选择
		Tools.mSleep_level(2000,level) --防止画面定格
		for i=0,6,1 do
			Tools.mSleep_level(200,level)
			Tools.Source_Single_Click(Inter_for_point[1][1] + i*138,Inter_for_point[1][2])
		end
		
		for i=0,6,1 do
			Tools.mSleep_level(200,level)
			Tools.Source_Single_Click(Inter_for_point[2][1] + i*138,Inter_for_point[2][2])
		end
		
		for i=0,5,1 do
			Tools.mSleep_level(200,level)
			Tools.Source_Single_Click(Inter_for_point[3][1] + i*138,Inter_for_point[3][2])
		end
		
		--点击确定喂食狗粮--继续确定
		for i=5,7,1 do
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(Active_Select_point[i][1],Active_Select_point[i][2])
		end
		--检测是否回到界面 Exp_confirm_flag
		while true do
			Tools.mSleep_level(500,level)
			ret = lowfunction.Exp_confirm()
			if ret == 1 then
				break
			else
				Tools.mSleep_level(1000,level)
				Tools.Source_Single_Click(Active_Select_point[8][1],Active_Select_point[8][2])
			end
		end
	end
	
	
	
end



-- 喂礼装
-- 大概流程
function invoking.Get_Gift_Exp(Max_timer)
	--这里定义一下表格格式
	-- 原点 136,251 右移一格138px 
	--开启狗娘模式
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Get_Exp_start_point[1],Get_Exp_start_point[2])
	--筛选模式971,129
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Select_Exp_point[1],Select_Exp_point[2])
	
	--操作筛选  全部取消  依次选择 830,547    834,551 
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(All_Cancel_point[1],All_Cancel_point[2])
	
	--这里 玩家选择筛选 功能待定    确定按钮
	for k=4,7,1 do
		Tools.mSleep_level(200,level)
		Tools.Source_Single_Click(Active_Gift_point[k][1],Active_Gift_point[k][2])
	end
	Tools.mSleep_level(1500,level)
	
	--自定义喂食轮数
	for Get_Exp_timer=1,Max_timer,1 do
		if Get_Exp_timer >= 2 then
			--开启狗娘模式
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(Get_Exp_start_point[1],Get_Exp_start_point[2])
		end
		--筛选完毕 不检测交给玩家自己选择
		Tools.mSleep_level(1500,level)
		for i=0,6,1 do
			Tools.mSleep_level(200,level)
			Tools.Source_Single_Click(Inter_for_point[1][1] + i*138,Inter_for_point[1][2])
		end
		
		for i=0,6,1 do
			Tools.mSleep_level(200,level)
			Tools.Source_Single_Click(Inter_for_point[2][1] + i*138,Inter_for_point[2][2])
		end
		
		for i=0,5,1 do
			Tools.mSleep_level(200,level)
			Tools.Source_Single_Click(Inter_for_point[3][1] + i*138,Inter_for_point[3][2])
		end
		
		--点击确定喂食狗粮--继续确定
		for i=5,7,1 do
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(Active_Select_point[i][1],Active_Select_point[i][2])
		end
		--检测是否回到界面 Exp_confirm_flag
		while true do
			Tools.mSleep_level(500,level)
			ret = lowfunction.Exp_confirm()
			if ret == 1 then
				break
			else
				Tools.mSleep_level(1000,level)
				Tools.Source_Single_Click(Active_Select_point[8][1],Active_Select_point[8][2])
			end
		end
	end

end