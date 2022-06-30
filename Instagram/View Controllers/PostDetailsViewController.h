//
//  PostDetailsViewController.h
//  Instagram
//
//  Created by isaacvarela on 6/30/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "PostTableViewCell.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface PostDetailsViewController : UIViewController
@property (nonatomic,strong) Post *currentPost;
@property (strong, nonatomic) IBOutlet PFImageView *selectedPostImage;
@property (strong, nonatomic) IBOutlet UILabel *selectedPostCaption;
@property (strong, nonatomic) IBOutlet UILabel *timePosted;

@end

NS_ASSUME_NONNULL_END
