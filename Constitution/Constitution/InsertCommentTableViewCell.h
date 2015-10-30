//
//  InsertCommentTableViewCell.h
//  Constitution
//
//  Created by Fernando Lizana on 10/30/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InsertCommentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextView *insertCommentTextView;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@end
