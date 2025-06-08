#ifndef HTF_BUILD_H
#define HTF_BUILD_H

#include <stdio.h>
#include <stdlib.h>
#include "defines.h"
#include "test/test.h"

i8 htf_build_compile(const char * const file);
i8 htf_build_run(const char * const file);

#endif
