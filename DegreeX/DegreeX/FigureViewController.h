#import <Cocoa/Cocoa.h>
#import <SceneKit/SceneKit.h>

#import <CocoaAsyncSocket/AsyncSocket.h>

@interface FigureViewController : NSViewController

@property (strong) IBOutlet SCNView *sceneView;
@property (strong) IBOutlet SCNNode *figureNode;

@property (assign) CGPoint origin;

@property (strong) AsyncSocket *listenSocket;
@property (strong) NSMutableArray *connectSockets;
@property (strong) NSMutableArray *cubes;

@end

