//
//  LORTrackerViewCell.m
//  LinuxOrgRu
//
//  Created by Alexey on 6/15/15.
//  Copyright (c) 2015 Anakros. All rights reserved.
//

#import "LORTrackerViewCell.h"

@implementation LORTrackerViewCell

- (void)awakeFromNib {
  UIView *bgColorView = [[UIView alloc] init];
  bgColorView.backgroundColor =
      [UIColor colorWithRed:92.0 / 255.0 green:53.0 / 255.0 blue:102.0 / 255.0 alpha:1.0];
  self.selectedBackgroundView = bgColorView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
