//
//  ViewController.m
//  LSXPopMenu
//
//  Created by LSX on 17/3/2.
//  Copyright © 2017年 lsx. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"
@interface ViewController ()<LSXPopMenuDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIButton * bt=[UIButton new];
    bt.tag=1;
    [bt addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    bt.backgroundColor=[UIColor redColor];
    bt.frame=CGRectMake(self.view.bounds.size.width-80, 100, 60, 30);
    [self.view addSubview:bt];
   
   
    UIButton * bt2=[UIButton new];
    bt2.tag=2;
    [bt2 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    bt2.backgroundColor=[UIColor redColor];
    bt2.frame=CGRectMake(100, self.view.height-40, 60, 30);
    [self.view addSubview:bt2];
    
    
    UIButton * bt3=[UIButton new];
    bt3.tag=3;
    [bt3 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    bt3.backgroundColor=[UIColor redColor];
    bt3.frame=CGRectMake(100, 100, 60, 30);
    [self.view addSubview:bt3];
    
}

-(void)LSXPopupMenuDidSelectedAtIndex:(NSInteger)index LSXPopupMenu:(LSXPopMenu *)LSXPopupMenu{

    NSLog(@"------点击---%ld",(long)index);
}

-(void)btn:(UIButton *)sender{
    
    
    /****根据传入的View  弹出视图****/
    if(sender.tag==1){
    
         [LSXPopMenu showRelyOnView:sender titles:@[@"可以点么",@"好的"]  icons:@[@"yuezhifu",@"blood_weixin"] menuWidth:120 isShowTriangle:YES delegate:self];
    }else if(sender.tag==2){
     /****制定 Point 弹出视图****/
          [LSXPopMenu showAtPoint:CGPointMake(self.view.centerX, self.view.centerY) titles:@[@"可以点么",@"好的"] icons:@[@"yuezhifu",@"blood_weixin"] menuWidth:200 isShowTriangle:NO delegate:self];
        
    }else{
    
        LSXPopMenu * menu=[[LSXPopMenu alloc]initWithTitles:@[@"可以点么",@"好的"] icons:@[@"yuezhifu",@"blood_weixin"] menuWidth:200 delegate:self];
        menu.isShowTriangle=YES;//是否显示三角
        menu.cornerRadius=0;//圆角半径
        
        menu.isShowShadow=YES;//是否显示阴影
        
        //menu.type=LSXPopMenuTypeDark;//显示
        
        menu.textColor=[UIColor redColor];
        menu.fontSize=25;
        
        [menu showRelyOnView:sender];
    }
}

@end
