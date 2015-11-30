#import <Foundation/Foundation.h>

#import <CocoaAsyncSocket/AsyncSocket.h>

@interface Bridge : NSObject <AsyncSocketDelegate>

@property (strong) AsyncSocket *socket;

@end
