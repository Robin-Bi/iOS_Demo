//
//  ViewController.m
//  TextKitDemo
//
//  Created by 毕瑞 on 16/3/7.
//  Copyright © 2016年 毕瑞. All rights reserved.
//

#import "ViewController.h"
#import "TextView.h"
#import <CoreText/CTFramesetter.h>

#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width
NSString *textStr = @"今天（北京时间2013年06月11日）凌晨，由库克引领的苹果发布了iOS7，本次新系统的发布可以说是iOS自发布以来最大的一次变革，iOS的设计由之前的拟物变为了现在的扁平化——这也标志着苹果真正的进入了库克时代。\
目前苹果只发布了iOS7的beta版本，虽然据闻有不少bug，不过无论你对iOS7的设计是吐槽也好，惊艳也罢，基调已经定下来了，苹果的这次革新，是否能够获得用户的青睐，就让用户来检验吧。\
按照往年的惯例，iOS7的release版本预计会在今年9月份发布，在这差不多3个月的时间里面，苹果的主要任务估计就是完善并加强iOS7的稳定性了。\
为了观察开发者对WWDC2013的关注情况，在WWDC开幕的时候，笔者分别在新浪微博和Twitter上检索WWDC关键字，发现相关新讯息更新的速度非常快，从这一个角度来说，无论是国内的开发者，还是国外的开发者，对苹果非常的期待。\
虽说iOS和相关设备的每次升级更新，都会引来大批的code monkey吐槽（譬如去年iPhone5的发布），不过吐槽归吐槽，想想社会是进步的，没有大胆的尝试，又哪来进步呢——无论成功与否，苹果这种引领业界创新";

@interface ViewController ()

@property (strong, nonatomic)  UITextView *textView;
@property (strong, nonatomic)  UIImageView *imageView;

@property (nonatomic) CGPoint gestureStartPosition;
@property (nonatomic) CGPoint gestureStartCenter;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    [self textKitDemo];
    
//    [self textAndPicture];
//    TextView *text = [[TextView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
//    [self.view addSubview:text];
    
//    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, kScreen_height)];
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self.view setNeedsLayout];
//    [self.view setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.view.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, self.view.bounds);
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World"];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attString.length), path, NULL);
    
    CTFrameDraw(frame, context);
    
    CFRelease(frame);
    CGPathRelease(path);
    CGContextRelease(context);
}


- (void)textAndPicture{
    // 装载内容的容器
    NSTextStorage *storage = [NSTextStorage new];
    [storage replaceCharactersInRange:NSMakeRange(0, 0)
                           withString:
     @"未选择的路-弗罗斯特\n\n黄色的树林里分出两条路，\n可惜我不能同时去涉足，\n我在那路口久久伫立，\n我向着一条路极目望去，\n直到它消失在丛林深处。\n但我却选了另外一条路，\n它荒草萋萋，十分幽寂，\n显得更诱人、更美丽，\n虽然在这两条小路上，\n都很少留下旅人的足迹，\n虽然那天清晨落叶满地，\n两条路都未经脚印污染。\n啊，留下一条路等改日再见！\n但我知道路径延绵无尽头，\n恐怕我难以再回返。\n也许多少年后在某个地方，\n我将轻声叹息把往事回顾，\n一片树林里分出两条路，\n而我选了人迹更少的一条，\n从此决定了我一生的道路。"];
    
    // 给内容容器添加布局(可以添加多个)
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    [storage addLayoutManager:layoutManager];
    
    // 高亮容器里面的某些内容
    [storage addAttribute:NSForegroundColorAttributeName
                    value:[UIColor redColor]
                    range:NSMakeRange(0, 5)];
    [storage addAttribute:NSForegroundColorAttributeName
                    value:[UIColor greenColor]
                    range:NSMakeRange(6, 4)];
    
    // 带有内容和布局的容器
    NSTextContainer *textContainer = [NSTextContainer new];
    [layoutManager addTextContainer:textContainer];
    
    // 设置textContainer中要排斥的路径
    UIImage *image = [UIImage imageNamed:@"photo"];
    CGRect areaRect = CGRectMake(5, 5, image.size.width, image.size.height);
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithRect:areaRect];
    textContainer.exclusionPaths = @[ovalPath];
    
    // 给TextView添加带有内容和布局的容器
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 20, 300, 400)
                                               textContainer:textContainer];
    textView.layer.borderWidth = 1;
    textView.scrollEnabled = NO;
    textView.editable      = NO;
    [self.view addSubview:textView];
    
    // 要显示的图片
    UIImageView *showImageView = [[UIImageView alloc] initWithFrame:areaRect];
    showImageView.image = image;
    [textView addSubview:showImageView];
}

- (void)textKitDemo{
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 60, kScreen_width, kScreen_height-180)];
    self.textView.text = textStr;
    [self.view addSubview:self.textView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreen_width-80)/2, CGRectGetMaxY(self.textView.frame), 80, 80)];
    self.imageView.image = [UIImage imageNamed:@"logo"];
    self.imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    
    //创建平移手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(imagePanned:)];
    //图片添加手势
    [self.imageView addGestureRecognizer:pan];
    
    //扣除贝塞尔路径,贝塞尔路径式的数组
    self.textView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
}

- (UIBezierPath *)translatedBezierPath {
    //取得矩形区域
    CGRect imageRect = [self.textView convertRect:self.imageView.frame fromView:self.view];
    //创建贝塞尔路径
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:imageRect];
    
    return bezierPath;
}


- (void)imagePanned:(id)sender{
    
    if ([sender isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *localSender = sender;
        
        if (localSender.state == UIGestureRecognizerStateBegan) {
            //开始状态，取得imageView在textView的中的point/center
            self.gestureStartPosition = [localSender translationInView:self.textView];
            self.gestureStartCenter = self.imageView.center;
            
        }else if (localSender.state == UIGestureRecognizerStateChanged) {
            //当前位置
            CGPoint currentPoint = [localSender translationInView:self.textView];
            
            CGFloat distanceX = currentPoint.x - self.gestureStartPosition.x;
            CGFloat distanceY = currentPoint.y - self.gestureStartPosition.y;
            
            //中心点变化
            CGPoint newCenter = self.gestureStartCenter;
            newCenter.x += distanceX;
            newCenter.y += distanceY;
            
            self.imageView.center = newCenter;
            
            //imageView的位置发生变化，贝塞尔路径重绘
            self.textView.textContainer.exclusionPaths = @[[self translatedBezierPath]];
        }else if (localSender.state == UIGestureRecognizerStateEnded){
            self.gestureStartPosition = CGPointZero;
            self.gestureStartCenter = CGPointZero;
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
