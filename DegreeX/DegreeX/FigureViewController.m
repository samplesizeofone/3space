#import "FigureViewController.h"
#import "CocoaAsyncSocket/AsyncSocket.h"

@implementation FigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(distanceDidChange:) name:@"distanceDidChange" object:nil];
    
    NSLog(@"%@", self.sceneView);
    
    
    self.cubes = [NSMutableArray array];
    SCNScene *scene = [SCNScene scene];
    self.sceneView.scene = scene;
    
//    CGFloat boxSide = 10.0; // A square box ...
//    SCNBox *box = [SCNBox boxWithWidth:boxSide
//                                height:boxSide
//                                length:boxSide
//                         chamferRadius:0]; // with sharp edges
//
//    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
//    [scene.rootNode addChildNode:boxNode];
//    self.figureNode = boxNode;

    SCNNode *cameraNode = [SCNNode node];
    cameraNode.camera   = [SCNCamera camera];
    cameraNode.position = SCNVector3Make(10, 10, 60);
    cameraNode.camera.zNear = 0;
    cameraNode.camera.zFar = 100;
    //    cameraNode.rotation =
    //    SCNVector4Make(1, 0, 0, // rotate around X
    //                   -atan2f(10.0, 20.0)); // -atan(camY/camZ)
    
    [scene.rootNode addChildNode:cameraNode];
    SCNNode *target = scene.rootNode;
    
    cameraNode.constraints = @[
                               [SCNLookAtConstraint lookAtConstraintWithTarget:target]
                               ];
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
    [scene.rootNode addChildNode:lightNode];
    lightNode.position = SCNVector3Make(300, 200, -100);

}

- (void)distanceDidChange:(NSNotification *)notification {
    NSLog(@"Wharg");
    NSNumber *xNumber = notification.userInfo[@"x"];
    NSNumber *yNumber = notification.userInfo[@"y"];
    NSNumber *zNumber = notification.userInfo[@"z"];
    
    SCNVector3 vec = SCNVector3Make([xNumber floatValue], [yNumber floatValue], [zNumber floatValue]);
    
    NSLog(@"%f %f %f", vec.x, vec.y, vec.z);
    
    if (vec.x == 0.0 && vec.y == 0.0 && vec.z == 0.0) {
        for (SCNNode *cube in self.cubes) {
            NSLog(@"here");
            [cube removeFromParentNode];
        }
        
        [self.cubes removeAllObjects];
    }
    
    vec.x = vec.x/10.0 - 30.0;
    vec.y = vec.y/10.0 - 30.0;
    vec.z = vec.z/2.0 - 100.0;
    NSLog(@"%f %f %f", vec.x, vec.y, vec.z);
    
    if (vec.x > 60) vec.x = 60;
    if (vec.x < -60) vec.x = -60;
    if (vec.y > 60) vec.y = 60;
    if (vec.y < -60) vec.y = -60;
    //    if (vec.z > 30) vec.z = 30;
    //    if (vec.z < -30) vec.z = -30;
    vec.y =  - vec.y;
    
    [self createBoxAtPoint:vec];
}


- (void)createBoxAtPoint:(SCNVector3)point {
    CGFloat boxSide = 2.0; // A square box ...
//    SCNBox *box = [SCNBox boxWithWidth:boxSide
//                                height:boxSide
//                                length:boxSide
//                         chamferRadius:0]; // with sharp edges
    SCNSphere *box = [SCNSphere sphereWithRadius:1]; // with sharp edges

    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    [self.sceneView.scene.rootNode addChildNode:boxNode];
    
    box.firstMaterial.diffuse.contents = [NSColor blueColor];
    box.firstMaterial.specular.contents = [NSColor whiteColor];
    [self.cubes addObject:boxNode];
    
    boxNode.position = point;
    
    NSLog(@"there");
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

@end
