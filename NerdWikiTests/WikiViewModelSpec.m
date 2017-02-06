//
//  WikiViewModelSpec.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 06/11/2016.
//  Copyright 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WikiViewModel.h"
#import "WikiService.h"
#import "WikiArticle.h"
#import "JRRxHttpClient.h"

SPEC_BEGIN(WikiViewModelSpec)

describe(@"WikiViewModel", ^{
    context(@"description", ^{
        __block NSMutableArray *result = [NSMutableArray new];
        __block id<WikiServiceProtocol> service =  [WikiService new];

        it(@"should return an NSArray of WikiArticle elements", ^{
            service.sharedClient = [JRRxHttpClient sharedClient];
            service.serviceUrl = @"http://www.wikia.com/api/v1/Wikis/List?expand=1&lang=en&batch=1";
            
            WikiViewModel *viewModel = [[WikiViewModel alloc] initWithService:service];
            
            [viewModel.executeSignal subscribeNext:^(id x) {
                result = x;
                
                
                [[expectFutureValue(result) shouldEventually] beKindOfClass:[NSArray class]];
                
                [[expectFutureValue([result objectAtIndex:0]) shouldEventually] beKindOfClass:[WikiArticle class]];
            }];
        });
    });
});

SPEC_END
