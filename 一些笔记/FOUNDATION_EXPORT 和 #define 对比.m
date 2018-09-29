FOUNDATION_EXPORT 和 #define 对比

//很多框架的.h文件这样定义
FOUNDATION_EXPORT double FMDBVersionNumber;
FOUNDATION_EXPORT const unsigned char FMDBVersionString[];

//.m文件中这样定义
NSString * const kMyConstantString = @"Hello";
NSString * const kMyConstantString2 = @"World";

//常用#define定义
#define kMyConstantString @"Hello"

区别是：
使用第一种方法在检测字符串的值是否相等的时候更快：对于第一种你可以直接使用(stringInstance == MyFirstConstant)来比较，而define则使用的是这种([stringInstance isEqualToString:MyFirstConstant])
第一种直接比较的是指针地址,而第二个则是一一比较字符串的每一个字符是否相等.
