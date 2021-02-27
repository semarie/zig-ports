# $OpenBSD$

COMMENT =	zig compiler

DISTNAME =	zig-0.8.0pre1038

GH_ACCOUNT =	ziglang
GH_PROJECT =	zig-bootstrap
GH_COMMIT =	c09fa1535739b965ad525fa71ce441b195cecbe0

CATEGORIES =	lang

HOMEPAGE =	https://ziglang.org/

#MAINTAINER =	Sebastien Marie <semarie@online.fr>

# MIT (zig) / Apache2 (llvm+clang+lld)
PERMIT_PACKAGE =	Yes

WANTLIB =	${COMPILER_LIBCXX} c curses m z

COMPILER =	base-clang ports-gcc

BUILD_DEPENDS =	devel/cmake \
		devel/ninja \
		meta/python3
#RUN_DEPENDS =		???
#LIB_DEPENDS =		???
#TEST_DEPENDS =		???

SEPARATE_BUILD =	Yes

CONFIGURE_STYLE =	none

#NO_TEST =		Yes

CMD =	cd ${WRKBUILD} && ${SETENV} ${MAKE_ENV} \
		WRKSRC="${WRKSRC}" \
		WRKBUILD="${WRKBUILD}" \
		MAKE_JOBS="${MAKE_JOBS}" \
	    sh "${.CURDIR}/files/build.sh"

do-build:
	${CMD} build

do-install:
	${CMD} install

post-install:
	rm ${PREFIX}/lib/zig/libcxx/include/*.orig

do-test:
	${CMD} test

.include <bsd.port.mk>
