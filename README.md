## 1.场景切换时的淡入淡出

<img src="https://github.com/BottlePeng/GodotProjectDemo/raw/main/examples/淡入淡出.gif" />

将scene_loader.tscn添加到`全局/自动加载`后,使用下面的函数即可实现淡入淡出切换场景
```
chang_scene_with_fade(path:String,fadeTime:float)
#path为场景路径
#fadeTime为切换时间
```
灵感来源:[【场景切换与淡入淡出效果  | GoDot4教程】](https://www.bilibili.com/video/BV1HwTezvE8d/?share_source=copy_web&vd_source=4adc071e3b96a224398d9c6f3b728748) 

## 2.line2d节点实现拖尾特效

<img src="https://github.com/BottlePeng/GodotProjectDemo/raw/main/examples/拖尾特效.gif" />

修改line2d节点的属性即可实现各种样式的拖尾特效
<img src="github.com/BottlePeng/GodotProjectDemo/raw/main/examples/拖尾特效.gif" />

## 3.悬浮提示框

<img src="https://github.com/BottlePeng/GodotProjectDemo/raw/main/examples/悬浮提示框.gif" />
