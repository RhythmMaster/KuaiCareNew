//
//  YihuMapViewController.m
//  KuaiCare
//
//  Created by macbook user on 16/11/7.
//  Copyright © 2016年 macbook user. All rights reserved.
//

#import "YihuMapViewController.h"
#import "cityModel.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@interface YihuMapViewController ()<BMKPoiSearchDelegate,UISearchBarDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)BMKPoiSearch *searcher;
@property (nonatomic ,strong)BMKLocationService*locService;
@property (nonatomic ,strong)UISearchBar *searchBar;
@property(nonatomic,strong)  BMKUserLocation*userLocation;
@property (nonatomic, strong)  NSMutableArray *array;
@property (nonatomic, strong)  BMKPointAnnotation *item;
@property (nonatomic ,strong)  BMKPointAnnotation *pointAnnotation;
@property (nonatomic ,strong)  BMKMapView *mapView;
@property (nonatomic ,assign)  int curPage;
@property (nonatomic ,strong)  UITableView *tableView;
@property (nonatomic ,strong)  NSMutableArray *poiArray;
@end

@implementation YihuMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(242, 242, 242);
    [self.navigationController.navigationBar setBarTintColor:RGB(38, 107, 255)];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title = @"地址选择";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem withBarItem:@"back_btn_normal" name:@"" target:self action:@selector(leftClick)];
    self.poiArray = [NSMutableArray array];
    _searcher = [[BMKPoiSearch alloc]init];
    _searcher.delegate = self;
    [self initUI];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchBar.mas_bottom);
        make.left.right.bottom.equalTo(0);
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
-(void)initUI
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, KCWIDTH, 40)];
    _searchBar.placeholder = @"搜索";
    _searchBar.delegate = self;
    [self.view addSubview:_searchBar];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
     [self search];
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   
    [self search];
    
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
      [self search];
}
-(void)search
{
    _curPage = 0;
    //发起检索
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageCapacity = 10;
    citySearchOption.pageIndex = _curPage;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *city = [ud objectForKey:@"city"];
    citySearchOption.city= city;
    citySearchOption.keyword = _searchBar.text;
    BOOL flag = [_searcher poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }

}
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error

{
    [self.poiArray removeAllObjects];
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
       
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            NSLog(@"%@",poi.name);
            NSLog(@"%@",poi.address);
            cityModel *model = [[cityModel alloc] init];
            model.name = poi.name;
            model.address = poi.address;
            [self.poiArray addObject:model];
            [self.tableView reloadData];
            
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.poiArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell== nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
  
    cityModel *model  =  [self.poiArray objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.address;
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cityModel *model = [self.poiArray objectAtIndex:indexPath.row];
    self.block(model.address);
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)viewWillDisappear:(BOOL)animated
{
   
    _searcher.delegate = nil;
    
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
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

@end
