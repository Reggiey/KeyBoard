//
//  CarCustomLicense.h
//  WisdomSuitcase
//
//  Created by MacWu on 2018/11/30.
//  Copyright © 2018年 MacWu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarCustomLicense : UIView


@property (strong, nonatomic) UILabel *titleLab;
@property (strong, nonatomic) UIImageView *newpowerCarBtnIv;///< 使能新能源车按钮的image，可以修改风格
@property (strong, nonatomic) UILabel *newpowerCarBtnLab;///< 使能新能源车按钮的label，可以修改风格
@property (copy, nonatomic) void (^clickCancelBlock)(void);
@property (copy, nonatomic) void (^clickConfirmBlock)(NSString *text);

@property (strong, nonatomic) UITextField *textField;

//新能源
@property (nonatomic,strong)UIButton *carEnergyBtn;

@end

NS_ASSUME_NONNULL_END
