#import "Bridge.h"

@implementation Bridge

- (instancetype)init {
    self = [super init];
    
    self.listenSocket = [[AsyncSocket alloc] initWithDelegate:self];
    self.connectedSockets = [[NSMutableArray alloc] init];
    [self.listenSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    NSError *e;
   [self.listenSocket acceptOnInterface:@"10.0.1.14" port:1338 error:&e];
    
    NSLog(@"Error %@", e);

    NSLog(@"setup");
    
    return self;
}

- (NSTimeInterval)onSocket:(AsyncSocket *)sock shouldTimeoutReadWithTag:(long)tag elapsed:(NSTimeInterval)elapsed bytesDone:(NSUInteger)length {
    return 10000;
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [sock readDataToData:[AsyncSocket CRLFData] withTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    double *d = (double *)[data bytes];
    [sock readDataToData:[NSData dataWithBytes:"12341234" length:8] withTimeout:-1 tag:0];

    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:@"distanceDidChange" object:nil userInfo:@{@"x": @(d[0]), @"y": @(d[1]), @"z": @(d[2])}];
    NSLog(@"%f", *d);
}

- (void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err {
    NSLog(@"err");
}

- (void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag {
    NSLog(@"part");
}

- (void)onSocketDidDisconnect:(AsyncSocket *)sock {
    NSLog(@"Bye bye");
}

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    NSLog(@"New");
    NSLog(@"%@", self.listenSocket);
    NSLog(@"%@", newSocket.connectedHost);
    [self.connectedSockets addObject:newSocket];
    NSLog(@"%@", self.connectedSockets);
    NSData *d = [[NSData alloc] init];
    [newSocket readDataToData:[NSData dataWithBytes:"12341234" length:8] withTimeout:-1 tag:0];
}

@end
