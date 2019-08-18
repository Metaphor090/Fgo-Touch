
-- Style风格
ViewStyle = {
  DEFAULT = "default", 
  CUSTOME = "custome"
}

-- 对齐方式
TextAlign = {
  LEFT = "left", 
  CENTER = "center",
  RIGHT = "right"
}

-- 创建View对象
local function createView(id, options, mematable)
  options = options or {}
  
  for k, v in pairs(mematable) do
    if k ~= '__index' and type(v) ~= 'function' and options[k] == nil then
      options[k] = v
    end
  end
  
  setmetatable(options, mematable)
  mematable.__index = mematable

  options.id = tostring(id)
  options.setRect = function(self, left, top, width, height)
    options.rect = string.format('%d, %d, %d, %d', left, top, width, height)
  end
  
  return options
end

--Image
Image = {
  id = "ImageID",
  type = "Image",
}

function Image:create(id, options)
  return createView(id, options, Image)
end

function Image:setSrc( src )
  self.src = tostring(src)
end

-- Lable
Label = {
  id = "LabelID",
  type = "Label",
  text = "LabelText",
  size = 15,
  align = TextAlign.CENTER,
  color = "0, 0, 0",
}
-- 创建Lable
function Label:create(id, options)
  return createView(id, options, Label)
end

-- RadioGroup
RadioGroup = {
  id = "RadioGroupID",
  type = "RadioGroup",
  list = "op1, op2, op3",
  select = "0"
}

function RadioGroup:create(id, options)
  return createView(id, options, RadioGroup)
end

function RadioGroup:setList(...)
  local list_value = ''
  local args = {...}
  
  for i, v in pairs(args) do
    if i == #args then
       list_value = list_value .. v
    else
       list_value = list_value  .. v .. ','
    end
  end
  
  self.list = list_value
end

function RadioGroup:setSelect(n)
  self.select = tostring(n)
end

-- Edit
Edit = {
  id = "Edit0",
  type = "Edit",
  prompt = "prompt",
  align = TextAlign.CENTER, 
  kbtype = "number",
  text = ""
}

function Edit:create(id, options)
  return createView(id, options, Edit)
end

--ComboBox
ComboBox = {
	id = "ComboBox",
	type = "ComboBox",
	list = "box1,box2,box3",
	select = "1",
	size = 30
}



function ComboBox:create(id, options)
  return createView(id, options, ComboBox)
end


function ComboBox:setList(...)
	local list_value = ''
	local args = {...}
	for k, v in pairs(args) do
		if k == #args then
		  list_value = list_value .. v
		else
		  list_value = list_value .. v .. ','
		end
    end
 
  self.list = list_value
end


-- CheckBoxGroupView
CheckBoxGroup = {
  id = "CheckBoxGroup0",
  type = "CheckBoxGroup",
  list = "op1, op2, op3",
  select = "1@2"
}

function CheckBoxGroup:create(id, options)
  return createView(id, options, CheckBoxGroup)
end

function CheckBoxGroup:setList(...)
  local list_value = ''
  local args = {...}
  
  for k, v in pairs(args) do
    if k == #args then
      list_value = list_value .. v
    else
      list_value = list_value .. v .. ','
    end
  end
 
  self.list = list_value
end

function CheckBoxGroup:setSelects(...)
  local select_value = ''
  local args = {...}
  
  for i, v in pairs(args) do
    if i == #args then
      select_value = select_value .. v
    else
      select_value = select_value .. v .. '@'
    end
  end
  
  self.select = select_value
end

-- Page
Page = {
  id = "PageID",
  type = "Page",
  text = "PageView0",
  views = {}
}

-- 创建Page
function Page:create(id, options)
  options = options or {}
  options.views = {}
  return createView(id, options, Page)
end

-- 添加子View
function Page:addView(view)
  if view == nil then
    error('view is nil')
  end

  if view and view.type ~= self.type then
    for i, v in pairs(self.views) do
      if v.id == view.id then
         error(string.format('id %d is repeat', view.id))
      end
    end
    self.views[#self.views + 1] = view
  else
    error('Page can not be add Page.')
  end
end

-- 删除子View
function Page:removeView(view)
  if view then
    for i = 1, #self.views do
      if self.views[i] == view then
        table.remove(self.views, i)
      end
    end
  end
end

function Page:removeViewByID(id)
  if view then
    for i = 1, #self.views do
      if self.views[i].id == id then
        table.remove(self.views, i)
      end
    end
  end
end


RootView = { 
  style = ViewStyle.DEFAULT, 
  width = true_width, 
  height = true_height, 
  cancelname = "Cancel", 
  okname = "OK", 
  views = {} ,
  bg = "bg.jpg",
  config = "配置一.dat"
}

-- 创建根View
function RootView:create(options) 
  options = options or {}
  options.views = {}
  return createView(-1, options, RootView)
end

function RootView:addView(view)
  if view == nil then
    error('view is nil')
  end

  is_page_style = function () 
    for i, v in pairs(self.views) do
      if v.type == Page.type then
        return true
      end
      return false
    end
  end

  if is_page_style() and view.type ~= Page.type then
    error('Only Page can be added')
  else
    self.views[#self.views + 1] = view
  end
end
