//
//  LinkedNodeTests.m
//  LinkedNodeTests
//
//  Created by liu on 2017/6/1.
//  Copyright © 2017年 liu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RNode.h"
@interface LinkedNodeTests : XCTestCase

@end

@implementation LinkedNodeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddHeader {
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    
    [n1 addHeader:n2];
    
    //    NSLog(@"n1:%@,header:%@",n1,[n1 header]);
    
    NSLog(@"n1:%@",n1);
    NSLog(@"n2:%@",n2);

    [n1 addHeader:[RNode new]];
    
    RNode *n3 = [RNode new];
    
    [n1 addHeader:n3];
    
    NSLog(@"n1:%@",n1);
    NSLog(@"n2:%@",n2);
    
    XCTAssertEqual(n2, n1.next,@"链表添加顺序不对");
    XCTAssertEqual(n3, [n3 header],@"链表添加顺序不对");
    XCTAssertEqual(n3, [n1 header],@"链表添加顺序不对");
    XCTAssertEqual(n1.before, nil,@"链表添加顺序不对");
    XCTAssertEqual(n3.next, nil,@"链表添加顺序不对");
    XCTAssertEqual(n3.before.before, n2,@"链表添加顺序不对");
    XCTAssertEqual(n1.next.next.next, n3,@"链表添加顺序不对");
    XCTAssertEqual(n3.before.before, n1.next,@"链表添加顺序不对");
}

- (void)testAddTail {
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    
    [n1 addTail:n2];
    
    //    NSLog(@"n1:%@,header:%@",n1,[n1 header]);
    
    NSLog(@"n1:%@",n1);
    NSLog(@"n2:%@",n2);
    
    [n1 addTail:[RNode new]];
    
    NSLog(@"n1:%@",n1);
    NSLog(@"n2:%@",n2);
    
    //    XCTAssertTrue(YES);
}

- (void)testLength{
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    
    XCTAssertEqual([n1 length],1,@"链表长度不正确");
    
    [n1 addHeader:n2];
    
    XCTAssertEqual([n1 length],2,@"链表长度不正确");

    [n1 addHeader:[RNode new]];
    
    XCTAssertEqual([n1 length],3,@"链表长度不正确");
    
    RNode *n3 = [RNode new];
    
    [n1 addHeader:n3];

    XCTAssertEqual([n1 length],4,@"链表长度不正确");
}

- (void)testDeleteAll{
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    RNode *n3 = [RNode new];
    RNode *n4 = [RNode new];
    
    
    [n1 addHeader:n2];
    [n1 addHeader:n3];
    [n1 addHeader:n4];
    
    XCTAssertTrue(n1.next,@"删除不全");
    XCTAssertTrue(n2.next && n2.before,@"删除不全");
    XCTAssertTrue(n3.next && n3.before,@"删除不全");
    XCTAssertTrue(n4.before,@"删除不全");
    
    [n1 deleteAll];
    
    XCTAssertTrue(!n1.next,@"删除不全");
    XCTAssertTrue(!n2.next && !n2.before,@"删除不全");
    XCTAssertTrue(!n3.next && !n3.before,@"删除不全");
    XCTAssertTrue(!n4.before,@"删除不全");
}


- (void)testInsertInto{
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    RNode *n3 = [RNode new];
    RNode *n4 = [RNode new];
    RNode *n5 = [RNode new];
    
    
    [n1 addHeader:n2];
    [n1 addHeader:n3];
//    [n1 addHeader:n4];
    
    [n1 insertNode:n4 atIndex:2];
    XCTAssertEqual(n3.before,n4,@"插入node错误");
    
    [n1 insertNode:n5 atIndex:0];
    XCTAssertEqual(n1.before,n5,@"插入node错误");
    XCTAssertEqual(n5.next.next.next,n4,@"插入node错误");
    XCTAssertEqual(n5.next.next.next.next,n3,@"插入node错误");
    
    RNode *n6 = [RNode new];
    
    [n5 insertNode:n6 atIndex:46];
    XCTAssertEqual([n1 header],n6,@"插入node错误");
    
    RNode *n7 = [RNode new];
    [n5 insertNode:n7 atIndex:-8];
    XCTAssertEqual([n1 tail],n7,@"插入node错误");
}

-(void)testDeleteNodeWithStep{
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    RNode *n3 = [RNode new];
    RNode *n4 = [RNode new];
    RNode *n5 = [RNode new];
    
    [n1 addHeader:n2];
    [n1 addHeader:n3];
    [n1 addHeader:n4];
//    [n1 addHeader:n5];
    
    XCTAssertEqual([n1 deleteAtIndex:100 withStep:1], n4,@"删除节点错误");
    XCTAssertEqual([[n1 deleteAtIndex:0 withStep:2] tail], n3,@"删除节点错误");
    XCTAssertTrue(!n1.before && !n1.next && !n2.before && !n2.next,@"删除节点错误");
    
    [n3 addHeader:n5];
    [n3 deleteAtIndex:1 withStep:10];
    XCTAssertEqual(n3.next, nil,@"删除节点错误");
    XCTAssertFalse(n4.next || n4.before || n5.next || n5.before,@"删除节点错误");
    
    [n1 addHeader:n2];
    [n1 addHeader:n3];
    [n1 addHeader:n4];
    
    [n3 deleteAtIndex:2 withStep:1];
    XCTAssertEqual(n1.next.next, n4,@"删除节点错误");
    
    [n1 insertNode:n3 atIndex:2];
    XCTAssertEqual(n2.next, n3,@"删除节点错误");
    
    [n3 deleteAtIndex:2 withStep:100];
    XCTAssertFalse(n4.before || !n2.before || !n1.next || n2.next,@"删除节点错误");
    
}

-(void)testDeleteNodeLeaveStep{
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    RNode *n3 = [RNode new];
    RNode *n4 = [RNode new];
    RNode *n5 = [RNode new];
    
    [n1 addHeader:n2];
    [n1 addHeader:n3];
    [n1 addHeader:n4];
    [n1 addHeader:n5];
    
    [n5 deleteTailLeaveStep:40];
    
    [n5 deleteTailLeaveStep:4];
    XCTAssertEqual(n1.next, nil,@"删除节点错误");
    
    [n3 deleteTailLeaveStep:2];
    XCTAssertEqual(n5.before, nil,@"删除节点错误");
    
}


-(void)testDeleteNode{
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    RNode *n3 = [RNode new];
    RNode *n4 = [RNode new];
    RNode *n5 = [RNode new];
    
    [n1 addHeader:n2];
    [n1 addHeader:n3];
    [n1 addHeader:n4];
    [n1 addHeader:n5];
    
    RNode *header = [n1 deleteNode:n1];
    XCTAssertEqual(header,n5,@"删除节点错误");
    
    [header deleteNode:n3];
    XCTAssertEqual(n2.next, n4,@"删除节点错误");
    XCTAssertEqual(header.before.before, n2,@"删除节点错误");
    XCTAssertEqual([n1 deleteNode:n2],n1,@"删除节点错误");
}

- (void)testIndex{
    RNode *n1 = [RNode new];
    RNode *n2 = [RNode new];
    RNode *n3 = [RNode new];
    RNode *n4 = [RNode new];
    RNode *n5 = [RNode new];
    
    [n1 addHeader:n2];
    [n1 addHeader:n3];
    [n1 addHeader:n4];
    
    XCTAssertEqual([n1 index],0,@"下标不正确");
    XCTAssertEqual([n2 index],1,@"下标不正确");
    XCTAssertEqual([n3 index],2,@"下标不正确");
    XCTAssertEqual([n4 index],3,@"下标不正确");
    XCTAssertEqual([n5 index],0,@"下标不正确");
    
    XCTAssertEqual([n1 indexWithNode:n1],0,@"下标不正确");
    XCTAssertEqual([n1 indexWithNode:n2],1,@"下标不正确");
    XCTAssertEqual([n1 indexWithNode:n3],2,@"下标不正确");
    XCTAssertEqual([n1 indexWithNode:n4],3,@"下标不正确");
    XCTAssertEqual([n1 indexWithNode:n5],-1,@"下标不正确");
    
    XCTAssertEqual([n4 indexWithNode:n4],3,@"下标不正确");
    
    XCTAssertEqual([n5 indexWithNode:n5],0,@"下标不正确");
    
    
    XCTAssertEqual([n5 nodeAtIndex:10],nil,@"下标不正确");
    XCTAssertEqual([n5 nodeAtIndex:0],n5,@"下标不正确");
    XCTAssertEqual([n4 nodeAtIndex:10],nil,@"下标不正确");
    XCTAssertEqual([n4 nodeAtIndex:0],n1,@"下标不正确");
    XCTAssertEqual([n4 nodeAtIndex:1],n2,@"下标不正确");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
