#import "LORLeftMenuTableViewController.h"

@interface LORLeftMenuTableViewController ()
@property(weak, nonatomic) IBOutlet UITableViewCell *newsCell;
@property(weak, nonatomic) IBOutlet UITableViewCell *galleryCell;
@property(weak, nonatomic) IBOutlet UITableViewCell *trackerCell;

@end

@implementation LORLeftMenuTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIView *bgColorView = [[UIView alloc] init];
  bgColorView.backgroundColor =
      [UIColor colorWithRed:92.0 / 255.0 green:53.0 / 255.0 blue:102.0 / 255.0 alpha:1.0];
  _trackerCell.selectedBackgroundView = bgColorView;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  // default selection
  [self.tableView selectRowAtIndexPath:[self.tableView indexPathForCell:_trackerCell]
                              animated:NO
                        scrollPosition:UITableViewScrollPositionNone];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - TableView Delegate

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([indexPath isEqual:[self.tableView indexPathForSelectedRow]]) {
    [self.sidePanelController showCenterPanelAnimated:YES];
  } else if ([indexPath isEqual:[tableView indexPathForCell:_trackerCell]]) {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.sidePanelController.centerPanel =
        [storyboard instantiateViewControllerWithIdentifier:@"TrackerNav"];
  }

  return indexPath;
}

@end
