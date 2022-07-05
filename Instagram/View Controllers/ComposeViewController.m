//
//  ComposeViewController.m
//  Instagram
//
//  Created by isaacvarela on 6/28/22.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "PostTableViewCell.h"
#import "HomeFeedViewController.h"
#import "SceneDelegate.h"


@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)selectImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    self.selectedImage.image = editedImage;
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onShareClick:(id)sender {
    [Post postUserImage:self.selectedImage.image withCaption:self.postCaption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
- (IBAction)cancelComposition:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
