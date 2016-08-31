//
//  BSBDJ1Tests.m
//  BSBDJ1Tests
//
//  Created by Yesi on 16/8/17.
//  Copyright © 2016年 Yesi. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface BSBDJ1Tests : XCTestCase

@end

@implementation BSBDJ1Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    //初始化的代码，在测试方法调用之前调用
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    // 释放测试用例的资源代码，这个方法会每个测试用例执行后调用

    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    // 测试用例的例子，注意测试用例一定要test开头
//    NSLog(@"开始爱上单元测试的第一个单元测试测试");
//    NSString *test = @"这是我的第一个单元测试";
//    XCTAssertTrue([test isEqualToString:@"初来乍到，就想测试成功，没门"]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    // 测试性能例子，有Instrument调试工具之后，其实这个没毛用。
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        // 需要测试性能的代码

    }];
}

@end
