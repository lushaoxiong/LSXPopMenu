# LSXPopMenu
一个特别简单的弹出视图,可扩展性高.欢迎下载使用.......如果满意请给个star
<br>
<br>
[简书地址](http://www.jianshu.com/u/7b90ca67ddc1)
<br>
<br>
![](https://github.com/lushaoxiong/LSXPopMenu/blob/master/2017-03-13%2011_28_03.gif) 
<br>
<br>
##使用说明
```
#import "LSXPopMenu.h"
@interface ViewController ()<LSXPopMenuDelegate>

/****根据传入的View  弹出视图****/

[LSXPopMenu showRelyOnView:sender titles:@[@"可以点么",@"好的"]  icons:@[@"yuezhifu",@"blood_weixin"] menuWidth:120 isShowTriangle:YES delegate:self];

/****制定 Point 弹出视图****/

[LSXPopMenu showAtPoint:CGPointMake(self.view.centerX, self.view.centerY) titles:@[@"可以点么",@"好的"] icons:@[@"yuezhifu",@"blood_weixin"] menuWidth:200 isShowTriangle:NO delegate:self];

LSXPopMenu * menu=[[LSXPopMenu alloc]initWithTitles:@[@"可以点么",@"好的"] icons:@[@"yuezhifu",@"blood_weixin"] menuWidth:200 delegate:self];
        menu.isShowTriangle=YES;//是否显示三角
        menu.cornerRadius=0;//圆角半径
        
        menu.isShowShadow=YES;//是否显示阴影
        
        //menu.type=LSXPopMenuTypeDark;//显示
        
        menu.textColor=[UIColor redColor];
        menu.fontSize=25;
        
        [menu showRelyOnView:sender];
```
