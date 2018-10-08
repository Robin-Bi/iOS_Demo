//换一个字体的两种处理：
//1.全部换可以使用分类
+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getClassMethod([self class], @selector(systemFontOfSize:));
        Method newMethod = class_getClassMethod([self class], @selector(fontchanger_YaheiFontOfSize:));
        method_exchangeImplementations(oldMethod, newMethod);
    });
}

+ (UIFont *)fontchanger_YaheiFontOfSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"MicrosoftYaHei" size:fontSize];
    if (!font)return [self fontchanger_YaheiFontOfSize:fontSize];
    return font;
}

#import "UILabel+FontChange.h"
#define CustomFontName @"FZLBJW--GB1-0"
@implementation UILabel (FontChange)
+ (void)load {
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(willMoveToSuperview:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(myWillMoveToSuperview:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}
- (void)myWillMoveToSuperview:(UIView *)newSuperview {
    [self myWillMoveToSuperview:newSuperview];
//    if ([self isKindOfClass:NSClassFromString(@"UIButtonLabel")]) {
//        return;
//    }  //设置部分不用换的
    if (self) {
        if (self.tag == 10086) { //设置部分不用换的
            self.font = [UIFont systemFontOfSize:self.font.pointSize];
        } else {
            if ([UIFont fontNamesForFamilyName:CustomFontName])
                self.font  = [UIFont fontWithName:CustomFontName size:self.font.pointSize];
        }
    }
}
@end

//2.部分换可以通过代码设置
//由于下载的时候需要使用的名字是PostScript名称，需要使用Mac内自带的应用“字体册“来获得相应字体的PostScript名称。
- (void)viewDidLoad {
    [super viewDidLoad];
    
    for(NSString *familyName in [UIFont familyNames]){
        NSLog(@"Font FamilyName = %@",familyName); //输出字体族科名字
        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\t%@",fontName);         //输出字体族科下字样名字
        }
    }
    _myLabel.font = [UIFont fontWithName:@"FZLBJW--GB1-0" size:17.0f];
    _myButton.titleLabel.font = [UIFont fontWithName:@"FZLBJW--GB1-0" size:17.0f];
}