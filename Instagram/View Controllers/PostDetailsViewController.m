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
    // Do any additional setup after loading the view.
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
