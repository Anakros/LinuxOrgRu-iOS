//
//  LORTrackerViewController.m
//  LinuxOrgRu
//
//  Created by Anakros on 6/13/15.
//  Copyright © 2015 Anakros. All rights reserved.
//

#import "LORTrackerViewController.h"
#import "LORSidePanelController.h"

@interface LORTrackerViewController ()
@property(nonatomic, strong) NSArray *trackerItems;
@end

@implementation LORTrackerViewController

- (void)viewDidLoad {
  [super viewDidLoad];

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
  UITableViewCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"TrackerItem" forIndexPath:indexPath];
  NSDictionary *trackerItem = _trackerItems[indexPath.row];

  [cell.textLabel setText:trackerItem[@"title"]];
  [cell.detailTextLabel setText:trackerItem[@"url"]];

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
