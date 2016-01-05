## HBFastTableViewController 
* The easiest way to create tableview 
* 用法最简单的创建tableview新框架 


##用法
pod 'HBKit', :git => 'https://github.com/Natoto/HBFastTableViewCotroller.git'

```javascript

@interface ViewController ()
//step 1
AS_CELL_STRUCT_COMMON(sys)
AS_CELL_STRUCT_COMMON(xib)
AS_CELL_STRUCT_COMMON(autoheight)
AS_CELL_STRUCT_COMMON(refresh)

@end

@implementation ViewController
//step 2
GET_CELL_STRUCT_WITH(sys, HBTABLE-系统控件)
GET_CELL_STRUCT_WITH(xib, HBTABLE-加载XIB)
GET_CELL_STRUCT_WITH(autoheight, HBTABLE-自动高度)
GET_CELL_STRUCT_WITH(refresh, HBTABLE-上下拉)

/**
*  响应的CELselect的方法
*/
//step 3
GET_CELL_SELECT_ACTION(cellstruct)
{
if(cellstruct == self.cell_struct_sys)
{
SystyleviewController * ctr = [[SystyleviewController alloc] init];
[self.navigationController pushViewController:ctr animated:YES];
}
else if(cellstruct == self.cell_struct_xib)
{
TESTXIBViewController * ctr = [[TESTXIBViewController alloc] init];
[self.navigationController pushViewController:ctr animated:YES];
}
}
//step4 OK
```
##系统风格
```javascript
- (void)viewDidLoad {
[super viewDidLoad];
self.title = @"系统TABLE STYLE";
for (int index = 0; index < 10; index ++) {

NSString * title = [NSString stringWithFormat:@"cell %d",index];
NSString * detail = [NSString stringWithFormat:@"detail cell %d",index];

CELL_STRUCT * cellstruct = [CELL_STRUCT_Common cell_x_x_struct:title detailvalue:detail target:self selectAction:@selector(cellselect:)];
cellstruct.sectionheight = 40;
cellstruct.sectioncolor = value_cellstruct_blue;
cellstruct.sectiontitle = @"SECTION 0";

cellstruct.cellheight = 60;
cellstruct.picture = @"profile";
cellstruct.CellStyleValue = index%3;
cellstruct.accessory = index%2;
cellstruct.selectionStyle = index%2;
[cellstruct.dictionary setObject:HBRandomColor forKey:key_cellstruct_background];
[self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(0, index)];
}

for (int index = 0; index < 10; index ++) {

NSString * title = [NSString stringWithFormat:@"cell %d",index];
NSString * detail = [NSString stringWithFormat:@"detail cell %d",index];

CELL_STRUCT * cellstruct = [CELL_STRUCT_Common cell_x_x_struct:title detailvalue:detail target:self selectAction:@selector(cellselect:)];
cellstruct.cellheight = 60;
cellstruct.sectionheight = 30;
cellstruct.sectiontitle = @"SECTION 1";
cellstruct.picture = @"profile";
cellstruct.CellStyleValue = index%3;
cellstruct.accessory = index%2;
cellstruct.selectionStyle = index%2;
[cellstruct.dictionary setObject:HBRandomColor forKey:key_cellstruct_background];
[self.dataDictionary setObject:cellstruct forKey:KEY_INDEXPATH(1, index)];
}

// Do any additional setup after loading the view.
}
```
![image](https://github.com/Natoto/HBFastTableViewCotroller/blob/master/iOS%20Simulator%20Screen%20Shot%202015%E5%B9%B48%E6%9C%8811%E6%97%A5%20%E4%B8%8B%E5%8D%885.24.09.png)
