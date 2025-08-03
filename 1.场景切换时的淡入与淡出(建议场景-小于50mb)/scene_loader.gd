extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

#使用淡出淡入加载场景
func chang_scene_with_fade(path:String,fadeTime:float)->void:
	#确保遮罩层级高于其他节点
	layer = 10
	color_rect.color.a = 0
	color_rect.show()
	
	#淡出动画
	var tween:=create_tween()
	tween.tween_property(color_rect,"color:a",1.0,fadeTime)
	await tween.finished
	await change_secen_async(path)
	
	#淡入动画
	var tween_out:=create_tween()
	tween_out.tween_property(color_rect,"color:a",0.0,fadeTime)
	await tween_out.finished
	
	color_rect.hide()

#异步加载场景,然后跳转
func change_secen_async(path:String)->void:
	#开始预加载
	ResourceLoader.load_threaded_request(path)
	
	#场景无效
	if ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
		push_error("该资源无效，或尚未使用 load_threaded_request() 加载")
	
	#检测场景是否在加载中
	while ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		#等待0.05s后再次检测
		await  get_tree().create_timer(0.05).timeout
		#也可以使用await  get_tree().process_frame,每帧检查一次
		
	#场景加载失败
	if ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_FAILED:
		push_error("加载过程中发生了错误，导致失败。")
		
	#判断是否加载完成
	if ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_LOADED:
		#加载完成后切换场景,如果场景过大(>50MB)会影响主进程导致卡顿
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(path))
