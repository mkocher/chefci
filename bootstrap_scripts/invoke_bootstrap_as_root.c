#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

/*
 * Scripts can't be setuid root
 * http://www.tuxation.com/setuid-on-shell-scripts.html
 */

int main()
{
   setuid( 0 );
   system( "/Volumes/Persistent/chefci/bootstrap_scripts/bootstrap_as_root.command" );

   return 0;
}
