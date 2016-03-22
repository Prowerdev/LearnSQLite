//
//  SQLOperationsClass.m
//  EstimatorFramework
//
//  Created by debasish panda on 16/10/13.
//
//

#import "SQLOperationsClass.h"

@implementation SQLOperationsClass


- (void)createMateTable
{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"MATE.db"]];
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        char *errMsg;
        const char *sql_stmt = "CREATE TABLE IF NOT EXISTS TESTESTIMATOR (APPID TEXT PRIMARY KEY, APPSNUMBER TEXT, DEVICECOUNT TEXT, PASSPERCENTAGE TEXT)";
        if (sqlite3_exec(testDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            self.sqlOperationsStatusLabel.text = @"Failed to create table";
        }
        
        sql_stmt = "create table if not exists matesib(estimatorEmpId number primary key, estimateName text, testingPercentageOnSecondaryDevice, testingPercentageDifferentLanguage, testingPercentageDifferentOperation, testingPercentageOrientation, manualTestCaseDevProductiviy, reviewRework text, testcaseReuseFactor text, remoteTestDevPercentage, localScriptDevProductivity number, remoteScriptDevProductivity, scriptReuseAcrossDevicePlatforms number, scriptReuseOnSecondaryDevices, scriptReuseAcrossDeviceScreenOrientation number, numberOfOsSupport number)";
        if (sqlite3_exec(testDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            self.sqlOperationsStatusLabel.text = @"Failed to create table";
        }
        else
        {
            [self saveDataToMainMateSibTable];
        }
        
        sql_stmt = "create table if not exists mateTestExecution(estimatorEmpId number primary key, PercentageOfRemoteExecution number, ManualExecProductivityLocal number, ManualExecProductivityRemote number, NonFuncTestExecProductivity number, AutomaticExecutionScriptsInMin number, SanityTestingPercentageManual number, RegressionTestingPercentageManual number, DefectVerifcation number, TestPlanningMngmt number, Contigency number)";
        if (sqlite3_exec(testDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            self.sqlOperationsStatusLabel.text = @"Failed to create table";
        }
        else
        {
            [self saveDataToMateTestExecutionTable];
        }
        
        sql_stmt = "create table if not exists mateNonfuncTesting(estimatorEmpId number primary key, NftSecurity number, NftPerf number, NftReliability number, NftUserExp number, NftMultiLang number, NftComptibility number, NftFieldTesting number, NftMonitoring number, NftSimulatorTesting number, ManualNftNoOfDevices number, CodeDrops number, PercentageFactorForOneDevice number)";
        if (sqlite3_exec(testDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            self.sqlOperationsStatusLabel.text = @"Failed to create table";
        }
        else
        {
            [self saveDataToMateNonFuncTestingTable];
        }
        
        sql_stmt = "create table if not exists matesibcomplexity(clientProjectEnagName text primary key, appName text, releaseNum integer, simpleTestNum integer, mediumTestNum integer, complexTestNum integer)";
        if (sqlite3_exec(testDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
        {
            self.sqlOperationsStatusLabel.text = @"Failed to create table";
        }
        else
        {
            [self saveDataToMateSibComplexity];
        }
        
        sqlite3_close(testDB);
        
    }
    else
    {
        self.sqlOperationsStatusLabel.text = @"Failed to open/create database";
    }
}


- (void)saveDataToMainMateSibTable
{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO matesib (estimatorEmpId, estimateName, testingPercentageOnSecondaryDevice, testingPercentageDifferentLanguage, testingPercentageDifferentOperation, testingPercentageOrientation, manualTestCaseDevProductiviy, reviewRework, testCaseReuseFactor, remoteTestDevPercentage, localScriptDevProductivity, remoteScriptDevProductivity, scriptReuseAcrossDevicePlatforms, scriptReuseOnSecondaryDevices, scriptReuseAcrossDeviceScreenOrientation, numberOfOsSupport) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", @"00000000", @"Default", @"30", @"30", @"40", @"70", @"40", @"Reviewed", @"2", @"40", @"50", @"40", @"40", @"40", @"40", @"3"];
        
        const char *insert_stmt = [insertSQL UTF8String];
        //NSLog(@"insert stmt:%@",insert_stmt);
        
        sqlite3_prepare_v2(testDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            self.sqlOperationsStatusLabel.text = @"Test data added";
        }
        else
        {
            self.sqlOperationsStatusLabel.hidden = YES;
            self.sqlOperationsStatusLabel.text = @"Failed to add test data, this EmpID might exist";
        }
        //sqlite3_finalize(statement);
        //sqlite3_close(testDB);
    }
}


- (void)saveDataToMateTestExecutionTable
{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO mateTestExecution (estimatorEmpId, PercentageOfRemoteExecution, ManualExecProductivityLocal, ManualExecProductivityRemote, NonFuncTestExecProductivity, AutomaticExecutionScriptsInMin, SanityTestingPercentageManual, RegressionTestingPercentageManual, DefectVerifcation, TestPlanningMngmt, Contigency) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", @"00000000", @"30", @"30", @"30", @"30", @"40", @"70", @"40", @"50", @"2", @"40"];
        
        const char *insert_stmt = [insertSQL UTF8String];
        //NSLog(@"insert stmt:%@",insert_stmt);
        
        sqlite3_prepare_v2(testDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            self.sqlOperationsStatusLabel.text = @"Test data added";
        }
        else
        {
            self.sqlOperationsStatusLabel.hidden = YES;
            self.sqlOperationsStatusLabel.text = @"Failed to add test data, this EmpID might exist";
        }
        //sqlite3_finalize(statement);
        //sqlite3_close(testDB);
    }
}


- (void)saveDataToMateNonFuncTestingTable
{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO mateNonfuncTesting (estimatorEmpId, NftSecurity, NftPerf, NftReliability, NftUserExp, NftMultiLang, NftComptibility, NftFieldTesting, NftMonitoring, NftSimulatorTesting, ManualNftNoOfDevices, CodeDrops, PercentageFactorForOneDevice) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", @"00000000", @"30", @"30", @"30", @"30", @"40", @"70", @"40", @"50", @"2", @"40", @"30", @"40"];
        
        const char *insert_stmt = [insertSQL UTF8String];
        //NSLog(@"insert stmt:%@",insert_stmt);
        
        sqlite3_prepare_v2(testDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            self.sqlOperationsStatusLabel.text = @"Test data added";
        }
        else
        {
            self.sqlOperationsStatusLabel.hidden = YES;
            self.sqlOperationsStatusLabel.text = @"Failed to add test data, this EmpID might exist";
        }
        //sqlite3_finalize(statement);
        //sqlite3_close(testDB);
    }
}


- (void)saveDataToMateSibComplexity
{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO matesibcomplexity(clientProjectEnagName text primary key, appName text, releaseNum integer, simpleTestNum integer, mediumTestNum integer, complexTestNum integer) VALUES (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", @"PrimaryProjEnagName", @"TestApp", @"0", @"0", @"0", @"0"];
        
        const char *insert_stmt = [insertSQL UTF8String];
        //NSLog(@"insert stmt:%@",insert_stmt);
        
        sqlite3_prepare_v2(testDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            self.sqlOperationsStatusLabel.text = @"Test data added";
        }
        else
        {
            self.sqlOperationsStatusLabel.hidden = YES;
            self.sqlOperationsStatusLabel.text = @"Failed to add test data, this EmpID might exist";
        }
        sqlite3_finalize(statement);
        sqlite3_close(testDB);
    }
}

- (void)saveDataToMateTable
{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO TESTESTIMATOR (APPID, APPSNUMBER, DEVICECOUNT, PASSPERCENTAGE) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")", self.sqlClientNameTextField.text, self.sqlEngagementNameTextField.text, self.sqlStartDateTextField.text, self.sqlEndDateTextField.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        //NSLog(@"insert stmt:%@",insert_stmt);
        
        sqlite3_prepare_v2(testDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            self.sqlOperationsStatusLabel.text = @"Test data added";
            self.sqlClientNameTextField.text = @"";
            self.sqlEngagementNameTextField.text = @"";
            self.sqlStartDateTextField.text = @"";
            self.sqlEndDateTextField.text = @"";
        } else {
            self.sqlOperationsStatusLabel.hidden = NO;
            self.sqlOperationsStatusLabel.text = @"Failed to add test data, this APPID might exist";
        }
        sqlite3_finalize(statement);
        sqlite3_close(testDB);
    }
}


- (NSMutableArray *)findDataFromSibMainMateTable
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT estimateName, testingPercentageOnSecondaryDevice, testingPercentageDifferentLanguage, testingPercentageDifferentOperation, testingPercentageOrientation, manualTestCaseDevProductiviy, reviewRework, testCaseReuseFactor, remoteTestDevPercentage, localScriptDevProductivity, remoteScriptDevProductivity, scriptReuseAcrossDevicePlatforms, scriptReuseOnSecondaryDevices, scriptReuseAcrossDeviceScreenOrientation, numberOfOsSupport FROM matesib WHERE estimatorEmpId=%@", @"00000000"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(testDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                self.mainMateResultArray = [[NSMutableArray alloc]init];
                for (int i = 0; i < 15; i++)
                {
                    [self.mainMateResultArray addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, i)]];
                }
                
                self.sqlOperationsStatusLabel.text = @"Match found";
            } else {
                self.sqlOperationsStatusLabel.text = @"Match not found";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(testDB);
    }
    return self.mainMateResultArray;
}


- (NSMutableArray *)findDataFromTestExecutionMainMateTable
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT PercentageOfRemoteExecution, ManualExecProductivityLocal, ManualExecProductivityRemote, NonFuncTestExecProductivity, AutomaticExecutionScriptsInMin, SanityTestingPercentageManual, RegressionTestingPercentageManual, DefectVerifcation, TestPlanningMngmt, Contigency FROM mateTestExecution WHERE estimatorEmpId=%@", @"00000000"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(testDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //self.mainMateResultArray = [[NSMutableArray alloc]init];
                [self.mainMateResultArray removeAllObjects];
                for (int i = 0; i < 10; i++)
                {
                    [self.mainMateResultArray addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, i)]];
                }
                
                self.sqlOperationsStatusLabel.text = @"Match found";
            } else {
                self.sqlOperationsStatusLabel.text = @"Match not found";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(testDB);
    }
    return self.mainMateResultArray;
}


- (NSMutableArray *)findDataFromNonFunctionalTestingMateTable
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT NftSecurity, NftPerf, NftReliability, NftUserExp, NftMultiLang, NftComptibility, NftFieldTesting, NftMonitoring, NftSimulatorTesting, ManualNftNoOfDevices, CodeDrops, PercentageFactorForOneDevice FROM mateNonfuncTesting WHERE estimatorEmpId=%@", @"00000000"];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(testDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                //self.mainMateResultArray = [[NSMutableArray alloc]init];
                [self.mainMateResultArray removeAllObjects];
                for (int i = 0; i < 12; i++)
                {
                    [self.mainMateResultArray addObject:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, i)]];
                }
                
                self.sqlOperationsStatusLabel.text = @"Match found";
            } else {
                self.sqlOperationsStatusLabel.text = @"Match not found";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(testDB);
    }
    return self.mainMateResultArray;
}


- (void)findDataFromMateTable
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &testDB) == SQLITE_OK)
    {
        self.sqlOperationsStatusLabel.hidden = NO;
        NSString *querySQL = [NSString stringWithFormat: @"SELECT APPSNUMBER, DEVICECOUNT, PASSPERCENTAGE FROM TESTESTIMATOR WHERE APPID=\"%@\"", self.sqlClientNameTextField.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(testDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *appsNum = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                self.sqlEngagementNameTextField.text = appsNum;
                
                NSString *deviceCnt = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                self.sqlStartDateTextField.text = deviceCnt;
                
                NSString *passPerc = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                self.sqlEndDateTextField.text = passPerc;
                
                self.sqlOperationsStatusLabel.text = @"Match found";
            } else {
                self.sqlOperationsStatusLabel.text = @"Match not found";
                self.sqlEngagementNameTextField.text = @"";
                self.sqlStartDateTextField.text = @"";
                self.sqlEndDateTextField.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(testDB);
    }
}


@end