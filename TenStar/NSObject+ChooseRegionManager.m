//
//  NSObject+ChooseRegionManager.m
//  TenStar
//
//  Created by Dharasis on 30/10/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "NSObject+ChooseRegionManager.h"

@implementation NSObject (ChooseRegionManager)


-(NSString*)manageRegion:(float)longitude latitude:(float)latitude{
    
    //If region is in centeral zone
    if(longitude > saudiCenterNorthWestLongitude && longitude < saudiCenterNorthEastLongitude && latitude > saudiCenterSouthEastLatitude && latitude < saudiCenterNorthEastLongitude)
        return @"Central";
    else if ([self isInsideRegion:saudiLongitude y1:saudiLatitude x2:saudiNorthWestLongitude y2:saudiNorthWestLatitude x3:saudiNorthEastLongitude y3:saudiNorthEastLatitude x:longitude y:latitude])
        return @"North";
    else if ([self isInsideRegion:saudiLongitude y1:saudiLatitude x2:saudiNorthWestLongitude y2:saudiNorthWestLatitude x3:saudiSouthWestLongitude y3:saudiSouthWestLatitude x:longitude y:latitude])
        return @"West";
    else if ([self isInsideRegion:saudiLongitude y1:saudiLatitude x2:saudiNorthEastLongitude y2:saudiNorthEastLatitude x3:saudiSouthEastLongitude y3:saudiSouthEastLatitude x:longitude y:latitude])
        return @"East";
    else if ([self isInsideRegion:saudiLongitude y1:saudiLatitude x2:saudiSouthWestLongitude y2:saudiSouthWestLatitude x3:saudiSouthEastLongitude y3:saudiSouthEastLatitude x:longitude y:latitude])
        return @"South";
    else
        return @"";
    
    
    
}

-(BOOL)isInsideRegion:(float)x1  y1:(float)y1 x2:(float)x2 y2:(float)y2 x3:(float)x3 y3:(float)y3 x:(float)x y:(float)y{

    float a = [self areaOfTriangle:x1 y1:y1 x2:x2 y2:y2 x3:x3 y3:y3];
    float b = [self areaOfTriangle:x y1:y x2:x2 y2:y2 x3:x3 y3:y3];
    float c = [self areaOfTriangle:x1 y1:y1 x2:x y2:y x3:x3 y3:y3];
    float d = [self areaOfTriangle:x1 y1:y1 x2:x2 y2:y2 x3:x y3:y];
    float sum = b+c+d;
    sum = floorf(sum);
    a=floorf(a);
    
   if(sum==a)
       return YES;
   else
        return NO;
    //x1, y1, x2, y2, x3, y3
    
}

-(float)areaOfTriangle:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 x3:(float)x3 y3:(float)y3
{
    return fabs((x1*(y2-y3) + x2*(y3-y1)+ x3*(y1-y2))/2.0);
}

@end
