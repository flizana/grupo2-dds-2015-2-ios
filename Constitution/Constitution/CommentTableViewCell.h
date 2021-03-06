//
//  CommentTableViewCell.h
//  Constitution
//
//  Created by Fernando Lizana on 10/30/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *commentLabel;
@property (strong, nonatomic) IBOutlet UIButton *approveButton;
@property (strong, nonatomic) IBOutlet UIButton *disapproveButton;
@property (strong, nonatomic) IBOutlet UILabel *approveLabel;
@property (strong, nonatomic) IBOutlet UILabel *disapproveLabel;

@end
