#import "LORTrackerViewController.h"
#import "LORSidePanelController.h"
#import "LORTrackerViewCell.h"
#import "LORTrackerLoadMoreCell.h"

#import "DTCoreText.h"

@interface LORTrackerViewController ()
@property(nonatomic, strong) NSArray *trackerItems;
@property BOOL didReachedEnd;
@end

@implementation LORTrackerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.didReachedEnd = NO;

  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 92.0;
  self.tableView.separatorColor = [UIColor whiteColor];

  self.refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl.tintColor = [UIColor whiteColor];
  [self.refreshControl addTarget:self
                          action:@selector(refreshControlPulled)
                forControlEvents:UIControlEventValueChanged];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self loadDataWithOffset:0 sender:self];
}

- (void)loadDataWithOffset:(NSUInteger)offset sender:(id)sender {
  if (self.refreshControl.refreshing && ![sender isKindOfClass:[UIRefreshControl class]]) {
    return;
  }

  [self.refreshControl beginRefreshing];

  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:@"https://www.linux.org.ru/api/tracker"
      parameters:@{
        @"filter" : @"all",
        @"offset" : @(offset)
      }
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *trackerItems = responseObject[@"trackerItems"];

        if (trackerItems.count == 0) {
          self.didReachedEnd = YES;
        } else {
          if (offset > 0 && offset > [_trackerItems count] - 1) {
            self.trackerItems =
                [_trackerItems arrayByAddingObjectsFromArray:responseObject[@"trackerItems"]];
          } else {
            self.trackerItems = responseObject[@"trackerItems"];

            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM d, h:mm a"];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc]
                initWithString:[NSString stringWithFormat:@"Last update: %@",
                                                          [formatter stringFromDate:[NSDate date]]]
                    attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
          }

          self.didReachedEnd = NO;
        }

        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to fetch tracker data: %@", error);
        [self.refreshControl endRefreshing];
      }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (_trackerItems.count > 0) {
    return self.didReachedEnd ? 1 : 2;
  }

  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  switch (section) {
  case 0:
    return [_trackerItems count];
  case 1:
    return _trackerItems.count > 0 ? 1 : 0;
  default:
    return 0;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  switch (indexPath.section) {
  case 0: {
    LORTrackerViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"TrackerItem" forIndexPath:indexPath];
    NSDictionary *trackerItem = _trackerItems[indexPath.row];

    [cell.title setText:[trackerItem[@"title"] stringByReplacingHTMLEntities]];
    NSMutableAttributedString *groupAndTagsString = [[NSMutableAttributedString alloc]
        initWithString:[NSString
                           stringWithFormat:@"%@  %@", trackerItem[@"groupTitle"],
                                            [trackerItem[@"tags"] componentsJoinedByString:@", "]]];
    [groupAndTagsString addAttributes:@{
      NSForegroundColorAttributeName : [UIColor whiteColor]
    } range:NSMakeRange(0, [trackerItem[@"groupTitle"] length] - 1)];
    [groupAndTagsString addAttributes:@{
      NSForegroundColorAttributeName :
          [UIColor colorWithRed:252.0 / 255.0 green:175.0 / 255.0 blue:62.0 / 255.0 alpha:1.0]
    } range:NSMakeRange([trackerItem[@"groupTitle"] length] + 2,
                        [[trackerItem[@"tags"] componentsJoinedByString:@", "] length])];

    [cell.groupAndTags setAttributedText:groupAndTagsString];

    [cell.author setText:trackerItem[@"lastCommentedBy"]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSDate *lastModified = [dateFormat dateFromString:trackerItem[@"lastModified"]];
    [dateFormat setDateFormat:@"dd.MM.yy HH:mm"];

    [cell.date setText:[dateFormat stringFromDate:lastModified]];

    return cell;
  }
  case 1: {
    UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"LoadMore" forIndexPath:indexPath];

    return cell;
  }
  default: {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    return cell;
  }
  }
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];

  if ([cell.reuseIdentifier isEqualToString:@"LoadMore"]) {
    [self loadDataWithOffset:_trackerItems.count sender:self];
  }
}

#pragma mark - Actions

- (IBAction)menuButtonTouched:(id)sender {
  [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)refreshControlPulled {
  [self loadDataWithOffset:0 sender:self.refreshControl];
}

@end
