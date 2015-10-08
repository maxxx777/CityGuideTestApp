//
//  MTItemListSearchPresenter.m
//  CityGuideTestApp
//
//  Created by MAXIM TSVETKOV on 07.10.15.
//  Copyright (c) 2015 MAXIM TSVETKOV. All rights reserved.
//

#import "MTItemListSearchPresenter.h"
#import "MTItemListSearchViewInterface.h"
#import "MTItemListWireframe.h"
#import "MTItemListCell.h"

static NSString *MTOffScreenCellIdentifier = @"OffScreenTableViewCell";
static NSString *MTSearchTableViewCellIdentifier = @"SearchTableViewCellIdentifier";

@interface MTItemListSearchPresenter ()

@property (nonatomic, strong) id<MTItemListRequesterInputInterface>itemListRequester;
@property (nonatomic, strong) id<MTItemListSearcherInputInterface>itemListSearcher;
@property (nonatomic, strong) MTItemListCell *prototypeCell;
@property (nonatomic, weak) MTItemListWireframe *wireframe;

@end

@implementation MTItemListSearchPresenter

- (instancetype)initWithItemListRequester:(id<MTItemListRequesterInputInterface>)itemListRequester
                         itemListSearcher:(id<MTItemListSearcherInputInterface>)itemListSearcher
                                wireframe:(MTItemListWireframe *)wireframe
{
    self = [super init];
    if (self) {
        
        _itemListRequester = itemListRequester;
        _itemListSearcher = itemListSearcher;
        _wireframe = wireframe;
        
    }
    return self;
}

#pragma mark - MTItemListSearchPresenterInterface

- (void)searchItemsWithSearchString: (NSString *)searchString
{
    [self.itemListRequester searchItemsWithSearchString:searchString];
}

- (NSUInteger)numberOfSearchResults
{
    return [self.itemListSearcher numberOfSearchResults];
}

- (CGFloat)heightForCell:(UITableViewCell *)cell
                 atIndex:(NSUInteger)index
             inTableView:(UITableView *)tableView
{
    if (!self.prototypeCell) {
        self.prototypeCell = [tableView dequeueReusableCellWithIdentifier:MTOffScreenCellIdentifier];
    }
    
    id item = [self.itemListSearcher searchResultAtIndex:index];
    
    return [self.prototypeCell heightForCellWithItem:item
                                      hasIndexedList:NO];
}

- (void)configureCell:(UITableViewCell *)cell
              atIndex:(NSUInteger)index
          inTableView:(UITableView *)tableView
{
    MTItemListCell *cellToConfigure = (MTItemListCell *)cell;
    id item = [self.itemListSearcher searchResultAtIndex:index];
    [cellToConfigure configureCellWithItem:item];
}

- (void)didSelectRowAtIndex:(NSUInteger)index
{
    id item = [self.itemListSearcher searchResultAtIndex:index];
    
    [self.wireframe onDidSelectItem:item];
}

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MTItemListCell class]
      forCellReuseIdentifier:MTSearchTableViewCellIdentifier];
    [tableView registerClass:[MTItemListCell class]
      forCellReuseIdentifier:MTOffScreenCellIdentifier];
}

- (NSString *)cellIdentifierForIndex:(NSUInteger)index
{
    return MTSearchTableViewCellIdentifier;
}

#pragma mark - MTItemListSearcherOutputInterface

- (void)onDidFetchItemsWithError:(NSError *)error
{
    //
}

@end
