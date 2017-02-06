//
//  WikiServiceSpec.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 06/11/2016.
//  Copyright 2016 Jean Raphael Bordet. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WikiService.h"
#import "WikiArticle.h"
#import "JRRxHttpClient.h"
#import "WikiServiceProtocol.h"
#import "NWApplicationAssembly.h"

SPEC_BEGIN(WikiServiceSpec)

describe(@"WikiService", ^{
    id<WikiServiceProtocol> service =  [WikiService new];
    
    describe(@"fetchTopWikies", ^{
        context(@"Server request successful", ^{
            it(@"should return an NSArray of WikiArticle elements", ^{
                __block NSMutableArray *result = [NSMutableArray new];
                
                service.sharedClient = [JRRxHttpClient sharedClient];
                service.serviceUrl = @"http://www.wikia.com/api/v1/Wikis/List?expand=1&lang=en&batch=1";
                
                [service.fetchTopWikies subscribeNext:^(id wikies) {
                    result = wikies;
                    
                    [[expectFutureValue(result) shouldEventually] beKindOfClass:[NSArray class]];
                    
                    [[expectFutureValue([result objectAtIndex:0]) shouldEventually] beKindOfClass:[WikiArticle class]];
                }];
            });
        });
    });
});

SPEC_END
