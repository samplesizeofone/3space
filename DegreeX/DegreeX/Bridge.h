#import <Foundation/Foundation.h>

#import <CocoaAsyncSocket/AsyncSocket.h>

@interface Bridge : NSObject <AsyncSocketDelegate>

@property (strong) AsyncSocket *listenSocket;
@property (strong) NSMutableArray *connectedSockets;

@end
