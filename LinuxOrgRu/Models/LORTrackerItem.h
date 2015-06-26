#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface LORTrackerItem : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy, readonly) NSNumber *identifier;
@property(nonatomic, copy, readonly) NSURL *url;
@property(nonatomic, copy, readonly) NSString *title;
@property(nonatomic, copy, readonly) NSString *groupTitle;
@property(nonatomic, copy, readonly) NSDate *postDate;
@property(nonatomic, copy, readonly) NSDate *lastModifiedDate;
@property(nonatomic, copy, readonly) NSString *lastCommentedBy;
@property(nonatomic, copy, readonly) NSNumber *pages;
@property(nonatomic, copy, readonly) NSString *author;
@property(nonatomic, copy, readonly) NSArray *tags;

@end
