#!/bin/sh
#
# Test Git in parallel
#

. ${0%/*}/lib.sh

group "Run tests" make --quiet -C t T="$(cd t &&
	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
	tr '\n' ' ')" ||
handle_failed_tests

if test 0 = "$1"
then
	# Run the git subtree tests only if main tests succeeded
	make -C contrib/subtree test
fi

check_unignored_build_artifacts
