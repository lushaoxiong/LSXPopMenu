//
//  LSXPopMenu.m
//  LSXPopMenu
//
//  Created by 医联通 on 17/3/2.
//  Copyright © 2017年 lsx. All rights reserved.
//

#import "LSXPopMenu.h"


#pragma mark - private categorys

@interface UIView (LSXFrame)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;

@end



@implementation UIView (LSXFrame)

-(CGFloat)x{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x{
    CGRect frame=self.frame;
    frame.origin.x=x;
    self.frame=frame;
}
-(CGFloat)y{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y{
    CGRect frame=self.frame;
    frame.origin.y=y;
    self.frame=frame;
}
-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
-(CGFloat)centerX{
    return self.center.x;
}
-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerY{
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end

#pragma mark - private Model

@interface LSXPopMenuModel : NSObject
@property(strong,nonatomic)NSString * title;
@property(strong,nonatomic)NSString * imgName;
@property(assign,nonatomic)CGFloat  tit_lenthMax;
@property(assign,nonatomic)CGFloat  imgW;
@property(assign,nonatomic)CGFloat  imgH;

@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) UIColor * textColor;
@property(nonatomic,assign) CGFloat  itemWidth;
@end

@implementation LSXPopMenuModel


@end




#pragma mark - private cell

@interface LSXPopMenuCell : UITableViewCell
@property(strong,nonatomic)UIImageView * imgView;
@property(strong,nonatomic)UILabel * titLa;
@property(strong,nonatomic)LSXPopMenuModel * Model;
@property(assign,nonatomic)CGFloat cellHeight;
@property (nonatomic, assign) BOOL isShowSeparator;
@property (nonatomic, strong) UIColor * separatorColor;
@end

@implementation LSXPopMenuCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        _imgView=[[UIImageView alloc]init];
        [self.contentView addSubview:_imgView];
        
        _titLa=[[UILabel alloc]init];
        [self.contentView addSubview:_titLa];
        
        _isShowSeparator = YES;
        _separatorColor = [UIColor lightGrayColor];
        [self setNeedsDisplay];
      
    }
    return self;
}
-(void)setModel:(LSXPopMenuModel *)Model{
    
    CGFloat W=Model.itemWidth;
    if (Model.imgName) {
        _titLa.textAlignment=NSTextAlignmentLeft;
        [_imgView setHighlighted:NO];
        CGFloat imgX =(W-Model.imgW-Model.tit_lenthMax*Model.fontSize-10)/2;
        CGFloat imgY=(_cellHeight-Model.imgH)/2;
        _imgView.frame=CGRectMake(imgX, imgY, Model.imgW, Model.imgH);
        _titLa.frame=CGRectMake(CGRectGetMaxX(_imgView.frame)+10, 0, W-10-CGRectGetMaxX(_imgView.frame), _cellHeight);
        _imgView.image=[UIImage imageNamed:Model.imgName];
    }else {
        [_imgView setHighlighted:YES];
        _titLa.textAlignment=NSTextAlignmentCenter;
        _titLa.frame=CGRectMake(0, 0, W, _cellHeight);
    }
        _titLa.text=Model.title;
//        _titLa.textColor=Model.textColor;
        _titLa.font=[UIFont systemFontOfSize:Model.fontSize];
}
- (void)setIsShowSeparator:(BOOL)isShowSeparator{
        _isShowSeparator = isShowSeparator;
        [self setNeedsDisplay];
}

- (void)setSeparatorColor:(UIColor *)separatorColor{
        _separatorColor = separatorColor;
        [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
        if (!_isShowSeparator) return;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5)];
        [_separatorColor setFill];
        [bezierPath fillWithBlendMode:kCGBlendModeNormal alpha:1];
        [bezierPath closePath];
}
@end




#pragma mark - LSXPopMenu

@interface LSXPopMenu ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LSXPopMenu{
    
    UIView * _mainView;
    UITableView * _contentView;
    UIView * _bgView;
    
    CGPoint _anchorPoint;
    
    CGFloat _lArrowHeight;
    CGFloat _lArrowWidth;
    CGFloat _lArrowPosition;
    CGFloat _lButtonHeight;
    
    NSArray * _titles;
    NSArray * _icons;
    
    UIColor * _contentColor;
    UIColor * _separatorColor;
    
    NSMutableArray * DataArr;
    
}
@synthesize cornerRadius = kCornerRadius;

-(instancetype)initWithTitles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth delegate:(id<LSXPopMenuDelegate>)delegate{

    if(self=[super init]){
    
        _lArrowHeight = 10;
        _lArrowWidth = 15;
        _lButtonHeight = 44;
        kCornerRadius = 5.0;
        _titles = titles;
        _icons  = icons;
        _dismissOnSelected = YES;
        _isShowTriangle=YES;
        _fontSize = 15.0;
        _textColor = [UIColor blackColor];
        _offset = 0.0;
        _type = LSXPopMenuTypeDefault;
        _contentColor = [UIColor whiteColor];
        _separatorColor = [UIColor lightGrayColor];
        
        if (delegate) self.delegate = delegate;
        
        self.width = itemWidth;
        self.height = (titles.count > 5 ? 5 * _lButtonHeight : titles.count * _lButtonHeight) + 2 * _lArrowHeight;
        
        _lArrowPosition = 0.5 * self.width - 0.5 * _lArrowWidth;
        
        self.alpha = 0;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 2.0;
        
        _mainView = [[UIView alloc] initWithFrame: self.bounds];
        _mainView.backgroundColor = _contentColor;
        _mainView.layer.cornerRadius = kCornerRadius;
        _mainView.layer.masksToBounds = YES;
        
        //创建内部视图(可以是自定义视图根据需求修改)
        _contentView = [[UITableView alloc] initWithFrame: _mainView.bounds style:UITableViewStylePlain];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.delegate = self;
        _contentView.dataSource= self;
        _contentView.bounces = titles.count > 5 ? YES : NO;
        _contentView.tableFooterView = [UIView new];
        _contentView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentView.height -= 2 * _lArrowHeight;
        _contentView.centerY = _mainView.centerY;
        
        [_mainView addSubview: _contentView];
        [self addSubview: _mainView];
        
        //创建蒙版背景透明
        _bgView = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _bgView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(dismiss)];
        [_bgView addGestureRecognizer: tap];

        //模型赋值
        DataArr=[[NSMutableArray alloc]init];
        NSString * MaxTit;
        for(int i=0;i<_titles.count;i++){
            NSString * tit1=_titles[i];
            if(tit1.length>MaxTit.length){
                MaxTit=tit1;
            }
            LSXPopMenuModel * model=[[LSXPopMenuModel alloc]init];
            model.fontSize=_fontSize;
            model.textColor=_textColor;
            UIImage *img=[UIImage imageNamed:_icons[0]];
            model.title=_titles[i];
            model.imgName=_icons[i];
            model.itemWidth=self.width;
            model.imgH=img.size.height;
            model.imgW=img.size.width;
            model.tit_lenthMax=MaxTit.length;
            [DataArr addObject:model];
        }
        [_contentView reloadData];
    }
    return self;
}
- (void)dismiss
{
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.alpha = 0;
        _bgView.alpha = 0;
    } completion:^(BOOL finished) {
        self.delegate = nil;
        [self removeFromSuperview];
        [_bgView removeFromSuperview];
    }];
}
- (void)showAtPoint:(CGPoint)point
{
    _mainView.layer.mask = [self getMaskLayerWithPoint:point];
    [self show];
}

- (void)showRelyOnView:(UIView *)view
{
    CGRect absoluteRect = [view convertRect:view.bounds toView:LMainWindow];
    CGPoint relyPoint = CGPointMake(absoluteRect.origin.x + absoluteRect.size.width / 2, absoluteRect.origin.y + absoluteRect.size.height);
    _mainView.layer.mask = [self getMaskLayerWithPoint:relyPoint];
    if (self.y < _anchorPoint.y) {
        self.y -= absoluteRect.size.height;
    }
    [self show];
}

+ (instancetype)showAtPoint:(CGPoint)point titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth isShowTriangle:(BOOL)isShowTriangle delegate:(id<LSXPopMenuDelegate>)delegate
{
    LSXPopMenu *popupMenu = [[LSXPopMenu alloc] initWithTitles:titles icons:icons menuWidth:itemWidth delegate:delegate];
    popupMenu.isShowTriangle=isShowTriangle;
    [popupMenu showAtPoint:point];
    return popupMenu;
}

+(instancetype)showRelyOnView:(UIView *)view titles:(NSArray *)titles icons:(NSArray *)icons menuWidth:(CGFloat)itemWidth isShowTriangle:(BOOL)isShowTriangle delegate:(id<LSXPopMenuDelegate>)delegate{
   
    LSXPopMenu * popupMenu=[[LSXPopMenu alloc]initWithTitles:titles icons:icons menuWidth:itemWidth delegate:delegate];
     popupMenu.isShowTriangle=isShowTriangle;
    [popupMenu showRelyOnView:view];
    return popupMenu;
}


#pragma mark tableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return DataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"LSXPopupMenu";
    
    LSXPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[LSXPopMenuCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.titLa.textColor=_textColor;
    cell.titLa.font=[UIFont systemFontOfSize:_fontSize];
    cell.cellHeight=45;
    cell.Model=DataArr[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell.separatorColor = _separatorColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self dismiss];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(LSXPopupMenuDidSelectedAtIndex:LSXPopupMenu:)]) {
        
        [self.delegate LSXPopupMenuDidSelectedAtIndex:indexPath.row LSXPopupMenu:self];
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    LSXPopMenuCell *cell = [self getLastVisibleCell];
    cell.isShowSeparator = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    LSXPopMenuCell *cell = [self getLastVisibleCell];
    cell.isShowSeparator = NO;
}

- (LSXPopMenuCell *)getLastVisibleCell
{
    NSArray <NSIndexPath *>*indexPaths = [_contentView indexPathsForVisibleRows];
    indexPaths = [indexPaths sortedArrayUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
        return obj1.row < obj2.row;
    }];
    NSIndexPath *indexPath = indexPaths.firstObject;
    return [_contentView cellForRowAtIndexPath:indexPath];
}

#pragma mark private functions
- (void)setType:(LSXPopMenuType)type
{
    _type = type;
    switch (type) {
        case LSXPopMenuTypeDark:
        {
            _textColor = [UIColor lightGrayColor];
            _contentColor = [UIColor colorWithRed:0.25 green:0.27 blue:0.29 alpha:1];
            _separatorColor = [UIColor lightGrayColor];
        }
            break;
            
        default:
        {
            _textColor = [UIColor blackColor];
            _contentColor = [UIColor whiteColor];
            _separatorColor = [UIColor lightGrayColor];
        }
            break;
    }
    _mainView.backgroundColor = _contentColor;
    [_contentView reloadData];
}

- (void)setFontSize:(CGFloat)fontSize
{
    _fontSize = fontSize;
    [_contentView reloadData];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [_contentView reloadData];
}

- (void)setDismissOnTouchOutside:(BOOL)dismissOnTouchOutside
{
    _dismissOnSelected = dismissOnTouchOutside;
    if (!dismissOnTouchOutside) {
        for (UIGestureRecognizer *gr in _bgView.gestureRecognizers) {
            [_bgView removeGestureRecognizer:gr];
        }
    }
}

- (void)setIsShowShadow:(BOOL)isShowShadow
{
    _isShowShadow = isShowShadow;
    if (!isShowShadow) {
        self.layer.shadowOpacity = 0.0;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 0.0;
    }
}

- (void)setOffset:(CGFloat)offset
{
    _offset = offset;
    if (offset < 0) {
        offset = 0.0;
    }
    self.y += self.y >= _anchorPoint.y ? offset : -offset;
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    kCornerRadius = cornerRadius;
    _mainView.layer.mask = [self drawMaskLayer];
    if (self.y < _anchorPoint.y) {
        _mainView.layer.mask.affineTransform = CGAffineTransformMakeRotation(M_PI);
    }
}

- (void)show {
    
    [LMainWindow addSubview: _bgView];
    [LMainWindow addSubview: self];
    LSXPopMenuCell *cell = [self getLastVisibleCell];
    cell.isShowSeparator = NO;
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
        _bgView.alpha = 1;
    }];
}

- (void)setAnimationAnchorPoint:(CGPoint)point
{
    CGRect originRect = self.frame;
    self.layer.anchorPoint = point;
    self.frame = originRect;
}

- (void)determineAnchorPoint
{
    CGPoint aPoint = CGPointMake(0.5, 0.5);
    if (CGRectGetMaxY(self.frame) > LScreenHeight) {
        aPoint = CGPointMake(fabs(_lArrowPosition) / self.width, 1);
    }else {
        aPoint = CGPointMake(fabs(_lArrowPosition) / self.width, 0);
    }
    [self setAnimationAnchorPoint:aPoint];
}

- (CAShapeLayer *)getMaskLayerWithPoint:(CGPoint)point
{
    [self setArrowPointingWhere:point];
    CAShapeLayer *layer = [self drawMaskLayer];
    [self determineAnchorPoint];
    if (CGRectGetMaxY(self.frame) > LScreenHeight) {
        
        _lArrowPosition = self.width - _lArrowPosition - _lArrowWidth;
        layer = [self drawMaskLayer];
        layer.affineTransform = CGAffineTransformMakeRotation(M_PI);
        self.y = _anchorPoint.y - self.height;
    }
    self.y += self.y >= _anchorPoint.y ? _offset : -_offset;
    return layer;
}

- (void)setArrowPointingWhere: (CGPoint)anchorPoint
{
    _anchorPoint = anchorPoint;
    
    self.x = anchorPoint.x - _lArrowPosition - 0.5*_lArrowWidth;
    self.y = anchorPoint.y;
    
    CGFloat maxX = CGRectGetMaxX(self.frame);
    CGFloat minX = CGRectGetMinX(self.frame);
    
    if (maxX > LScreenWidth - 10) {
        self.x = LScreenWidth - 10 - self.width;
    }else if (minX < 10) {
        self.x = 10;
    }
    
    maxX = CGRectGetMaxX(self.frame);
    minX = CGRectGetMinX(self.frame);
    
    if ((anchorPoint.x <= maxX - kCornerRadius) && (anchorPoint.x >= minX + kCornerRadius)) {
        _lArrowPosition = anchorPoint.x - minX - 0.5*_lArrowWidth;
    }else if (anchorPoint.x < minX + kCornerRadius) {
        _lArrowPosition = kCornerRadius;
    }else {
        _lArrowPosition = self.width - kCornerRadius - _lArrowWidth;
    }
}
/****绘制边框***/
- (CAShapeLayer *)drawMaskLayer
{
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _mainView.bounds;
    
    CGPoint topRightArcCenter = CGPointMake(self.width-kCornerRadius, _lArrowHeight+kCornerRadius);
    CGPoint topLeftArcCenter = CGPointMake(kCornerRadius, _lArrowHeight+kCornerRadius);
    CGPoint bottomRightArcCenter = CGPointMake(self.width-kCornerRadius, self.height - _lArrowHeight - kCornerRadius);
    CGPoint bottomLeftArcCenter = CGPointMake(kCornerRadius, self.height - _lArrowHeight - kCornerRadius);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(0, _lArrowHeight+kCornerRadius)];
    [path addLineToPoint: CGPointMake(0, bottomLeftArcCenter.y)];
    [path addArcWithCenter: bottomLeftArcCenter radius: kCornerRadius startAngle: -M_PI endAngle: -M_PI-M_PI_2 clockwise: NO];
    [path addLineToPoint: CGPointMake(self.width-kCornerRadius, self.height - _lArrowHeight)];
    [path addArcWithCenter: bottomRightArcCenter radius: kCornerRadius startAngle: -M_PI-M_PI_2 endAngle: -M_PI*2 clockwise: NO];
    [path addLineToPoint: CGPointMake(self.width, _lArrowHeight+kCornerRadius)];
    [path addArcWithCenter: topRightArcCenter radius: kCornerRadius startAngle: 0 endAngle: -M_PI_2 clockwise: NO];
    [path addLineToPoint: CGPointMake(_lArrowPosition+_lArrowWidth, _lArrowHeight)];
    if(_isShowTriangle){
        [path addLineToPoint: CGPointMake(_lArrowPosition+0.5*_lArrowWidth, 0)];
        [path addLineToPoint: CGPointMake(_lArrowPosition, _lArrowHeight)];
        [path addLineToPoint: CGPointMake(kCornerRadius, _lArrowHeight)];
    }
    [path addArcWithCenter: topLeftArcCenter radius: kCornerRadius startAngle: -M_PI_2 endAngle: -M_PI clockwise: NO];
    
    [path closePath];
    
    maskLayer.path = path.CGPath;
    
    return maskLayer;
}

















@end
