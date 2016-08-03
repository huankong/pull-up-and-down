//
//  ViewController.m
//  下拉放大
//
//  Created by ldy on 16/2/20.
//  Copyright © 2016年 ldy. All rights reserved.
//

#import "ViewController.h"
#define KScreenH    [UIScreen mainScreen].bounds.size.height
#define KScreenW    [UIScreen mainScreen].bounds.size.width
#define KHeight     300
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_imageView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.translucent = NO;
    _imageView.frame = CGRectMake(0, 64, KScreenW, KHeight);
//    UIImage *newImage = [self imageWithcontentY:64];

    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
   
//    UIImage *topImage = [self imageWithcontentY:64];
//    UIImageView *barImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, KScreenW, 20)];
//    barImage.image = [UIImage imageNamed:@"1"];
//    [self.navigationController.navigationBar addSubview:barImage];
    
//    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor greenColor];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, KScreenW, KScreenH+64) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:tableView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KHeight)];
    headView.backgroundColor = [UIColor redColor];
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KHeight)];
    _imageView.image = [UIImage imageNamed:@"1.png"];

    [self.view addSubview:_imageView];
    
    
    tableView.tableHeaderView = headView;
 
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 200, 200, 200)];
    vi.backgroundColor = [UIColor purpleColor];
//    [_imageView addSubview:vi];
//    [tableView insertSubview:vi aboveSubview:_imageView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentY = scrollView.contentOffset.y;
//    NSLog(@"%f",contentY);
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
//   self.navigationController.navigationBar.translucent = YES;
    if (contentY > -64) {
        _imageView.frame = CGRectMake(0, -contentY-64, KScreenW, KHeight);
        if (contentY > KHeight-64*2) {
            
            UIImage *oldImage = [UIImage imageNamed:@"1.png"];
            CGFloat imageH = oldImage.size.height;
            CGFloat imageW = oldImage.size.width;
            CGFloat cgH = imageH*64/KHeight;
            CGImageRef cgImage = CGImageCreateWithImageInRect(oldImage.CGImage, CGRectMake(0, imageH-cgH, imageW, cgH));
            UIImage *newImage = [UIImage imageWithCGImage:cgImage];

            CGImageRef cgTopImage = CGImageCreateWithImageInRect(oldImage.CGImage, CGRectMake(0, imageH-imageH*64/KHeight, oldImage.size.width, imageH*20/KHeight));
            UIImage *newTopImage = [UIImage imageWithCGImage:cgTopImage];
            UIImageView *barImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -20, KScreenW, 20)];
            barImage.image = newTopImage;
            for(UIImageView *naviImage in self.navigationController.navigationBar.subviews)
            {
//                if ([naviImage isEqual:barImage]) {
                if(naviImage.frame.size.height == 20){
                    
                    [naviImage removeFromSuperview];
                }
            }
            [self.navigationController.navigationBar addSubview:barImage];

            
            [self.navigationController.navigationBar setBackgroundImage:newImage forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.clipsToBounds = NO;
//            self.navigationController.navigationBar.translucent = NO;
        }
    }
    else if (contentY < -64){
        CGFloat nowW = KScreenW*(-contentY+KHeight-64)/KHeight;
        CGFloat nowX = -(nowW-KScreenW)/2.0;
        _imageView.frame = CGRectMake(nowX, 0, nowW, -contentY+KHeight-64);
    }
}
//- (UIImage *)imageWithcontentY:(CGFloat)contentY
//{
//    UIImage *image = [UIImage imageNamed:@"1.png"];
//    CGImageRef cgRef = image.CGImage;
//    CGFloat y = (contentY)*image.size.height/KHeight;
//    CGImageRef imageRef = CGImageCreateWithImageInRect(cgRef, CGRectMake(0,y,image.size.width, 64));
//    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//    return thumbScale;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(10)*0.1 green:arc4random_uniform(10)*0.1 blue:arc4random_uniform(10)*0.1 alpha:1];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
