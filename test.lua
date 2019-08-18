-- 文件名为module.lua
-- 定义一个名为tools的模块
test = {}


-- 定义一个常量
test.constant = "一个常量"


-- 测试功能函数 测试游戏是否在前台 在才开始 测试功能
function test.func()
	while true do
		isfront = isFrontApp("com.netease.wyclx"); --更新前台状态
			if isfront == 1 then
				break
			end
		toast("请打开楚留香app应用"); --提示用户打开
		mSleep(3000)
	end
	
	-- 测试样例
	
	init("0", 1); --以当前应用 Home 键在右边初始化
	-- -- 点击功能    57,664
	-- x,y = 57,664
	-- tools.Click(x,y)
	
	
	
	
	
	
end


function test.StartGame()
	flag = appIsRunning("com.netease.wyclx"); --检测QQ是否在运行
		if flag == 0 then --如果没有运行
			runApp("com.netease.wyclx") --运行QQ
		end
	
	toast("打开成功"); --提示用户打开
	-- 获取前台应用识别ID
	appid = frontAppName()
	init(appid,1) -- 初始化
	toast("初始化成功"); --提示用户打开
	
end