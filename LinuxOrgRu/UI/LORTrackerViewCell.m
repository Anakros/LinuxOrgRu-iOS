#import "LORTrackerViewCell.h"
#import "DTCoreText.h"

@implementation LORTrackerViewCell

- (void)awakeFromNib {
  UIView *bgColorView = [[UIView alloc] init];
  bgColorView.backgroundColor =
      [UIColor colorWithRed:92.0 / 255.0 green:53.0 / 255.0 blue:102.0 / 255.0 alpha:1.0];
  self.selectedBackgroundView = bgColorView;
}

- (void)prepareForReuse {
  [self layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

- (NSDateFormatter *)dateFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];

  formatter.dateFormat = @"dd.MM.yy HH:mm";

  return formatter;
}

- (void)configureWithModel:(LORTrackerItem *)model {
  self.title.text = [model.title stringByReplacingHTMLEntities];
  self.groupAndTags.attributedText = [self groupsAndTagsUsing:model.groupTitle tags:model.tags];
  self.author.text = model.lastCommentedBy;
  self.date.text = [[self dateFormatter] stringFromDate:model.lastModifiedDate];

  [self layoutIfNeeded];
}

- (NSAttributedString *)groupsAndTagsUsing:(NSString *)groupTitle tags:(NSArray *)tags {
  NSString *tagsString = [tags componentsJoinedByString:@", "];
  NSString *concatenatedString = [NSString stringWithFormat:@"%@  %@", groupTitle, tagsString];
  NSMutableAttributedString *string =
      [[NSMutableAttributedString alloc] initWithString:concatenatedString];

  [string addAttributes:@{
    NSForegroundColorAttributeName : [UIColor whiteColor]
  } range:NSMakeRange(0, groupTitle.length - 1)];
  [string addAttributes:@{
    NSForegroundColorAttributeName :
        [UIColor colorWithRed:252.0 / 255.0 green:175.0 / 255.0 blue:62.0 / 255.0 alpha:1.0]
  } range:NSMakeRange(groupTitle.length + 2, tagsString.length)];

  return string;
}

@end
