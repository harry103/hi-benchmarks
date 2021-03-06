#!/usr/bin/env sh
# SPDX-License-Identifier: GPL-3.0+

# -----------------------------------------------------------------------------
# parse command line arguments

export HIBENCHMARKS_BUILD_WITH_DEBUG=0

while [ ! -z "${1}" ]
do
    case "${1}" in
        debug)
            export HIBENCHMARKS_BUILD_WITH_DEBUG=1
            ;;

        *)
            ;;
    esac

    shift
done


# -----------------------------------------------------------------------------

# First run install-alpine-packages.sh under alpine linux to install
# the required packages. build-x86_64-static.sh will do this for you
# using docker.

cd $(dirname "$0") || exit 1

# if we don't run inside the hibenchmarks repo
# download it and run from it
if [ ! -f ../hibenchmarks-installer.sh ]
then
    git clone https://github.com/firehol/hibenchmarks.git hibenchmarks.git || exit 1
    cd hibenchmarks.git/makeself || exit 1
    ./build.sh "$@"
    exit $?
fi

cat >&2 <<EOF

This program will create a self-extracting shell package containing
a statically linked hibenchmarks, able to run on any 64bit Linux system,
without any dependencies from the target system.

It can be used to have hibenchmarks running in no-time, or in cases the
target Linux system cannot compile hibenchmarks.

EOF

# read -p "Press ENTER to continue > "

if [ ! -d tmp ]
    then
    mkdir tmp || exit 1
fi

./run-all-jobs.sh "$@"
exit $?
