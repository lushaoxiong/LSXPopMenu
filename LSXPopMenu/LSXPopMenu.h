//
//  LSXPopMenu.h
//  LSXPopMenu
//
//  Created by 医联通 on 17/3/2.
//  Copyright © 2017年 lsx. All rights reserved.
//

#import <UIKit/UIKit.h>
#define LScreenWidth [UIScreen mainScreen].bounds.size.width
#define LScreenHeight [UIScreen mainScreen].bounds.size.height
#define LMainWindow  [UIApplication sharedApplication].keyWindow

typedef NS_ENUM(NSInteger , LSXPopMenuType) {
    LSXPopMenuTypeDefault = 0,
    LSXPopMenuTypeDark
};
@class LSXPopMenu;
@protocol LSXPopMenuDelegate <NSObject>

@optional
/**
 点击事件回调
 */
- (void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu;
@end


@interface LSXPopMenu : UIView
/**
 圆角半径 Default is 5.0
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 是否显示阴影 Default is YES
 */
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowShadow;

/**
 是否显三角形 Default is YES
 */
@property (nonatomic, assign , getter=isShadowShowing) BOOL isShowTriangle;

/**
 选择菜单项后消失 Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnSelected;

/**
 点击菜单外消失  Default is YES
 */
@property (nonatomic, assign) BOOL dismissOnTouchOutside;

/**
 设置字体大小 Default is 15
 */
@property (nonatomic, assign) CGFloat fontSize;

/**
 设置字体颜色 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor * textColor;

/**
 设置偏移距离 (>= 0) Default is 0.0
 */
@property (nonatomic, assign) CGFloat offset;

/**
 设置显示模式 Default is LSXPopupMenuTypeDefault
 */
@property (nonatomic, assign) LSXPopMenuType type;

/**
 代理
 */
@property (nonatomic, weak) id <LSXPopMenuDelegate> delegate;

/**
 初始化popupMenu
 
 @param titles    标题数组
 @param icons     图标数组
 @param itemWidth 菜单宽度
 @param delegate  代理
 */
- (instancetype)initWithTitles:(NSArray *)titles
                         icons:(NSArray *)icons
                     menuWidth:(CGFloat)itemWidth
                      delegate:(id<LSXPopMenuDelegate>)delegate;

/**
 在指定位置弹出类方法
 */
+(instancetype)showAtPoint:(CGPoint)point titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth isShowTriangle:(BOOL)isShowTriangle delegate:(id<LSXPopMenuDelegate>)delegate;


/**
 依赖指定view弹出类方法
 */
+ (instancetype)showRelyOnView:(UIView *)view titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth isShowTriangle:(BOOL)isShowTriangle delegate:(id<LSXPopMenuDelegate>)delegate;


/**
 在指定位置弹出
 
 @param point 需要弹出的point
 */
- (void)showAtPoint:(CGPoint)point;


/**
 依赖指定view弹出
 
 @param view 需要依赖的view
 */
- (void)showRelyOnView:(UIView *)view;

/**
 消失
 */
- (void)dismiss;

@end
