#import "LORTrackerItem.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"
#import "MTLValueTransformer.h"

@implementation LORTrackerItem

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  return @{
    @"identifier" : @"id",
    @"url" : @"url",
    @"title" : @"title",
    @"groupTitle" : @"groupTitle",
    @"postDate" : @"postDate",
    @"lastModifiedDate" : @"lastModified",
    @"lastCommentedBy" : @"lastCommentedBy",
    @"pages" : @"pages",
    @"tags" : @"tags",
    @"author" : @"author"
  };
}

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
  return dateFormatter;
}

+ (NSValueTransformer *)urlJSONTransformer {
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)postDateJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success,
                                                               NSError *__autoreleasing *error) {
    return [[self dateFormatter] dateFromString:dateString];
  } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
    return [[self dateFormatter] stringFromDate:date];
  }];
}

+ (NSValueTransformer *)lastModifiedDateJSONTransformer {
  return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success,
                                                               NSError *__autoreleasing *error) {
    return [[self dateFormatter] dateFromString:dateString];
  } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
    return [[self dateFormatter] stringFromDate:date];
  }];
}

@end
