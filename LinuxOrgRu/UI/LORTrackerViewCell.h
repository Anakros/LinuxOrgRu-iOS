//
//  LORTrackerViewCell.h
//  LinuxOrgRu
//
//  Created by Alexey on 6/15/15.
//  Copyright (c) 2015 Anakros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LORTrackerViewCell : UITableViewCell
@property(weak, nonatomic) IBOutlet UILabel *title;
@property(weak, nonatomic) IBOutlet UILabel *groupAndTags;
@property(weak, nonatomic) IBOutlet UILabel *author;
@property(weak, nonatomic) IBOutlet UILabel *date;

@end
