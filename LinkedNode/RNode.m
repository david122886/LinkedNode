//
//  RNode.m
//  LinkedNode
//
//  Created by liu on 2017/6/1.
//  Copyright © 2017年 liu. All rights reserved.
//

#import "RNode.h"

@implementation RNode

/**
 @brief 追加在表头（表头index最大，在链表右边）
 @return 表头（header）
 */
-(RNode*)addHeader:(RNode*)header{
    RNode *p = [self header];
    if (!header) {
        return p;
    }
    NSAssert(!header.next && !header.before, @"node不能在多链表中共存");
    header.index = p.index+1;
    p.next = header;
    header.before = p;
    header.next = nil;
    return header;
}

/**
 @brief 追加节点在尾部，保证header永远不变（表尾index==0，在链表左边）
 @return 表尾（tail）
 */
-(RNode*)addTail:(RNode*)tail{
    RNode *p = [self tail];
    if (!tail) {
        return p;
    }
    NSAssert(!tail.next && !tail.before, @"node不能在多链表中共存");
    p.before = tail;
    tail.next = p;
    tail.before = nil;
    [tail resetLinkIndexs];
    return tail;
}

/**
 @brief 插入节点
 @return 表头
 */
-(RNode*)insertNode:(RNode*)node atIndex:(NSInteger)index{
    RNode *p = [self tail];
    if (!node) {
        return p;
    }
    NSAssert(!node.next && !node.before, @"node不能在多链表中共存");
    if (index <= 0) {
        //追加尾
        p.before = node;
        node.next = p;
        node.before = nil;
        [node resetLinkIndexs];
        return [node header];
    }
    
    NSInteger tmpIndex = -1;
    RNode *tmpNode = nil;
    while (p) {
        tmpIndex++;
        if (tmpIndex == index) {
            tmpNode = p;
            break;
        }
        p = p.next;
    }
    
    if (tmpNode) {
        node.before = tmpNode.before;
        node.next = tmpNode;
        tmpNode.before.next = node;
        tmpNode.before = node;
    }else{
        //追加头
        RNode *header = [self header];
        node.before = header;
        node.next = nil;
        header.next = node;
    }
    [node resetLinkIndexs];
    return [node header];
}


/**
 @brief 删除节点
 @return 表头
 */
-(RNode*)deleteNode:(RNode*)node{
    RNode *header = [self header];
    if (!node || (!node.next && !node.before)) {
        return header;
    }
    
    if (header == node) {
        header = header.before;
        header.next = nil;
        node.before = nil;
        node.next = nil;
        return header;
    }
    
    
    RNode *p = header;
    while (p) {
        if (p == node) {
            RNode *before = p.before;
            RNode *next = p.next;
            before.next = next;
            next.before = before;
            
            node.before = nil;
            node.next = nil;
            break;
        }
        p = p.before;
    }
    
    return header;
}


/**
 @brief 删除节点
 @return 表头
 */
-(RNode*)deleteAtIndex:(NSInteger)index withStep:(NSInteger)step{
    if (index < 0 || step <= 0) {
        return [self header];
    }
    
    RNode *tail = [self tail];
    RNode *p = tail;
    NSInteger tmpIndex = -1;
    RNode *startNode = nil,*endNode = nil;
    
    while (p) {
        tmpIndex++;
        if (tmpIndex == index) {
            startNode = p;
        }
        if (tmpIndex == index+step-1) {
            endNode = p;
        }
        if (!p.next && startNode && !endNode) {
            endNode = p;
        }
        p = p.next;
    }
    
    
    if (startNode) {
        RNode *before = startNode.before;
        RNode *next = endNode.next;
        if (!before && !next) {
            [startNode deleteAll];
            return self;
        }else{
            before.next = next;
            next.before = before;
            
            startNode.before = nil;
            endNode.next = nil;
            [startNode deleteAll];
//            return [self header];
            RNode *needNode = [before?:next header];
            NSAssert(needNode, @"链表有无法引用风险");
            return needNode;
        }
    }else{
        return [self header];
    }
}

/**
 @brief 从链表头开始删除，保留step长度
 @return 表头
 */
-(RNode*)deleteHeaderLeaveStep:(NSInteger)step{
    RNode *header = [self header];
    if (step <= 0) {
        return header;
    }
    NSInteger length = [self length];
    if (step >= length) {
        return header;
    }
    RNode *node = nil;
    NSInteger tmpIndex = -1;
    while (header) {
        tmpIndex++;
        if (tmpIndex > (length - step -1)) {
            break;
        }
        node = header;
        header = header.before;
        
        node.next = nil;
        node.before = nil;
        
        header.next = nil;
    }
    
    return header ? : self;
}


/**
 @brief 从链表尾部开始删除，保留step长度
 @return 表头
 */
-(RNode*)deleteTailLeaveStep:(NSInteger)step{
    if (step <= 0) {
        return [self header];
    }
    NSInteger length = [self length];
    if (step >= length) {
        return [self header];
    }
    RNode *tail = [self tail];
    RNode *node = nil;
    NSInteger tmpIndex = -1;
    while (tail) {
        tmpIndex++;
        if (tmpIndex > (length - step -1)) {
            break;
        }
        node = tail;
        tail = tail.next;
        
        node.next = nil;
        node.before = nil;
        
        tail.before = nil;
    }
    
    return tail ? [tail header] : self;
}


/**
 @brief 删除所在链表
 */
-(void)deleteAll{
    RNode *p = [self header];
    while (p) {
        RNode *node = p;
        p = p.before;
        
        p.next = nil;
        node.before = nil;
    }
}


-(RNode*)nodeAtIndex:(NSInteger)index{    
    RNode *p = [self tail];
    NSInteger tmpIndex = -1;
    while (p) {
        tmpIndex++;
        if (tmpIndex == index) {
            return p;
        }
        p = p.next;
    }
    return nil;
}


-(NSInteger)indexWithNode:(RNode*)node{
    if (!node || (!node.before && !node.next && self != node)) {
        return -1;
    }
    RNode *p = [self tail];
    NSInteger index = -1;
    BOOL exist = NO;
    while (p) {
        index++;
        if (p == node) {
            exist = YES;
            break;
        }
        p = p.next;
    }
    return exist ? index : -1;
}


/**
 @brief self在链表中位置
 */
-(NSInteger)index{
    RNode *p = [self tail];
    NSInteger index = -1;
    BOOL exist = NO;
    while (p) {
        index++;
        if (p == self) {
            exist = YES;
            break;
        }
        p = p.next;
    }
    return exist ? index : -1;
}


/**
 @brief 链表长度
 */
-(NSInteger)length{
    NSInteger count = 0;
    RNode *p = [self header];
    while (p) {
        count++;
        p = p.before;
    }
    
    return count;
}


/**
 @brief 表头在链表最右边
 */
-(RNode*)header{
    
    RNode *p = self;
    while (p.next) {
        p = p.next;
    }
    
    return p;
}
/**
 @brief 表尾在链表最左边
 */
-(RNode*)tail{
    
    RNode *p = self;
    while (p.before) {
        p = p.before;
    }
    
    return p;
}



-(void)resetLinkIndexs{
    RNode *p = [self tail];
    NSInteger count = 0;
    while (p) {
        p.index = count++;
        p = p.next;
    }
}

-(NSString *)description{
    RNode *header = [self header];
    NSString *msg = [NSString stringWithFormat:@"[<%p> %ld]\n link:[<%p>%ld]",self,self.index,header,header.index];
    RNode *p = header;
    NSInteger length = 1;
    while (p.before) {
        p = p.before;
        msg = [msg stringByAppendingFormat:@"->[<%p> %ld]",p,p.index];
        length++;
    }
    msg = [msg stringByAppendingFormat:@" ||length(%ld)",length];
    return msg;
}
@end
