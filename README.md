# InteractiveViewController
UIViewController可实现交互式下滑结束页面

仿微信小程序左滑dismiss界面；

- (void)viewDidLoad {
    // ...
    
    [self addDismissGestureWithDirection:UIInteractiveDirectionHorizontal];
    
    // ...
}

例子：

![image](https://github.com/tounaobun/InteractiveViewController/blob/master/sample.gif)
