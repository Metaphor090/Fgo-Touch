function split(str, delimiter)
	if str==nil or str=='' or delimiter==nil then
		return {}
	end
	local result = {}
	for match in (str..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end
function print(...)--万能输出
	local con={...}
	for key,value in ipairs(con) do
		if(type(value)=="table")then
			printTbl(value)
			con[key]=""
		else
			con[key]=tostring(value)
		end
	end
	sysLog(table.concat(con,"  "))
end
function printTbl(tbl)--table输出,请注意不要传入对象,会无限循环卡死
	local function prt(tbl,tabnum)
		tabnum=tabnum or 0
		if not tbl then return end
		for k,v in pairs(tbl)do
			if type(v)=="table" then
				print(string.format("%s[%s](%s) = {",string.rep("\t",tabnum),tostring(k),"table"))
				prt(v,tabnum+1)
				print(string.format("%s}",string.rep("\t",tabnum)))
			else
				print(string.format("%s[%s](%s) = %s",string.rep("\t",tabnum),tostring(k),type(v),tostring(v)))
			end
		end
	end
	print("Print Table = {")
	prt(tbl,1)
	print("}")
end

function errorReport(info,isStop)--逻辑错误报告,info是附加信息,isStop是否以error的形式报错,否为直接打印
	local pt= getOSType()
	if isPriviateMode()==1 then
		pt=pt.."越狱/Root"
	else
		pt=pt.."免越狱/免Root"
	end
	if getProduct then
		if getProduct()==7 then pt=pt.."(酷玩)" end
	end
	local w,h = getScreenSize()
	local ScreenSize=w.."_"..h
	local str=string.format("%s\r\n===系统信息===\r\n手机分辨率:%s\r\npt:%s\r\n引擎版本号%s\r\n请反馈给作者附加信息和发生错误的具体情况!",info,ScreenSize,pt,getEngineVersion())
	if isStop then error(str,0) end
	print(str)
end

function getStrLen(a)--支持识别中文,UTF8编码的
	local l=string.len(a)
	local len=0
	for i=1,l do
		asc2=string.byte(string.sub(a,i,i))
		if asc2>127 then
			len=len+1/3-0.00000001
		else
			len=len+1
		end
	end
	return math.floor(len+0.5)
end


