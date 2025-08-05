- [一. 特效](#一-特效)
  - [1.场景切换时的淡入淡出](#1场景切换时的淡入淡出)
    - [演示](#演示)
    - [使用方法](#使用方法)
    - [来源:](#来源)
  - [2.line2d节点实现拖尾特效](#2line2d节点实现拖尾特效)
    - [演示](#演示-1)
    - [使用方法](#使用方法-1)
- [二. UI](#二-ui)
  - [1.悬浮提示框](#1悬浮提示框)
    - [演示](#演示-2)
    - [组成](#组成)
    - [使用方法](#使用方法-2)
  - [2.不规则物品背包](#2不规则物品背包)
    - [演示](#演示-3)
    - [组成](#组成-1)
    - [实现逻辑](#实现逻辑)
    - [使用方法](#使用方法-3)
    - [来源:](#来源-1)
  
# 一. 特效
## 1.场景切换时的淡入淡出
### 演示  
<img src="examples\1_1_演示_1.gif" width="400">  


### 使用方法  
1.将scene_loader.tscn添加到`全局/自动加载`

<img src="examples\1_1_使用方法_1.png" width="400">  

2.使用`chang_scene_with_fade`函数代替`get_tree().change_scene_to_file`使用即可

```
chang_scene_with_fade(path:String,fadeTime:float)
#path为场景路径
#fadeTime为切换时间
```

### 来源:
[【场景切换与淡入淡出效果  | GoDot4教程】](https://www.bilibili.com/video/BV1HwTezvE8d/?share_source=copy_web&vd_source=4adc071e3b96a224398d9c6f3b728748) 

## 2.line2d节点实现拖尾特效
### 演示   
<img src="examples\1_2_演示_1.gif" width="400" >  

### 使用方法    
修改line2d节点的属性即可实现各种样式的拖尾特效<br>
<img src="examples\1_2_使用方法_1.png" width="200">  

# 二. UI
## 1.悬浮提示框
### 演示  
<img src="examples\2_1_演示_1.gif" width="400">  

### 组成  
<img src="examples\2_1_组成_1.png">  

### 使用方法  
1.将`tip.tscn`添加到项目中  
2.将`mouse_panel.tscn`中的代码添加到需要使用悬浮窗的对象上  
3.修改`tip.tscn`的`tip`节点可以实现不同的悬浮窗背景  
4.修改`tip.tscn`的`content`节点可以显示不同的内容,可使用BBCode格式  
<img src="examples\2_1_使用方法_1.png">  

## 2.不规则物品背包
### 演示  
<img src="examples\2_2_演示_1.gif" width="400">  

### 组成    
项目文件:  
<img src="examples\2_2_组成_1.png">  
背包场景节点树:  
<img src="examples\2_2_组成_2.png" height="320">  

### 实现逻辑
```
背包系统
├─数据层: 
│ ├─背包数据:Array[Array[x,y]]类型,x为物品的ID,y为物品所占的第一个格子相对于其父节点的索引
│ └─被拿去物品的数据:int类型,储存物品ID
└─表现层
  ├─背包背景: GridMgr(GridContainer类型)节点
  │ └─背包格子: Grid(TextureRect类型),添加或删除Grid节点即可更改背包大小
  │   └─物品: 添加或删除Item节点来表现物品的放置与拿起  
  └─鼠标拿起的物品: 鼠标拿去物品时,物品跟随鼠标移动,鼠标位于物品中心  
```
拿起或放置物品逻辑:  
<img src="examples\2_2_实现逻辑_1.png"  height="400">    

### 使用方法  
1.修改`GridMgr`节点的`columns`属性可以更改背包每行的格子数量  
2.在`GridMgr`节点下增加新的`grid`场景即可添加格子  
3.`resources\cell_bg`为格子背景( :exclamation:`PanelContainer`节点的背景也使用的此文件,需要修改背景可另外设置)  
4.`item`的图标由`resources\item_icon`切割而来,`item`的逻辑是为了实现背包系统而制作的,正式使用时需按照需要自行调整实现逻辑  

### 来源:
> :exclamation:本项目实现逻辑与来源项目不同,仅使用来源项目的图标资源以及实现思路
 
[【Godot类暗黑、背包乱斗的背包系统 - 背包系统介绍】](https://www.bilibili.com/video/BV1yJmdYWEAP/?spm_id_from=333.1007.top_right_bar_window_history.content.click&vd_source=6c81251a45d4df2f6a2cddd01d3608aa) 