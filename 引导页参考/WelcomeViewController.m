//
//  WelcomeViewController.m
//  qwe
//
//  Created by 黄维荣 on 16/4/11.
//  Copyright © 2016年 黄维荣. All rights reserved.
//

#import "WelcomeViewController.h"
#import "RootNavigationController.h"
#import "AppDelegate.h"
#import "LockViewController.h"
@interface WelcomeViewController ()<UIScrollViewDelegate>
//scrollView属性
@property (retain, nonatomic)UIScrollView *scrollerView;
//page
@property (nonatomic, retain)UIPageControl *page;
//动作计数
@property (nonatomic, assign)NSInteger actionNum;
//background
@property (nonatomic, retain)UIView *bgView;
//backGround
@property (nonatomic, retain)UIView *secBgView;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addScrollerView];
    [self promptView];
    self.actionNum = 0;
}
#pragma mark------scrollView方法-------
-(void)addScrollerView{
    self.scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    //设置代理
    self.scrollerView.delegate = self;
    //打开交互
    self.scrollerView.userInteractionEnabled = YES;
    //添加视图
    [self.view addSubview:_scrollerView];
    //在大是scrollView上添加手势
    //->1.创建手势(轻点)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    //->2.添加手势
    [self.scrollerView addGestureRecognizer:tap];
    //创建图片组名称
    NSArray *imageArr = @[@"wel1",@"wel2"];
    //创建scrollView内容大小
    self.scrollerView.contentSize = CGSizeMake(320 *imageArr.count, 568);
    for (int i = 0; i < imageArr.count; i ++) {
        //大s添加小s
        //每一张小s上 有自己对应的唯一一张view
        UIScrollView *smallScrolView = [[UIScrollView alloc]init];
        //每个小的s设置代理
        smallScrolView.delegate = self;

        smallScrolView.frame = CGRectMake(i * 320, 0, 320, 568);
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        imageView.frame = CGRectMake(0, 0, 320, 568);
        
        [imageView setImage:[UIImage imageNamed:imageArr[i]]];

        [self.scrollerView addSubview:smallScrolView];
        
        [smallScrolView addSubview:imageView];
    }
    //设置是否整屏反动
    self.scrollerView.pagingEnabled = YES;
    
    //设置边界是否回弹 默认yes
    self.scrollerView.bounces = NO;
    //设置是否显示横向滚动条
    self.scrollerView.showsHorizontalScrollIndicator = NO;
    
    //设置是否显示纵向滚动条
    self.scrollerView.showsVerticalScrollIndicator = NO;
    //page  导航 +++++++++++++
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(110, 540, 100, 30)];
    //设置小原点的个数
    self.page.numberOfPages = 2;
    //当前小圆点的颜色
    self.page.currentPageIndicatorTintColor = [UIColor blackColor];
    //非当前小原点的颜色
    self.page.pageIndicatorTintColor = [UIColor whiteColor];
    //添加
    [self.view addSubview:_page];
}
#pragma mark===========结束减速调用的代理方法=============
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    self.page.currentPage = self.scrollerView.contentOffset.x/320;
}

#pragma mark-------手势事件-------
-(void)tapAction:(UITapGestureRecognizer *)tap{
 
    if (self.actionNum == 0) {
        self.bgView.subviews[0].hidden = YES;
        self.bgView.subviews[1].hidden = NO;
        self.bgView.subviews[2].hidden = YES;
        self.actionNum = 1;
    }else if (self.actionNum == 1){
        self.bgView.subviews[0].hidden = YES;
        self.bgView.subviews[1].hidden = YES;
        self.bgView.subviews[2].hidden = NO;
        self.actionNum = 2;
    }else if (self.actionNum == 2){
        [UIView animateWithDuration:0.7 animations:^{
            self.scrollerView.contentOffset = CGPointMake(320 * 1, 0);
        }];
        self.actionNum = 3;
    }else if (self.actionNum == 3){
        self.secBgView.subviews[0].hidden = YES;
        self.secBgView.subviews[1].hidden = NO;
        //动画
        [self performSelector:@selector(changeRootVcAction) withObject:nil afterDelay:2];
    }
}
#pragma mark-------更换根视图-------
-(void)changeRootVcAction{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    RootNavigationController *rootNav = [story instantiateViewControllerWithIdentifier:@"rootNav"];
    LockViewController *rootVc = [story instantiateViewControllerWithIdentifier:@"lockView"];
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = rootVc;
}
#pragma mark-------在smallScrolView上添加提示(界面搭建)------
-(void)promptView{
    //设置灰色背景图
    self.bgView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.bgView.backgroundColor = [UIColor blackColor];
    self.bgView.alpha = 0.5;
    self.bgView.userInteractionEnabled = YES;
    //取出第一张图片
    UIScrollView *smlSclView = self.scrollerView.subviews[0];
    [smlSclView addSubview:self.bgView];
    //图片1
    UIImageView *imgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(20, 35, 100, 100)];
    imgView1.image = [UIImage imageNamed:@"prom1"];
    [self.bgView addSubview:imgView1];
    //图片2
    UIImageView *imgView2 = [[UIImageView alloc]initWithFrame:CGRectMake(210, 35, 100, 100)];
    imgView2.image = [UIImage imageNamed:@"prom2"];
    [self.bgView addSubview:imgView2];
    imgView2.hidden = YES;
    //图片3
    UIImageView *imgView3 = [[UIImageView alloc]initWithFrame:CGRectMake(140, 280, 100, 100)];
    imgView3.image = [UIImage imageNamed:@"prom3"];
    [self.bgView addSubview:imgView3];
    imgView3.hidden = YES;
    
    //第二个界面
    self.secBgView = self.scrollerView.subviews[1].subviews[0];
    //
    UIImageView *secImgView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 135, 100, 60)];
    secImgView.image = [UIImage imageNamed:@"prom4"];
    [self.secBgView addSubview:secImgView];
    //
    UIImageView *secImgView1 = [[UIImageView alloc]initWithFrame:CGRectMake(125, 140, 150, 80)];
    secImgView1.image = [UIImage imageNamed:@"welcome4"];
    [self.secBgView addSubview:secImgView1];
    secImgView1.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
