#include "htf_build.h"

i8
htf_build_compile(const char * const file)
{
	i8 ret = EXIT_FAILURE;

	GUARD_NULL(file);

	printf("Compiling %s\n", file);
	system("clang example/example.c -o example/example");

	ret = EXIT_SUCCESS;
cleanup:
	return ret;
}

i8
htf_build_run(const char * const file)
{
	i8 ret = EXIT_FAILURE;

	GUARD_NULL(file);

	printf("Running %s\n", file);
	system("./example/example");

	ret = EXIT_SUCCESS;
cleanup:
	return ret;
}
