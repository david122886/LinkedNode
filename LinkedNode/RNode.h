//
//  RNode.h
//  LinkedNode
//
//  Created by liu on 2017/6/1.
//  Copyright © 2017年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 @brief 阅读数据结构，采用双向链表形式管理数据（主要解决相邻页数据处理问题）
 */
@interface RNode : UIView
@property (nonatomic,strong) RNode *before;
@property (nonatomic,strong) RNode *next;


@property (nonatomic,assign) NSInteger index;

#pragma mark - 双向链表操作

/**
 @brief 追加节点在尾部，保证header永远不变（表尾index==0，在链表左边）
 @return 表尾（tail）
 */
-(RNode*)addTail:(RNode*)tail;

/**
 @brief 追加在表头（表头index最大，在链表右边）
 @return 表头（header）
 */
-(RNode*)addHeader:(RNode*)header;

/**
 @brief 插入节点
 @return 表头
 */
-(RNode*)insertNode:(RNode*)node atIndex:(NSInteger)index;


/**
 @brief 删除节点
 @return 表头
 */
-(RNode*)deleteNode:(RNode*)node;

/**
 @brief 删除节点
 @return 表头
 */
-(RNode*)deleteAtIndex:(NSInteger)index withStep:(NSInteger)step;

/**
 @brief 从链表尾部开始删除，保留step长度
 @return 表头
 */
-(RNode*)deleteTailLeaveStep:(NSInteger)step;


/**
 @brief 从链表头开始删除，保留step长度
 @return 表头
 */
-(RNode*)deleteHeaderLeaveStep:(NSInteger)step;

/**
 @brief 删除所在链表
 */
-(void)deleteAll;


/**
 @brief 替换节点
 @return 替换成功返回表头，不成功nil
 */
-(RNode*)replaceAtIndex:(NSInteger)index withNode:(RNode*)node;

/**
 @brief 使用node替换自己,self从链表中踢出
 @return 替换成功返回表头，不成功nil
 */
-(RNode*)replaceWithNode:(RNode*)node;


/**
 @brief 链表长度
 */
-(NSInteger)length;
/**
 @brief 表头在链表最右边
 */
-(RNode*)header;
/**
 @brief 表尾在链表最左边
 */
-(RNode*)tail;

-(RNode*)nodeAtIndex:(NSInteger)index;

-(NSInteger)indexWithNode:(RNode*)node;
/**
 @brief self在链表中位置
 */
-(NSInteger)index;
@end
