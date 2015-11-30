#import "FigureViewController.h"
#import "CocoaAsyncSocket/AsyncSocket.h"

@implementation FigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(distanceDidChange:) name:@"distanceDidChange" object:nil];
    
    NSLog(@"%@", self.sceneView);
    
    SCNScene *scene = [SCNScene scene];
    self.sceneView.scene = scene;
    
    CGFloat boxSide = 10.0; // A square box ...
    SCNBox *box = [SCNBox boxWithWidth:boxSide
                                height:boxSide
                                length:boxSide
                         chamferRadius:0]; // with sharp edges

    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    [scene.rootNode addChildNode:boxNode];
    self.figureNode = boxNode;

    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera   = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(0, 10, 20);
    cameraNode.rotation =
    SCNVector4Make(1, 0, 0, // rotate around X
                   -atan2f(10.0, 20.0)); // -atan(camY/camZ)
    
    [scene.rootNode addChildNode:cameraNode];
    
    NSColor *lightBlueColor =
    [NSColor colorWithCalibratedRed:  4.0/255.0
                              green:120.0/255.0
                               blue:255.0/255.0
                              alpha:1.0];

    SCNLight *light = [SCNLight light];
    light.type  = SCNLightTypeDirectional;
    light.color = lightBlueColor;

    SCNNode *lightNode = [SCNNode node];
    lightNode.light    = light;
    [cameraNode addChildNode:lightNode];
}

- (void)distanceDidChange:(NSNotification *)notification {
    NSLog(@"Wharg");
    NSNumber *xNumber = notification.userInfo[@"x"];
    NSNumber *yNumber = notification.userInfo[@"y"];
    NSNumber *zNumber = notification.userInfo[@"z"];
    
    SCNVector3 vec = self.figureNode.position;

    vec.x = [xNumber doubleValue]/10.0;
    vec.y = [yNumber doubleValue]/10.0;
    vec.z = [zNumber doubleValue]/10.0;
    
    self.figureNode.position = vec;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

@end
