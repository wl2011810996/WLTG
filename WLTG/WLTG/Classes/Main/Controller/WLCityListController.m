//
//  WLCityListController.m
//  WLTG
//
//  Created by 荣耀iMac on 16/7/5.
//  Copyright © 2016年 GloriousSoftware. All rights reserved.
//

#import "WLCityListController.h"
#import "WLCitySection.h"
#import "NSObject+Value.h"
#import "WLCity.h"
#import "WlMetaDataTool.h"
#import "WLSearchResultController.h"

#define kSearchH 44

@interface WLCityListController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *_citySectons;
    UIView *_cover;
    UITableView *_tableView;
    
    WLSearchResultController *_searchResult;
    UISearchBar *_searchBar;
}

@end

@implementation WLCityListController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addSearchBar];
    
    [self addTableView];
    
    [self loadCitiesData];
    
}


-(void)addSearchBar
{
    UISearchBar *search = [[UISearchBar alloc]init];
    search.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    search.frame = CGRectMake(0, 0, self.view.frame.size.width, kSearchH);
    search.delegate = self;
    search.placeholder = @"请输入城市或拼音";
    
    [self.view addSubview:search];
    _searchBar = search;
}

-(void)addTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    CGFloat h = self.view.frame.size.height - kSearchH;
    tableView.frame = CGRectMake(0, kSearchH, self.view.frame.size.width, h);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

-(void)loadCitiesData
{
    _citySectons = [NSMutableArray array];
    NSArray *sections = [WLMetaDataTool sharedWLMetaDataTool].totalCitySections;
    [_citySectons addObjectsFromArray:sections];
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        [_searchResult.view removeFromSuperview];
    }else
    {
        if (_searchResult == nil) {
            _searchResult = [[WLSearchResultController alloc]init];
            _searchResult.view.frame = _cover.frame;
            _searchResult.view.autoresizingMask = _cover.autoresizingMask;
            [self addChildViewController:_searchResult];
        }
        _searchResult.searchText = searchText;
        [self.view addSubview:_searchResult.view];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    
    if (_cover == nil) {
        _cover = [[UIView alloc]init];
        _cover.backgroundColor = [UIColor blackColor];
        _cover.frame = _tableView.frame;
        _cover.autoresizingMask = _tableView.autoresizingMask;
        [_cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick)]];
    }
    [self.view addSubview:_cover];
    _cover.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.7;
    }];
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self coverClick];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self coverClick];
}

-(void)coverClick
{
    [UIView animateWithDuration:0.3 animations:^{
        _cover.alpha = 0.0;
    }completion:^(BOOL finished) {
        [_cover removeFromSuperview];
    }];
    
    [_searchBar setShowsCancelButton:NO animated:YES];
    
    [_searchBar resignFirstResponder];
}




#pragma mark --tableView代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citySectons.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    WLCitySection *s = _citySectons[section];
    return s.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    WLCitySection *s = _citySectons[indexPath.section];
    WLCity *city = s.cities[indexPath.row];
    
    cell.textLabel.text = city.name;
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    WLCitySection *s = _citySectons[section];
    return s.name;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSLog(@"%@",[_citySectons valueForKeyPath:@"name"]);
    return [_citySectons valueForKeyPath:@"name"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLCitySection * s = _citySectons[indexPath.section];
    WLCity *city = s.cities[indexPath.row];
    [WLMetaDataTool sharedWLMetaDataTool].currentCity = city;
}


@end
