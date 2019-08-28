require("global")
-- 文件名为module.lua
-- 定义一个名为tools的模块
lowfunction = {}


-- 定义一个常量
lowfunction.constant = "一个常量"


-- ###已测试
-- fgo 检测是否进入战斗 检测的就是attack。
function lowfunction.Battle_confirm()
	--Battle_confirm_table
	local ret = Tools.Single_FindColor(true,Battle_confirm_table,2)

	if ret== true then
		result = 1
		nLog("【战斗界面】")
	else
		result = 0
		nLog("【未进入战斗界面】")
	end
	
	
	return result 
end




-- 主界面检测
function lowfunction.Main_Page_confirm()
	Tools.mSleep_level(1000,level)

	local ret = Tools.Single_FindColor(true,Main_Page_table,1)



	if ret == true then
		result = 1
		nLog("【获取主界面】")
	else
		result = 0
		nLog("【未获取主界面】")
		--未获取主界面就点上面的无痛点969,19
		Tools.mSleep_level(10,level)
		Tools.Source_Single_Click(969,19)
	end
		return result 
	
end



-- ###测试
-- 技能释放 点击技能 然后确定 所以要带入点击坐标
-- 技能释放有选择对象释放的
-- 三个角色对应坐标 332,442  655,441  967,452
-- 如果skill_type 是1 要选择队友释放 是2选择敌人释放 是0不管
-- skill_target 为 1 2 3
function lowfunction.Skill_comfirm(Skill_No,Skill_colors)
	local master_index = Skill_No-9--御主衣服要重置
	if Skill_No >= 10 then
		if Master_Skill_OS[master_index] == 1  then
			nLog("【技能可使用】")
			ret = 1
		else
		
			nLog("【技能冷却中】")
			ret = 0
		end
		
	
	else
	
		Tools.mSleep_level(20,level)
		-- 先检测是否cd
		local color =Tools.Single_ColorStr(true,Skill_Site[Skill_No][1], Skill_Site[Skill_No][2])
		--9b9b9b
		nLog(color.."=="..Skill_colors[Skill_No])
		--前置检测技能参数是否有误
		
		if (math.abs(color - Skill_colors[Skill_No]) <= 65535) and color ~=0 and  Skill_colors[Skill_No]~=0 then -- 如果两个颜色相同说明可以使用
			nLog("【技能可使用】")
			ret = 1
		
		
		else
			nLog("【技能冷却中】")
			ret = 0
		end
	
	end
	
	
	return ret
end




-- ！！！bug 换人技能释放后，操作出错
-- 重新编排 skilldo  cd_os = 1 算cd的  其他表示不算cd
function lowfunction.Skill_Do(Skill_No,Skill_Type,Skill_colors)
	if Skill_No <10 then
		master_index = math.floor((Skill_No+2)/3)
	else
		master_index = Skill_No-9
	end
	
	--首先还是要区分是否要算cd的情况

	-- 将御主cd和普通cd分开算
	--如果启用了阿拉什或者换人礼装，那么采用cd_os ~=1的策略 
	--如果没有启用则用cd_os ==1的策略 Stella_switch_func_glo Master_switch_func_glo
	
	--===============================================================

	--分开算两个的cd
	--dialog("此时的Skill_Type："..tostring(Skill_Type))
	if Skill_No < 10 then 
		
		normal_cd = lowfunction.Skill_comfirm(Skill_No,Skill_colors)--检查普通技能的cd
		if normal_cd == 1 then
			Tools.mSleep_level(200,level)
			Tools.Source_Single_Click(Skill_Site[Skill_No][1],Skill_Site[Skill_No][2])
			--Tools.mSleep_level(200,level)
			--Tools.Source_Single_Click(SkillCancelPoint[1],SkillCancelPoint[2])--技能确认SkillComfirmPoint
			lowfunction.auto_skill(Skill_Type)
		end
	end
	
	if Skill_No == 10 or Skill_No == 11 then
		
		
		if Master_Skill_OS[master_index] == 1 then  --检查御主技能cd 
			lowfunction.master_Skill_Do(Skill_No) --重置御主技能cd
			--Tools.mSleep_level(200,level)
			--Tools.Source_Single_Click(SkillComfirmPoint[1],SkillComfirmPoint[2])--技能确认SkillComfirmPoint
			
			lowfunction.auto_skill(Skill_Type)
		end
	
	end

	--dialog("此时的状态值："..tostring(Skill_No)..",".."Master_switch_func_glo:"..tostring(Master_switch_func_glo)..",".."master_index:"..tostring(master_index))
	if Skill_No == 12 and Master_switch_func_glo == "是" and Master_Skill_OS[master_index] == 1 then --换人礼装专属模式
		
		lowfunction.master_Skill_Do(Skill_No)
		--Tools.mSleep_level(200,level)
		--Tools.Source_Single_Click(SkillComfirmPoint[1],SkillComfirmPoint[2])--技能确认SkillComfirmPoint
		lowfunction.switch_os(Master_switch_start_glo,Master_switch_end_glo) --位置设置为全局变量
	elseif Skill_No == 12 and Master_switch_func_glo == "否" and Master_Skill_OS[master_index] == 1 then
		
		lowfunction.master_Skill_Do(Skill_No) --重置御主技能cd
		--Tools.mSleep_level(200,level)
		--Tools.Source_Single_Click(SkillComfirmPoint[1],SkillComfirmPoint[2])--技能确认SkillComfirmPoint
		lowfunction.auto_skill(Skill_Type)
		
	end
	return 1
		
			
	
		

	
end

function lowfunction.auto_skill(Skill_Type)
	--超时计数
	local SkillTimer = 0
	local WaitTimer = 0
	--判断技能类型 自动判断技能类型
	Tools.mSleep_level(500,level)
	skill_res = lowfunction.auto_skill_type()
	if skill_res == 0 then
		while true do
			--动画动作 这里用是否出attck来判断
			Tools.mSleep_level(500,level)  --随机一个数，随机延迟，造成手指按下和抬起的一个随机性。
			local Skill_Over = Tools.Single_FindColor(true,Battle_confirm_table,2)
			if Skill_Over == true then
			
				break
			else
				nLog('技能等待中')
				
				SkillTimer = SkillTimer + 1
				if SkillTimer > 10 then
					nLog('技能等待超时~')
					--判断为队友模式
					lowfunction.PartyMode(Skill_Type)
					--Tools.SingleSnapshot()--截图
					break
				end
			end
		
		end
	
	else
		lowfunction.PartyMode(Skill_Type)
	end
end


function lowfunction.PartyMode(Skill_Type)
	local SkillTimer = 0
	Tools.mSleep_level(500,level)
	nLog(Skill_Type)
	Tools.Source_Single_Click(Get_effect[Skill_Type][1],Get_effect[Skill_Type][2])
	--动画动作
	while true do
			--动画动作 这里用是否出attck来判断
		Tools.mSleep_level(500,level)  --随机一个数，随机延迟，造成手指按下和抬起的一个随机性。
		
		local Skill_Over = Tools.Single_FindColor(true,Battle_confirm_table,2)
		if Skill_Over == true then
			break
		else
			nLog('技能等待中')
			SkillTimer = SkillTimer + 1
			if SkillTimer > 50 then
				nLog('技能等待超时~')
				--执行二人或者单人
				Tools.mSleep_level(500,level)
				Tools.Source_Single_Click(SingleEffect[1][1],SingleEffect[1][2])
				Tools.mSleep_level(500,level)
				Tools.Source_Single_Click(SingleEffect[2][1],SingleEffect[2][2])
			end
			
		end
	
	end
end


--御主技能释放
function lowfunction.master_Skill_Do(Skill_No)
	--master技能  Master_Skill_Point   Master_Skill_site
	--点开御主技能面板
	local master_index = Skill_No-9
	
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Master_Skill_Point[1],Master_Skill_Point[2])
	--点击御主技能
	Tools.mSleep_level(500,level)
	Tools.Source_Single_Click(Master_Skill_site[master_index][1],Master_Skill_site[master_index][2])
	Master_Skill_OS[master_index] = 0 --标识设置为0
end


--###已测试
--自动判定技能的类型返回0 表示通用技能  1表示 队友技能
function lowfunction.auto_skill_type()
	local res = 0
	--算1114,560 的灰度值
	----Gray = (r*299 + g*587 + b*114 + 500) / 1000  sysLog(r.."="..g.."="..b)
	
	--Tools.mSleep_level(300,level)  Skill_type_auto_flag2
	local c3b = Tools.Single_ColorRGB(true,Skill_type_auto_flag[1],Skill_type_auto_flag[2])
	local c3b2 = Tools.Single_ColorRGB(true,Skill_type_auto_flag2[1],Skill_type_auto_flag2[2])
	Gray = (c3b.r*299 + c3b.g*587 + c3b.b*114 + 500) / 1000
	Gray2 = (c3b2.r*299 + c3b2.g*587 + c3b2.b*114 + 500) / 1000
	nLog(Gray..","..Gray2)
	if math.abs(Gray -25) <= 20 and math.abs(Gray2-160) <= 20 then
	
		nLog("队友模式")
		
		res = 1

	else
		res = 0
	
		nLog("普通模式")
	end
		
	
	
	return res
end

-- ###重写读卡策略 分别适配五种情况
-- 5张卡分别检测 带入x,y返回卡类别 
function lowfunction.Normal_Read_Card(card_No)

	--type 1 首卡染色 2 三色卡 3 克制出卡（特殊读牌） 4 助战出卡（特殊读牌） 5 一人出一卡 （特殊读牌）
	--1号卡检测
	local result = "未知卡牌"
	
	Tools.mSleep_level(10,level)
	local c3b = Tools.Single_ColorRGB(false,Card_Site[card_No][1],Card_Site[card_No][2])

	--value,index = Tools.maximum(c3b)
	--sysLog("值是"..value..",".."序号"..index)
	--如果 单色最大 并且 比两个加起来都大
	--if c3b.r > 175  and c3b.g >140 and c3b.g < 240 and c3b.b < 110  then
	if c3b.r >  c3b.g  and c3b.r > c3b.b then	
		result = "红卡"

		return result
	end
	
	--if c3b.r > 200 and c3b.g > 225 and c3b.b > 70  and c3b.b < 160 then
	if c3b.g >  c3b.r  and c3b.g > c3b.b then		
		result = "绿卡"
		--sysLog(result..'='..c3b.r..'='..c3b.g..'='..c3b.b)
		return result
	end
	
	--if c3b.r > 50 and c3b.r < 150 and c3b.g > 190 and c3b.b > 220 then
	if c3b.b >  c3b.r  and c3b.b > c3b.g then			
		result = "蓝卡"
		--sysLog(result..'='..c3b.r..'='..c3b.g..'='..c3b.b)
		return result
	end
	--sysLog(result..'='..c3b.r..'='..c3b.g..'='..c3b.b)
	return result
end

--色卡读取
function lowfunction.Normal_Read_Color_Card()

	Card_Result = {}
  

    
  
    for i,val in ipairs(Card_Site) do
		ret = lowfunction.Normal_Read_Card(i)
		table.insert(Card_Result,{i,ret}) --序号 卡色[红卡 蓝卡 绿卡]
	end
   
	
	return Card_Result
end





    
	
	
	


--助战读取
function lowfunction.Helper_Read_Card()
	local Card_Result = {}
	local c3b = {}
	for k,v in ipairs(Helper_Color_Site) do
		c3b = Tools.Single_ColorRGB(false,v[1],v[2])
		if c3b.r>240 and c3b.g>240 and c3b.b>240 then
			nLog("识别为助战卡")
			table.insert(Card_Result,k) --序号 卡色
		end
	end
	return Card_Result
end


--一人打一下读牌
-- Gray = (R*299 + G*587 + B*114 + 500) / 1000
 -- One_By_One_Color_Site
 
--r,g,b = getColorRGB(v[1],v[2])
		--转换灰度
		--Gray = (r*299 + g*587 + b*114 + 500) / 1000  sysLog(r.."="..g.."="..b)
		
		
--
function lowfunction.OneByOne_Read_Card()
	Card_Result = {}
    local ColorCharTable = {}
    local RedTotal=1
    local BlueTotal = 2
    local GreenTotal = 3
    local CardColor = "未知卡牌"
	OneCardData = {StartSite={948,559},k=0.46,b=115}
    TwoCardData = {StartSite={985,482},k=1.11,b=-611}
    ThreeCardData = {StartSite={1041,435},k=3.0,b=-2688}
    FourCardData = {StartSite={1112,505},k=-7.58,b=8944}
    FiveCardData = {StartSite={1160,506},k=-1.84,b=2646}
    ColorCardTable = {OneCardData,TwoCardData,ThreeCardData,FourCardData,FiveCardData}
    
    --直线的斜率是 k=(y2-y1)/(x2-x1)
    --直线方程 y=kx+b
    --第一张牌的各项参数  k=0.46511627906977   b=  115.19
    --第二张牌的各项参数  k=1.1111111111111   b=  -611.33
    --第三张牌的各项参数  k=3.0   b=  -2688.0
    --第四张牌的各项参数  k= -7.5833333333333  b=  8944.25
    --第五张牌的各项参数  k= -1.8444444444444  b=  2645.5555555556
	
	for CardTableKey,CardTableValue in ipairs(ColorCardTable) do
		--循环  距离大概94个点   
	  
		for Dir=1,94,1 do
		   local IndexX = CardTableValue.StartSite[1]+Dir
		   IndexY=CardTableValue.k*(IndexX)+CardTableValue.b
		   --1.能求出y，并且在这个坐标点上采色
		   local RGBColor = Tools.Single_ColorRGB(false,x_site,y_site)
		  
			  
		   --这里分析和判断 然后直接插入色卡结果
		   --分析特征表获得结果 主基准色 > 次基准色相加
		   --判断三次 依次为 红卡 蓝卡 绿卡
		   if RGBColor.r > RGBColor.g and RGBColor.r > b then
				--插入颜色特征表 1表示红 2 蓝 3 绿
				table.insert(ColorCharTable,1) 
			elseif RGBColor.b > RGBColor.r and RGBColor.b > RGBColor.g then
				--插入颜色特征表 1表示红 2 蓝 3 绿
				table.insert(ColorCharTable,2) 
			elseif RGBColor.g > RGBColor.r and RGBColor.g > RGBColor.b then
				--插入颜色特征表 1表示红 2 蓝 3 绿
				table.insert(ColorCharTable,3) 
		   end
				
				
		end
		--收集完特征点进行统计分析
		for ColorCharKey,ColorCharValue in ipairs(ColorCharTable) do
			if ColorCharValue == 1 then
					RedTotal = RedTotal + 1
			elseif ColorCharValue == 2 then
					BlueTotal = BlueTotal + 1
			elseif ColorCharValue == 3  then
					GreenTotal = GreenTotal + 1
			 end
		end
		if RedTotal > BlueTotal and RedTotal > GreenTotal then
			CardColor = "红卡"
		elseif BlueTotal > RedTotal and BlueTotal > GreenTotal then
		 
			CardColor = "蓝卡"
		 elseif GreenTotal > RedTotal and GreenTotal > BlueTotal then
			CardColor = "绿卡"
		end
		table.insert( Card_Result,{CardTableKey,CardColor})
		--清空特征表
		ColorCharTable = {}
	  
	end

    
   
	
	return Card_Result
	
	
end


--重写 选卡规则
function lowfunction.Normal_Select_Card(Card_Result,Card_Color,Type)
	--先读卡
	-- 遍历读取卡类别 --

	Get_Card_Table = {}
	color_time = 0

	if Type == "首卡染色" then
		--依次遍历卡编号  选择 匹配卡色
		for k,v in ipairs(Card_Result) do
			if v[2] == Card_Color then
				--匹配到 那么就选择该卡 + 顺次两卡
				table.insert(Get_Card_Table,v[1])
				--删除该处编号
				table.remove(Card_Result,k)
				--顺次选择两卡
				table.insert(Get_Card_Table,Card_Result[1][1])
				table.insert(Get_Card_Table,Card_Result[2][1])
				
				return Get_Card_Table
			end
		
		end
		
		if #Get_Card_Table < 3 then
		
			--没匹配到
			table.insert(Get_Card_Table,Card_Result[1][1])
			table.insert(Get_Card_Table,Card_Result[2][1])
			table.insert(Get_Card_Table,Card_Result[3][1])
		end
		
		return Get_Card_Table
	
	else
		--三色卡  以凑足三色卡为优先原则
		--依次遍历卡编号  选择 匹配卡色
		for k,v in ipairs(Card_Result) do
			if v[2] == Card_Color then
				
				color_time  = color_time + 1
			end
		end
		
		--总结 color次数
		if color_time >= 3 then
			nLog("满足三色卡")
			--既然满足三色那么重新遍历 取出匹配项
			for k,v in ipairs(Card_Result) do
				if v[2] == Card_Color then
					table.insert(Get_Card_Table,v[1])
				end
			end
			return Get_Card_Table
		else --color_time < 3
			--凑不齐的情况 就首卡染色 根据color_time的数量 补齐剩下的牌
			for PicKey,PicValue in ipairs(Card_Result) do
				if PicValue[2] == Card_Color then
					table.insert(Get_Card_Table,PicValue[1])
					Card_Result[PicKey][1] = 999 --修改值让其剔除
				end
			end
			
			local RemainTime = 3 - color_time --剩下要选的牌
			while RemainTime ~= 0 do
				for PicKey,PicValue in ipairs(Card_Result) do
					if Card_Result[PicKey][1] ~= 999 then
						table.insert(Get_Card_Table,PicValue[1])
						Card_Result[PicKey][1] = 999 --修改值让其剔除
						RemainTime = RemainTime - 1
						break
					end
				end
			end
			
			
			
			return Get_Card_Table
		end
	end
	
end



function lowfunction.Put_Card(Put_card_table)
	for k,v in ipairs(Put_card_table) do
		Tools.mSleep_level(200,level)
		Tools.Source_Single_Click(Put_Card_Site[v][1],Put_Card_Site[v][2])
	
	end

end



-- 检测战斗结束
-- 获取到战斗结束 点击屏幕 两次 点击下一步 1124,685 v然后等待获取主界面
--战斗结束也需要加固


function lowfunction.NewBattleOver()
	Tools.mSleep_level(100,level)
	local ret = Tools.Single_FindColor(true,NewBattle_Over_Table,2)
	

	local Battle_flag = 0
	for Battle_Over = 1,4,1 do
		RGBTable = Tools.Single_ColorRGB(false,NewBattle_Over_Flag[Battle_Over][1],NewBattle_Over_Flag[Battle_Over][2])
		if RGBTable.r < 30 and RGBTable.g < 30 and RGBTable.b < 30 then
			Battle_flag = Battle_flag + 1
		end
	end
	
	
	if Battle_flag >=3 and ret == true then
		nLog("【战斗结束】")
		Tools.mSleep_level(1000,level)
		Tools.Source_Single_Click(Battle_Over_Point[1],Battle_Over_Point[2])
		Tools.mSleep_level(1000,level)
		Tools.Source_Single_Click(Battle_Over_Point[1],Battle_Over_Point[2])
		Tools.mSleep_level(1000,level)
		Tools.Source_Single_Click(Battle_Over_Point[1],Battle_Over_Point[2])
		while true do
			--持续检测下一步按钮
			Tools.mSleep_level(1000,level)
			next_ret = Tools.Single_FindColor(true,Battle_Over_next_table,2)
			--固定点点击 1121,680 X3 这里找下一步的特征码算了
			if next_ret == true then
				Tools.mSleep_level(1500,level)
				Tools.Source_Single_Click(Battle_Over_Point[1],Battle_Over_Point[2])
			else
			
				break
			end
	
		end
		return 1
	else
	
		nLog("【继续战斗】")
		--如果继续战斗的话那么一直点无用界面 UselessPoint
		Tools.mSleep_level(800,level)
		Tools.Source_Single_Click(UselessPoint[1],UselessPoint[2])
		return 0	
	end
	

end


-- ###以测试
-- 获取当前场景
--以第一次调用为基准值
function lowfunction.GetCurrentStage()
	
	local CurrentStageColor1,CurrentStageColor2,CurrentStageColor3 = lowfunction.GetScanPointColor()--检测手段2
	if BaseStageFlag == 0 then
		--将当前值保存到base里 
		BaseStageFlag = 1
		BaseStageColor1 = CurrentStageColor1
		BaseStageColor2 = CurrentStageColor2
		BaseStageColor3 = CurrentStageColor3
		return CurrentStage
	else
	if BaseStageColor1 == CurrentStageColor1 and BaseStageColor2 == CurrentStageColor2 and BaseStageColor3 == CurrentStageColor3 then --不翻页
	
			--dialog('当前场景为'..tostring(CurrentStage))
			nLog('当前场景为'..tostring(CurrentStage))
			return CurrentStage
			
			
		elseif (BaseStageColor1 ~= CurrentStageColor1 and BaseStageColor2 ~= CurrentStageColor2 and BaseStageColor3 ~= CurrentStageColor3)   --如果有两个点变了那么就是变了
			--(BaseStageColor1 ~= CurrentStageColor1 and BaseStageColor3 ~= CurrentStageColor3) or
			--(BaseStageColor2 ~= CurrentStageColor2 and BaseStageColor3 ~= CurrentStageColor3) then
			then
			 
			CurrentStage = CurrentStage + 1  --翻页
			--重新获取变量
			
			BaseStageColor1 = CurrentStageColor1
			BaseStageColor2 = CurrentStageColor2
			BaseStageColor3 = CurrentStageColor3
			if CurrentStage >= 3 then --最大值设为3
			
				CurrentStage = 3
			end
			--dialog('当前场景为'..tostring(CurrentStage))
			nLog('当前场景为'..tostring(CurrentStage))
			return CurrentStage
		else
			--dialog('当前场景为'..tostring(CurrentStage))
			nLog('当前场景为'..tostring(CurrentStage)) --一个值变了不管
			return CurrentStage
		end
	end
	
	
	
end



function lowfunction.GetScanPointSum(Rect)
	--初始化一些转换参数
	
	--如果左右有黑白则调用这个比例
	if Act_Env.Left ~= 0 then
		AppurtenantScaleMode=Act_Env.Height/Dev_Env.Height  --开发转实际缩放比例
	else
		AppurtenantScaleMode=Act_Env.Width/Dev_Env.Width  --开发转实际缩放比例
	end

	
	local PointSum = 0
	--将原表复制一份 进行操作 最后销毁即可
	local Copy_Rect = Tools.TableCopy(Rect)
	local trueScanArea = All_Resolution.缩放Area(Copy_Rect)
	Tools.KeepSwitch()
	--然后扫点获取符合点个数
	mSleep(100)
	for col=trueScanArea[2],trueScanArea[4],1 do --列
		for row=trueScanArea[1],trueScanArea[3],1 do
			
			color_r, color_g, color_b = getColorRGB(row,col)
			--sysLog(color_r..'&'..color_g)
			if color_r >= 190 and color_g <= 25 then
				PointSum = PointSum + 1
			
			end
		end
	
	end
	
	nLog('当前的点总和为：'..PointSum)
	
	return PointSum

end


function lowfunction.GetScanPointColor()
	--CurrentStage

	local StageColor1 = Tools.Single_ColorStr(true,Stage_flag.one[1][1],Stage_flag.one[1][2])
	local StageColor2 = Tools.Single_ColorStr(false,Stage_flag.one[2][1],Stage_flag.one[2][2])
	local StageColor3 = Tools.Single_ColorStr(false,Stage_flag.one[3][1],Stage_flag.one[3][2])
	
	return StageColor1,StageColor2,StageColor3

end
-- ###以测试
-- 单一检测宝具
--重写宝具检测函数 检测九宫格如果有满足点则判断为可以释放
function lowfunction.BaoJu_confirm(Charecter_No)
	local LightSum = 0
	local NewLightRGB = {}
	local Move_Flag = {
	{0,0},
	{1,0},
	{0,1},
	{1,1}	
	}
	-- np满格特征点239,667,0xd3d3d3
	
	for Move_k,Move_v in ipairs(Move_Flag) do
		local LightRGB = Tools.Single_ColorRGB(false,Baoju_confirm_site[Charecter_No][1]+Move_v[1],Baoju_confirm_site[Charecter_No][2]+Move_v[2])
		for k,v in pairs(LightRGB) do
			table.insert(NewLightRGB,v)
				
		end
		table.sort(NewLightRGB) -- 默认由小到大
		--计算公式 亮度公式：(max(r,g,b)+max2(r,g,b))/2 
		Light = (NewLightRGB[3] + NewLightRGB[2])/2
		NewLightRGB = {} --重置表格
		if Light >= 60 then
			LightSum = LightSum + 1
		end
	end
	
	--最后判断总数
	if LightSum >= 1 then --放宽检测
		nLog("[角色宝具已充满]")
		return 1
	else
		nLog("[角色宝具未达成]")
		return 0
	end
	

end

-- ！！！待测试
-- 激活出牌界面
function lowfunction.active()
	Tools.mSleep_level(300,level)
	Tools.Source_Single_Click(Attack_point[1],Attack_point[2])
	
end




-- 宝具和卡牌的释放 打牌阶段
-- 释放宝具的时候判断一下是否是大英雄。如果不是直接释放 是的话 要释放之后刷新下技能
-- 刷新过一次之后就不要刷新了
function lowfunction.BaoJu_do(BaoJu_No)
	
	-- 点击attack 等待两秒开始选牌 Attack按钮 1134,604
	if BaoJu_No ~= 4 then
		Tools.mSleep_level(600,level)
		Tools.Source_Single_Click(Baoju_site[BaoJu_No][1],Baoju_site[BaoJu_No][2])
		
	end
	
	if als_refresh_flag == 1 and Stella_switch_func_glo == "是" and BaoJu_No == Stella_site_func_glo then
		
		--刷新技能释放信号给刷新技能得地方调用
		SwitchFlag = 1 --换人操作信号

	end
	
	
end
	
--重写针对颜色的刷新技能特征组
function lowfunction.RefreshSkillCD(char_site)
	local Skill_Attribute = {}
	--_K:Switchkeep()
	
	if char_site == 1 then --左从者
		for i=1,3,1 do
			Tools.mSleep_level(50,level)
			color = Tools.Single_ColorStr(true,Skill_Site[i][1],Skill_Site[i][2])
			--table.insert(Skill_Attribute,color)
			--替换到总表里 Skill_colors
			nLog("刷新技能"..color.."替换掉"..Skill_colors[i])
			Skill_colors[i] = color
			
		end
			
	end
	
	if char_site == 2 then --中从者
		for i=4,6,1 do
			
			color = Tools.Single_ColorStr(true,Skill_Site[i][1],Skill_Site[i][2])
			Skill_colors[i] = color
		end
	end
	
	if char_site == 3 then --右从者
		for i=7,9,1 do
			
			color = Tools.Single_ColorStr(true,Skill_Site[i][1],Skill_Site[i][2])
			Skill_colors[i] = color
		end
	end
	
end




-- 技能读取特征库--
-- 这里要带skill_flag参数表，不是每个英灵都有3技能
function lowfunction.GetCurrentSkillAttribute()
	Skill_colors = {}


	-- 遍历 --
	-- 这里直接keep一次图片 降低 消耗
	
	for k,v in ipairs(Skill_Site) do
	
		-- 遍历技能标尺
		
		Tools.mSleep_level(10,level)
		color = Tools.Single_ColorStr(false,v[1], v[2]) --获取(100,100)的颜色值，赋值给color变量
		nLog(string.format("%X",color))
	
		table.insert(Skill_colors,color)
	
		
	
	end
	
	return Skill_colors
end

 --Target_Site = {{40,41},  {285,41},  {525,40}}
function lowfunction.Select_Target(target_no)
	--dialog("做操作"..tostring(target_no))
	
	--Tools.mSleep_level(300,level)
	Tools.Source_Single_Click(Target_Site[target_no][1],Target_Site[target_no][2])
	

end


-- 克制读牌 读取固定点五个 获取红色特征
function lowfunction.Read_Card_Counter()
	local Card_Counter_table = {}
	for k,v in ipairs(Card_Site_Counter) do
		
		c3b = Tools.Single_ColorRGB(false,Card_Site_Counter[k][1],Card_Site_Counter[k][2])
		if c3b.r >= 160 and c3b.g<=5 and c3b.b <=5 then
			-- 克制牌
			table.insert(Card_Counter_table,k)
			nLog(k)
		end
	end
	
	return Card_Counter_table
end

--克制大于天 克制选牌 带入克制序号表（3，1，2）
--这个函数的功能就是补齐和选出三张最优牌  Card_Counter_table 1 2
function lowfunction.Select_Card_Counter(Card_Counter_table)
	local output_card_table = {}
	local source_card_table = {1,2,3,4,5}
	--分两种情况 如果不足三张克制 则补齐牌
	if #Card_Counter_table < 3 then
		--获取待插入序号，然后补齐剩下的
		prepare_no = 3 - #Card_Counter_table
		--清洗出哪些牌是可选的
		for i=1,#Card_Counter_table,1 do
			--table.remove(source_card_table,Card_Counter_table[i])
			table.insert(output_card_table,Card_Counter_table[i])
		end
		
		
		
		for i=1,#source_card_table,1 do
			if source_card_table[i] ~= output_card_table[i] then
				table.insert(output_card_table,source_card_table[i])
			
			end
			
		end
		
		
		
	end
	--超过三张的情况 直接顺序输出
	if #Card_Counter_table >= 3 then
		for i=1,3,1 do
		
			table.insert(output_card_table,Card_Counter_table[i])
		
		end
	end
	for k,v in ipairs(output_card_table) do
		nLog(v)
	end
	return output_card_table
end



--ap补充确认
--用灰度值来判断替换掉找色判断
function lowfunction.AP_Recharge_confirm()
	--首先识别是否需要补充
	local APRechargeRGB = Tools.Single_ColorRGB(true,APRechargePoint[1],APRechargePoint[2])
	--计算灰度值  Gray = (r*299 + g*587 + b*114 + 500) / 1000
	local Gray = (APRechargeRGB.r*299 + APRechargeRGB.g*587 + APRechargeRGB.b*114 + 500) / 1000
	--APRechargeTable
	local ret = Tools.Single_FindColor(true,APRechargeTable,10)


	
	if Gray < 100 and ret == true then
		nLog("需要补充")
		--需要补充的类型 指定补充 如果指定的没有那么就找替代
		return 1
	else
		nLog("不需要补充")
		return 0
	end

	
end


--ap补充 type 1 圣晶石 2 黄金果实 3 白银 4青铜
function lowfunction.AP_Recharge(Recharge_type)
	--根据type 选择补充对象
	Tools.mSleep_level(1000,level)
	--点击补充对象
	Tools.Source_Single_Click(AP_Recharge_site[Recharge_type][1],AP_Recharge_site[Recharge_type][2])
	--等待1秒 点击补充831,562
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(AP_Recharge_flag[1],AP_Recharge_flag[2])
end


--助战页面确认
function lowfunction.Helper_confirm()
	--首先识别是否需要补充
	local ret = Tools.Single_FindColor(true,Helper_flag_table,6)
	if ret == true then
		nLog("助战界面")
		--需要补充的类型 指定补充 如果指定的没有那么就找替代
		
		result = 1
	else
		--Tools.SingleSnapshot()
		toast("不是助战界面",3)
	
		nLog("不是助战界面")
		
		result = 0
	end
	return result
end

--编队确认
function lowfunction.formation_confirm()
	ret = Tools.Single_FindColor(true,formation_confirm_table,2)
	if ret == true then
		nLog("编队界面")
		--需要补充的类型 指定补充 如果指定的没有那么就找替代
		
		result = 1
	else
		nLog("不是编队界面")
		result = 0
	end
	return result
end


--助战英灵选择Helper_profession_type select_mode表示 选择哪种助战方式0随便选 1偏英灵 2偏礼装 3都要
function lowfunction.Helper_Select(Select_mode,profession_type,servent_name,Gift_name)
	local mode_type_table = {} --助战扫描结果
	local res = 0
	local ResTimer = 1
	local times = 1
	local GiftRet = false
	
	--先确定英灵职业 如果是随意选一个就不管这个
	nLog("当前助战选项"..MaxHelperFuncGlo)
	nLog("职介定位数据"..tostring(Helper_profession_type[profession_type][1])..","..tostring(Helper_profession_type[profession_type][2]))
	if Helper_mode_func_glo ~= "随意选一个" then
		Tools.mSleep_level(1000,level)  
		Tools.Source_Single_Click(Helper_profession_type[profession_type][1],Helper_profession_type[profession_type][2])
	end
	
	
	while res == 0 do
		--然后获取英灵特征 这里开始遍历滑条
		--Tools.SingleSnapshot()
		Tools.mSleep_level(1000,level) 
		Click_servent_xy = Tools.Single_FindColor_Site(true,Servent_name_table[servent_name],1)
		Tools.mSleep_level(1200,level)
		--然后获取礼装特征
		Click_gift_xy = Tools.Single_FindColor_Site(true,Gift_name_table[Gift_name],1)
		--添加多次刷新失败的扩大搜索条件（不识别满破）
		
		if ResTimer > MaxHelperTimerGlo then
			
			if MaxHelperFuncGlo == "随意选一个" then
				Tools.mSleep_level(1000,level)
				Tools.Source_Single_Click(Helper_Site_default[1],Helper_Site_default[2])
				res = 1
			
			end
			
			if MaxHelperFuncGlo == "只选英灵" then
				if Click_servent_xy ~= false then
					--已确定英灵 点击确定
					Tools.mSleep_level(200,level)
					Tools.Click(Click_servent_xy.x,Click_servent_xy.y)
					res = 1
				end
			end
			
			if MaxHelperFuncGlo == "只选礼装" then
			
				if Click_gift_xy ~= false then
					--已确定英灵 点击确定
					Tools.mSleep_level(200,level)
					Tools.Click(Click_gift_xy.x,Click_gift_xy.y)
					res = 1
				end
				
			end
		
		else
			--是否识别满破礼装
			if GiftMaxLvGlo == "否" then  --否0 是1
				
				--默认选择第一个 英灵 148,269  Helper_Site_default
				if Select_mode == "随意选一个" then
					Tools.mSleep_level(200,level)
					Tools.Source_Single_Click(Helper_Site_default[1],Helper_Site_default[2])
					res = 1
				end
				if Select_mode == "只选英灵" then
					if Click_servent_xy ~= false then
						--已确定英灵 点击确定
						Tools.mSleep_level(200,level)
						Tools.Click(Click_servent_xy.x,Click_servent_xy.y)
						res = 1
					end
				end
				
				if Select_mode == "只选礼装" then
					if Click_gift_xy ~= false then
						--已确定英灵 点击确定
						Tools.mSleep_level(200,level)
						Tools.Click(Click_gift_xy.x,Click_gift_xy.y)
						res = 1
					end
				
				end
				
				if Select_mode == "英灵和礼装都要选" then
					if Click_servent_xy ~= false and Click_gift_xy ~=false then
						if Click_gift_xy.y > Click_servent_xy.y  then  --and Click_gift_xy.y - Click_servent_xy.y <= 180
							Tools.mSleep_level(200,level)
							Tools.Click(Click_servent_xy.x,Click_servent_xy.y)
							res = 1
						
						end
					
					end
				end
			else --要识别满破
				if Click_gift_xy ~= false then
					GiftRet = lowfunction.CheckGiftFullLv(Click_gift_xy)
					nLog('当前坐标'..Click_gift_xy.x..","..Click_gift_xy.y)
				else
					GiftRet = false
				end
				
				if GiftRet == true then
					nLog('已找到满破礼装！')
				else
					nLog('未找到满破礼装！')
					
				end
					--默认选择第一个 英灵 148,269  Helper_Site_default
					----助战方式 随便选一个 只选英灵 只选礼装 两者都要
				if Select_mode == "随便选一个"  then
					Tools.mSleep_level(200,level)
					Tools.Source_Single_Click(Helper_Site_default[1],Helper_Site_default[2])
					res = 1
				end
				if Select_mode == "只选英灵"  then
					if Click_servent_xy ~= false then
						--已确定英灵 点击确定
						Tools.mSleep_level(200,level)
						Tools.Click(Click_servent_xy.x,Click_servent_xy.y)
						res = 1
					end
				end
				
				if Select_mode == "只选礼装" and GiftRet == true then
					if Click_gift_xy ~= false then
						--已确定英灵 点击确定
						Tools.mSleep_level(200,level)
						Tools.Click(Click_gift_xy.x,Click_gift_xy.y)
						res = 1
					end
				
				end
				
				if Select_mode == "英灵和礼装都要选" and GiftRet == true then
					if Click_servent_xy ~= false and Click_gift_xy ~=false then
						if Click_gift_xy.y > Click_servent_xy.y  then  --and Click_gift_xy.y - Click_servent_xy.y <= 180
							Tools.mSleep_level(200,level)
							Tools.Click(Click_servent_xy.x,Click_servent_xy.y)
							res = 1
						
						end
					
					end
				end
					
			end
			--如果x，y差值不大于180     and 
		
		end
		
		
		
		
		if res == 1 then
			return 1
		end
		--翻页
		times = lowfunction.Helper_block(times)
		if times >=5 then
			times = 1
			Tools.mSleep_level(3000,level)
			--刷新助战835,128  842,556
			Tools.Source_Single_Click(Fresh_Helper_point[1][1],Fresh_Helper_point[1][2])
			Tools.mSleep_level(400,level) 
			Tools.Source_Single_Click(Fresh_Helper_point[2][1],Fresh_Helper_point[2][2])
			Tools.mSleep_level(3000,level)
			--循坏一次 自加1
			nLog('没找到扩展条件+1')
			ResTimer = ResTimer + 1
		end
	
	end
end

--助战遍历滑条 代入遍历次数
function lowfunction.Helper_block(times)
	--Helper_block_site
	Tools.mSleep_level(200,level)
	Tools.Source_Single_Click(Helper_block_site[times][1],Helper_block_site[times][2])
	return times+1

end


--剧情模式识别
function lowfunction.Movie_confirm()
	local ret = Tools.Single_FindColor(true,Movie_flag_table,2)
	if ret == true then
		nLog("剧情界面")
		--需要补充的类型 指定补充 如果指定的没有那么就找替代
		
		result = 1
	else
		nLog("不是剧情界面")
		result = 0
	end
	return result

end

--狗粮界面识别Exp_confirm_flag
function lowfunction.Exp_confirm()

	local ret = Tools.Single_FindColor(true,Exp_confirm_table,2)
	if ret == true then
		nLog("狗粮界面")
		--需要补充的类型 指定补充 如果指定的没有那么就找替代
		
		result = 1
	else
		nLog("不是狗粮界面")
		result = 0
	end
	return result

	
end



-- 换人礼装专属操作 换人之后需要清理技能cd
function lowfunction.switch_os(start,endl)

	if Master_switch_func_glo == "是" and sw_refresh_flag == 1 then --是
		--将要清空该处位置的从者技能
		

	
		--刷新技能释放信号给刷新技能得地方调用
		SwitchFlag = 1
	
	
	end
	--Master_switch_site Master_switch_ok
	
	Tools.mSleep_level(2500,level)
	Tools.Source_Single_Click(Master_switch_site[start][1],Master_switch_site[start][2])
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Master_switch_site[endl][1],Master_switch_site[endl][2])
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Master_switch_ok[1],Master_switch_ok[2])
	--动画动作
	while true do
				--动画动作 这里用是否出attck来判断
			Tools.mSleep_level(500,level)  --随机一个数，随机延迟，造成手指按下和抬起的一个随机性。
			local Skill_Over = Tools.Single_FindColor(true,Battle_confirm_table,2)
			if Skill_Over == true then
				break
			else
				nLog('换人等待中')
			end
		
	end
	if  sw_refresh_flag == 1 and SwitchFlag == 1 then
		lowfunction.RefreshSkillCD(Master_switch_start_glo)
		
		SwitchFlag = 0
		sw_refresh_flag = 0
	end		
end


--用矩形判断敌人数量
function lowfunction.GetTargetNumber()
	
	--Target_Number_site
	local Target_Number = 0
	for k,v in ipairs(Target_Number_site) do
		PointRGB = Tools.Single_ColorRGB(true,v[1],v[2])
		if PointRGB.r > 100 and  PointRGB.r> PointRGB.g and PointRGB.r > PointRGB.b then
		
			
			Target_Number = Target_Number + 1
			nLog("一个敌人存活")
		end
	end
	
	return Target_Number
	
end
--判断敌人数量 如果低于xx 就不释放宝具
function lowfunction.get_Target_number()
	--Target_Number_site 识别敌人数量  67,5},{77,36
	local Target_Number = 0
	local Add_Flag = false
	for k,v in ipairs(Gas_Site) do
		
		c3b = Tools.Single_ColorRGB(false,Gas_Site[k][1],Gas_Site[k][2]); --获取(100,100)的颜色值，赋值给color变量
		
		--检测三种情况 灰色三色差不小于20  黄色r g 大于200 红色
		if c3b.r > 60 and c3b.r < 120 and  c3b.g > 60 and c3b.g < 120 and c3b.b > 60 and c3b.b < 120 then
			Add_Flag = true
		end	
		
		if c3b.r >= 200 and c3b.g >= 200 then
			Add_Flag = true
		end
		
		if c3b.r >= 200 and c3b.g < 100 and c3b.b < 105 then
			Add_Flag = true
		end
	
		
		--每一次检测出之后 进行处理
		if Add_Flag == true then
			nLog("第"..k.."个敌人存活")
			Target_Number = Target_Number + 1
		end
	end
	
	return Target_Number
end



--助战角色数据库 代入编号 返回 职介和 角色名
----呆毛王 小莫 大王 闪闪 水呆毛  孔明 梅林 艳后 杰克 白枪呆 纳尔逊 拉二 船长 奶光 黑狗 黑贞
function lowfunction.Helper_Char_database(charName)
	--目前的队列
	local char_database = {'saber|呆毛王','saber|小莫','saber|大王','archer|闪闪','archer|水呆毛','caster|孔明','caster|梅林','assassin|杀斯卡哈','assassin|杰克','lancer|枪斯卡哈','lancer|迦尔纳','rider|拉二','rider|船长',
		'berserker|奶光','berserker|黑狗','extra|黑贞','lancer|贞德lily','archer|弓凛','rider|黑骑呆','berserker|狂长江','assassin|艳后','caster|水尼禄','rider|R小莫','caster|妖僧','berserker|狂金时','lancer|小恩','caster|C狐','extra|北斋',
		'berserker|BX毛','saber|武藏','saber|冲田总司','saber|花嫁尼禄','archer|阿周那','archer|特斯拉','archer|弓凛','lancer|白枪呆','lancer|枪凛','assassin|山中老人',
		'assassin|酒吞','extra|BB','extra|天草','extra|伯爵','extra|阿比','caster|术尼托','lancer|枪狐','caster|术师匠','lancer|枪奶光'}
	for charKey,charValue in ipairs(char_database) do
		FindRet = string.find(charValue,charName)
		if FindRet ~= nil then
			local ret = Tools.Split(charValue, '|')  
		
			return ret[1],ret[2]
		
		end
	end
	

end


--助战礼装数据库 代入编号 返回 礼装名
--'纯洁绽放','阿尔托莉雅之星','巫女狐','化为红莲的影之国','正射必中'
function lowfunction.Helper_Gift_database(giftName)
	return giftName
	
end


--从者行动命令生成1  准备重写
function lowfunction.make_command1()
	--Skill_op3_func_glo = '0@1@2@3@4@5@6@7@8@12@13@14'
	--表标准格式 stage1_ruler1 = {stage=1,req = "nr",skill = {No=2,Type=1,BaoJu=1,target=1}}
	local Skill_send_table = {}
	local Skill_req = 'nr'
	
	local Baoju_glo = 4
	local BuffChar = 1
	local Skill_op_list = Tools.Split(Skill_op1_func_glo, '@') --为空
	
	
	
	if #check_ret1 == 0 then
		for k,v in ipairs(Skill_op_list) do
			if v == '13' then
				Baoju_glo = 1
			end
			
			if v == '14' then
				Baoju_glo = 2
			end
			
			if v == '15' then
				Baoju_glo = 3
			end
			
			--这里筛选一下v
			if v ~= nil and v~='' then
				--插入操作表规则不同 判断edit的格式
				BuffChar,BaoJuChar,CharNo = lowfunction.GetCharPos(tonumber(v),1)
				local Normal_ruler = {stage = 1,req = Skill_req,skill = {No=tonumber(v),Type=BuffChar,BaoJu=CharNo,target=fire_in_func_1_glo}}
				table.insert(Skill_send_table,Normal_ruler)
				
			end
			
			
		end
		
		
		
	else
		--根据高级自定义表格来插入
		for k,v in ipairs(check_ret1) do
			--这里解析命令方式
			--高级自定义技能释放信息解析
			--SkillInfo ---[1a|ra|13b]  ui层一定要判断格式
			ContentInfo,ContentType = lowfunction.ParsingSkillInfo(v)
			if ContentInfo == '13' then
				Baoju_glo = 1
			end
			
			if ContentInfo == '14' then
				Baoju_glo = 2
			end
			
			if ContentInfo == '15' then
				Baoju_glo = 3
			end
			
			if ContentInfo == 'r' then
				ContentInfo = 10
			end
			
			if ContentInfo == 'c' then
				ContentInfo = 11
			end
			
			if ContentInfo == 'v' then
				ContentInfo = 12
			end
			
			--这里筛选一下v
			if v ~= nil and v~="" then
				--插入操作表规则不同 判断edit的格式
				BuffChar,BaoJuChar,CharNo = lowfunction.GetCharPos(tonumber(ContentInfo),1)
				local Normal_ruler = {stage = 1,req = ContentType,skill = {No=tonumber(ContentInfo),Type=BuffChar,BaoJu=BaoJuChar,target=fire_in_func_1_glo}}
				table.insert(Skill_send_table,Normal_ruler)
				
			end
			
		end
	end
	

	print(Skill_send_table)
	return Skill_send_table

end


function lowfunction.make_command2()
	--表标准格式 stage1_ruler1 = {stage=1,req = "nr",skill = {No=2,Type=1,BaoJu=1,target=1}}
	local Skill_send_table = {}
	local Skill_req = 'nr'
	
	local Baoju_glo = 4
	
	local Skill_op_list = Tools.Split(Skill_op2_func_glo, '@')
	

	if #check_ret2 == 0 then
		for k,v in ipairs(Skill_op_list) do
			
			if v == '13' then
				Baoju_glo = 1
			end
			
			if v == '14' then
				Baoju_glo = 2
			end
			
			if v == '15' then
				Baoju_glo = 3
			end
			
			--这里筛选一下v
			if v ~= nil and v~="" then
				--插入操作表规则不同 判断edit的格式
				BuffChar,BaoJuChar,CharNo = lowfunction.GetCharPos(tonumber(v),2)
				local Normal_ruler = {stage = 2,req = Skill_req,skill = {No=tonumber(v),Type=BuffChar,BaoJu=CharNo,target=fire_in_func_2_glo}}
				table.insert(Skill_send_table,Normal_ruler)
				
			end
			
			
		end
		
		
		
	else
		--根据顺序表来插入
		for k,v in ipairs(check_ret2) do
			ContentInfo,ContentType = lowfunction.ParsingSkillInfo(v)
			if ContentInfo == '13' then
				Baoju_glo = 1
			end
			
			if ContentInfo == '14' then
				Baoju_glo = 2
			end
			
			if ContentInfo == '15' then
				Baoju_glo = 3
			end
			
			if ContentInfo == 'r' then
				ContentInfo = 10
			end
			
			if ContentInfo == 'c' then
				ContentInfo = 11
			end
			
			if ContentInfo == 'v' then
				ContentInfo = 12
			end
			
			--这里筛选一下v
			if v ~= nil and v~="" then
				--插入操作表规则不同 判断edit的格式
				BuffChar,BaoJuChar,CharNo = lowfunction.GetCharPos(tonumber(ContentInfo),2)
				local Normal_ruler = {stage = 2,req = ContentType,skill = {No=tonumber(ContentInfo),Type=BuffChar,BaoJu=BaoJuChar,target=fire_in_func_2_glo}}
				table.insert(Skill_send_table,Normal_ruler)
				
			end
			
		end
	end
	

	return Skill_send_table
end


function lowfunction.make_command3()
	--表标准格式 stage1_ruler1 = {stage=1,req = "nr",skill = {No=2,Type=1,BaoJu=1,target=1}}
	local Skill_send_table = {}
	local Skill_req = 'nr'
	
	local Baoju_glo = 4
	
	local Skill_op_list = Tools.Split(Skill_op3_func_glo, '@')
	


	if #check_ret3 == 0 then
		for k,v in ipairs(Skill_op_list) do
			if v == '13' then
				Baoju_glo = 1
			end
			
			if v == '14' then
				Baoju_glo = 2
			end
			
			if v == '15' then
				Baoju_glo = 3
			end
			
			--这里筛选一下v
			if v ~= nil and v~="" then
				--插入操作表规则不同 判断edit的格式
				BuffChar,BaoJuChar,CharNo = lowfunction.GetCharPos(tonumber(v),3)
				local Normal_ruler = {stage = 3,req = Skill_req,skill = {No=tonumber(v),Type=BuffChar,BaoJu=CharNo,target=fire_in_func_3_glo}}
				table.insert(Skill_send_table,Normal_ruler)
				
			end
			
			
		end
		
		
		
	else
		--根据顺序表来插入
		for k,v in ipairs(check_ret3) do
			ContentInfo,ContentType = lowfunction.ParsingSkillInfo(v)
			if ContentInfo == '13' then
				Baoju_glo = 1
			end
			
			if ContentInfo == '14' then
				Baoju_glo = 2
			end
			
			if ContentInfo == '15' then
				Baoju_glo = 3
			end
			
			if ContentInfo == 'r' then
				ContentInfo = 10
			end
			
			if ContentInfo == 'c' then
				ContentInfo = 11
			end
			
			if ContentInfo == 'v' then
				ContentInfo = 12
			end
			
			--这里筛选一下v
			if v ~= nil and v~="" then
				--插入操作表规则不同 判断edit的格式
				BuffChar,BaoJuChar,CharNo = lowfunction.GetCharPos(tonumber(ContentInfo),3)
				local Normal_ruler = {stage = 3,req = ContentType,skill = {No=tonumber(ContentInfo),Type=BuffChar,BaoJu=BaoJuChar,target=fire_in_func_3_glo}}
				table.insert(Skill_send_table,Normal_ruler)
				
			end
			
		end
	end
	
	return Skill_send_table
end


function lowfunction.do_Infinity_pool(timer)


	for i=1,timer,1 do
		Tools.mSleep_level(200,level)  
		Tools.Source_Single_Click(Infinity_pool_point[1],Infinity_pool_point[2])

	end
	
end


--校验技能释放顺序数据
--[新版格式1a,rb,13a]
function lowfunction.check_edit(edit_string)
	--定义原生字符库
	local Source_database = {'1','2','3','4','5','6','7','8','9','r','c','v','13','14','15'}
	local check_num_flag = 0
	--分几种情况，如果为空
	local string_list = {}
	if edit_string == '' then
		--高级技能释放顺序开关 关闭
		nLog("高级技能释放顺序开关 关闭")
		return string_list
	else
		--如果有字符 尝试分割，如果能返回结果则下一步 不能则报错
		string_list = Tools.Split(edit_string, '-')
		if string_list[1] == nil then
			nLog("技能顺序格式有误，请检查")
			dialog("技能顺序格式有误，请检查", 0)
			lua_exit()
			
		else
			--有分割的格式了，那么遍历每一项是否有非法字符
			--判断位数符合2-3 且前缀符合预期 并且后缀字符符合ab
			
			
			for k,v in ipairs(string_list) do
				local strLens = string.len(v)
				local check_num_flag = 0
				--ContentInfo,ContentType = lowfunction.ParsingSkillInfo(v)
				
				for k2,v2 in ipairs(Source_database) do
					if strLens == 2 then
						if string.sub(v,0,1) == v2 then --前缀字符符合预期 并且 后缀字符符合ab  and (ContentType == 97 or ContentType == 98) 
							if string.sub(v,2,2) == 'a' or string.sub(v,2,2) == 'b' then
								--如果找到匹配项则pass
								check_num_flag = 1
							
							end
							
						end
					else
						--3位数
						if string.sub(v,0,2) == v2 then 
							if string.sub(v,3,3) == 'a' or string.sub(v,3,3) == 'b' then
									--如果找到匹配项则pass
									check_num_flag = 1
								
							end
						end
					end
				end
				
				if check_num_flag == 0 then
					nLog("技能顺序编辑有误，请检查")
					dialog("技能顺序编辑有误，请检查", 0)
					lua_exit()
			
				end
				
			end
		end	
	
		
	end
	
	return string_list
end


function lowfunction.Resolution_profile(true_width,true_height)
	local proportion = true_width/true_height
	local profile_flag = 0
	
	
	--根据比例划分
	--1.常规 16：9的屏幕 无须设置即可使用
	if  true_width/true_height > 1.777 and true_width/true_height < 1.779 then
		nLog("当前调用的是16：9的方案")
	

		Act_Env = {  --实体机环境 1080X1920  1080X2340  209  209
		Top = 0,Sub = 0,Left =0 ,Right = 0,
		Width = true_width,
		Height = true_height
		} 
	
		profile_flag = 1
	end
	
	
	--2.18：9的屏幕 开始都要特殊处理
	

	if tostring(true_width/true_height) == '2' then
		nLog("当前调用的是18：9的方案")

		--这里进行分辨率划分
		if true_width == 2160 then
				Act_Env = {  
			Top = 0,Sub = 0,Left =119 ,Right = 119,
			Width = true_width,
			Height = true_height
			} 
		profile_flag = 1
		end
		
		if true_width == 2880 then
			Act_Env = {  
			Top = 0,Sub = 0,Left =159 ,Right = 159,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 1440 then
		
			Act_Env = {  
			Top = 0,Sub = 0,Left =79 ,Right = 79,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
	
	
		
	end
	
	--3.16：10的屏幕 开始都要特殊处理
	if tostring(true_width/true_height) == '1.6' then
		nLog("当前调用的是16：10的方案")
		--这里进行分辨率划分
		if true_width == 1920 then
				Act_Env = {  
			Top = 61,Sub = 61,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
		profile_flag = 1
		end
		
		if true_width == 1280 then
				Act_Env = {  
			Top = 40,Sub = 40,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
		profile_flag = 1
		end
		
		if true_width == 2560 then
				Act_Env = {  
			Top = 81,Sub = 81,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
		profile_flag = 1
		end
		
	end
	
	--4. 5：3 的屏幕
	if tostring(true_width/true_height) == '1.6666666666667' then
		nLog("当前调用的是5：3的方案")
		if true_width == 1280  then
			Act_Env = {  
			Top = 24,Sub =24,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 800  then
			Act_Env = {  
			Top = 15,Sub =15,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 1800  then
			Act_Env = {  --sub 34
			Top = 0,Sub =0,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 1920  then
			Act_Env = {  
			Top = 37,Sub =37,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 2560  then
			Act_Env = {  
			Top = 49,Sub =49,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
	
	end
	
	--5. 4:3的屏幕
	if tostring(true_width/true_height) == '1.3333333333333' then

		nLog("当前调用的是4:3的方案")
		
		if true_width == 1024  then
			Act_Env = {  
			Top = 96,Sub =96,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 2048  then
			Act_Env = {  
			Top = 195,Sub =195,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 2732  then
			Act_Env = {  
			Top = 257,Sub =257,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 2224  then
			Act_Env = {  
			Top = 210,Sub =210,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
		profile_flag = 1		
		end
		
		
	end
	
	--6. 20.5：10的屏幕
	--特殊分辨率1 1480x720  2.0555555555556
	if tostring(true_width/true_height) == '2.0555555555556' then
		nLog("当前调用的是20.5：10的方案")
		if true_width == 1480 then
			
			Act_Env = {  
				Top = 0,Sub =0,Left =99 ,Right = 99,
				Width = true_width,
				Height = true_height
			} 
		profile_flag = 1
		end
		
		if true_width == 2220 then
			
			Act_Env = {  
				Top = 0,Sub =0,Left =149 ,Right = 149,
				Width = true_width,
				Height = true_height
			} 
		profile_flag = 1
		end
		
		if true_width == 2960 then
			
			Act_Env = {  
				Top = 0,Sub =0,Left =199 ,Right = 199,
				Width = true_width,
				Height = true_height
			} 
		profile_flag = 1
		end
		
	end
	
	--7.特殊分辨率开始======
	--特殊分辨率4 1080*2040 1.8888888888889
	if tostring(true_width/true_height) == '1.8888888888889' then
		nLog("当前调用的是18.9：10的方案")
		Act_Env = {  
		Top = 0,Sub =0,Left =59 ,Right = 59,
		Width = true_width,
		Height = true_height
		} 
	
		profile_flag = 1

	end
	
	-- 特殊分辨率7 2280x1080 
	if tostring(true_width/true_height) == '2.1111111111111' then
										
										
		nLog("当前调用的是21.1：10的方案")
		
		--特殊分辨率 720x1520 PBAM00
	
	
		if getSystemProperty('ro.build.product') == 'COL' then
			nLog("当前调用的是COL的方案")
			Act_Env = {  
			Top = 0,Sub =0,Left =172 ,Right = 172,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		else
			
			--通用适配方案
			Act_Env = {  
			Top = 0,Sub =0,Left =119 ,Right = 119,
			Width = true_width,
			Height = true_height
			} 

			profile_flag = 1
		
			
		end
		
		
	

	end
	
	--特殊分辨率5 1312*2560  1.9512195121951
	if tostring(true_width/true_height) == '1.9512195121951' then
		nLog("当前调用的是19.5：10的方案")
		Act_Env = {  
		Top = 0,Sub =0,Left =113 ,Right = 113,
		Width = true_width,
		Height = true_height
		} 
	
	
		profile_flag = 1

	end
	
	--特殊分辨率6 2244x1080 2.0777777777778
	if tostring(true_width/true_height) == '2.0777777777778' then
										
		nLog("当前调用的是20.7：10的方案")
		Act_Env = {  
		Top = 0,Sub =0,Left =161 ,Right = 161,
		Width = true_width,
		Height = true_height
		} 
	
	
		profile_flag = 1

	end
	
	--特殊分辨率 2240x1080
	if tostring(true_width/true_height) == '2.0740740740741' then
		nLog("当前调用的是20.7：10的方案")
		Act_Env = {  
		Top = 0,Sub =0,Left =159 ,Right = 159,
		Width = true_width,
		Height = true_height
		} 
	
		
		profile_flag = 1
	
	
	end
	
	--特殊分辨率 2248x1080
	if tostring(true_width/true_height) == '2.0814814814815' then
		nLog("当前调用的是20.7：10的方案")
		Act_Env = {  
		Top = 0,Sub =0,Left =163 ,Right = 163,
		Width = true_width,
		Height = true_height
		} 
	
		
		profile_flag = 1
	
	
	end
	
	--特殊分辨率 2316x1080
	if tostring(true_width/true_height) == '2.1444444444444' then
		nLog("当前调用的是20.7：10的方案")
		Act_Env = {  
		Top = 0,Sub =0,Left =197 ,Right = 197,
		Width = true_width,
		Height = true_height
		} 
	
		
		profile_flag = 1
	
	
	end
	
	--特殊分辨率 2340x1080
	if tostring(true_width/true_height) == '2.1666666666667' then
		nLog("当前调用的是21.6：10的方案")
		if true_width == 2340 and true_height==1080 then
		
			Act_Env = {  
			Top = 0,Sub =0,Left =209 ,Right = 209,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		
		end
		
		
		--特殊分辨率3120x1440
	
		if true_width == 3120 and true_height == 1440 then
			Act_Env = {  
			Top = 0,Sub =0,Left =279 ,Right = 279,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
	
	end
	
	--特殊分辨率 2242x1080
	
	if tostring(true_width/true_height) == '2.0759259259259' then
		nLog("当前调用的是21.6：10的方案")
		Act_Env = {  
		Top = 0,Sub =0,Left =160 ,Right = 160,
		Width = true_width,
		Height = true_height
		} 
	

		profile_flag = 1
	end
	
	
	
	
	
	--特殊分辨率 2436x1125
	if tostring(true_width/true_height) == '2.1653333333333' then
		nLog("当前调用的是xs的方案")
		Act_Env = {  --
		Top = 0,Sub =0,Left = 217,Right = 217,
		Width = true_width,
		Height = true_height
		} 
	

		profile_flag = 1
	end
	
	--特殊分辨率 828x1792
	if tostring(true_width/true_height) == '2.1642512077295' then
		nLog("当前调用的是xr xs max的方案")
		
		if true_width == 1792 then
			Act_Env = {  
			Top = 0,Sub =0,Left =159 ,Right = 159,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
		if true_width == 2688 then
			Act_Env = {  
			Top = 0,Sub =0,Left =239 ,Right = 239,
			Width = true_width,
			Height = true_height
			} 
	

			profile_flag = 1
		end
	end
	
	--特殊分辨率 640x1136
	if tostring(true_width/true_height) == '1.775' then
		nLog("当前调用的是iphone4的方案")
		
		if true_width == 1136 then
			Act_Env = {  
			Top = 0,Sub =0,Left =0 ,Right = 0,
			Width = true_width,
			Height = true_height
			} 
			profile_flag = 1
		end
		
	

		
	end
	
	--自定义分辨率规划 查看是否勾选 1勾选
	if ResolutionIOGlo  == "是" then 
		--校验分辨率是否符合参数
		if type(TopGlo) == 'number' and type(BottomGlo) == 'number' and type(LeftGlo) == 'number' and type(RightGlo) == 'number' then
			Act_Env = {  
				Top = TopGlo ,Sub =BottomGlo ,Left =LeftGlo  ,Right = RightGlo ,
				Width = true_width,
				Height = true_height
				} 
			nLog(TopGlo..','..BottomGlo..','..LeftGlo..','..RightGlo)
		else
			
			dialog("自定义分辨率参数应该为数字，请检查", 0)
			lua_exit()
		end
		profile_flag = 1
	end
	

	
	if profile_flag == 0 then
		dialog("不支持的分辨率!请截图联系作者添加支持！您当前的分辨率是"..true_width.."x"..true_height, 0)

		lua_exit(); --否则退出脚本


	end
end




--灵基变卖 功能函数组  
--排序按钮 1127,129
--稀有度  1067,230
--决定 855,642
--升降序 1248,137
--贩卖决定 1154,672
--销毁 845,587
--关闭639,585

--亮度公式：(max(r,g,b)+min(r,g,b))/2 
--如果L（亮度）<100 那么就跳过 >100 判断条件是否吃
function lowfunction.Sale(Max_timer,Lock)
	local NewLightRGB = {}
	local LightRGB = {}
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Sort_point[1],Sort_point[2])
	
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(Rare_point[1],Rare_point[2])
	
	Tools.mSleep_level(1000,level)
	Tools.Source_Single_Click(OK_point[1],OK_point[2])
	
	--检测是否是升序 如果不是则点击升降按钮
	Tools.mSleep_level(1000,level)
	local UpDown_ret = lowfunction.UpDown_comfirm()
	if UpDown_ret ~= 1 then
		Tools.mSleep_level(1000,level)
		Tools.Source_Single_Click(UpDown_point[1],UpDown_point[2])
	end
	Tools.mSleep_level(1500,level)
	--总轮数 
	for Start_timer = 1,Max_timer,1 do
		
		for Get_Exp_timer=0,2,1 do
				--筛选完毕 不检测交给玩家自己选择 138 142
				--默认sort从小到大排序
			for i=0,6,1 do
				Tools.mSleep_level(200,level)
				--检测亮度  {r=color_r,g=color_g,b=color_b}
				LightRGB = Tools.Single_ColorRGB(true,Scaner_for_point[1] + i*133,Scaner_for_point[2] + Get_Exp_timer*142)
				for k,v in pairs(LightRGB) do
					table.insert(NewLightRGB,v)
				
				end
				table.sort(NewLightRGB) -- 默认由小到大
				
				
				--计算公式 亮度公式：(max(r,g,b)+max2(r,g,b))/2 
				Light = (NewLightRGB[3] + NewLightRGB[2])/2
				nLog("当前的点"..tostring(Scaner_for_point[1] + i*133)..","..tostring(Scaner_for_point[2] + Get_Exp_timer*142).."当前的亮度"..tostring(Light))
				NewLightRGB = {}
				LightRGB = {}
				--开关 是否开启亮度判断 开启后则三星以下 全部清除，没开则all清除 注意加锁
				if Lock == true then
					if Light > 100  then
						Tools.mSleep_level(200,level)
						Tools.Source_Single_Click(Scaner_for_point[1] + i*133,Scaner_for_point[2] + Get_Exp_timer*142)
					else
						--跳过
					end
				
				else -- 没加锁
					Tools.mSleep_level(200,level)
					Tools.Source_Single_Click(Scaner_for_point[1] + i*133,Scaner_for_point[2] + Get_Exp_timer*142)
				end

			end
			

		
		end
		
		
		
		--决定贩卖
		Tools.mSleep_level(1000,level)
		Tools.Source_Single_Click(Sale_point[1],Sale_point[2])
		
		--销毁
		Tools.mSleep_level(1000,level)
		Tools.Source_Single_Click(Destruction_point[1],Destruction_point[2])
		
		--关闭按钮Close_point
		Tools.mSleep_level(3000,level)
		Tools.Source_Single_Click(Close_point[1],Close_point[2])
		
		
		
	end
	
	
end


--判断升降序按钮
function lowfunction.UpDown_comfirm()
	local result
	local ret = Tools.Single_FindColor(true,Up_table,2)
	if ret == true then
		nLog('是升序按钮')
		result = 1 
		
	else
		nLog('是降序按钮')
		result = 0
	end
	
	return result
end


--多套配置文件切换
-- 带入配置编号
function lowfunction.MultConfigSwap()
	
end

--获取当前脚本配置参数
function lowfunction.GetCurrentConfigName()
nLog('此时的ui名'..RootView.config)
	return RootView.config

end

--判断配置文件是否变动
function lowfunction.ConfigIsChange()
	local configName = ''
	local NowNumber = 0
	--1.获取用户当前选取的配置参数
	
	if config_func_glo == 0 then
		configName = '配置一.dat'
		NowNumber = 0
	end
	
	if config_func_glo == 1 then
		configName = '配置二.dat'
		NowNumber = 1
	end
	
	if config_func_glo == 2 then
		configName = '配置三.dat'
		NowNumber = 2
	end
	
	if config_func_glo == 3 then
		configName = '配置四.dat'
		NowNumber = 3
	end
	
	if config_func_glo == 4 then
		configName = '配置五.dat'
		NowNumber = 4
	end
	
	if configName ~= RootView.config then
	
		nLog('配置文件已变动') --如果变动则返回变动的参数配置
		return configName,NowNumber
	else
		nLog('配置文件未变动')
		return false
	end
end

--哪一个target_pos气槽红了 则报警
function lowfunction.GetGas(Target_Pos)
	
	color_table = Tools.Single_ColorRGB(true,Gas_Site[Target_Pos][1],Gas_Site[Target_Pos][2])
	nLog(tostring(color_table.r)..","..tostring(color_table.g)..","..tostring(color_table.b))
	if color_table.r > 240 and color_table.g < 150 then
		
		nLog('检测对象已满危险！')
			
		return Target_Pos
	else
		nLog('还没充满气槽')
		return false
	end
	

end


--预警规则写入 预警规则高于一切 所以这里只需要获取技能编号造出符合skill_do参数的
function lowfunction.preSkill_do(pre_stage,buff_glo,target_glo)
	--表标准格式 stage1_ruler1 = {stage=1,req = "nr",skill = {No=2,Type=1,BaoJu=1,target=1}}
	local Skill_send_table = {}
	local Skill_req = 'nr'
	
	local Baoju_glo = 4
	
	--这里要ui层获取技能参数

	local preSkill_list = Tools.Split(preGroup_func_glo, '@')
	
	for pre_k,pre_v in ipairs(preSkill_list) do
	
		if pre_v ~=nil and pre_v ~='' then --参数合法
			BuffChar,BaoJuChar,CharNo = lowfunction.GetCharPos(tonumber(pre_v+1),1)
			pre_ruler = {stage = pre_stage,req = Skill_req,skill = {No=tonumber(pre_v+1),Type=buff_glo,BaoJu=Baoju_glo,target=target_glo}}
			
			table.insert(Skill_send_table,pre_ruler)
		end
	end
	
	

	return Skill_send_table

end


--高级自定义技能释放信息解析
--SkillInfo ---[1a|13]
function lowfunction.ParsingSkillInfo(SkillInfo)
	--判断信息位数
	if(string.len(SkillInfo) == 2) then
		
		local NewInfo = string.sub(SkillInfo,0,1)
		local NewType = string.byte(SkillInfo,2)  --a=97 b=98

		if NewType == 97 then
			NewType = 'nr'
			return tostring(NewInfo),NewType
		end
		
		if NewType == 98 then
			NewType = 'np'
			return tostring(NewInfo),NewType
		end
		
		return tostring(NewInfo),NewType
	else --位数是3
		local NewInfo = string.sub(SkillInfo,0,2)
		local NewType = string.byte(SkillInfo,3)  --a=97 b=98
		if NewType == 97 then
			NewType = 'nr'
			return tostring(NewInfo),NewType
		end
		
		if NewType == 98 then
			NewType = 'np'
			return tostring(NewInfo),NewType
		end
		
		return tostring(NewInfo),NewType
	end


	
end

--根据技能编号返回对应角色编号
function lowfunction.GetCharNo(SkillNo)
	local retNo = 4
	if SkillNo == 1 or SkillNo == 2 or SkillNo == 3 then
		return 1
	end

	if SkillNo == 4 or SkillNo == 5 or SkillNo == 6 then
		return 2
	end
	
	if SkillNo == 7 or SkillNo == 8 or SkillNo == 9 then
		return 3
	end
	
	return retNo
end



function lowfunction.GetCharPos(SkillNo,Side)
--==============================================================
	--Type 1：主-副-辅 2：主-辅-辅 3：副-副-副
	--这里进行解析
	--问题：辅助手可能技能会给副攻
	local BuffChar = 1
	local BaoJuChar = 1
	
	local CharNo = lowfunction.GetCharNo(SkillNo) --获取当前角色编号
	
	
	
	if Side == 1 then
		local LocationTable = {LeftLocation1_glo,MidLocation1_glo,RightLocation1_glo}
	
		for key,value in ipairs(LocationTable) do
			if value == "主攻手" then --找到主攻手 获取其编号  1主攻 2 副攻 3 辅助
				BuffChar = key
				BaoJuChar = key
			end
			
			if value == "副攻手" then --找到副攻
				if key == CharNo then
					BuffChar = key  --找到本命条件2
				else
					--找到主攻手绑定buff
					for InnerKey,InnerValue in ipairs(LocationTable) do
						if InnerValue == 1 then
							BuffChar = InnerKey
						end
					end
				end
				
				--找到主攻手绑定宝具
				for InnerKey,InnerValue in ipairs(LocationTable) do
					if InnerValue == 1 then
						BaoJuChar = InnerKey
					end
				end
				
			end
			
			if value == "辅助手" then --找到辅助
				for InnerKey,InnerValue in ipairs(LocationTable) do
					if InnerValue == 1 then
						BuffChar = InnerKey
						BaoJuChar = InnerKey
					end
				end
			end
		end
		
		if CharNo == 4  then --御主技能
			local LocationTable = {LeftLocation1_glo,MidLocation1_glo,RightLocation1_glo}
			for key,value in ipairs(LocationTable) do
				if value == 1 then --找到主攻手 获取其编号  1主攻 2 副攻 3 辅助
					BuffChar = key
					BaoJuChar = key
				end
			end
			return BuffChar,BaoJuChar,CharNo
		end
	end
	
	
	if Side == 2 then
		local LocationTable = {LeftLocation2_glo,MidLocation2_glo,RightLocation2_glo}
			-- LeftLocation1_glo MidLocation1_glo RightLocation1_glo 联动决定buffchar给谁
		for key,value in ipairs(LocationTable) do
			if value == "主攻手" then --找到主攻手 获取其编号
				BuffChar = key
				BaoJuChar = key
			end
			
			if value == "副攻手" then --找到副攻
				if key == CharNo then
					BuffChar = key  --找到本命条件2
				else
					--找到主攻手绑定buff
					for InnerKey,InnerValue in ipairs(LocationTable) do
						if InnerValue == "主攻手" then
							BuffChar = InnerKey
						end
					end
				end
				--找到主攻手绑定宝具
				for InnerKey,InnerValue in ipairs(LocationTable) do
					if InnerValue == "主攻手" then
						BaoJuChar = InnerKey
					end
				end
				
			end
			
			if value == "辅助手" then --找到辅助
				for InnerKey,InnerValue in ipairs(LocationTable) do
					if InnerValue == "主攻手" then
						BuffChar = InnerKey
						BaoJuChar = InnerKey
					end
				end
			end
		end
		if CharNo == 4  then --御主技能
			local LocationTable = {LeftLocation2_glo,MidLocation2_glo,RightLocation2_glo}
			for key,value in ipairs(LocationTable) do
				if value == 1 then --找到主攻手 获取其编号  1主攻 2 副攻 3 辅助
					BuffChar = key
					BaoJuChar = key
				end
			end
			return BuffChar,BaoJuChar,CharNo
		end
	
	end
	
	
	
	if Side == 3 then
		local LocationTable = {LeftLocation3_glo,MidLocation3_glo,RightLocation3_glo}
			-- LeftLocation1_glo MidLocation1_glo RightLocation1_glo 联动决定buffchar给谁
		for key,value in ipairs(LocationTable) do
			if value == "主攻手" then --找到主攻手 获取其编号
				BuffChar = key
				BaoJuChar = key
			end
			
			if value == "副攻手" then --找到副攻
				if key == CharNo then
					BuffChar = key  --找到本命条件2
				else
					--找到主攻手绑定buff
					for InnerKey,InnerValue in ipairs(LocationTable) do
						if InnerValue == "主攻手" then
							BuffChar = InnerKey
						end
					end
				end
				--找到主攻手绑定宝具
				for InnerKey,InnerValue in ipairs(LocationTable) do
					if InnerValue == "主攻手" then
						BaoJuChar = InnerKey
					end
				end
				
			end
			
			if value == "辅助手" then --找到辅助
				for InnerKey,InnerValue in ipairs(LocationTable) do
					if InnerValue == "主攻手" then
						BuffChar = InnerKey
						BaoJuChar = InnerKey
					end
				end
			end
		end
		if CharNo == 4  then --御主技能
			local LocationTable = {LeftLocation3_glo,MidLocation3_glo,RightLocation3_glo}
			for key,value in ipairs(LocationTable) do
				if value == 1 then --找到主攻手 获取其编号  1主攻 2 副攻 3 辅助
					BuffChar = key
					BaoJuChar = key
				end
			end
			return BuffChar,BaoJuChar,CharNo
		end
	end
	
	
	
		
	
	

	return BuffChar,BaoJuChar,CharNo
end


--判断发牌界面是否结束  PutCardTable
function lowfunction.DoPutCardOver()
	Tools.mSleep_level(5000,level) --延迟5秒
	ret = Tools.Single_FindColor(true,PutCardTable,2)
	if ret == true then
		--5秒后还检测到发牌界面。则调用系统自动发牌操作
		--如果没检测到下一步按钮则 做一次发牌卡屏操作
		--直接点一排发牌 
		--防止卡发
		nLog('防止卡发牌')
		for k,v in ipairs(PutCardLagTable) do
		
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(PutCardLagTable[k][1],PutCardLagTable[k][2])
		end

	end
end


--获取当前角色人物特征点 和上次的特征组进行比对 返回改变结果
function lowfunction.GetCurrentCharAttribute()
	--CharacterFlag   CharacterTable
	local InnerCharAttribute = {}
	--如果有换人礼装 获取信号标识
	 
	if SwitchFlag == 0 and sw_refresh_flag == 0 then
		--遍历三次获取每个角色的特征数据
		for CurChar=1,3,1 do 
			--如果激活这个界面则跳过专属编号  取两个色加强获取特征
			if Master_switch_start_glo ~= CurChar then
				Tools.mSleep_level(100,level)
				color = Tools.Single_ColorStr(true,CharacterFlag[CurChar][1],CharacterFlag[CurChar][2])
				
				--比对
				nLog(color..'='..CharacterTable[CurChar])
				if math.abs(CharacterTable[CurChar] - color) >= 201586 and color~= 16777215 and color ~= 0 then --添加一个去除杂色的条件 16777215 -ffffff 0
					
					nLog('角色发生改变~重新采集技能数据')
					CharacterTable[CurChar] = color
					for i=CurChar*3-2,CurChar*3,1 do
						Tools.mSleep_level(50,level)
						color = Tools.Single_ColorStr(false,Skill_Site[i][1],Skill_Site[i][2])
						--table.insert(Skill_Attribute,color)
						--替换到总表里 Skill_colors
						nLog("刷新技能"..color.."替换掉"..Skill_colors[i])
						Skill_colors[i] = color
					end
					--将新的特征码存储到角色特征中
				else
					
					nLog('角色未发生改变~'..color)
					
				end
			else
				--角色相同则不做刷新操作
			end
				
		end
	else
		--遍历三次获取每个角色的特征数据
		local CharColorTable = {}
		local SameChar = 0
		for CurChar=1,3,1 do
			color = Tools.Single_ColorStr(true,CharacterFlag[CurChar][1],CharacterFlag[CurChar][2])
			table.insert(CharColorTable,color)
		end
		
		if CharColorTable[1] == CharColorTable[2] and CharColorTable[1] == CharColorTable[3] then
			SameChar = 1
		end
		for CurChar=1,3,1 do 
			--如果激活这个界面则跳过专属编号
		
			color = Tools.Single_ColorStr(false,CharacterFlag[CurChar][1],CharacterFlag[CurChar][2])
			--比对
			nLog(color..'='..CharacterTable[CurChar])
			if math.abs(CharacterTable[CurChar] - color) >= 201586 and color~= 16777215 and color ~= 0 and SameChar == 0 then --添加一个去除杂色的条件 16777215 -ffffff 0
				
				--添加一个预备修改动作
				
			
				nLog('角色发生改变~重新采集技能数据')
				CharacterTable[CurChar] = color
				for i=CurChar*3-2,CurChar*3,1 do
					Tools.mSleep_level(50,level)
					color = Tools.Single_ColorStr(false,Skill_Site[i][1],Skill_Site[i][2])
					--table.insert(Skill_Attribute,color)
					--替换到总表里 Skill_colors
					nLog("刷新技能"..color.."替换掉"..Skill_colors[i])
					Skill_colors[i] = color
				end
				--将新的特征码存储到角色特征中
		
				
				
			else
				
				nLog('角色未发生改变~'..color)
				
			end
		
				
		end
	end

			
end

--友情池抽取
function lowfunction.GetFriendShip(MaxTimer) --edit1_glo
	
	
	for Timer = 1 , MaxTimer,1 do
		Tools.mSleep_level(1000,level)
		
		--FirstPoint 每日免费点击按钮
	
		
		Tools.mSleep_level(500,level)
		Tools.Source_Single_Click(NormalFriendshipPoint[1],NormalFriendshipPoint[2])
	
		
		--ConfirmGetPoint 确定召唤
		Tools.mSleep_level(500,level)
		Tools.Source_Single_Click(ConfirmGetPoint[1],ConfirmGetPoint[2])
		--等3秒 检测结算界面
		--SummonOverTable
		
		while true do
			Tools.mSleep_level(300,level)
			ret = Tools.Single_FindColor(true,SummonOverTable,1)
			if ret == true then
				nLog('获取结算界面')
				break
			else  
				Tools.Source_Single_Click(Battle_Over_Point[1],Battle_Over_Point[2])
			end
		end
		--点击召唤  SummonPoint
		Tools.mSleep_level(1000,level)
		Tools.Source_Single_Click(SummonPoint[1],SummonPoint[2])
	end

end

--识别满破礼装 带入找到的基准点 xy
function lowfunction.CheckGiftFullLv(BaseXY)
	--构筑 变量型表组
	--[[
	三色兼备 = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={2,168,1277,717},
	{x=56,y=326,color=0x9eeba6,offset=0x101010},
	{x=166,y=335,color=0xeff191,offset=0x101010},
	{x=177,y=323,color=0xee6633,offset=0x101010}
	},
	]]--
	local BaseTable = {
	Anchor="Middle",MainPoint={x=640,y=360},
	Area={BaseXY.x-130,BaseXY.y-44,BaseXY.x+150,BaseXY.y+44},
		{x=192,y=555,color=0xffff56,offset=0x101010}
	}
	GiftRet = Tools.Single_FindColor(false,BaseTable,8)
	return GiftRet
	
end


--识别是否需要添加好友
function lowfunction.CheckFriend()
	
	Ret = lowfunction.MultInterfaceFriendAndMain()
     
    
	if Ret == 2 then
		nLog("【未进入申请好友界面】")
		return false
	else
		nLog("【进入申请好友界面】")
		return true
	end

	


end



--自动剧情模块-========================
function lowfunction.SearchMap()
	--判断是否还在房间内
	toast('动态扫描中...')
	nLog('动态扫描中...')
	while true do
		Tools.mSleep_level(500,level)
		Ret = lowfunction.DynamicScanning(PreGray)
		if Ret == 0 then
			nLog("【未匹配到主线房间】")
			dialog("【未匹配到主线房间】,将下一个游标拖拽到中间位置",0)
		else
			return Ret
		end
	end
	
	

end

--找主线room特征
function lowfunction.GetStoryRoom()
	--StoryRoomTable
	for i=1,3,1 do
		Tools.mSleep_level(2000,level)
		local ret = Tools.Single_FindColor_Site(true,StoryRoomTable,2)
		if ret~= false then
			
			nLog("【主线room界面】")
			Tools.mSleep_level(1000,level)
			Tools.Source_Single_Click(ret.x,ret.y)
			return true
		else
			
			nLog("【未进入主线room界面】")
			
		end
		
	end
	return false
end



--动态扫描  用多点匹配来找大概位置
function lowfunction.DynamicScanning(PrePoint)
	
	local AfterPointColorInfo = 0
	local AfterGray = 0
	SourcePoint = {1206,100}
	--记录一个原始点
	mSleep(500)
	local SourcePointColorInfo = Tools.Single_ColorRGB(true,SourcePoint[1],SourcePoint[2])
	
	local SourceGray = (SourcePointColorInfo.r*299 + SourcePointColorInfo.g*587 + SourcePointColorInfo.b*114 + 500) / 1000
	if math.abs(PrePoint - SourceGray) <= 2 then
		--说明是房间模式
		return PrePoint
		
	else
		while true do
			--NextStroyTable
			mSleep(500)
			
			RetTableX,RetTableY = Tools.Mult_FindColor_Site(true,NextStroyTable,15)
		
			mSleep(3000)
			
			if RetTableX~= -1 and RetTableY~=-1 then
				
				--点完所有可能得点
				Tools.mSleep_level(100,level)
				Tools.Source_Single_Click(RetTableX+20,RetTableY+60)
		
				--查看房间是否变黑
				Tools.mSleep_level(500,level)
				AfterPointColorInfo = Tools.Single_ColorRGB(true,SourcePoint[1],SourcePoint[2])
				AfterGray = (AfterPointColorInfo.r*299 + AfterPointColorInfo.g*587 + AfterPointColorInfo.b*114 + 500) / 1000
				nLog("AfterGray:"..tostring(AfterGray)..",".."SourceGray:"..tostring(SourceGray))
				if math.abs(SourceGray - AfterGray) >= 2 then
					toast("已经激活房间！")
					nLog("已经激活房间！")
					return AfterGray
				end
			else
				nLog("还未找到房间奥~"..tostring(#RetTable))
			end
	
		end
	
	end
	
end

function lowfunction.MultInterfaceCheck()
	--两个界面的基准色

	APRechargeBaseColorStr = 15724535
	if ServerTypeGlo == '台服' then
		HelperBaseColorStr = 1982287
	else
		HelperBaseColorStr = 3164505
	end
	HelperBaseColorStr2 = 1916494
	MultInterfaceCheckPoint={1014,383}
	
	BaseColorStr = Tools.Single_ColorStr(true,MultInterfaceCheckPoint[1],MultInterfaceCheckPoint[2])
	
	--进行比对
	HleperDiff = math.abs(BaseColorStr-HelperBaseColorStr)
	APRDiff = math.abs(BaseColorStr-APRechargeBaseColorStr)
	nLog("BaseColorStr:"..tostring(BaseColorStr)..",".."HleperDiff:"..tostring(HleperDiff)..",".."APRDiff:"..tostring(APRDiff))
	if  APRDiff< 1000000 and HleperDiff > APRDiff then --助战偏大说明是ap界面
		nLog("AP补充界面")
		return 2
	elseif HleperDiff < 1000000 and HleperDiff < APRDiff then --AP偏大 说明是助战
		nLog("助战界面")
		return 1
	else
		nLog("没找到开始改变特征")
		--不符合的话 调换base参数再试一次
		HleperDiff2 = math.abs(BaseColorStr-HelperBaseColorStr2)
		nLog("BaseColorStr:"..tostring(BaseColorStr)..",".."HleperDiff2:"..tostring(HleperDiff2)..",".."APRDiff:"..tostring(APRDiff))
		if  APRDiff < 1000000 and HleperDiff2 > APRDiff then --助战偏大说明是ap界面
			nLog("AP补充界面")
			return 2
		elseif HleperDiff2 < 1000000 and HleperDiff2 < APRDiff then --AP偏大 说明是助战
			nLog("助战界面")
			return 1
		end
		
		
		return false
	end

end

function lowfunction.MultInterfaceFriendAndMain()
	--两个界面的基准色
	FriendBaseColorStr = 6123398
	MainBaseColorStr = 14013653
	MultInterfaceCheckPoint = {65,39}
	
	
	BaseColorStr = Tools.Single_ColorStr(true,MultInterfaceCheckPoint[1],MultInterfaceCheckPoint[2])
	
	--进行比对
	FriendDiff = math.abs(BaseColorStr-FriendBaseColorStr)
	MainDiff = math.abs(BaseColorStr-MainBaseColorStr)
	nLog("BaseColorStr:"..tostring(BaseColorStr)..",".."FriendDiff:"..tostring(FriendDiff)..",".."MainDiff:"..tostring(MainDiff))
	if  MainDiff< 1000000 and FriendDiff > MainDiff then --助战偏大说明是ap界面
		nLog("主界面")
		return 2
	elseif FriendDiff < 1000000 and FriendDiff < MainDiff then --AP偏大 说明是助战
		nLog("好友界面")
		return 1
	else
		
		
		return false
	end

end

--==================================
