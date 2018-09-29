memset

void *memset(void *ptr, int value, size_t num);
1.ptr 指向需要填充的内存块
2.value 传进来是一个 int 类型的值，但是这个函数填充内存块的方式是把这个 int 转成 unsigned char 的方式
3.num 表示填充value需要的字节数
4.返回一个指向内存块的指针

#include <stdio.h>
#include <string.h>
int main(){
	char str[] = "almost every programmer should know memset!";
	memset(str, '-', 16);
	puts(str);
	return 0;
}

输出：----------------grammer should know memset!
