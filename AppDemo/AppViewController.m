//
//  ViewController.m
//  AppDemo
//
//  Created by Penchala, Sandeep Kumar on 6/14/15.
//  Copyright (c) 2015 Penchala, Sandeep Kumar. All rights reserved.
//

#import "AppViewController.h"
#import "Constants.h"
#import "AppUICollectionViewCell.h"
#import "ImageDialog.h"

@interface AppViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeightConstraint;
@property UIRefreshControl *refreshControl;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segMentedView;
@property (nonatomic) AppTypes type;
@property(strong, nonatomic) NSArray *myAppsArray;
@property(strong, nonatomic) NSArray *appsCatalogArray;
@property (weak,nonatomic) ImageDialog *imageDialogView;
@end

@implementation AppViewController

/**
 Synthesize Properties
 */

@synthesize refreshControl = _refreshControl,
headerViewHeightConstraint = _headerViewHeightConstraint,
    collectionView = _collectionView;
- (IBAction)onViewChanged:(id)sender {
    NSInteger selectedIndex = [sender selectedSegmentIndex];
    switch (selectedIndex) {
        case 0:
            _type = MY_APPS;
             _headerViewHeightConstraint.constant = 0;
            [_collectionView reloadData];
            break;
        case 1:
             _type = APP_CATALOG;
             _headerViewHeightConstraint.constant = 42;
            [_collectionView reloadData];
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _type = MY_APPS;
    _headerViewHeightConstraint.constant = 0;
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.tintColor = [UIColor colorWithRed:0.26 green:0.74 blue:0.99 alpha:1];
    [_refreshControl addTarget:self action:@selector(reloadApps) forControlEvents:UIControlEventValueChanged];
    [_collectionView addSubview:_refreshControl];
    _myAppsArray = [NSArray arrayWithObjects:@"adobe",@"dropbox",@"evernote",@"bluebox_icon", nil];
    _appsCatalogArray = [NSArray arrayWithObjects:@"bluebox_icon",@"skype",@"mail",@"skype",@"adobe",@"dropbox",@"evernote",@"google_drive",@"google_hangouts",@"microsoft_office_outlook", nil];
    
}



-(void)reloadApps
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void) {
        [_refreshControl endRefreshing];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UIColectinView delegate funcions

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        return (_type == MY_APPS) ? [_myAppsArray count]: [_appsCatalogArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    AppUICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.appImage.image = [UIImage imageNamed:(_type == MY_APPS) ? _myAppsArray[indexPath.row]: _appsCatalogArray[indexPath.row]];
        cell.appName.text = (_type == MY_APPS) ? _myAppsArray[indexPath.row]: _appsCatalogArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ImageDialog~iphone" owner:self options:nil];
    if (views.count) {
        _imageDialogView = [views objectAtIndex:0];
    }
    [self.view addSubview:_imageDialogView];
    _imageDialogView.appImage.image = [UIImage imageNamed:(_type == MY_APPS) ? _myAppsArray[indexPath.row]: _appsCatalogArray[indexPath.row]];
    _imageDialogView.imageName.text = (_type == MY_APPS) ? _myAppsArray[indexPath.row]: _appsCatalogArray[indexPath.row];
     [_imageDialogView showImageDialogView];
    
}
@end

