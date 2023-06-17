//
//  MarkerList.h
//  PlaceReminderApp
//
//  Created by zic on 13/06/2023.
//

#import <Foundation/Foundation.h>
#import "MarkerClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarkerList : NSObject

-(instancetype)init;
+(instancetype)getinstance;
-(void)AddItem:(MarkerClass *)_item;
-(void)DeleteItem:(int)_index;
-(int) GetCount;
-(int) GetMarkerIndex:(MarkerClass *)_marker;
-(MarkerClass *)GetItem:(int)_index;
@property (strong, nonatomic) NSMutableArray<MarkerClass *> *markerList;

@end

NS_ASSUME_NONNULL_END
