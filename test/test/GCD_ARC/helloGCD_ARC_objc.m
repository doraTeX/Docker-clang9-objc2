#include <dispatch/dispatch.h>
#import <stdio.h>
#import "Fraction.h"

int main( int argc, const char *argv[] ) {
   dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
   Fraction *frac = [[Fraction alloc] init];

   [frac setNumerator: 1];
   [frac setDenominator: 3];

   // print it
   dispatch_sync(queue, ^{
     printf( "The fraction is: " );
     [frac print];
     printf( "\n" );
   });
   if (__has_feature(objc_arc)) {
     printf("ARC is working.");
     return 0;
   } else {
     printf("ARC is not working.");
     return -1;
   }
}
