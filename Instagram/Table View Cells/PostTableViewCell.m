//
//  PostTableViewCell.m
//  Instagram
//
//  Created by isaacvarela on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "PostTableViewCell.h"
#import "Post.h"
@import Parse;
#import "Parse/Parse.h"

@implementation PostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCurrentPost:(Post *)post {
    _currentPost = post;

    self.postedImage.file = post[@"image"];
    [self.postedImage loadInBackground];
    self.postedCaption.text = post.caption;
}

@end
