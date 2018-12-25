
最近项目中使用了自定义键盘，网上搜了一下，介绍很多，然后自己简单的实现了一下，不足的地方请多多指教
适配的问题请自己进行，键盘高度问题自己修改   CarCustomLicense.m 中84行
CarCustomLicense类为展示的输入框显示
CarKeyBoardView 为自定义的键盘
调用方法，请先引入  CarCustomLicense 

在需要的地方调用即可
CarCustomLicense *carView = [[CarCustomLicense alloc]initWithFrame:CGRectMake(SMATR_WITH(15), 100, ScreenW - SMATR_WITH(30), SMATR_WITH(35))];
[self.view addSubview:carView];
[carView.textField becomeFirstResponder];
[carView setClickConfirmBlock:^(NSString * _Nonnull text) {
NSLog(@"输入的车牌  %@",text);

}];
