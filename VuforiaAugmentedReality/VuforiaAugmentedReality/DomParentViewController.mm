/*============================================================================
 Copyright (c) 2012 QUALCOMM Austria Research Center GmbH .
 All Rights Reserved.
 Qualcomm Confidential and Proprietary
 ============================================================================*/

#import "DomParentViewController.h"
#import "Dominoes.h"
#import "ButtonOverlay.h"
#import "OverlayViewController.h"
#import "ARViewController.h"
#import "EAGLView.h"

@implementation DomParentViewController // subclass of ARParentViewController

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    parentView = [[UIView alloc] initWithFrame:arViewRect];
    
    // Add the DominoEAGLView and the overlay view to the window
    arViewController = [[ARViewController alloc] init];
    
    // need to set size here to setup camera image size for AR
    arViewController.arViewSize = arViewRect.size;
    [parentView addSubview:arViewController.view];
    
    // Create an auto-rotating overlay view and its view controller (used for
    // displaying UI objects, such as the camera control menu)

    buttonOverlayVC = [[ButtonOverlay alloc] initWithNibName:@"ButtonOverlay" bundle:nil];
    dominoesSetButtonOverlay(buttonOverlayVC);
    [buttonOverlayVC setMenuCallBack:@selector(showMenu) forTarget:self];
    [parentView addSubview: buttonOverlayVC.view];
    
    // Create an auto-rotating overlay view and its view controller (used for
    // displaying UI objects, such as the camera control menu)
    overlayViewController = [[OverlayViewController alloc] init];
    [parentView addSubview: overlayViewController.view];

    self.view = parentView;
}


// Pass touches on to our main touchy/feely view
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [arViewController.arView touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [arViewController.arView touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [arViewController.arView touchesEnded:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [arViewController.arView touchesCancelled:touches withEvent:event];
}

// provoke the menu pop-up
- (void) showMenu
{
    [overlayViewController showOverlay];
}

@end
