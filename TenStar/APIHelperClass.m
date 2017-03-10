//
//  APIHelperClass.m
//  TenStar
//
//  Created by Dharasis on 03/07/16.
//  Copyright © 2016 Dharasis. All rights reserved.
//

#import "APIHelperClass.h"

@implementation APIHelperClass

#pragma mark- login Service
+(void)loginService:(NSString*)email password:(NSString*)password success : (void (^)(NSDictionary *responseDict))success{
    
   
    
       
    NSURL *URL = [NSURL URLWithString:loginServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    NSString *body = [NSString stringWithFormat:@"email=%@&password=%@",email,password];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
           
            
        }
      
        
    }];
    
  // dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    [task resume];
    
    
}

#pragma mark- Sign Up Service
+(void)signUpService:(NSString*)email password:(NSString*)password
                name:(NSString*)name  success : (void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:signUpServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    NSString *body = [NSString stringWithFormat:@"email=%@&password=%@&name=%@",email,password,name];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}

#pragma mark- List of door service

+(void)listOfDoorService:    (void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:listOfDoorServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
       
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}

#pragma mark- update password Service

+(void)updatePasswordService:(NSString*)userId  newPassword:(NSString*)newPassword oldPassword:(NSString*)oldPassword  success:(void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:changePasswordServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    NSString *body = [NSString stringWithFormat:@"user_id=%@&newPass=%@&oldPass=%@",userId,newPassword,oldPassword];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];

    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}

#pragma mark- update Profile Service

+(void)updateProfileService:(NSString*)name mobile:(NSString*)mobile gender:(NSString*)gender age:(NSString*)age contact_no:(NSString*)contactNo address:(NSString*)address    userId:(NSString*)userId success:(void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:updateProfileServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"name=%@&mobile=%@&gender=%@&age=%@&contact_no=%@&address=%@&user_id=%@",name,mobile,gender,age,contactNo,address,userId];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    

    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}

#pragma fetch User Profile

+(void)fetchProfileService:(NSString*)userId  success:(void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:fetchProfileServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"user_id=%@",userId];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}


#pragma fetch All Door Service

+(void)fetchAllDoorService :(NSString*)param1 val1:(NSString*)value1 param2:(NSString*)param2 val2:(NSString*)value2 :(void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:listOfAllDoorServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:@"POST"];
   
    NSString *body = [NSString stringWithFormat:@"%@=%@&%@=%@",param1,value1,param2,value2];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
  
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}


#pragma fetch User Profile

+(void)fetchDoorDetailService:(NSString*)doorID  success:(void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:fetchDoorDetailsUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"door_id=%@",doorID];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}

#pragma mark- Fetch Client Detail
+(void)fetchClientDetails:(void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:fetchClientDetailsServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}


#pragma mark- Fetch Supervisor Detail
+(void)fetchSupervisorDetails:(void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:fetchSupervisorDetailsServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}


#pragma mark- Add Door Service
+(void)addDoorService:(UIImage*)image region:(NSString*)region door_short_name:(NSString*)doorName address:(NSString*)address responsible_person_ph_no:(NSString*)phNo  latitude:(NSString*)lat longitude:(NSString*)longitute supervisor_id:(NSString*)supervisorId client_id:(NSString*)clientId  customDoorId:(NSString*)custom_door_id : (void (^)(NSDictionary *responseDict))success{
    
    
    NSDictionary *params = @{@"region":region,@"door_short_name":doorName,@"address":address,@"responsible_person_ph_no":phNo,@"latitude":lat,@"longitude":longitute,@"supervisor_id":supervisorId,@"client_id":clientId,@"custom_door_id":custom_door_id};


//    NSString *param = [NSString stringWithFormat:@"region=%@&door_short_name=%@&address=%@&responsible_person_ph_no=%@&latitude=%@&longitude=%@&supervisor_id=%@&client_id=%@&images[]=%@",region,doorName,address,phNo,lat,longitute,supervisorId,clientId,body];
//    

    
    
    NSURL *URL = [NSURL URLWithString:addDoorServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    
    
    //------------
    
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"V2ymHFg03ehbqgZCaKO6jy";
    
    
    //
    //    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
     NSData *imageData = UIImageJPEGRepresentation(image, .3);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"images[]\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    

    
    //-----------
//
//    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}
#pragma mark- Add Door Service
+(void)uploadProfilePhoto:(UIImage*)image  user_id:(NSString*)userId : (void (^)(NSDictionary *responseDict))success{
    
    
    NSDictionary *params = @{@"user_id":userId};
    
    
    //    NSString *param = [NSString stringWithFormat:@"region=%@&door_short_name=%@&address=%@&responsible_person_ph_no=%@&latitude=%@&longitude=%@&supervisor_id=%@&client_id=%@&images[]=%@",region,doorName,address,phNo,lat,longitute,supervisorId,clientId,body];
    //
    
    
    
    NSURL *URL = [NSURL URLWithString:uploadProfilePhotoService];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    
    
    //------------
    
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"V2ymHFg03ehbqgZCaKO6jy";
    
    
    //
    //    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(image, .3);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    
    
    //-----------
    //
    //    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}




#pragma mark- Add Door Service
+(void)updateDoorService:(UIImage*)image region:(NSString*)region door_short_name:(NSString*)doorName address:(NSString*)address responsible_person_ph_no:(NSString*)phNo  latitude:(NSString*)lat longitude:(NSString*)longitute supervisor_id:(NSString*)supervisorId client_id:(NSString*)clientId door_id:(NSString*)doorId customId:(NSString*)custom_door_id : (void (^)(NSDictionary *responseDict))success{
    
    
    NSDictionary *params = @{@"region":region,@"door_short_name":doorName,@"address":address,@"responsible_person_ph_no":phNo,@"latitude":lat,@"longitude":longitute,@"supervisor_id":supervisorId,@"client_id":clientId,@"door_id":doorId,@"custom_door_id":custom_door_id};
    
    
    //    NSString *param = [NSString stringWithFormat:@"region=%@&door_short_name=%@&address=%@&responsible_person_ph_no=%@&latitude=%@&longitude=%@&supervisor_id=%@&client_id=%@&images[]=%@",region,doorName,address,phNo,lat,longitute,supervisorId,clientId,body];
    //
    
    
    
    NSURL *URL = [NSURL URLWithString:updateDoorServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    
    
    //------------
    
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"V2ymHFg03ehbqgZCaKO6jy";
    
    
    //
    //    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(image, .3);
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"images[]\"; filename=\"image.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    
    
    //-----------
    //
    //    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}
#pragma mark- notification Service
+(void)notificationService:(NSString*)user_id : (void (^)(NSDictionary *responseDict))success{

    
    
    NSURL *URL = [NSURL URLWithString:notificationServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"user_id=%@",user_id];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    

    
    
}
#pragma mark - Read Notification Url

+(void)readNotificationService:(NSString*)notification_id : (void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:notificationReadServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"notification_id=%@",notification_id];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}

#pragma mark - Read Notification Url

+(void)deleteNotificationService:(NSString*)notification_id : (void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:deleteNotificatonServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"notification_id=%@",notification_id];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}

#pragma mark - SOS notification
+(void)sosNotificationService:(NSString*)userId latitude:(NSString*)latitude longitude:(NSString*)longitude cityName:(NSString*)city country:(NSString*)countryName : (void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:sosService];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"user_id=%@&latitude=%@&longitude=%@&city_name=%@&country_name=%@",userId,latitude,longitude,city,countryName];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}
#pragma mark- delete Door Action
+(void)deleteDoorService:(NSString*)doorId  : (void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:deleteDoorServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"door_id=%@",doorId];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}


#pragma mark- Maintenance Door Action

+(void)maintenance:(NSData*)front_shop_picture permitted:(NSString*)permitted  door_id:(NSString*)doorID pictures_of_wall:(NSData*)wallPic  old_transformer_picture:(NSData*)transformPic picture_of_new_wire:(NSData*)newWirePic planogram_picture:(NSData*)planogramPic boutique_acrylic_repair_picture:(NSData*)boutiqueRepairPic header_acrylic_picture:(NSData*)headerPic door_complete_final_picture:(NSData*)finalPic  tube_changed:(NSString*)tudeChanged tube_quantity:(NSString*)tudeQuality  transformer_changed:(NSString*)transformrChanged cable_service_required:(NSString*)cableReq  visual_boutique_replaced:(NSString*)visualBoutique boutique_quantity:(NSString*)hotspotReplace paint_touch_up:(NSString*)paintTouch planogram_issue:(NSString*)planogramIssue  boutique_acrylic_repair:(NSString*)boutiqueAcrylicRepair boutique_acrylic_description:(NSString*)tubeHolder boutique_acrylic_replace:(NSString*)boutiqueReplace header_acrylic_replace:(NSString*)headerReplace drawer_rails_replaced:(NSString*)drawerReplace drawer_rails_quantity:(NSString*)drawerRailQunt door_status:(NSString*)doorStatus date_of_finished:(NSString*)dateFinised : (void (^)(NSDictionary *responseDict))success{
    
    
//    NSDictionary *params = @{@"permitted":permitted,@"door_id":doorID,@"tube_changed":tudeChanged,@"tube_quantity":tudeQuality,@"transformer_changed":transformrChanged,@"cable_service_required":cableReq,@"visual_boutique_replaced":visualBoutique,@"boutique_quantity":boutiqueQnty,@"paint_touch_up":paintTouch,@"planogram_issue":planogramIssue,@"boutique_acrylic_repair":boutiqueAcrylicRepair,@"boutique_acrylic_description":descp,@"boutique_acrylic_replace":boutiqueReplace,@"header_acrylic_replace":headerReplace,@"drawer_rails_replaced":drawerReplace,@"drawer_rails_quantity":drawerRailQunt,@"door_status":doorStatus,@"date_of_finished":dateFinised};
    
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:permitted forKey:@"permitted"];
    [params setValue:doorID forKey:@"door_id"];
    [params setValue:tudeChanged forKey:@"tube_changed"];
    [params setValue:tudeQuality forKey:@"tube_quantity"];
    [params setValue:transformrChanged forKey:@"transformer_changed"];
    [params setValue:cableReq forKey:@"cable_service_required"];
    [params setValue:visualBoutique forKey:@"visual_boutique_replaced"];
    [params setValue:hotspotReplace forKey:@"hotspot_replace"];
    [params setValue:paintTouch forKey:@"paint_touch_up"];
    [params setValue:planogramIssue forKey:@"planogram_issue"];
    [params setValue:boutiqueAcrylicRepair forKey:@"boutique_acrylic_repair"];
    [params setValue:tubeHolder forKey:@"tube_holder"];
    [params setValue:boutiqueReplace forKey:@"boutique_acrylic_replace"];
    [params setValue:headerReplace forKey:@"header_acrylic_replace"];
    [params setValue:drawerReplace forKey:@"drawer_rails_replaced"];
    [params setValue:headerReplace forKey:@"drawer_rails_quantity"];
    [params setValue:doorStatus forKey:@"door_status"];
    [params setValue:dateFinised forKey:@"date_of_finished"];


    
    
    
    //    NSString *param = [NSString stringWithFormat:@"region=%@&door_short_name=%@&address=%@&responsible_person_ph_no=%@&latitude=%@&longitude=%@&supervisor_id=%@&client_id=%@&images[]=%@",region,doorName,address,phNo,lat,longitute,supervisorId,clientId,body];
    //
    
    
    
    NSURL *URL = [NSURL URLWithString:doorMaintenanceServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    
    
    //------------
    
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"V2ymHFg03ehbqgZCaKO6jy";
    
    
    //
    //    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
    
    if (front_shop_picture) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"front_shop_picture\"; filename=\"front_shop_picture.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:front_shop_picture];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    if (wallPic) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pictures_of_wall\"; filename=\"pictures_of_wall.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:wallPic];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    
    if (transformPic) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"old_transformer_picture\"; filename=\"old_transformer_picture.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:transformPic];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    
    if (newWirePic) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"picture_of_new_wire\"; filename=\"picture_of_new_wire.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:newWirePic];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    
    if (planogramPic) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"planogram_picture\"; filename=\"planogram_picture.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:newWirePic];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    if (boutiqueRepairPic) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"boutique_acrylic_repair_picture\"; filename=\"boutique_acrylic_repair_picture.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:newWirePic];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    if (headerPic) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"header_acrylic_picture\"; filename=\"header_acrylic_picture.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:newWirePic];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
//    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    

    if (finalPic) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"door_complete_final_picture\"; filename=\"door_complete_final_picture.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:newWirePic];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
  [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    
    
    //-----------
    //
    //    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}

#pragma mark- delete Door Action
+(void)commentService:(NSString*)doorId message:(NSString*)comment  userId:(NSString*)userid  roles:(NSString*)Role :  (void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:commentServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"user_id=%@&door_id=%@&comment=%@&role=%@",userid,doorId,comment,Role];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}




#pragma mark- Add Door Service
+(void)doorMaintenanceNotPermited:(NSData*)frontShopPhoto  permited:(NSString*)permtd  permitedDate:(NSString*)date  doorId:(NSString*)doorID : (void (^)(NSDictionary *responseDict))success{
    
    
    NSDictionary *params = @{@"permitted":permtd,@"permitted_date":date,@"door_id":doorID};
    
    
    //    NSString *param = [NSString stringWithFormat:@"region=%@&door_short_name=%@&address=%@&responsible_person_ph_no=%@&latitude=%@&longitude=%@&supervisor_id=%@&client_id=%@&images[]=%@",region,doorName,address,phNo,lat,longitute,supervisorId,clientId,body];
    //
    
    
    
    NSURL *URL = [NSURL URLWithString:doorMaintenanceServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    
    
    //------------
    
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:50];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"V2ymHFg03ehbqgZCaKO6jy";
    
    
    //
    //    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data

    if (frontShopPhoto) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"front_shop_picture\"; filename=\"front_shop_picture.jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:frontShopPhoto];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    
    
    //-----------
    //
    //    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
}
#pragma mark - view Door Maintenance
+(void)viewDoorMaintenanceService: (NSString*)doorId : (void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:viewDoorMaintenanceServiceUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"door_id=%@",doorId];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}
#pragma mark - view Door Maintenance
+(void)changeDoorStatusService: (NSString*)doorId  Doorstatus:(NSString*)door_status :(void (^)(NSDictionary *responseDict))success{
    
    
    
    NSURL *URL = [NSURL URLWithString:doorStatusService];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    NSString *body = [NSString stringWithFormat:@"door_id=%@&status=%@",doorId,door_status];
    
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData* data,NSURLResponse* response,NSError *error){
        
        
        if(!error){
            
            
            id  json  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            
            success(json);
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}

@end
