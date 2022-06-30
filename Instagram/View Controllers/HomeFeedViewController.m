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


@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate>
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
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchPosts];

}

- (IBAction)didTapLogout:(id)sender {
    SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    mySceneDelegate.window.rootViewController = loginViewController;
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    
}

- (IBAction)composeAPost:(id)sender {
    SceneDelegate *mySceneDelegate = (SceneDelegate * ) UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ComposeViewController *composeViewController = [storyboard instantiateViewControllerWithIdentifier:@"ComposeViewController"];
    mySceneDelegate.window.rootViewController = composeViewController;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.arrayOfPosts = [posts mutableCopy];
            [self.homeFeedTableView reloadData];
            [self.homeFeedTableView.refreshControl endRefreshing];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}
 

@end
