//
//  LORTrackerViewController.m
//  LinuxOrgRu
//
//  Created by Anakros on 6/13/15.
//  Copyright © 2015 Anakros. All rights reserved.
//

#import "LORTrackerViewController.h"
#import "LORSidePanelController.h"
#import "LORTrackerViewCell.h"

#import "DTCoreText.h"

@interface LORTrackerViewController ()
@property(nonatomic, strong) NSArray *trackerItems;
@end

@implementation LORTrackerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 92.0;

  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self
                          action:@selector(refreshControlPulled:)
                forControlEvents:UIControlEventValueChanged];

  [self loadData];
}

- (void)loadData {
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:@"https://www.linux.org.ru/api/tracker"
      parameters:nil
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _trackerItems = responseObject[@"trackerItems"];

        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
      }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to fetch tracker data: %@", error);
      }];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_trackerItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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

  [cell.author setText:trackerItem[@"author"]];
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
  NSDate *lastModified = [dateFormat dateFromString:trackerItem[@"lastModified"]];
  [dateFormat setDateFormat:@"dd.MM.yy HH:mm"];

  [cell.date setText:[dateFormat stringFromDate:lastModified]];

  [cell layoutIfNeeded];

  return cell;
}

#pragma mark - Actions

- (IBAction)menuButtonTouched:(id)sender {
  [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)refreshControlPulled:(id)sender {
  [self loadData];
}

@end
