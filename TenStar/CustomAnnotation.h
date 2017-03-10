//
//  CustomAnnotation.h
//  TenStar
//
//  Created by Dharasis on 06/08/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface CustomAnnotation : NSObject<MKAnnotation>

@property(nonatomic, assign) CLLocationCoordinate2D coordinate;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subtitle;
@property(nonatomic, assign) int doorId;
-(id) initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
@end
