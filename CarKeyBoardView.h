//
//  CarKeyBoardView.h
//  ConchParking
//
//  Created by MacWu on 2018/12/25.
//  Copyright © 2018 MacWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarKeyBoardViewDelegate <NSObject>
//选择输入
- (void)clickWithString:(NSString *)string;
//点击删除
- (void)deleteBtnClick;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CarKeyBoardView : UIView


@property (nonatomic, weak) id<CarKeyBoardViewDelegate> delegate;

- (void)deleteEnd;



@end

NS_ASSUME_NONNULL_END
