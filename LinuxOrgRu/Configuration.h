#ifdef Configuration_importingFromDotM

#define LOR_NSString_CONST(key, value) NSString *const key = value;
#else
#define LOR_NSString_CONST(key, value) FOUNDATION_EXPORT NSString *key;
#endif

LOR_NSString_CONST(LOR_Keys_Server, @"https://www.linux.org.ru/api")