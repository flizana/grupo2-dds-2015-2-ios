//
//  ProposalDetailTableViewController.m
//  Constitution
//
//  Created by Fernando Lizana on 10/30/15.
//  Copyright (c) 2015 DDS. All rights reserved.
//

#import "ProposalDetailTableViewController.h"
#import "ProposalTableViewCell.h"
#import "CommentTableViewCell.h"
#import "InsertCommentTableViewCell.h"
#import "Comment.h"
#import "Network.h"
#import "APIParameters.h"

@interface ProposalDetailTableViewController ()

@property (strong, nonatomic) NSArray *comments;

@end

@implementation ProposalDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadComments];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Network

- (void)downloadComments
{
    [Network downloadCommentsForProposalId:self.proposal.proposalId withBLock:^(BOOL success, NSError *error, NSArray *comments){
        if (!error){
            if (success){
                [self parseComments:comments];
            } else {
                [self alertStatus:@"Download Failed" message:@"Could not download comments. Please try again."];
            }
        } else {
            [self alertStatus:@"Download Failed" message:@"Could not download comments. Please try again."];
        }
    }];
}

#pragma mark - Parsing

- (void)parseComments:(NSArray *)comments
{
    NSMutableArray *commentsArray = [NSMutableArray array];
    for (NSDictionary *comm in comments){
        NSDictionary *serverComment = [comm objectForKey:@"comment"];
        Comment *comment = [[Comment alloc] init];
        comment.commentId = [(NSNumber *)[serverComment objectForKey:CommentIdParameter] unsignedLongValue];
        comment.comment = (NSString *)[serverComment objectForKey:CommentTextParameter];
        comment.userId = [(NSNumber *)[serverComment objectForKey:CommentUserIdParameter] unsignedLongValue];
        comment.userFirstName = (NSString *)[serverComment objectForKey:CommentUserFirstNameParameter];
        comment.userLastName = (NSString *)[serverComment objectForKey:CommentUserLastNameParameter];
        comment.numApproval = (unsigned long)[(NSNumber *)[serverComment objectForKey:CommentNumApprovalParameter] unsignedLongValue];
        comment.numDisapproval = (unsigned long)[(NSNumber *)[serverComment objectForKey:CommentNumDisapprovalParameter] unsignedLongValue];
        NSString *userApprovesString = (NSString *)[serverComment objectForKey:CommentUserApprovesParameter];
        NSString *userDisapprovesString = (NSString *)[serverComment objectForKey:CommentUserDisapprovesParameter];
        if ([userApprovesString isEqualToString:@"true"]){
            comment.userApproves = YES;
        } else {
            comment.userApproves = NO;
        }
        if ([userDisapprovesString isEqualToString:@"true"]){
            comment.userDisapproves = YES;
        } else {
            comment.userDisapproves = NO;
        }
        [commentsArray addObject:comment];
    }
    self.comments = [NSArray arrayWithArray:commentsArray];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return 1;
    } else  if (section == 1){
        if (!self.comments){
            return 0;
        } else {
            return self.comments.count;
        }
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0){
        return @"Proposal";
    } else if (section == 1){
        return @"Comments";
    } else {
        return @"Insert Comment";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0]};
        CGRect rect = [self.proposal.proposalText boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 125;
    } else if (indexPath.section == 1){
        Comment *comment = self.comments[indexPath.row];
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:17.0]};
        CGRect rect = [comment.comment boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 132;
    } else {
        return 128.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *proposalCellIdentifier = @"proposalDetailCell";
    static NSString *commentCellIdentifier = @"commentCell";
    static NSString *insertCommentCellIdentifier = @"insertCommentCell";
    
    if (indexPath.section == 0){ // Proposal section
        ProposalTableViewCell *cell = (ProposalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:proposalCellIdentifier forIndexPath:indexPath];
        if (!cell){
            cell = [[ProposalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:proposalCellIdentifier];
        }
        cell.titleLabel.numberOfLines = 0;
        cell.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.titleLabel.text = self.proposal.proposalTitle;
        cell.proposalLabel.numberOfLines = 0;
        cell.proposalLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.proposalLabel.text = self.proposal.proposalText;
        cell.approveLabel.text = [NSString stringWithFormat:@"%li", self.proposal.numApproval];
        cell.approveLabel.textAlignment = NSTextAlignmentRight;
        cell.disapproveLabel.text = [NSString stringWithFormat:@"%li", self.proposal.numDisapproval];
        cell.disapproveLabel.textAlignment = NSTextAlignmentRight;
        [cell.approveButton setEnabled:!self.proposal.userApproves];
        [cell.approveButton setSelected:self.proposal.userApproves];
        [cell.disapproveButton setEnabled:!self.proposal.userDisapproves];
        [cell.disapproveButton setSelected:self.proposal.userDisapproves];
        
        return cell;
    } else if (indexPath.section == 1) { // Comments section
        CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:commentCellIdentifier forIndexPath:indexPath];
        if (!cell){
            cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:commentCellIdentifier];
        }
        
        Comment *comment = self.comments[indexPath.row];
        [cell.nameLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", comment.userFirstName, comment.userLastName];
        cell.commentLabel.numberOfLines = 0;
        cell.commentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.commentLabel.text = comment.comment;
        cell.approveLabel.text = [NSString stringWithFormat:@"%li", comment.numApproval];
        cell.approveLabel.textAlignment = NSTextAlignmentRight;
        cell.disapproveLabel.text = [NSString stringWithFormat:@"%li", comment.numDisapproval];
        cell.disapproveLabel.textAlignment = NSTextAlignmentRight;
        [cell.approveButton setEnabled:!comment.userApproves];
        [cell.approveButton setSelected:comment.userApproves];
        [cell.disapproveButton setEnabled:!comment.userDisapproves];
        [cell.disapproveButton setSelected:comment.userDisapproves];
        
        return cell;
    } else { // Insert comment section
        InsertCommentTableViewCell *cell = (InsertCommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:insertCommentCellIdentifier forIndexPath:indexPath];
        if (!cell){
            cell = [[InsertCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:insertCommentCellIdentifier];
        }
        
        return cell;
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - UI Actions

- (IBAction)approveProposalButtonTapped:(id)sender
{
    NSLog(@"approve proposal...");
}

- (IBAction)disapproveProposalButtonTapped:(id)sender
{
    NSLog(@"disapprove proposal...");
}

- (IBAction)approveCommentButtonTapped:(id)sender
{
    NSLog(@"approve comment...");
}

- (IBAction)disapproveCommentButtonTapped:(id)sender
{
    NSLog(@"disapprove comment...");
}

- (IBAction)insertCommentButtonTapped:(id)sender
{
    NSIndexPath *indexPath = [self indexPathForSender:sender];
    InsertCommentTableViewCell *cell = (InsertCommentTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    NSString *commentText = cell.insertCommentTextView.text;
    [self.proposal insertComment:commentText block:^(BOOL success, NSError *error){
        if (!error){
            [self downloadComments];
        } else {
            NSLog(@"Error inserting comment: [%@]", error);
            [self alertStatus:@"Insert Comment Failed" message:@"Could not insert comment. Please try again."];
        }
    }];
}

- (NSIndexPath *)indexPathForSender:(id)sender
{
    if (!sender){
        return nil;
    }
    
    if ([sender isKindOfClass:[ProposalTableViewCell class]]){
        ProposalTableViewCell *cell = sender;
        return [self.tableView indexPathForCell:cell];
    } else if ([sender isKindOfClass:[CommentTableViewCell class]]){
        CommentTableViewCell *cell = sender;
        return [self.tableView indexPathForCell:cell];
    } else if ([sender isKindOfClass:[InsertCommentTableViewCell class]]){
        InsertCommentTableViewCell *cell = sender;
        return [self.tableView indexPathForCell:cell];
    }
    
    return [self indexPathForSender:((UIView *)[sender superview])];
}

#pragma mark - UIAlertController

- (void)alertStatus:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
