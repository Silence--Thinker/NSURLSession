
#import <Foundation/Foundation.h>
//http://blog.sina.com.cn/s/blog_ae9351980101dmzg.html
@interface NSString (JSON_new)

+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithObject:(id) object;

@end
