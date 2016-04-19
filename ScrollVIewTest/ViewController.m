//
//  ViewController.m
//  ScrollVIewTest
//
//  Created by tunsuy on 12/3/16.
//  Copyright © 2016年 tunsuy. All rights reserved.
//

#import "ViewController.h"
#import "BigPicViewController.h"

#define kSeperateWidth 20
#define kContentMargin 20
#define kImageCount 5
#define kImageViewWidth 200

static NSInteger curIndex;

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic) CGFloat startOffsetX;
@property (nonatomic) CGFloat endOffsetX;
@property (nonatomic) CGPoint point;
@property (nonatomic, strong) NSArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _images = @[@"IMG1.jpg",@"IMG2.jpg",@"IMG3.png",@"IMG4.jpg",@"IMG5.jpg"];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    _scrollView.contentSize = CGSizeMake(kSeperateWidth*(kImageCount+1)+kImageViewWidth*kImageCount, CGRectGetHeight(_scrollView.frame));
    [self.view addSubview:_scrollView];
//    
//    从iOS7开始，苹果对navigationBar进行了模糊处理，并把self.navigationController.navigationBar.translucent = YES 作为默认处理;
//    这时候就会出现一个问题，当你push的控制器以ScrollView或TableView为主View时，模糊处理会使状态栏和NavigationBar挡住后面的视图，所以苹果会主动把主View的内容向下移动64px，同理，底部Tabbar会使主View向上偏移49px，Toolbar会是主View向上偏移44px
//    如果不想让主View自动发生偏移时 处理如下：
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.navigationController.navigationBar.translucent = NO;
    
    _scrollView.delegate = self;
    
    [self generateContent];
    
}

- (void)generateContent{
    
    for (int i=1; i<=kImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSeperateWidth*i+200*(i-1), kContentMargin, 200, _scrollView.frame.size.height-kContentMargin*2)];
        imageView.image = [UIImage imageNamed:_images[i-1]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor grayColor];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPic:)];
        [imageView addGestureRecognizer:tapGest];
        imageView.tag = i-1;
        [self.scrollView addSubview:imageView];
    }
}

- (void)seeBigPic:(id)sender{
    UITapGestureRecognizer *tapGest = (UITapGestureRecognizer *)sender;
    UIImageView *imageView = (UIImageView *)tapGest.view;
    
    BigPicViewController *bigPicVC = [[BigPicViewController alloc] init];
//    bigPicVC.callback(_images,imageView.tag);
    [bigPicVC curImage:_images withIndex:imageView.tag];
    NSLog(@"touch image is : %ld", (long)imageView.tag);

    [self presentViewController:bigPicVC animated:YES completion:nil];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    _endOffsetX = scrollView.contentOffset.x;
//    if (_endOffsetX > _startOffsetX) {
//        CGPoint point  = scrollView.contentOffset;
//        point.x = (CGFloat)((int)_endOffsetX%(kSeperateWidth+kImageViewWidth)*(kSeperateWidth+kImageViewWidth));
//        scrollView.contentOffset = point;
//    }
    
//    scrollView.contentOffset = _point;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    _endOffsetX = scrollView.contentOffset.x;
//    if (_endOffsetX > _startOffsetX) {
//        _point  = scrollView.contentOffset;
//        NSLog(@"_endOffsetX %d (kSeperateWidth+kImageViewWidth) %d is : %d", (int)_endOffsetX, (kSeperateWidth+kImageViewWidth), (int)_endOffsetX/(kSeperateWidth+kImageViewWidth));
//        _point.x = (CGFloat)(((int)_endOffsetX/(kSeperateWidth+kImageViewWidth)+1)*(kSeperateWidth+kImageViewWidth));
//        NSLog(@"pointX is : %f", _point.x);
//        
//        if (_point.x+(kImageViewWidth+kSeperateWidth)*2 <= kImageCount*kImageViewWidth+(kImageCount+1)*kSeperateWidth) {
//            scrollView.contentOffset = _point;
//        }
//        
//    }
//    else{
//        _point  = scrollView.contentOffset;
//        NSLog(@"_endOffsetX %f (kSeperateWidth+kImageViewWidth) %d is : %d", _endOffsetX, (kSeperateWidth+kImageViewWidth), (int)_endOffsetX/(kSeperateWidth+kImageViewWidth));
//        _point.x = (CGFloat)(((int)_endOffsetX/(kSeperateWidth+kImageViewWidth))*(kSeperateWidth+kImageViewWidth));
//        NSLog(@"pointX is : %f", _point.x);
//        
//        //        if (_point.x-(kImageViewWidth+kSeperateWidth)*2 >= kImageCount*kImageViewWidth+(kImageCount+1)*kSeperateWidth) {
//        scrollView.contentOffset = _point;
//        //        }
//    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    _endOffsetX = scrollView.contentOffset.x;
    if (_endOffsetX > _startOffsetX) {
        _point  = scrollView.contentOffset;
        NSLog(@"_endOffsetX %d (kSeperateWidth+kImageViewWidth) %d is : %d", (int)_endOffsetX, (kSeperateWidth+kImageViewWidth), (int)_endOffsetX/(kSeperateWidth+kImageViewWidth));
        _point.x = (CGFloat)(((int)_endOffsetX/(kSeperateWidth+kImageViewWidth)+1)*(kSeperateWidth+kImageViewWidth));
        NSLog(@"pointX is : %f", _point.x);
    
        if (_point.x+(kImageViewWidth+kSeperateWidth)*2 <= kImageCount*kImageViewWidth+(kImageCount+1)*kSeperateWidth) {
            scrollView.contentOffset = _point;
        }
        
    }
    else{
        _point  = scrollView.contentOffset;
        NSLog(@"_endOffsetX %f (kSeperateWidth+kImageViewWidth) %d is : %d", _endOffsetX, (kSeperateWidth+kImageViewWidth), (int)_endOffsetX/(kSeperateWidth+kImageViewWidth));
        _point.x = (CGFloat)(((int)_endOffsetX/(kSeperateWidth+kImageViewWidth))*(kSeperateWidth+kImageViewWidth));
        NSLog(@"pointX is : %f", _point.x);
        
//        if (_point.x-(kImageViewWidth+kSeperateWidth)*2 >= kImageCount*kImageViewWidth+(kImageCount+1)*kSeperateWidth) {
            scrollView.contentOffset = _point;
//        }
    }
}

+ (void)curIndex:(NSInteger)index{
    curIndex = index;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGPoint point = _scrollView.contentOffset;
    point.x = (kSeperateWidth+kImageViewWidth)*curIndex;
    _scrollView.contentOffset = point;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
