#import <AppKit/AppKit.h>
#import "AppDelegate.h"

int main()
{
  NSApplication *app = [NSApplication sharedApplication];
  NSWindow* delegate = [[AppDelegate alloc] init];
  [app setDelegate:delegate];
  [app run];
}
