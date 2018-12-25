# CarBoard 封装
最近项目中使用了自定义键盘，网上搜了一下，介绍很多，然后自己简单的实现了一下，不足的地方请多多指教
适配的问题请自己进行


###修改适配的地方 
   
    CarCustomLicense.m 中84行 以及 CarKeyBoardView.m 的UIview动画方法 

###实用类介绍

    CarCustomLicense类为展示的输入框显示
    CarKeyBoardView 为自定义的键盘


###调用说明 
     
    双击导致观察者
    需要的类中引入 CarCustomLicense.h
    需要使用到自定义车牌键盘的地方调用
    CarCustomLicense *carView = [[CarCustomLicense alloc]initWithFrame:CGRectMake(15, 100, ScreenW - 30, 35)];
    [self.view addSubview:carView];
    [carView.textField becomeFirstResponder];
    [carView setClickConfirmBlock:^(NSString * _Nonnull text) {
    NSLog(@"输入的车牌  %@",text);
    
    }];
    
![KeyBoard](/keyBoardPop.png)
![KeyBoard](/keyBoardInput.png)
![KeyBoard](/keyBoardDelete.png)

### 关于作者
* Email： <speciallw@qq.com>
* 有任何建议或者使用中遇到问题都可以给我发邮件, 作者比较懒，具体的实现逻辑，这就不详细的说明了，网上一搜一大堆




