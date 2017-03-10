//
//  APIHelperClass.h
//  TenStar
//
//  Created by Dharasis on 03/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIHelperClass : NSObject

+(void)loginService:(NSString*)email password:(NSString*)password success : (void (^)(NSDictionary *responseDict))success;
+(void)listOfDoorService:(void (^)(NSDictionary *responseDict))success;
+(void)signUpService:(NSString*)email password:(NSString*)password
                name:(NSString*)name  success : (void (^)(NSDictionary *responseDict))success;
+(void)updatePasswordService:(NSString*)userId  newPassword:(NSString*)newPassword oldPassword:(NSString*)oldPassword  success:(void (^)(NSDictionary *responseDict))success;
+(void)updateProfileService:(NSString*)name mobile:(NSString*)mobile gender:(NSString*)gender age:(NSString*)age contact_no:(NSString*)contactNo address:(NSString*)address    userId:(NSString*)userId success:(void (^)(NSDictionary *responseDict))success;
+(void)fetchProfileService:(NSString*)userId  success:(void (^)(NSDictionary *responseDict))success;
+(void)fetchAllDoorService :(NSString*)param1 val1:(NSString*)value1 param2:(NSString*)param2 val2:(NSString*)value2 :(void (^)(NSDictionary *responseDict))success;
+(void)fetchDoorDetailService:(NSString*)doorID  success:(void (^)(NSDictionary *responseDict))success;
+(void)fetchClientDetails:(void (^)(NSDictionary *responseDict))success;
+(void)fetchSupervisorDetails:(void (^)(NSDictionary *responseDict))success;
+(void)addDoorService:(UIImage*)image region:(NSString*)region door_short_name:(NSString*)doorName address:(NSString*)address responsible_person_ph_no:(NSString*)phNo  latitude:(NSString*)lat longitude:(NSString*)longitute supervisor_id:(NSString*)supervisorId client_id:(NSString*)clientId  customDoorId:(NSString*)custom_door_id : (void (^)(NSDictionary *responseDict))success;
+(void)uploadProfilePhoto:(UIImage*)image  user_id:(NSString*)userId : (void (^)(NSDictionary *responseDict))success;
+(void)updateDoorService:(UIImage*)image region:(NSString*)region door_short_name:(NSString*)doorName address:(NSString*)address responsible_person_ph_no:(NSString*)phNo  latitude:(NSString*)lat longitude:(NSString*)longitute supervisor_id:(NSString*)supervisorId client_id:(NSString*)clientId door_id:(NSString*)doorId customId:(NSString*)custom_door_id : (void (^)(NSDictionary *responseDict))success;
+(void)notificationService:(NSString*)user_id : (void (^)(NSDictionary *responseDict))success;
+(void)readNotificationService:(NSString*)notification_id : (void (^)(NSDictionary *responseDict))success;
+(void)deleteNotificationService:(NSString*)notification_id : (void (^)(NSDictionary *responseDict))success;
+(void)sosNotificationService:(NSString*)userId latitude:(NSString*)latitude longitude:(NSString*)longitude cityName:(NSString*)city country:(NSString*)countryName : (void (^)(NSDictionary *responseDict))success;
+(void)deleteDoorService:(NSString*)doorId  : (void (^)(NSDictionary *responseDict))success;
+(void)commentService:(NSString*)doorId message:(NSString*)comment  userId:(NSString*)userid  roles:(NSString*)Role :  (void (^)(NSDictionary *responseDict))success;
+(void)maintenance:(NSData*)front_shop_picture permitted:(NSString*)permitted  door_id:(NSString*)doorID pictures_of_wall:(NSData*)wallPic  old_transformer_picture:(NSData*)transformPic picture_of_new_wire:(NSData*)newWirePic planogram_picture:(NSData*)planogramPic boutique_acrylic_repair_picture:(NSData*)boutiqueRepairPic header_acrylic_picture:(NSData*)headerPic door_complete_final_picture:(NSData*)finalPic  tube_changed:(NSString*)tudeChanged tube_quantity:(NSString*)tudeQuality  transformer_changed:(NSString*)transformrChanged cable_service_required:(NSString*)cableReq  visual_boutique_replaced:(NSString*)visualBoutique boutique_quantity:(NSString*)boutiqueQnty paint_touch_up:(NSString*)paintTouch planogram_issue:(NSString*)planogramIssue  boutique_acrylic_repair:(NSString*)boutiqueAcrylicRepair boutique_acrylic_description:(NSString*)descp boutique_acrylic_replace:(NSString*)boutiqueReplace header_acrylic_replace:(NSString*)headerReplace drawer_rails_replaced:(NSString*)drawerReplace drawer_rails_quantity:(NSString*)drawerRailQunt door_status:(NSString*)doorStatus date_of_finished:(NSString*)dateFinised : (void (^)(NSDictionary *responseDict))success;
+(void)doorMaintenanceNotPermited:(NSData*)frontShopPhoto  permited:(NSString*)permtd  permitedDate:(NSString*)date  doorId:(NSString*)doorID : (void (^)(NSDictionary *responseDict))success;
+(void)viewDoorMaintenanceService: (NSString*)doorId : (void (^)(NSDictionary *responseDict))success;
+(void)changeDoorStatusService: (NSString*)doorId  Doorstatus:(NSString*)door_status :(void (^)(NSDictionary *responseDict))success;
@end
