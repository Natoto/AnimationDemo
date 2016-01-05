//
//  BaseTableViewController.m
//  PetAirbnb
//
//  Created by nonato on 14-11-25.
//  Copyright (c) 2014年 Nonato. All rights reserved.
//
#import "CELL_STRUCT.h"
#import "HBBaseTableViewController.h"
#import <objc/runtime.h>

#if 1
#import "MJRefresh.h"
#endif

@interface HBBaseTableViewController()

@end;

@implementation HBBaseTableViewController


-(void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    _tableView = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {//这个是需要的
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //    self.dataDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    if (!self.noAutoConfigTableView) {
        [self configTableView];
    }
}

//注册
-(void)configTableView
{
    if ([self tableView]) {
        [self setExtraCellLineHidden:self.tableView];
        //注册CELL 目前只考虑到两种情况 2个 section不同的时候 注册 其他的自己添加
        CELL_STRUCT * cell0struct= [self.dataDictionary objectForKey:KEY_INDEXPATH(0, 0)];
        if ([cell0struct.xibvalue isEqualToString:@"xib"]) {
            TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, cell0struct.cellclass)
        }
        CELL_STRUCT * cellstruct1 = [self.dataDictionary objectForKey:KEY_INDEXPATH(1, 0)];
        if (cellstruct1) {
            if ([cellstruct1.xibvalue isEqualToString:@"xib"]) {
                TABLEVIEW_REGISTERXIBCELL_CLASS(self.tableView, cellstruct1.cellclass)
            }
        }
    }
}

/**
 * 使用默认配置 供子类调用
 */
-(void)TableViewDefaultConfigWithTitle:(NSString *)title
{
//TODO:默认设置标题等
//    [self userDefaultBackground];
//    [self.navigationbar setTitle:title];
//    [self showhbnavigationbarBackItem:YES];
//    [self.navigationbar setBackgroundColor:[UIColor clearColor]];
//    [self adjustContentOffSet:HEIGHT_NAVIGATIONBAR bottom:0];
}

/**
 * 使用默认配置 供子类调用
 */
-(void)userDefaultConfigWithTitle:(NSString *)title
{
    [self TableViewDefaultConfigWithTitle:title];
}

-(void)observeTapgesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTap:)];
    [self.tableView addGestureRecognizer:tap];
}

-(void)tableViewTap:(UIGestureRecognizer *)gesture
{
     [[NSNotificationCenter defaultCenter] postNotificationName:notify_basetableview_tap object:gesture];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = self.view.backgroundColor;  
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tag = TAG_TABLEVIEW;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(void)viewDidCurrentView
{
    
}
- (void)setExtraCellLineHidden:(UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}


#if 1
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的refreshView)
    self.noHeaderFreshView = YES;
    [self.tableView.header beginRefreshing];
    self.noFooterView = YES;
}

-(void)setNoHeaderFreshView:(BOOL)noHeaderFreshView
{
    _noHeaderFreshView = noHeaderFreshView;
    if (noHeaderFreshView) {
        [self.tableView.header removeFromSuperview];
    }
    else
    {
        self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshView)];
//        [self.tableView addHeaderWithTarget:self action:@selector(refreshView)];
    }
}

-(void)setNoFooterView:(BOOL)noFooterView
{
    _noFooterView = noFooterView;
    if (noFooterView) {
        [self.tableView.footer removeFromSuperview];
    }
    else
    {
        self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getNextPageView)];
    }
}

-(void)refreshView
{
}
-(void)removeFooterView{
}

-(void)setFooterView{
}

//调用上下拉需要的

//加载调用的方法
-(void)getNextPageView
{
    
}

-(void)startHeaderLoading
{
    [self.tableView.header beginRefreshing];
}
-(void)FinishedLoadData
{
    [self.tableView.header  endRefreshing];
    [self.tableView.footer endRefreshing];
}

-(void)noMore
{
    [self.tableView removeFromSuperview];
}

-(void)finishReloadingData
{
    [self.tableView.header endRefreshing];
    [self.tableView.footer endRefreshing];
}
#endif


-(void)reloadTableViewCellWithKeyindexpath:(NSString *)keyindexpath
{
    NSString * sectionstr = KEY_INDEXPATH_SECTION_STR(keyindexpath);
    NSString * rowstr = KEY_INDEXPATH_ROW_STR(keyindexpath);
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowstr.intValue inSection:sectionstr.intValue]] withRowAnimation:UITableViewRowAnimationAutomatic];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 响应cell选择
-(void)cellDidSelect:(id)sender
{
    NSLog(@"%@",sender);
 
}

-(NSMutableDictionary *)dataDictionary
{
    if (!_dataDictionary) {
        _dataDictionary = [NSMutableDictionary new];
    }
    return _dataDictionary;
}


-(CGRect)adjustContentOffSet:(CGFloat)top bottom:(CGFloat)bottom
{
    self.tableView.frame = CGRectMake(0, top, [UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height - top - bottom);
    return self.tableView.frame;
}
#pragma mark - Table view data source
 
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    return cell_struce.sectionheight;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    return cell_struce.sectionfooterheight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    if (cell_struce.sectiontitle.length) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, cell_struce.sectionheight)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.bounds.size.width - 20, cell_struce.sectionheight)];
        label.center = CGPointMake(view.frame.origin.x + view.frame.size.width/2, view.frame.origin.y + view.frame.size.height/2);
        label.text = cell_struce.sectiontitle;
        label.font = [UIFont systemFontOfSize:cell_struce.sectionfont];
        label.textColor = [self colorWithStructKey:cell_struce.sectioncolor];
        label.textAlignment = NSTextAlignmentLeft;
        view.backgroundColor = self.tableView.backgroundColor;
        [view addSubview:label];
        return view;
    }
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CELL_STRUCT *cell_struce = [self.dataDictionary objectForKey:KEY_INDEXPATH(section, 0)];
    if (cell_struce.sectionfooter.length) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, cell_struce.sectionfooterheight)];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, view.bounds.size.width - 20, cell_struce.sectionfooterheight)];
        label.center = CGPointMake(view.frame.origin.x + view.frame.size.width/2, view.frame.origin.y + view.frame.size.height/2);
        label.text = cell_struce.sectionfooter;
        label.textAlignment = NSTextAlignmentLeft;
        view.backgroundColor = self.tableView.backgroundColor;
        [view addSubview:label];
        return view;
    }
    return [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray * keys = self.dataDictionary.allKeys;
    NSInteger maxsection = 1;
    for (int index = 0; index < keys.count; index ++) {
         NSString * key =[keys objectAtIndex:index];
        
        NSString * sectionstr = KEY_SECTION_INDEX_STR(key); //[key substringWithRange:NSMakeRange(7, 1)];
        if ((sectionstr.integerValue +1) > maxsection) {
            maxsection = (sectionstr.integerValue + 1);
        }
     }
    return maxsection;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * keys = self.dataDictionary.allKeys;
    NSString * sectionx = KEY_SECTION_MARK(section);
    
    //[NSString stringWithFormat:@"section%ld_",(long)section];
    NSInteger sectioncount = 0;
    for (int index = 0; index < keys.count; index ++) {
        NSString * key =[keys objectAtIndex:index];
        if ([key rangeOfString:sectionx].location != NSNotFound) {
            sectioncount ++;
        }
    }
    return sectioncount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CELL_STRUCT * cellstruct = [self.dataDictionary objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    NSString * identifier01 = cellstruct.cellclass;
    HBBaseTableViewCell *cell ;
    if(cellstruct.xibvalue && [cellstruct.xibvalue isEqualToString:@"xib"])
    {
//        [tableView registerClass:NSClassFromString(cellstruct.cellclass) forCellReuseIdentifier:identifier01];
        cell =  [tableView dequeueReusableCellWithIdentifier:identifier01 forIndexPath:indexPath];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier01];
    }
    
    if (!cell) {
        NSString * Classname = [NSString stringWithFormat:@"%@",cellstruct.cellclass];
        Class cls = NSClassFromString(Classname);
        if(cellstruct.xibvalue && [cellstruct.xibvalue isEqualToString:@"xib"])
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:cellstruct.cellclass owner:self options:nil] lastObject];
        }
        else
        {
            if(cellstruct.CellStyleValue == 1)
            {
                cell = [[cls alloc]  initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier01];
            }
            else if(cellstruct.CellStyleValue == 2)
            {
                cell = [[cls alloc]  initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:identifier01];
            }
            else if(cellstruct.CellStyleValue == 3)// (Used in iPod).
            {
                cell = [[cls alloc]  initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier01];
            }
            else
            {
                cell = [[cls alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier01];
            }
            
        }
    }
    if ([[cell class] isSubclassOfClass:[HBBaseTableViewCell class]]) {
        cell.delegate = self;
        cell.showTopLine = cellstruct.showTopLine;
        cell.showBottomLine = cellstruct.showBottomLine;
        cell.indexPath = indexPath;
        cell.selector = cellstruct.sel_selector;
        cell.selectionStyle = cellstruct.selectionStyle?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
        cell.accessoryType = cellstruct.accessory?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        [cell setcellTitleLabelNumberOfLines:cellstruct.titleLabelNumberOfLines];
        [cell setcellimageRight:cellstruct.imageRight];
        [cell setcelldetailtitle:cellstruct.detailtitle];
        [cell setcellplaceholder:cellstruct.placeHolder];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellTitle:cellstruct.title];
        [cell setcellTitleFont:cellstruct.titleFont];
        [cell setcellAttributeTitle:cellstruct.attributeTitle];
        [cell setcellValue2:cellstruct.subvalue2];
        [cell setcellProfile:cellstruct.picture];
        [cell setcellpicturecolor:cellstruct.picturecolor];
        [cell setcellValue:cellstruct.value];
        [cell setcellRightValue:cellstruct.rightValue];
        [cell setcellobject:cellstruct.object];
        [cell setcellobject2:cellstruct.object2];
        [cell setcellTitleColor:cellstruct.titlecolor];
        [cell setcelldictionary:cellstruct.dictionary];
        [cell setcellArray:cellstruct.array];
        [cell setcellimageCornerRadius:cellstruct.imageCornerRadius];
    }
    return cell;
}
 
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.nodeselectRow) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    CELL_STRUCT * cellstruct = [self.dataDictionary  objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    if ( cellstruct.sel_selector && [self respondsToSelector:cellstruct.sel_selector])
    {
        [self performSelector:cellstruct.sel_selector withObject:cellstruct afterDelay:0];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CELL_STRUCT * cellstruct = [self.dataDictionary  objectForKey:KEY_INDEXPATH(indexPath.section, indexPath.row)];
    return cellstruct.cellheight;
}

-(UIColor *)colorWithStructKey:(NSString *)key
{
    if ([key isEqualToString:value_cellstruct_blue]) {
        return  CELL_STRUCT_COLOR(blue);
    }
    else if([key isEqualToString:value_cellstruct_red])
    {
        return CELL_STRUCT_COLOR(red);
    }
    else if([key isEqualToString:value_cellstruct_clear])
    {
        return CELL_STRUCT_COLOR(clear);
    }
    else if([key isEqualToString:value_cellstruct_white])
    {
        return CELL_STRUCT_COLOR(white);
    }
    else if([key isEqualToString:value_cellstruct_gray])
    {
        return CELL_STRUCT_COLOR(gray);
    }
    
    return nil;
}
@end



//计算CELL的高度
@implementation UITableView (HBTemplateLayoutCell)

- (id)fd_templateCellForReuseIdentifier:(NSString *)identifier
{
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    NSMutableDictionary *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [self dequeueReusableCellWithIdentifier:identifier];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        templateCellsByIdentifiers[identifier] = templateCell;
    }
    
    return templateCell;
}

/**
 *  计算CELL的高度 实现的方法需要在cell的具体实现里面重载sizeThatFit:
 *
 *  @param identifier    identifier
 *  @param configuration cell加载数据的
 *
 *  @return 高度
 */
- (CGFloat)hb_heightForCellWithIdentifier:(NSString *)identifier configuration:(void (^)(id cell))configuration
{
    if (!identifier) {
        return 0;
    }
    
    // Fetch a cached template cell for `identifier`.
    UITableViewCell *cell = [self fd_templateCellForReuseIdentifier:identifier];
    
    // Manually calls to ensure consistent behavior with actual cells (that are displayed on screen).
    [cell prepareForReuse];
    
    // Customize and provide content for our template cell.
    if (configuration) {
        configuration(cell);
    }
    
    CGFloat contentViewWidth = CGRectGetWidth(self.frame);
    
    // If a cell has accessory view or system accessory type, its content view's width is smaller
    // than cell's by some fixed values.
    if (cell.accessoryView) {
        contentViewWidth -= 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {
        static CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        contentViewWidth -= systemAccessoryWidths[cell.accessoryType];
    }
    
    CGSize fittingSize = CGSizeZero;
    
    // If auto layout enabled, cell's contentView must have some constraints.
    BOOL autoLayoutEnabled = YES;
    if (autoLayoutEnabled) {
        
        // If not using auto layout, you have to override "-sizeThatFits:" to provide a fitting size by yourself.
        // This is the same method used in iOS8 self-sizing cell's implementation.
        // Note: fitting height should not include separator view.
        SEL selector = @selector(sizeThatFits:);
        BOOL inherited = ![cell isMemberOfClass:UITableViewCell.class];
        BOOL overrided = [cell.class instanceMethodForSelector:selector] != [UITableViewCell instanceMethodForSelector:selector];
        if (inherited && !overrided) {
            NSAssert(NO, @"Customized cell must override '-sizeThatFits:' method if not using auto layout.");
        }
        fittingSize = [cell sizeThatFits:CGSizeMake(contentViewWidth, 0)];
    }
    
    // Add 1px extra space for separator line if needed, simulating default UITableViewCell.
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingSize.height += 1.0 / [UIScreen mainScreen].scale;
    }
    
    
    return fittingSize.height;
}
@end;

