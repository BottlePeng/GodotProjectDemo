## 1.场景切换时的淡入淡出
演示:  
<img src="examples\渐入渐出.gif" width="400">  


使用方法:  
1.将scene_loader.tscn添加到`全局/自动加载`

<img src="examples\全局设置.png" width="400">  

2.使用`chang_scene_with_fade`函数代替`get_tree().change_scene_to_file`使用即可

```
chang_scene_with_fade(path:String,fadeTime:float)
#path为场景路径
#fadeTime为切换时间
```

灵感来源:[【场景切换与淡入淡出效果  | GoDot4教程】](https://www.bilibili.com/video/BV1HwTezvE8d/?share_source=copy_web&vd_source=4adc071e3b96a224398d9c6f3b728748) 

## 2.line2d节点实现拖尾特效
演示:<  
<img src="examples\拖尾特效.gif" width="400" >  

修改line2d节点的属性即可实现各种样式的拖尾特效<br>
<img src="examples\line2d节点设置.png" width="200">  

## 3.悬浮提示框
演示:  
<img src="examples\悬浮提示窗.gif" width="400">  

组成:  
<img src="examples\悬浮窗场景.png">  


使用方法:  
1.将`tip.tscn`添加到项目中  
2.将`mouse_panel.tscn`中的代码添加到需要使用悬浮窗的对象上  
3.修改`tip.tscn`的`tip`节点可以实现不同的悬浮窗背景  
4.修改`tip.tscn`的`content`节点可以显示不同的内容,可使用BBCode格式  
<img src="examples\tip节点.png">  
