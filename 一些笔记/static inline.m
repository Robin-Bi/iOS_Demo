static inline & static void *

//如果你的.m文件需要频繁调用一个函数,可以用static inline来声明,这相当于把函数体当做一个大号的宏定义.
static inline NSString * AFMultipartFormInitialBoundary(NSString *boundary) {
    return [NSString stringWithFormat:@"--%@%@", boundary, kAFMultipartFormCRLF];
}

//static void * 这种声明方式常用于kvo,用来当做contenxt的key来添加. 
//在编译的时候创建一个唯一的指针.因为kvo的时候context如果不小心重复了,会发生奇怪的事情.用这种方式可以避免.
static void *SYAFHTTPRequestSerializerObserverContext = &SYAFHTTPRequestSerializerObserverContext;
[self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:SYAFHTTPRequestSerializerObserverContext];
[self removeObserver:self forKeyPath:keyPath context:SYAFHTTPRequestSerializerObserverContext];

