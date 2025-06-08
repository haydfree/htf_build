#include "test.h"

void
test_htf_build_compile(void)
{
	htf_build_compile("example/example.c");
}

void
test_htf_build_run(void)
{
	htf_build_run("example/example");
}

int
main(void)
{
	test_htf_build_compile();
	test_htf_build_run();
	return 0;
}
