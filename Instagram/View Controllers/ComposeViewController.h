//
//  ComposeViewController.h
//  Instagram
//
//  Created by isaacvarela on 6/28/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *selectedImage;
@property (strong, nonatomic) IBOutlet UITextField *postCaption;

@end

NS_ASSUME_NONNULL_END
