//
//  ProposalTableViewCell.h
//  Constitution
//
//  Created by Fernando Lizana on 10/30/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProposalTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *proposalLabel;
@property (strong, nonatomic) IBOutlet UIButton *approveButton;
@property (strong, nonatomic) IBOutlet UIButton *disapproveButton;

@end
