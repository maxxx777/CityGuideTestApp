//
//  MTItemListPresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListPresenter.h"
#import "MTItemListViewInterface.h"
#import "MTItemListWireframe.h"
#import "MTAlertWrapper.h"

@interface MTItemListPresenter ()

@property (nonatomic, strong) id<MTItemListRequesterInputInterface>itemListRequester;
@property (nonatomic, weak) MTItemListWireframe *wireframe;

@end

@implementation MTItemListPresenter

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                                wireframe:(MTItemListWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _itemListRequester = itemListRequester;
        _wireframe = wireframe;
        
    }
    return self;
}

- (UIViewController<MTItemListViewInterface> *)userInterface
{
    NSAssert(_userInterface != nil, @"userInterface is equal to nil");
    return _userInterface;
}

#pragma mark - MTItemListPresenterInterface

- (void)onDidLoadView
{
    [self.userInterface configureNavigationBarWithTitle:NSLocalizedString(@"Cities", nil)];
    [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"All", nil)];
}

- (void)onDidPressRightBarButtonOnNavigationBar
{
    [self.wireframe onDidAddNewItemWithDelegate:self];
}

- (void)onDidPressRightBarButtonOnToolbar:(UIBarButtonItem *)barButton
{
    MTAlertWrapper *alertWrapper = [[MTAlertWrapper alloc] init];
    [alertWrapper showActionSheetInViewController:self.userInterface
                                    fromBarButton:barButton
                                         fromRect:CGRectZero
                                        withTitle:NSLocalizedString(@"Filter Places", nil)
                                cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                           otherButtonTitlesArray:@[NSLocalizedString(@"All", nil),
                                                                                                                                                                                                                            NSLocalizedString(@"100 miles", nil),
                                                                                                                                                                                                                            NSLocalizedString(@"10 miles", nil),
                                                                                                                                                                                                                            NSLocalizedString(@"1 mile", nil)]
                                clickedCompletion:nil
                             didDismissCompletion:^(NSInteger buttonIndex, NSString *actionTitle, NSString *inputText){
                                    if (actionTitle) {
                                        
                                        if ([actionTitle isEqualToString:NSLocalizedString(@"100 miles", nil)]) {
                                            
                                            [self.itemListRequester fetchItemsWithin100Mile];
                                            [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"100 miles", nil)];
                                            
                                        } else if ([actionTitle isEqualToString:NSLocalizedString(@"10 miles", nil)]) {
                                            
                                            [self.itemListRequester fetchItemsWithin10Mile];
                                            [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"10 miles", nil)];
                                            
                                        } else if ([actionTitle isEqualToString:NSLocalizedString(@"1 mile", nil)]) {
                                            
                                            [self.itemListRequester fetchItemsWithin1Mile];
                                            [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"1 mile", nil)];
                                            
                                        } else if ([actionTitle isEqualToString:NSLocalizedString(@"All", nil)]) {
                                            
                                            [self.itemListRequester fetchAllItems];
                                            [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"All", nil)];
                                            
                                        }
                                        
                                    } else {
                                        
                                        if (buttonIndex == 1) {
                                            
                                            [self.itemListRequester fetchAllItems];
                                            [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"All", nil)];
                                            
                                        } else if (buttonIndex == 2) {
                                            
                                            [self.itemListRequester fetchItemsWithin100Mile];
                                            [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"100 miles", nil)];
                                            
                                        } else if (buttonIndex == 3) {
                                            
                                            [self.itemListRequester fetchItemsWithin10Mile];
                                            [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"10 miles", nil)];
                                            
                                        } else if (buttonIndex == 4) {
                                            
                                            [self.itemListRequester fetchItemsWithin1Mile];
                                            [self.userInterface configureBarButtonFilterWithTitle:NSLocalizedString(@"1 mile", nil)];
                                            
                                        }
                                        
                                    }
                                }];
}

#pragma mark - MTEditPlaceDetailDelegate

- (void)onDidEditPlaceDetail
{
    [self.itemListRequester fetchItemsWithLastFilterType];
}

@end
