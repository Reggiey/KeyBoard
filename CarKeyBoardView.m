//
//  CarKeyBoardView.m
//  ConchParking
//
//  Created by MacWu on 2018/12/25.
//  Copyright © 2018 MacWu. All rights reserved.
//

#import "CarKeyBoardView.h"

#define kWidth  self.frame.size.width
#define kHeight self.frame.size.height
#define HEXCOLOR(hex, alp) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:alp]


@interface CarKeyBoardView()
{
    UIView *_bottomView;
    UIButton *_btn;
}

@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *otherArray;

@property (nonatomic,strong)UIView *provincesView;
@property (nonatomic,strong)UIView *otherBackView;
@end

@implementation CarKeyBoardView


- (NSArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = @[@"京",@"津",@"渝",@"沪",@"冀",@"晋",@"辽",@"吉",@"黑",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"琼",@"川",@"贵",@"云",@"陕",@"甘",@"青",@"蒙",@"桂",@"宁",@"新",@"",@"藏",@"使",@"领",@"警",@"学",@"港",@"澳",@""];
    }
    return _provinceArray;
}

- (NSArray *)otherArray {
    if (!_otherArray) {
        _otherArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"",@"Z",@"X",@"C",@"V",@"B",@"N",@"M",@""];
    }
    return _otherArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HEXCOLOR(0x000000, 0.1);
        //接受通知，改变省份键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFAction:) name:@"abc" object:nil];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    //省份键盘
    _provincesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 220)];
    _provincesView.backgroundColor = HEXCOLOR(0xd2d5da, 1);
    _provincesView.hidden = NO;
    //数子和英文键盘
    _otherBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, 220)];
    _otherBackView.hidden = YES;
    _otherBackView.backgroundColor = HEXCOLOR(0xd2d5da, 1);
    
    [self addSubview:_provincesView];
    [self addSubview:_otherBackView];
    
    int row = 4;
    int column = 10;
    CGFloat btnY = 4;
    CGFloat btnX = 2;
    CGFloat maginR = 5;
    CGFloat maginC = 10;
    CGFloat btnW = (size.width - maginR * (column -1) - 2 * btnX)/column;
    CGFloat btnH = (_provincesView.frame.size.height - maginC * (row - 1) - 6) / row;
    CGFloat m = 12;
    CGFloat w = (size.width - 24 - 7 * btnW - 6 * maginR - 2 * btnX)/2;
    CGFloat mw = (size.width - 8 * maginR - 9 * btnW - 2 * btnX) / 2;
    //    NSLog(@"LY >> count - %zd", self.array1.count);
    for (int i = 0; i < self.provinceArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i / column == 3) {
            if (i == 30) {
                btn.frame = CGRectMake(btnX, btnY + 3 * (btnH + maginC), w, btnH);
                [btn setBackgroundImage:[UIImage imageNamed:@"key_abc"] forState:UIControlStateNormal];
                btn.enabled = NO;
                _btn = btn;
            }else if (i == 38) {
                btn.frame = CGRectMake(6 * (btnW + maginR) + btnW + w + m + m, btnY + 3 * (btnH + maginC), w, btnH);
                [btn setBackgroundImage:[UIImage imageNamed:@"key_over"] forState:UIControlStateNormal];
            }else {
                btn.frame = CGRectMake((i % column - 1)*(btnW + maginR) + w + m + btnX, btnY + 3 * (btnH + maginC), btnW, btnH);
                [btn setBackgroundImage:[UIImage imageNamed:@"key_number"] forState:UIControlStateNormal];
            }
        }else {
            btn.frame = CGRectMake(btnW * (i % column) + i % column * maginR + btnX, btnY + i/column * (btnH + maginC), btnW, btnH);
            [btn setBackgroundImage:[UIImage imageNamed:@"key_number"] forState:UIControlStateNormal];
        }
        [btn setTitleColor:HEXCOLOR(0x23262F, 1) forState:UIControlStateNormal];
        [btn setTitle:self.provinceArray[i] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(btn1Click:) forControlEvents:UIControlEventTouchUpInside];
        [_provincesView addSubview:btn];
    }
    
    for (int i = 0; i < self.otherArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i >= 20 && i < 29) {
            btn.frame = CGRectMake(btnX + mw + (btnW + maginR) * (i % column), btnY + 2 * (btnH + maginC), btnW, btnH);
            [btn setBackgroundImage:[UIImage imageNamed:@"key_number"] forState:UIControlStateNormal];
        }else if (i >= 29) {
            if (i == 29) {
                btn.frame = CGRectMake(btnX, btnY + 3 * (btnH + maginC), w, btnH);
                [btn setBackgroundImage:[UIImage imageNamed:@"key_back"] forState:UIControlStateNormal];
            }else if (i == 37) {
                btn.frame = CGRectMake(6 * (btnW + maginR) + btnW + w + m + m + btnX, btnY + 3 * (btnH + maginC), w, btnH);
                [btn setBackgroundImage:[UIImage imageNamed:@"key_over"] forState:UIControlStateNormal];
            }else {
                btn.frame = CGRectMake((i % column)*(btnW + maginR) + w + m + btnX, btnY + 3 * (btnH + maginC), btnW, btnH);
                [btn setBackgroundImage:[UIImage imageNamed:@"key_number"] forState:UIControlStateNormal];
            }
        }else {
            btn.frame = CGRectMake(btnW * (i % column) + i % column * maginR + btnX, btnY + i/column * (btnH + maginC), btnW, btnH);
            [btn setBackgroundImage:[UIImage imageNamed:@"key_number"] forState:UIControlStateNormal];
        }
        [btn setTitleColor:HEXCOLOR(0x23262F, 1) forState:UIControlStateNormal];
        [btn setTitle:self.otherArray[i] forState:UIControlStateNormal];
        
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(btn2Click:) forControlEvents:UIControlEventTouchUpInside];
        [_otherBackView addSubview:btn];
    }
    
    //实现弹出省份键盘
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.provincesView.frame;
        frame.origin.y = self.frame.size.height - 220 - BottomHeight;
        self.provincesView.frame = frame;
    }];
    //实现弹出数字英文键盘
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.otherBackView.frame;
        frame.origin.y = self.frame.size.height - 220 - BottomHeight;
        self.otherBackView.frame = frame;
    }];
    
}

- (void)btn1Click:(UIButton *)sender {
    _btn.enabled = YES;
    if (sender.tag == 30) {//点击ABC时，隐藏数子英文键盘 _backView2
        if (_otherBackView.hidden){     // _backView2 隐藏了
            _provincesView.hidden = YES;
            _otherBackView.hidden = NO;
        }else {
            sender.enabled = NO;
        }
        
    }else if (sender.tag == 38){//点击删除
        if (_otherBackView.hidden) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnClick)]) {
                [self.delegate deleteBtnClick];
            }
        }
    }else {
        _provincesView.hidden = YES;
        _otherBackView.hidden = NO;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithString:)]) {
            [self.delegate clickWithString:self.provinceArray[sender.tag]];
        }
    }
}

- (void)btn2Click:(UIButton *)sender {
    if (sender.tag == 29) {//点击了ABC
        _provincesView.hidden = NO;
        _otherBackView.hidden = YES;
        
    }else if (sender.tag == 37) {//点击了删除
        if (self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnClick)]) {
            [self.delegate deleteBtnClick];
        }
        
    }else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(clickWithString:)]) {
            [self.delegate clickWithString:self.otherArray[sender.tag]];
        }
    }
}

- (void)deleteEnd {
    _provincesView.hidden = NO;
    _otherBackView.hidden = YES;
}

- (void)textFAction:(NSNotification *)notification {
    NSString *str = notification.userInfo[@"text"];
    if (str.length == 0) {
        _btn.enabled = NO;
    }else {
        _btn.enabled = YES;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
