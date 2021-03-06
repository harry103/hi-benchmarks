#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0+

. $(dirname "${0}")/../functions.sh "${@}" || exit 1

fetch "fping-4.0" "https://github.com/schweikert/fping/releases/download/v4.0/fping-4.0.tar.gz"

export CFLAGS="-static"

run ./configure \
	--prefix=${HIBENCHMARKS_INSTALL_PATH} \
	--enable-ipv4 \
	--enable-ipv6 \
	${NULL}

cat >doc/Makefile <<EOF
all:
clean:
install:
EOF

run make clean
run make -j${SYSTEM_CPUS}
run make install

if [ ${HIBENCHMARKS_BUILD_WITH_DEBUG} -eq 0 ]
then
    run strip ${HIBENCHMARKS_INSTALL_PATH}/bin/fping
fi
