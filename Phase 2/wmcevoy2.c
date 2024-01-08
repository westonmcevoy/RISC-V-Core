#include "stdio.h"
#include "string.h"

/*
 *  c abstraction assignment
 */

int main() {
    // This took ten minutes of writing, compiling, and debugging before it was working perfectly (easy)
    unsigned int letter = 'M';
    int result = 0;
    int i = 0;
    for(i=0;i<letter;i++){
        result = result + i + letter;
    }
    printf("Result = %d\n", result);
    return result;                      // result = 8855 or 0x2297
}

