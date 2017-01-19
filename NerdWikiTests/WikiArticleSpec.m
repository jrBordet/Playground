//
//  WikiArticleSpec.m
//  NerdWiki
//
//  Created by Jean Raphael Bordet on 18/01/2017.
//  Copyright 2017 Jean Raphael Bordet. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "WikiArticle.h"
#import "JRRxHttpClient.h"

SPEC_BEGIN(WikiArticleSpec)

describe(@"WikiArticle", ^{
    describe(@"initWithTitle:domain:url:wordmark:desc:", ^{
        
        context(@"initialization", ^{
            __block WikiArticle *article = [[WikiArticle alloc] initWithTitle:@"Elder Scrolls"
                                                               domain:@"elderscrolls.wikia.com"
                                                                  url:@"http://elderscrolls.wikia.com/"
                                                             wordmark:@"http://vignette4.wikia.nocookie.net/elderscrolls/images/8/89/Wiki-wordmark.png/revision/latest?cb=20170106194035"
                                                                 desc:@"The Elder Scrolls Wiki consists of over 40,000 articles"];
            
            it(@"should fill correctly the model", ^{
                [[article.title should] equal:@"Elder Scrolls"];
                [[article.domain should] equal:@"elderscrolls.wikia.com"];
                [[article.url should] equal:@"http://elderscrolls.wikia.com/"];
                [[article.wordmark should] equal:@"http://vignette4.wikia.nocookie.net/elderscrolls/images/8/89/Wiki-wordmark.png/revision/latest?cb=20170106194035"];
                [[article.desc should] equal:@"The Elder Scrolls Wiki consists of over 40,000 articles"];
            });
        });
    });
    
    describe(@"parseWikiArticlesWithJSONResponse:", ^{
        context(@"Server request successful", ^{
            it(@"should return all related articles urls", ^{
                NSString *url = @"http://www.wikia.com/api/v1/Wikis/List?expand=100&batch=1";
                
                [[[[JRRxHttpClient sharedClient] performRequestWithBaseUrl:url query:nil transform:^id(NSDictionary *jsonResponse) {
                    return [WikiArticle parseWikiArticlesWithJSONResponse:jsonResponse];
                }] map:^id(NSArray *value) {
                    return [WikiArticle parseUrlDetailsWithWikiArticles:value];
                }] subscribeNext:^(NSArray *urls) {
                    [[expectFutureValue(urls) shouldEventually] haveCountOf:25];
                    
                    [[[urls objectAtIndex:0] should] equal:@"http://elderscrolls.wikia.com/api/v1/Articles/List?expand=1&limit=100"];
                }];
            });
        });
    });
});

SPEC_END
