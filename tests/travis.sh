#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2015-05-25 01:38:24 +0100 (Mon, 25 May 2015)
#
#  https://github.com/harisekhon/tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  http://www.linkedin.com/in/harisekhon
#

set -eu

hr(){
    echo "===================="
}

# Taint code doesn't use PERL5LIB, use -I instead
I_lib=""

if [ -n "${PERLBREW_PERL:-}" ]; then

    PERL_VERSION="${PERLBREW_PERL}"
    PERL_VERSION="${PERLBREW_PERL/perl-/}"

    # For Travis CI which installs modules locally
    export PERL5LIB=$(echo \
        ${PERL5LIB:-.} \
        $PERLBREW_ROOT/perls/$PERLBREW_PERL/lib/site_perl/$PERL_VERSION/x86_64-linux \
        $PERLBREW_ROOT/perls/$PERLBREW_PERL/lib/site_perl/$PERL_VERSION/darwin-2level \
        $PERLBREW_ROOT/perls/$PERLBREW_PERL/lib/site_perl/$PERL_VERSION \
        $PERLBREW_ROOT/perls/$PERLBREW_PERL/lib/$PERL_VERSION/x86_64-linux \
        $PERLBREW_ROOT/perls/$PERLBREW_PERL/lib/$PERL_VERSION/darwin-2level \
        $PERLBREW_ROOT/perls/$PERLBREW_PERL/lib/$PERL_VERSION \
        | tr '\n' ':'
    )

    for x in $(echo "$PERL5LIB" | tr ':' ' '); do
        I_lib+="-I $x "
    done

    sudo=sudo
    #perl="/home/travis/perl5/perlbrew/perls/$TRAVIS_PERL_VERSION/bin/perl"
    perl=perl
else
    sudo=""
    perl=perl
fi
