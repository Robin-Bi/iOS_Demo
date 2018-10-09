#pragma 一般常用的功能是分段注释

#pragma 另外一个功能就是处理编译器警告

忽略参数非空检查（”-Wnonnull”）
#pragma clang diagnostic push 
#pragma clang diagnostic ignored "-Wnonnull" 
//code
#pragma clang diagnostic pop 

忽略方法弃用警告（”-Wdeprecated-declarations”）
#pragma clang diagnostic push 
#pragma clang diagnostic ignored "-Wdeprecated-declarations" 
//code
#pragma clang diagnostic pop 

忽略不兼容指针类型
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
//code这里插入相关的代码
#pragma clang diagnostic pop

忽略未使用变量
#pragma clang diagnostic push
#pragma clang diagnostic ignored "--Wunused-variable"
//code这里插入相关的代码
#pragma clang diagnostic pop

忽略selector中使用了不存在的方法名（在使用反射机制通过类名创建类对象的时候会需要的）
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
//code这里插入相关的代码
#pragma clang diagnostic pop
