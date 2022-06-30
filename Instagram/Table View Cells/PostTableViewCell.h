//
//  PostTableViewCell.h
//  Instagram
//
//  Created by isaacvarela on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;


NS_ASSUME_NONNULL_BEGIN

@interface PostTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PFImageView *postedImage;
@property (strong, nonatomic) IBOutlet UILabel *postedCaption;

@property (strong, nonatomic) Post *currentPost;


@end

NS_ASSUME_NONNULL_END
