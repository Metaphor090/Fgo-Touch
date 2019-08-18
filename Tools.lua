require 'All_Resolution'
require("TSLib")
Tools = {}



--截图
function Tools.SingleSnapshot()
	current_time = os.date("%Y-%m-%d", os.time()); --以时间戳命名进行截图
	w,h = getScreenSize();
	-- 右下角顶点坐标最大为 (宽度最大值 - 1，高度最大值 - 1)
	snapshot(current_time..".png", 0, 0, w-1, h-1);
	--dialog("识别失败！将这个路径的图片发送给作者！"..userPath()..current_time..".png", time)
end

function Tools.检测静止()
	local gc
	local js=0
	local ww,hh
	local w, h= getScreenSize() --获取设备分辨率
	if w>h then ww=w hh=h else ww=h hh=w end
	
		if oc==nil then
                oc={ --检测屏幕是否静止
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                        {0,0,0,0,0,0,0,0,0,0},
                } 
                
        end
        keepScreen(true)
        setScreenScale(w,h,0)
        for i=1,10 do
          for j=1,10 do
			 -- ss=ss+1
			  gc=getColor(i*math.ceil(ww/11),j*math.ceil(hh/11))
				if oc[i][j]==gc then
				  js=js+1
				end
				oc[i][j]=gc
			end
        end
        keepScreen(false)
        sysLog('屏幕数量：'..js)
        return js
end

--统计毫秒
function Tools.GetTimer()
	local bb = require("badboy")
	bb.loadluasocket()
	local socket = bb.socket
	local function sleep(sec)
		socket.select(nil,nil,sec);
	end
	local t0 = socket.gettime()
	sleep(0.4);
	local t1 = socket.gettime()
	return(t1 - t0)
end

function Tools.Click(x_site,y_site)
	
	touchDown(1, x_site, y_site);
	mSleep(50)
	touchUp(1, x_site, y_site);
end

function Tools.KeepSwitch()
	keepScreen(true)
	mSleep(50)
	
	keepScreen(false)
end


--单点获取该点的RGB值
function Tools.Single_ColorRGB(Refresh,x_site,y_site)
	--分解开发点x和y
	--组装坐标组
	
	--开发数据 转换成实体数据
	local RealSite = All_Resolution.DevToProduction({x_site,y_site})
	--实体数据代入接口 返回正确的结果
	if Refresh == true then
		Tools.KeepSwitch()
	else
		
	end
	local color_r, color_g, color_b = getColorRGB(RealSite.x, RealSite.y)
	return {r=color_r,g=color_g,b=color_b}
end

--单点获取该点颜色字符串
function Tools.Single_ColorStr(Refresh,x_site,y_site)
	local RealSite = All_Resolution.DevToProduction({x_site,y_site})
	if Refresh == true then
		Tools.KeepSwitch()
	else
		
	end
	color = getColor(RealSite.x, RealSite.y)
	return color

end


--全分辨率拖动处理
function Tools.LeftDragClick(StartX,StartY,EndX,EndY)
	local bb = require("badboy")
	local RealStart = All_Resolution.DevToProduction({StartX,StartY})
	local RealEnd = All_Resolution.DevToProduction({EndX,EndY})
	
	bb.loadutilslib()
	--1039,616
	swip(RealStart.x,RealStart.y,RealEnd.x,RealEnd.y)
end


--单点找色

--叉叉原生单击动作
function Tools.Source_Single_Click(x_site,y_site)
	-- 模拟按下起始坐标(100, 200)
	--nLog("当前的坐标为"..x_site..","..y_site)
	local RealTable = All_Resolution.DevToProduction({x_site,y_site})
	touchDown(1,RealTable.x,RealTable.y)
	mSleep(50)
	touchUp(1,RealTable.x,RealTable.y )
end

--区域多点找一色
function Tools.Single_FindColor(Refresh,table_site,Timer)
	local dim = 95
	local color_table = {}
	--分解table表格 获取开发数据 table_site
	--[[
		{
			Anchor="Middle",MainPoint={x=37,y=45},
			Area={22,24,52,65},
			{x=30,y=42,color=0x0d0d1d,offset=0x101010},
			{x=37,y=36,color=0x2b3566,offset=0x101010},
			{x=39,y=53,color=0x293160,offset=0x101010},
			{x=35,y=48,color=0x242c5d,offset=0x101010}
		} 
	]]--
	local RealTable = All_Resolution.DevToProduction(table_site)
	--触动精灵格式
	--[[
		{  974,  219, 0xf1e0bf},
		{ 1003,  212, 0xf1e3ca},
		{ 1051,  200, 0xece3c2},
	
	]]--
	
	--分解实际表格 把点带入数据
					
	for colorKey,colorValue in ipairs(RealTable) do
		if type(colorKey) == 'number' then
			--处理colorvalue再插入
			--重新构造表格式
			TempTableValue = {colorValue.x,colorValue.y,colorValue.color}
			table.insert(color_table,TempTableValue)
		end
	end
	--构造area
	
	if Refresh == true then
		Tools.KeepSwitch()
		
	else
		
	end
	
	--循环两次查找
	for SearchIndex=1,Timer,1 do
		local x,y=findMultiColorInRegionFuzzyByTable(color_table,dim,RealTable.Area[1],RealTable.Area[2],RealTable.Area[3],RealTable.Area[4],{orient =1})
		if x ~= -1 and y~= -1 then
		
			return true
		else
			dim = dim - 5;
		end
	end
	
	return false
	
end

--单点(多点)找色返回坐标区域
function Tools.Mult_FindColor_Site(Refresh,table_site,Timer)
	local dim=95
	local Production_table = All_Resolution.DevToProduction(table_site)
	--分解实际表格 把点带入数据
	local color_table = {}
	for colorKey,colorValue in ipairs(Production_table) do
		if type(colorKey) == 'number' then
			--重新构造表格式
			TempTableValue = {colorValue.x,colorValue.y,colorValue.color}
			table.insert(color_table,TempTableValue)
		end
	end
	--实体数据代入接口 返回正确的结果
	if Refresh == true then
		Tools.KeepSwitch()
	else
	
	end

	--循环两次查找
	for SearchIndex=1,Timer,1 do
	
		local Retx,Rety = findMultiColorInRegionFuzzy( 0xf1cb27, "3|1|0xffce10,7|3|0xfdb606,11|3|0xffc20a,16|6|0xffb70a,21|9|0xffaa10,24|12|0xffa30c", dim, Production_table.Area[1], Production_table.Area[2], Production_table.Area[3], Production_table.Area[4])
		nLog("ret:"..tostring(Retx)..","..tostring(Rety))
		--,{ main = 0x303030, list = 0x303030 }
		--local Retx,Rety = findMultiColorInRegionFuzzyByTable(color_table,dim,Production_table.Area[1],Production_table.Area[2],Production_table.Area[3],Production_table.Area[4],{orient =1})
		--local RetColorTable = findColors(RealTable.Area, color_table,pixOver,0,0,0) 
		--返回匹配的点坐标数组
		if Retx ~= -1 and Rety~= -1 then
			
			return Retx,Rety
		else
			dim = dim - 5;
		end
		
	end
end


--单点(多点)找色返回坐标
function Tools.Single_FindColor_Site(Refresh,table_site,Timer)
	local dim=95
	--开发数据 转换成实体数据
	local Production_table = All_Resolution.DevToProduction(table_site)
	
	--分解实际表格 把点带入数据
	local color_table = {}
	for colorKey,colorValue in ipairs(Production_table) do
		if type(colorKey) == 'number' then
			--重新构造表格式
			TempTableValue = {colorValue.x,colorValue.y,colorValue.color}
			table.insert(color_table,TempTableValue)
		end
	end
	--实体数据代入接口 返回正确的结果
	if Refresh == true then
		Tools.KeepSwitch()
	
	else
	
	end
	--循环两次查找
	for SearchIndex=1,Timer,1 do
		local Retx,Rety=findMultiColorInRegionFuzzyByTable(color_table,dim,Production_table.Area[1],Production_table.Area[2],Production_table.Area[3],Production_table.Area[4],{orient =1})
		if Retx ~= -1 and Rety~= -1 then
		
			return {x=Retx,y=Rety}
		else
			dim = dim - 5;
		end
	end
	
	return false
end








--获取设备信息
function Tools.GetDeviceInfo()
	local Jailbroken = "未越狱"
	local DPI = "IOS"
	--获取脚本引擎版本号
	--local EnginVersion = TSVersions();
	--sysLog("脚本引擎版本是："..EnginVersion)
	local width,height = getScreenSize()--获取屏幕分辨率
	
	sysLog("分辨率是："..width.."X"..height);
	--t = getNetTime() --获取网络时间
	--sysLog("当前时间是："..t);
	local OS_type = getOSType() --获取系统类型
	sysLog("当前系统类型是："..OS_type);
	--local OS_Env = isPriviateMode() --获取系统环境类型
	--if OS_Env == 1 then

	--	Jailbroken = "越狱"
	--end
	--sysLog("当前系统环境类型："..Jailbroken);
	--sysLog('CPU构架: ' .. getSystemProperty('ro.arch'))
	--sysLog('手机产品号:' .. getSystemProperty('ro.build.product'))
	--local language = getLocalInfo()
	--sysLog(string.format('当前系统语言: %s', language))
	if OS_type == "android"  then
		local DPI = getDPI()
	else
		local DPI = "IOS"
	end
	
	sysLog(string.format('当前设备屏幕DPI: %s', DPI))
	--charge,level = getBatteryLevel() --获取电池状态
	--sysLog("电池状态："..charge.."==="..level)
	--local ScreenDirection = getScreenDirection() --获取屏幕方向
	--sysLog("屏幕方向："..ScreenDirection)
	--if ScreenDirection == 0 then
	--	Screen_mode = "竖屏"
	--end
	
	--if ScreenDirection == 1 then
	--	Screen_mode = "横屏"
	--end
	
	--if ScreenDirection == 2 then
	--	Screen_mode = "横屏（左）"
	--end
	--{EnginVersion,{width,height},OS_type,Jailbroken,getSystemProperty('ro.arch'),getSystemProperty('ro.build.product'),language,DPI,Screen_mode}
	
	return width.."X"..height,OS_type,Jailbroken,DPI
end


-- lua table 元素去重
function Tools.table_unique(source) 
    local check = {};
    local ret = {};
    for key , value in pairs(source) do
		
        if not check[value] then
            ret[key] = value
            check[value] = value
        end
    end
    return ret
end 

--数组去重
function Tools.removeRepeat(a)
    local b = {}
    for k,v in ipairs(a) do
        if(#b == 0) then
            b[1]=v;
        else
            local index = 0
            for i=1,#b do
                if(v == b[i]) then
                    break

                end
                index = index + 1
            end
            if(index == #b) then
                b[#b + 1] = v;
            end
        end
    end
    return b
end
-- table 泛型去重
function Tools.removeRepeated(a)
    for k,v in pairs(a) do
        local count=0
        for j in pairs(a)do count=count+1 end
        for i=k+1,count do
            if v==a[i] then
                table.remove(a,i)
            end
        end
    end
	return a
end


-- 延迟档次0 1 2 3 4 5 每一个档次 + 200ms
function Tools.mSleep_level(base_time,level)
	
	mSleep(math.random(base_time+level*100,base_time+10+level*100))

end



-- 字符串分割
function Tools.Split(szFullString, szSeparator)  
	local nFindStartIndex = 1  
	local nSplitIndex = 1  
	local nSplitArray = {}  
	while true do  
	   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
	   if not nFindLastIndex then  
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
		break  
	   end  
	   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
	   nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
	   nSplitIndex = nSplitIndex + 1  
	end  
	return nSplitArray  
end


function Tools.GetMultHud(showText)
	return true
end


function Tools.GetSingleHud(showText)
	--给一个初始量  改动后还原初始量
	fwShowTextView("TellWind","textid",showText,"center","FF0000","FFDAB9",15,0,0,0,300,100,1);
	mSleep(500)
	fwCloseView("TellWind",  "textid");

end


-- 带入一个数值表，返回最大值以及序号
function Tools.maximum(a)

    local mi = 1             -- maximum index

    local m = a[mi]          -- maximum value

    for i,val in ipairs(a) do

       if val > m then

           mi = i

           m = val

       end

    end

    return m, mi

end

--判断是否是nan
function Tools.isnan(x) return x ~= x end


--获取表长度
function Tools.getTblLen(tbl)--获取表长度
	local len=0
	for k,v in pairs(tbl) do
		len=len+1
	end
	return len
end

--表复制
function Tools.TableCopy(Tbl)--表复制没有复制元表
	local t={}
	if getmetatable(Tbl) then setmetatable(t,getmetatable(Tbl)) end
	for k,v in pairs(Tbl) do
		if type(v)=="table" then
			t[k]=Tools.TableCopy(v)
		else
			t[k]=v
		end
	end
	return t
end



--多选框表内容转序号
function Tools.CheckBoxToIndex(PreSkillTable)
	local TempSkillIndex = ""
	for PreSkillKey,PreSkillValue in pairs(PreSkillTable) do
			if PreSkillValue ~= nil then
				--组合提取
				if TempSkillIndex == "" then
					TempSkillIndex = PreSkillKey--这个key并不是准确的no
				else
					TempSkillIndex = TempSkillIndex.."@"..PreSkillKey
				end
				
				
			end
			
	end
	--dialog(TempSkillIndex,0)
	return TempSkillIndex
end


--查找表中key是否存在
function Tools.FindTableKey(TableName,KeyName)
	if TableName == nil then
		return false
	end
	for k, v in pairs(TableName) do
		if k ==  KeyName then
			return true
		end
	end
	return false
end


return Tools