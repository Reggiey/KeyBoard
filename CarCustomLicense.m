//
//  CarCustomLicense.m
//  WisdomSuitcase
//
//  Created by MacWu on 2018/11/30.
//  Copyright © 2018年 MacWu. All rights reserved.
//

#import "CarCustomLicense.h"

#import "CarKeyBoardView.h"

//屏幕的宽
#define ScreenW [UIScreen mainScreen].bounds.size.width
//屏幕的高
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface CarCustomLicense ()<CarKeyBoardViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray <UILabel *>*labelArr;
@property (nonatomic, strong) CarKeyBoardView *keyboardView;

@end


@implementation CarCustomLicense

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self carWithInterfsce];
    }
    return self;
}


- (void)carWithInterfsce{
    
    CGFloat height = self.frame.size.height;
    //***
    UIControl *maskView = [[UIControl alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
    maskView.backgroundColor = UIColor.whiteColor;
    [maskView addTarget:self action:@selector(tapMaskView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:maskView];
    //***/
    {
        UIView *markView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
        markView.layer.borderColor = [UIColor clearColor].CGColor;
        markView.layer.borderWidth = 0.667;
        markView.userInteractionEnabled = NO;
        [self addSubview:markView];
    }
    
    _labelArr = [[NSMutableArray alloc] init];
    //输入后显示的文字，lab覆盖textFiled
    for (NSInteger i=0; i<8; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, height, height)];
        lab.textColor = UIColor.blackColor;
        lab.font = [UIFont systemFontOfSize:15];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.layer.borderWidth = 0.667;
        lab.layer.borderColor = [UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:1].CGColor;
        lab.userInteractionEnabled = NO;
        [_labelArr addObject:lab];
        CGRect frame = lab.frame;
        if (i==0) {
            frame.origin.x = 0;
        }
        else if (i==1) {
            frame.origin.x = CGRectGetMaxX(_labelArr[0].frame) + 6;//_labelArr[0].maxX;
        }
        else if (i==2) {
            frame.origin.x = CGRectGetMaxX(_labelArr[1].frame) + 7;//_labelArr[1].maxX+8;
        }
        else {
            frame.origin.x = CGRectGetMaxX(_labelArr[i-1].frame) + 6;//_labelArr[i-1].maxX+5;
        }
        lab.frame = frame;
        [self addSubview:lab];
    }
    
    UITextField *textfiled = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_labelArr.firstObject.frame), _labelArr.firstObject.frame.origin.y, 10, 10)];
    [textfiled addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew  context:nil];
    self.keyboardView = [[CarKeyBoardView alloc] initWithFrame:CGRectMake(0, ScreenH - 220, ScreenW, 220)];
    self.keyboardView.delegate = self;
    
    textfiled.textColor = UIColor.clearColor;
    textfiled.tintColor = UIColor.clearColor;
    textfiled.font = [UIFont systemFontOfSize:5];

    textfiled.inputView = self.keyboardView;
    
    
    [self addSubview:textfiled];
    [self sendSubviewToBack:textfiled];
    self.textField = textfiled;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:UITextFieldTextDidChangeNotification object:nil];
    
    _labelArr.lastObject.hidden = YES;
    UIControl *newpowerCarBtn = [[UIControl alloc] initWithFrame:_labelArr.lastObject.frame];
    newpowerCarBtn.backgroundColor = UIColor.whiteColor;
    newpowerCarBtn.layer.borderWidth = 0.667;
    newpowerCarBtn.layer.borderColor = [UIColor colorWithRed:178/255.0 green:179/255.0 blue:180/255.0 alpha:1].CGColor;
   
    [newpowerCarBtn addTarget:self action:@selector(tapEnableNewpowerCar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:newpowerCarBtn];
    //新能源显示
    {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 3, newpowerCarBtn.frame.size.width, 0.55*newpowerCarBtn.frame.size.height-6)];
        iv.contentMode = UIViewContentModeCenter;
        [newpowerCarBtn addSubview:iv];
        iv.image = [UIImage imageNamed:@"icon_add"];
        self.newpowerCarBtnIv = iv;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.55*newpowerCarBtn.frame.size.height, newpowerCarBtn.frame.size.width, 0.45*newpowerCarBtn.frame.size.height-4)];
        lab.text = @"新能源";
        lab.textColor = [UIColor colorWithRed:152.0/255.0 green:153.0/255.0 blue:154.0/255.0 alpha:1];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:10];
        [newpowerCarBtn addSubview:lab];
        self.newpowerCarBtnLab = lab;
        _carEnergyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _carEnergyBtn.frame = CGRectMake(newpowerCarBtn.frame.origin.x, newpowerCarBtn.frame.origin.y, newpowerCarBtn.frame.size.width, newpowerCarBtn.frame.size.height);
        _carEnergyBtn.backgroundColor = [UIColor whiteColor];
        _carEnergyBtn.userInteractionEnabled = NO;
        [self addSubview:_carEnergyBtn];
        _carEnergyBtn.alpha = 0;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if (self.clickConfirmBlock) {
        self.clickConfirmBlock(self.textField.text);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"abc" object:nil userInfo:@{@"text": change[@"new"]}];
   
}
//输入实现
- (void)clickWithString:(NSString *)string {
    NSLog(@"self.plateTF.text -- %@", string);
    
    if (self.textField.text) {
        NSInteger count = self.labelArr.lastObject.hidden==NO?self.labelArr.count:self.labelArr.count-1;
        if (self.textField.text.length == count) {
            return;
        }
        self.textField.text = [self.textField.text stringByAppendingString:string];
    }else {
        self.textField.text = [@"" stringByAppendingString:string];
    }
    NSInteger i = self.textField.text.length-1;
    UILabel *lab = self.labelArr[i];
    lab.text = string;

}
//删除点击实现
- (void)deleteBtnClick {
    if (self.textField.text.length == 0) {
    }else if (self.textField.text.length == 1) {
        [self.keyboardView deleteEnd];
        self.textField.text = [self.textField.text substringToIndex:[self.textField.text length] - 1];
        NSInteger i = self.textField.text.length;
        self.labelArr[i].text = nil;
    }else {
        self.textField.text = [self.textField.text substringToIndex:[self.textField.text length] - 1];
        NSInteger i = self.textField.text.length;
        self.labelArr[i].text = nil;
    }
    
    
}
#pragma mark - Observer (UITextFieldTextDidChangeNotification)
- (void)textFieldEditChanged:(NSNotification *)notification{
    NSLog(@"notification = %@", notification);
    UITextField *textField = (UITextField *)notification.object;
    if (textField == self.textField) {
//        NSInteger count = self.labelArr.lastObject.hidden==NO?self.labelArr.count:self.labelArr.count-1;
        //[YQTools limitChatCount:notification length:count];
    }
}


#pragma mark - actions
- (void)tapBackground:(UITapGestureRecognizer *)sender{
   
    [self removeFromSuperview];
}

//
- (void)tapEnableNewpowerCar:(UIButton *)sender{
    [sender removeFromSuperview];
    _labelArr.lastObject.hidden = NO;
}

- (void)tapCancel:(UIButton *)sender{
    if (self.clickCancelBlock) {
        self.clickCancelBlock();
    }
    [self removeFromSuperview];
}

- (void)tapConfirm:(UIButton *)sender{
    NSString *text = @"";
    for (NSInteger i=0; i<self.labelArr.count; i++) {
        if (self.labelArr[i].text.length>0) {
            text = [text stringByAppendingString:self.labelArr[i].text];
        }
    }
    if (self.clickConfirmBlock) {
        self.clickConfirmBlock(text);
    }
    [self removeFromSuperview];
}

- (void)tapMaskView:(id)sender{
    //[sender.view resignFirstResponder];
    [self.textField becomeFirstResponder];
}

#pragma mark -
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
