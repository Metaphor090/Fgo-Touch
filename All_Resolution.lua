--导入这套算法 需要三套图色进行 也就是说我需要做3套数据 基本上覆盖所有分辨率情况
--1 .需要坐标点 + 开发分辨率

All_Resolution = {}


--总的转换函数 开发环境点和表数据 放到这里来进行统一转换 
function All_Resolution.DevToProduction(Data_Table)
	
	--初始化一些转换参数
	local RealSite = {x=-1,y=-1}
	-- 获取到正确的缩放比例
	--1.获取到实际的开发分辨率
	DevResolutionX = Dev_Env.Width-Dev_Env.Left-Dev_Env.Right
	DevResolutionY = Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub
	--2.获取到正确的实体机分辨率
	ActResolutionX = Act_Env.Width-Act_Env.Left-Act_Env.Right
	ActResolutionY = Act_Env.Height-Act_Env.Top-Act_Env.Sub
	
	--if Act_Env.Left ~= 0 then
	--	AppurtenantScaleMode=Act_Env.Height/Dev_Env.Height  --开发转实际缩放比例
	--else
	--	AppurtenantScaleMode=Act_Env.Width/Dev_Env.Width  --开发转实际缩放比例
	--end
	AppurtenantScaleMode = ActResolutionX/DevResolutionX
	
	
	--将原表复制一份 进行操作 最后销毁即可
	local Copy_Data_Table = Tools.TableCopy(Data_Table)
	--=====================
	
	Table_Len = Tools.getTblLen(Copy_Data_Table)
	if Table_Len == 2  then --坐标组
		
		--将Data_Table 取出来  
		
		--因为这个游戏没有锚点所以可以直接上缩放算法
		
		--算出具体位置 排除干扰位置 
		RealSite.x=(Copy_Data_Table[1]-Dev_Env.Left)*AppurtenantScaleMode+Act_Env.Left
		RealSite.y=(Copy_Data_Table[2]-Dev_Env.Top)*AppurtenantScaleMode+Act_Env.Top
		
		--锚点算法=========================================
		--[[
			local RealSite = All_Resolution.三图色找点算法( 
			Data_Table[1]+Dev_Env.Left,Data_Table[2]+Dev_Env.Top,
			Data_Table[1]+Dev_Env.Left,Data_Table[2]+Dev_Env.Top,
			Data_Table[1]+Dev_Env.Left,Data_Table[2]+Dev_Env.Top,
			Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
			Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
			Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
			Act_Env.Width-Act_Env.Left-Act_Env.Right,Act_Env.Height-Act_Env.Top-Act_Env.Sub
			)
		]]--
		
		--==================================================
		
		return RealSite
	else --表格数据
			--[[
				local RealSite = All_Resolution.三图色找点算法(  
				Data_Table.MainPoint.x+Dev_Env.Left,Data_Table.MainPoint.y+Dev_Env.Top,
				Data_Table.MainPoint.x+Dev_Env.Left,Data_Table.MainPoint.y+Dev_Env.Top,
				Data_Table.MainPoint.x+Dev_Env.Left,Data_Table.MainPoint.y+Dev_Env.Top,
				Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
				Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
				Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
				Act_Env.Width-Act_Env.Left-Act_Env.Right,Act_Env.Height-Act_Env.Top-Act_Env.Sub
				)
			
			]]--
			--缩放算法
			
			RealSite.x=(Copy_Data_Table.MainPoint.x-Dev_Env.Left)*AppurtenantScaleMode+Act_Env.Left
			RealSite.y=(Copy_Data_Table.MainPoint.y-Dev_Env.Top)*AppurtenantScaleMode+Act_Env.Top
			Copy_Data_Table.MainPoint.x = RealSite.x
			Copy_Data_Table.MainPoint.y = RealSite.y
	
			--=========================
			
			--Area转化=================
			
			--[[
				local True_Table = {}
				local Pre_Table = {{x=Data_Table.Area[1]+Dev_Env.Left,y=Data_Table.Area[2]+Dev_Env.Top},{x=Data_Table.Area[3]+Dev_Env.Left,y=Data_Table.Area[4]+Dev_Env.Top}}
				for PreKey,PreValue in ipairs(Pre_Table) do
					--转换
					local RealSite = All_Resolution.三图色找点算法(
						PreValue.x,PreValue.y,
						PreValue.x,PreValue.y,
						PreValue.x,PreValue.y,
						Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
						Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
						Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
						Act_Env.Width-Act_Env.Left-Act_Env.Right,Act_Env.Height-Act_Env.Top-Act_Env.Sub
					)
					table.insert(True_Table,RealSite.x)
					table.insert(True_Table,RealSite.y)
				end
			]]--
			
			
			local True_Table = All_Resolution.缩放Area(Copy_Data_Table.Area)
			
			Copy_Data_Table.Area = True_Table
			--==============================
			
			--number转化==============================
				--{x=30,y=42,color=0x0d0d1d,offset=0x101010},
				--转换
				
			--[[
				for key,value in ipairs(Data_Table)	do
					
					local RealSite = All_Resolution.三图色找点算法(
						value.x+Dev_Env.Left,value.y+Dev_Env.Top,
						value.x+Dev_Env.Left,value.y+Dev_Env.Top,
						value.x+Dev_Env.Left,value.y+Dev_Env.Top,
						Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
						Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
						Dev_Env.Width-Dev_Env.Left-Dev_Env.Right,Dev_Env.Height-Dev_Env.Top-Dev_Env.Sub,
						Act_Env.Width-Act_Env.Left-Act_Env.Right,Act_Env.Height-Act_Env.Top-Act_Env.Sub
					)
					Data_Table[key].x = RealSite.x
					Data_Table[key].y = RealSite.y
					--每一次循环初始化变量
				
			end
			
			]]--
			for key,value in ipairs(Copy_Data_Table)	do
			
				--缩放算法
				RealSite.x=(value.x-Dev_Env.Left)*AppurtenantScaleMode+Act_Env.Left
				RealSite.y=(value.y-Dev_Env.Top)*AppurtenantScaleMode+Act_Env.Top
				Copy_Data_Table[key].x = RealSite.x
				Copy_Data_Table[key].y = RealSite.y
			end
		
			--==========================================
		
			return Copy_Data_Table
	end
	
end

function All_Resolution.缩放Area(Area)  --缩放Area
	Area[1]=(Area[1]-Dev_Env.Left)*AppurtenantScaleMode+Act_Env.Left
	Area[3]=(Area[3]-Dev_Env.Left)*AppurtenantScaleMode+Act_Env.Left
	Area[2]=(Area[2]-Dev_Env.Top)*AppurtenantScaleMode+Act_Env.Top
	Area[4]=(Area[4]-Dev_Env.Top)*AppurtenantScaleMode+Act_Env.Top
	local width=Area[3]-Area[1]
	local height=Area[4]-Area[2]
	return  {Area[1],Area[2],Area[3],Area[4]}
end



function All_Resolution.锚点计算公式(x1,y1,x2,y2,x3,y3,a1,b1,a2,b2,a3,b3)
	local s =-(b1*x2*y3 - b1*x3*y2 - b2*x1*y3 + b2*x3*y1 + b3*x1*y2 - b3*x2*y1)/(a1*b2*y3 - a1*b3*y2 - a2*b1*y3 + a2*b3*y1 + a3*b1*y2 - a3*b2*y1);
	local t =-(a1*x2*y3 - a1*x3*y2 - a2*x1*y3 + a2*x3*y1 + a3*x1*y2 - a3*x2*y1)/(a1*b2*x3 - a1*b3*x2 - a2*b1*x3 + a2*b3*x1 + a3*b1*x2 - a3*b2*x1);
	--(s,t)表示锚点位置，且s，t均在(0,1)之间
	--sysLog('计算锚点的位置：'..s..','..t);
	local ret1 = Tools.isnan(s)
	local ret2 = Tools.isnan(t)
	if ret1 == true or ret2 ==  true then
		s = x1
		t = y1
	end
	type(s)
	
	return s,t
end

function All_Resolution.三图色找点算法(x1,y1,x2,y2,x3,y3,a1,b1,a2,b2,a3,b3,运行分辨率宽,运行分辨率高)
	--计算锚点位置
	s,t = All_Resolution.锚点计算公式(x1,y1,x2,y2,x3,y3,a1,b1,a2,b2,a3,b3)
	--有了锚点之后，怎么去适配呢？
	--计算宽高比
	--计算不同分辨率下的锚点的位置
	A1 = a1 * s;
	B1 = b1 * t;
	A2 = a2 * s;
	B2 = b2 * t;
	宽的占比11 = (x1 - A1)/a1;
	高的占比12 = (y1 - B1)/b1;
	宽的占比21 = (x2 - A2)/a2;
	高的占比22 = (y2 - B2)/b2;
	宽高比 = (x1 - A1)/(y1 - B1)
	--计算宽和高最大能填充到什么程度
	if math.abs(宽的占比11) > math.abs(宽的占比21) then
		宽的占比 = 宽的占比11
	else
		宽的占比 = 宽的占比21
	end
	if 	math.abs(高的占比12) > math.abs(高的占比22) then
		高的占比 = 高的占比12
	else
		高的占比 = 高的占比22
	end
	--给定一个分辨率下，坐标点位置计算
	width,height = 运行分辨率宽,运行分辨率高;
	理论宽 = width * 宽的占比;
	理论高 = height * 高的占比;
	理论宽高比 = 理论宽/理论高
	if math.abs(理论宽高比) > math.abs(宽高比) then
		实际高 = 理论高;
		实际宽 = 理论高 * 宽高比
	else
		实际宽 = 理论宽
		实际高 = 理论宽/宽高比;
	end
	新的锚点坐标X = width * s;
	新的锚点坐标Y = height * t;
	X_site =  新的锚点坐标X + 实际宽;
	Y_site =  新的锚点坐标Y + 实际高;
	return {x = X_site,y = Y_site}; --这个x，y是
end