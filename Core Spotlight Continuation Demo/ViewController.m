//
//  ViewController.m
//  Core Spotlight Continuation Demo
//
//  Created by 于宙 on 2017/4/1.
//  Copyright © 2017年 ryan. All rights reserved.
//

#import "ViewController.h"
@import CoreSpotlight;
@import MobileCoreServices;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)indexObjects:(id)sender {
    NSArray *items = @[@"test", @"test 1", @"test 2", @"test 3", @"test 4", @"test 5", @"test 6", @"test 7", @"test 8", @"test 9", @"test 10", @"test 11", @"test 12", @"test 13", @"test 14", @"test 15", @"test 16", @"test 17"];
    
    NSMutableArray *searchItems = [NSMutableArray arrayWithCapacity:items.count];
    for (NSString *item in items) {
        CSSearchableItemAttributeSet *attributeSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:(NSString *)kUTTypeContent];
        attributeSet.displayName = item;
        attributeSet.contentDescription = @"CoreSpotlight Demo: A demo shows how to use CoreSpotlight(iOS 9+) and CoreSpotlightContinuation(iOS 10+) API";
        attributeSet.keywords = @[@"spotlight", @"demo"];
        
        CSSearchableItem *searchItem = [[CSSearchableItem alloc] initWithUniqueIdentifier:item domainIdentifier:@"CoreSpotlightDemo" attributeSet:attributeSet];
        [searchItems addObject:searchItem];
    }
    
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:searchItems completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Index objects failed：%@", error);
        } else {
            NSLog(@"Index objects success!");
        }
    }];
}

- (IBAction)removeIndexedObjects:(id)sender {
    [[CSSearchableIndex defaultSearchableIndex] deleteAllSearchableItemsWithCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Remove Indexed objects failed：%@", error);
        } else {
            NSLog(@"Remove Indexed objects success!");
        }
    }];
}

- (IBAction)queryIndexedObjects:(id)sender {
    CSSearchQuery *query = [[CSSearchQuery alloc] initWithQueryString:@"displayName =='test*2'" attributes:@[@"displayName", @"keywords"]];
    
    [query setFoundItemsHandler:^(NSArray<CSSearchableItem *> *searchableItems) {
        for (CSSearchableItem *item in searchableItems) {
            NSLog(@"displayName: %@", item.attributeSet.displayName);
            NSLog(@"keywords: %@", item.attributeSet.keywords);
        }
    }];
    
    [query setCompletionHandler:^(NSError *error) {
        if (error) {
            NSLog(@"Query Indexed objects failed：%@", error);
        } else {
            NSLog(@"Query Indexed objects success!");
        }
    }];
    
    [query start];
}


@end
