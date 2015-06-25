#import "LORTrackerLoadMoreCell.h"

@interface LORTrackerLoadMoreCell ()
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property(weak, nonatomic) IBOutlet UILabel *title;
@property(weak, nonatomic) IBOutlet UIImageView *reloadImage;

@end

@implementation LORTrackerLoadMoreCell

- (void)awakeFromNib {
  self.reloadImage.image = [self.reloadImage.image imageWithColor:[UIColor whiteColor]];
}

- (void)prepareForReuse {
  self.loadingIndicator.hidden = YES;
  self.title.hidden = YES;
  self.reloadImage.hidden = NO;

  [self.loadingIndicator stopAnimating];

  self.reloadImage.alpha = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  if (selected) {
    [self.loadingIndicator startAnimating];
    self.title.text = @"Loading more...";

    [UIView animateWithDuration:0.2
        animations:^{
          self.reloadImage.alpha = 0;
        }
        completion:^(BOOL finished) {
          self.loadingIndicator.hidden = NO;
          self.title.hidden = NO;
        }];
  }
}

@end
