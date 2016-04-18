//
//  QMQNSStringExtendTests.m
//  QMQZhiHuDaily
//
//  Created by Charles on 4/17/16.
//  Copyright © 2016 Charles.Qiu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+Extend.h"

@interface QMQNSStringExtendTests : XCTestCase

@end

@implementation QMQNSStringExtendTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testIsEmpty {
    XCTAssertEqual(YES, [NSString isEmptyString:@" "]);
    XCTAssertEqual(YES, [NSString isEmptyString:@"     "]);
    XCTAssertEqual(NO, [NSString isEmptyString:@"not empty"]);
    XCTAssertEqual(NO, [NSString isEmptyString:@"tempStr"]);
    XCTAssertEqual(YES, [NSString isEmptyString:nil]);
}

- (void)testToHex {
    NSInteger decimalNum = 23342348888;
    NSString *hexNum = [@"56f4ffa58" uppercaseString];
    NSString *covertedNum = [NSString toHex:decimalNum];
    
    XCTAssertEqualObjects(hexNum, covertedNum);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
