#include "AppDelegate.h"

@implementation AppDelegate : NSWindow

- (id)init {
  return self;
}

- (void)applicationDidFinishLaunching:(NSNotification*)aNotification
{
  [self orderFront:self];
  NSAlert* alert = [[NSAlert alloc] init];
  [alert setMessageText:@"Hello alert"];
  [alert addButtonWithTitle:@"All done"];
  int result = [alert runModal];
  if (result == NSAlertFirstButtonReturn) {
    NSLog(@"First button pressed");
  }
  NSApplication* app = [NSApplication sharedApplication];
  [app terminate:self];
}
@end
