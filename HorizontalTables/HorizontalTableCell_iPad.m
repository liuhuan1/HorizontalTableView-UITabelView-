//
//  HorizontalTableCell_iPad.m
//  HorizontalTables
//
//  Created by Felipe Laso on 8/21/11.
//  Copyright 2011 Felipe Laso. All rights reserved.
//

#import "HorizontalTableCell_iPad.h"
#import "ArticleCell_iPad.h"
#import "ArticleTitleLabel.h"
#import "ControlVariables.h"

@implementation HorizontalTableCell_iPad

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArticleCell";
    
    __block ArticleCell_iPad *cell = (ArticleCell_iPad *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[[ArticleCell_iPad alloc] initWithFrame:CGRectMake(0, 0, kCellWidth_iPad, kCellHeight_iPad)] autorelease];
    }
    else
    {
        [[cell viewWithTag:999] removeFromSuperview];
    }
    __block NSDictionary *currentArticle = [self.articles objectAtIndex:indexPath.row];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(concurrentQueue, ^{        
        UIImage *image = nil;        
        image = [UIImage imageNamed:[currentArticle objectForKey:@"ImageName"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [cell.thumbnail setImage:image]; 
        });
    }); 
    
    cell.titleLabel.text = [currentArticle objectForKey:@"Title"];
    
    UILabel *lael = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 30)];
    lael.tag = 999;
    lael.text = [currentArticle objectForKey:@"Title"];
    [cell addSubview:lael];
    
    return cell;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.horizontalTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCellHeight_iPad, kTableLength_iPad)] autorelease];
        self.horizontalTableView.showsVerticalScrollIndicator = NO;
        self.horizontalTableView.showsHorizontalScrollIndicator = NO;
        self.horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI * 0.5);
        [self.horizontalTableView setFrame:CGRectMake(kRowHorizontalPadding_iPad * 0.5, kRowVerticalPadding_iPad * 0.5, kTableLength_iPad - kRowHorizontalPadding_iPad, kCellHeight_iPad)];
        
        self.horizontalTableView.rowHeight = kCellWidth_iPad;
        self.horizontalTableView.backgroundColor = kHorizontalTableBackgroundColor;
        
        self.horizontalTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.horizontalTableView.separatorColor = [UIColor clearColor];
        
        self.horizontalTableView.dataSource = self;
        self.horizontalTableView.delegate = self;
        [self addSubview:self.horizontalTableView];
    }
    
    return self;
}

@end