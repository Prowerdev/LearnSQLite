//
//  ViewController.m
//  LearnSQLite
//
//  Created by Panda, Debasish on 22/03/16.
//  Copyright © 2016 Panda, Debasish. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SQLOperationsClass *sqlOperationClass = [[SQLOperationsClass alloc]init];
    [sqlOperationClass createMateTable];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
