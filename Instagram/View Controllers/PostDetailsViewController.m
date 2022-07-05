//
//  PostDetailsViewController.m
//  Instagram
//
//  Created by isaacvarela on 6/30/22.
//

#import "PostDetailsViewController.h"

@interface PostDetailsViewController ()

@end

@implementation PostDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedPostImage.file = self.currentPost[@"image"];
    [self.selectedPostImage loadInBackground];
    self.selectedPostCaption.text = self.currentPost.caption;
    self.timePosted.text = [NSString stringWithFormat:@"%@", self.currentPost.createdAt];
}

@end
