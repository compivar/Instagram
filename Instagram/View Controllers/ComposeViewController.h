//
//  ComposeViewController.h
//  Instagram
//
//  Created by isaacvarela on 6/28/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ComposeViewControllerDelegate

- (void)didPost:(Post *)post;

@end

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *selectedImage;
@property (strong, nonatomic) IBOutlet UITextField *postCaption;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
