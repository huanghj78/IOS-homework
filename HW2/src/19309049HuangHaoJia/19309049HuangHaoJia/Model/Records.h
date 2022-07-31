//
//  Records.h
//  19309049HuangHaoJia
//
//  Created by student5 on 2021/10/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Records : NSObject{
    NSString* time;
    NSString* place;
    NSString* clothes;
    NSString* feel;
    NSArray* photos;
}
-(id)init:(NSString*)time at:(NSString*)place dressed:(NSString*)clothes feels:(NSString*)feel with:(NSArray*)photos;
-(NSString*)getTime;
-(NSString*)getPlace;
-(NSString*)getClothes;
-(NSString*)getFeel;
-(NSArray*)getPhotos;
-(NSString*)getInfo;

@end

NS_ASSUME_NONNULL_END
