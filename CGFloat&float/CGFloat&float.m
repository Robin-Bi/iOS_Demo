typedef CGFLOAT_TYPE CGFloat;

#if defined(__LP64__) && __LP64__
# define CGFLOAT_TYPE double  //64位操作系统下CGFloat是double类型
# define CGFLOAT_IS_DOUBLE 1
# define CGFLOAT_MIN DBL_MIN
# define CGFLOAT_MAX DBL_MAX
#else
# define CGFLOAT_TYPE float  //32位操作系统下CGFloat是float类型
# define CGFLOAT_IS_DOUBLE 0
# define CGFLOAT_MIN FLT_MIN
# define CGFLOAT_MAX FLT_MAX
#endif

结论是：CGFloat 能够保证代码在64位和32情况下都安全，虽然可能造成一定的消耗