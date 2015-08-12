//
//  CVCViewController.m
//  collectionViewCompleted
//
//  Created by 北村 彰悟 on 2015/06/18.
//  Copyright (c) 2015年 北村 彰悟. All rights reserved.
//

#import "CVCViewController.h"
#import "CVCItem.h"
#import "CVCViewCell.h"
#import "CVCEditViewController.h"
@interface CVCViewController ()
@end

@implementation CVCViewController{
    NSMutableArray *_items;
    int i;
    CVCItem *item;
}


static NSString * const reuseIdentifier = @"Cell";

- (id)init{
    self = [super initWithNibName:@"CVCViewController" bundle:nil];
    if (self) {
        self.title = @"アラーム";        
        _items = [NSMutableArray arrayWithCapacity:0];
        for (i = 0;i < 3; i++) {
            item = [[CVCItem alloc]init];
            item.number = i+1;
            item.caption = [NSString stringWithFormat:@"cap%d",item.number];

            [_items addObject:item];
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _dict =[[NSDictionary alloc]init];
    
    self.collectionView.allowsMultipleSelection = YES;

    UINib *nib = [UINib nibWithNibName:@"CVCViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"CellId"];
    
    //cellが返ってくる。 親だけで完結。押されたcellを判別。
//    CVCViewCell *cell = (CVCViewCell*)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    int cellId = cell.cellId;
//    for (CVCItem *item in _items) {
//        if (item.number == cellId) {
//            [self delete:cellId];
//        }
//    }
    
    //cellに書く内容。
//    [self.collectionView performSelector:@selector(delete:)];
    
//    
//    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Custom Action"
//                                                      action:@selector(customAction:)];
//    UIMenuController *menu = [UIMenuController sharedMenuController];
//    [menu setTargetRect:CGRectZero inView:self.view];
//    [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
//    [menu setMenuVisible:YES];
//    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:menuItem]];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}
- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [super viewWillAppear:animated];
    NSLog(@"cap:%@",item.caption);
    NSLog(@"time:%d",item.number);

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefaults objectForKey:@"caption"];
    NSString *time = [userDefaults objectForKey:@"number"];
    item.setTime = time;
    item.caption = name;
    NSLog(@"cur:%@",time);
    
    [self.collectionView reloadData];
    
}

#pragma mark - UICollectionViewDelegate methods
- (BOOL)collectionView:(UICollectionView *)collectionView
      canPerformAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender {
    if (action == @selector(delete:)) {
        [_items removeObjectAtIndex:indexPath.row];
        [self.collectionView reloadData];
        return YES;
    }
    return NO;  // YES for the Cut, copy, paste actions
}
- (void)delete:(id)sender {
    NSLog(@"delete");
//    //menuの確認を出してから削除したいが...。
//    UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Custom Action"
//                                                      action:@selector(customAction:)];
//    UIMenuController *menu = [UIMenuController sharedMenuController];
//    [menu setTargetRect:CGRectZero inView:self.view];
//    [menu setMenuItems:[NSArray arrayWithObject:menuItem]];
//    [menu setMenuVisible:YES];
}

- (BOOL)collectionView:(UICollectionView *)collectionView
shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView
         performAction:(SEL)action
    forItemAtIndexPath:(NSIndexPath *)indexPath
            withSender:(id)sender {
    NSLog(@"performAction");
}

#pragma mark - UIMenuController required methods
- (BOOL)canBecomeFirstResponder {
    // NOTE: The menu item will on iOS 6.0 without YES (May be optional on iOS 7.0)
    return YES;
}
//
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    NSLog(@"canPerformAction");
//    // The selector(s) should match your UIMenuItem selector
//    if (action == @selector(customAction:)) {
//        return YES;
//    }
//    return NO;
//}

#pragma mark - Custom Action(s)
- (void)customAction:(id)sender {
    NSLog(@"custom action! %@", sender);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellId = @"CellId";
    CVCViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    item = [_items objectAtIndex:indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",item.number];
    cell.capLabel.text = item.caption;

    // Configure the cell
    UIView *selectedView = [UIView new];
    selectedView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.8 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    return cell;
}

#pragma mark - UICollectionViewDelegate
//選択時
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    item = [_items objectAtIndex:indexPath.row];
    //確認。
    NSLog(@"%@",item.caption);
    if (indexPath.row + 1 == _items.count) {
        i++;
        item.number = i;
        item.caption = [NSString stringWithFormat:@"cap%d",i];
        [_items addObject:item];
        [collectionView reloadData];
    }else{
        CVCEditViewController *editView = [[CVCEditViewController alloc]initWithNibName:@"CVCEditViewController" bundle:nil];
        editView.cvcViewValue = item.number;
        editView.cvcViewTitle = item.caption;
        [self.navigationController pushViewController:editView animated:YES];
    }
}

// 選択解除の度に選択中のアイテムリストを NSLog に出力する
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray* selectedItems = [self.collectionView indexPathsForSelectedItems];
    NSLog(@"解除:%@", selectedItems);
}
#pragma mark <UICollectionViewDelegate>


/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
