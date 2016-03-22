//
//  SQLOperationsClass.h
//  EstimatorFramework
//
//  Created by debasish panda on 16/10/13.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface SQLOperationsClass : NSObject
{
    sqlite3 *testDB;
    NSString *databasePath;
}

@property (nonatomic, weak) UILabel *sqlOperationsStatusLabel;
@property (nonatomic, weak) UILabel *sqlClientNameLabel;
@property (nonatomic, weak) UILabel *sqlEngagementNameLabel;
@property (nonatomic, weak) UILabel *sqlStartDateLabel;
@property (nonatomic, weak) UILabel *sqlEndDateLabel;

@property (nonatomic, weak) UITextField *sqlClientNameTextField;
@property (nonatomic, weak) UITextField *sqlEngagementNameTextField;
@property (nonatomic, weak) UITextField *sqlStartDateTextField;
@property (nonatomic, weak) UITextField *sqlEndDateTextField;

@property (nonatomic, weak) UIView *visibleView;

@property (nonatomic, strong) NSMutableArray *mainMateResultArray;

- (void)createMateTable;
- (void)saveDataToMateTable;
- (void)findDataFromMateTable;
- (NSMutableArray *)findDataFromSibMainMateTable;
- (NSMutableArray *)findDataFromTestExecutionMainMateTable;
- (NSMutableArray *)findDataFromNonFunctionalTestingMateTable;


@end
