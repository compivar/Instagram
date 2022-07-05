//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by isaacvarela on 6/27/22.
//

#import "HomeFeedViewController.h"
#import "SceneDelegate.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "PostTableViewCell.h"
#import "PostDetailsViewController.h"


@interface HomeFeedViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *homeFeedTableView;
@property (nonatomic, strong) NSMutableArray *arrayOfPosts;

@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    self.homeFeedTableView.refreshControl = refreshControl;
    self.homeFeedTableView.dataSource = self;
    self.homeFeedTableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchPosts];

}

- (IBAction)onLogout:(id)sender {
    SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    mySceneDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
    }];
    
}

- (IBAction)composeAPost:(id)sender {
    SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ComposeViewController *composeViewController = [storyboard instantiateViewControllerWithIdentifier:@"ComposeViewController"];
    mySceneDelegate.window.rootViewController = composeViewController;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PostDetailsSegue"]) {
        Post *post = self.arrayOfPosts[[self.homeFeedTableView indexPathForCell:sender].row];
        PostDetailsViewController *detailsController = [segue destinationViewController];
        detailsController.currentPost = post;
    } else {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"forIndexPath:indexPath];
    Post *post = self.arrayOfPosts[indexPath.row];
    cell.currentPost = post;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (void) fetchPosts {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.arrayOfPosts = [posts mutableCopy];
            [self.homeFeedTableView reloadData];
            [self.homeFeedTableView.refreshControl endRefreshing];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
 

- (void)didPost:(nonnull Post *)post {
    [self.arrayOfPosts insertObject:post atIndex:0];
    [self.homeFeedTableView reloadData];
}


@end
