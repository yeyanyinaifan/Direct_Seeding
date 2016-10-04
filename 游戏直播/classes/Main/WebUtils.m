//
//  WebUtils.m
//  游戏直播
//
//  Created by tarena on 16/9/8.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "WebUtils.h"
#import "CategoryModel.h"
#import "RoomModel.h"
#import "BaseWebUtils.h"
@implementation WebUtils
+(void)requestCategorysWithCallback:(MyCallback)callback{
    
    
    [BaseWebUtils Get:URL_CategorysPath andParams:nil andCallback:^(id obj) {
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
        NSArray *categorys = [CategoryModel arrayOfModelsFromDictionaries:arr error:nil];
        callback(categorys);
    }];
    
    
    
   
}
+(void)requestRoomsWithPage:(int)page andCallback:(MyCallback)callback{
    
    NSString *path = [NSString stringWithFormat:URL_RoomsPath,page];
    
 
    
    if (page==1) {
        [path stringByReplacingOccurrencesOfString:@"_1" withString:@""];
    }
    
    [BaseWebUtils Get:path andParams:nil andCallback:^(id obj) {
        if (obj) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            NSArray *dataArr = dic[@"data"];
            NSArray *rooms = [RoomModel arrayOfModelsFromDictionaries:dataArr error:nil];
            callback(rooms);
        }else{
            callback(nil);
        }
       
    }];
    
    
    
}

+(void)requestRoomsWithCategory:(NSString *)category andPage:(int)page andCallback:(MyCallback)callback{
    
    
    NSString *path = [NSString stringWithFormat:URL_CategoryRoomsPath,category,page];
    
    
    
    if (page==1) {
       path = [path stringByReplacingOccurrencesOfString:@"list_1" withString:@"list"];
    }
    [BaseWebUtils Get:path andParams:nil andCallback:^(id obj) {
         if (obj) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
        NSArray *dataArr = dic[@"data"];
        NSArray *rooms = [RoomModel arrayOfModelsFromDictionaries:dataArr error:nil];
        callback(rooms);
         }else{
             callback(nil);
         }
    }];
    
    
    
}

+(void)requestRoomsWithName:(NSString *)name andCallback:(MyCallback)callback{
   
    int page = 0;
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@"site.search" forKey:@"m"];
    [params setObject:@"2" forKey:@"os"];
    [params setObject:@"0" forKey:@"p[categoryId]"];
    [params setObject:name forKey:@"p[key]"];
    [params setObject:@(page) forKey:@"p[page]"];
    [params setObject:@"20" forKey:@"p[size]"];
    [params setObject:@"1.3.2" forKey:@"v"];
    
  
    [BaseWebUtils Post:URL_SearchRoomsPath andParams:params andCallback:^(id obj) {
        if (obj) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
            NSArray *dataArr = dic[@"data"][@"items"];
            NSArray *rooms = [RoomModel arrayOfModelsFromDictionaries:dataArr error:nil];
            callback(rooms);
        }else{
            callback(nil);
        }
    }];
    
    
    
}
+(void)requestHomeInfoWithCallback:(MyCallback)callback{
    
    
    
    [BaseWebUtils Get:URL_homePath andParams:nil andCallback:^(id obj) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:obj options:0 error:nil];
        NSMutableDictionary *allInfo = [NSMutableDictionary dictionary];
        for (NSString *key in dic.allKeys) {
            NSArray *arr = dic[key];
            
            NSMutableArray *rooms = [NSMutableArray array];
            for (NSDictionary *roomDic in arr) {
                
                NSDictionary *objDic = roomDic[@"link_object"];
                if (objDic) {
                    RoomModel *room = [[RoomModel alloc]initWithDictionary:objDic error:nil];
                    [rooms addObject:room];
                }
                
                
            }
            
            
            
            
            [allInfo setObject:rooms forKey:key];
            
        }
        
        
        //解析list里面的数据
        NSArray *listArr = dic[@"list"];
        [allInfo setObject:listArr forKey:@"list"];
        
        callback(allInfo);
        
        
    }];
}


@end
