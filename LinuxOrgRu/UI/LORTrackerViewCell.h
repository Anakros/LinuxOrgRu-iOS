#import <UIKit/UIKit.h>
#import "LORTrackerItem.h"

@interface LORTrackerViewCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UILabel *title;
@property(weak, nonatomic) IBOutlet UILabel *groupAndTags;
@property(weak, nonatomic) IBOutlet UILabel *author;
@property(weak, nonatomic) IBOutlet UILabel *date;

- (void)configureWithModel:(LORTrackerItem *)model;

@end
