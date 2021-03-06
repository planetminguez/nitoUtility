//
//  ntvNetService.m
//  nitoUtility
//
//  Created by Kevin Bradley on 9/16/19.
//  Copyright © 2019 nito. All rights reserved.
//

#import "ntvNetService.h"

@implementation NSNetService (scienceBro)

- (NSString *)easyIP{
    if (self.addresses.count == 0) return nil;
    struct sockaddr_in *addr = (struct sockaddr_in *) [[[self addresses] objectAtIndex:0] bytes];
    return [NSString stringWithUTF8String:(char *) inet_ntoa(addr->sin_addr)];
}

@end

@implementation ntvNetService

- (id)initWithNetService:(NSNetService *)service {
    
    self = [super init];
    if (self){
        //struct sockaddr_in *addr = (struct sockaddr_in *) [[[service addresses] objectAtIndex:0] bytes];
        _ipAddress = [service easyIP];
        _port = 22;
        _fullIP = [NSString stringWithFormat:@"%@:%li", _ipAddress, _port];
        _title = [NSString stringWithFormat:@"%@ (%@)", [service name], _fullIP];
        _serviceName = [service name];

    }
    return self;
}

- (void)updatePort:(NSInteger)port {
    _port = port;
    _fullIP = [NSString stringWithFormat:@"%@:%li", _ipAddress, _port];
    _title = [NSString stringWithFormat:@"%@ (%@)", _serviceName, _fullIP];
}


@end
