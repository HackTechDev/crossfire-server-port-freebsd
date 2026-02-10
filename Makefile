PORTNAME=	crossfire-server
DISTVERSION=	1.75.0
CATEGORIES=	games
MASTER_SITES=	SF/crossfire/crossfire-server/${DISTVERSION}
DISTNAME=	crossfire-${DISTVERSION}

MAINTAINER=	lesanglierdesardennes@gmail.com
COMMENT=	Server for the Crossfire multiplayer game
WWW=		https://crossfire.real-time.com/

LICENSE=	GPLv2+

LIB_DEPENDS=	libpng.so:graphics/png

USES=		gmake perl5 xorg
USE_XORG=	xpm
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--prefix=${PREFIX} \
		--sysconfdir=${PREFIX}/etc \
		--localstatedir=/var

CONFFILES=	${WRKSRC}/etc/ban_file \
		${WRKSRC}/etc/dm_file \
		${WRKSRC}/etc/exp_table \
		${WRKSRC}/etc/forbid \
		${WRKSRC}/etc/metaserver2 \
		${WRKSRC}/etc/motd \
		${WRKSRC}/etc/news \
		${WRKSRC}/etc/rules \
		${WRKSRC}/etc/settings \
		${WRKSRC}/etc/stat_bonus

post-install:
	# Configs: install as samples
.for f in ban_file dm_file exp_table forbid metaserver2 motd news rules settings stat_bonus
	${MV} ${STAGEDIR}${PREFIX}/etc/crossfire/${f} ${STAGEDIR}${PREFIX}/etc/crossfire/${f}.sample
.endfor

	${MKDIR} ${STAGEDIR}/var/crossfire

.for d in account accounts datafiles players template-maps unique-items
	${MKDIR} ${STAGEDIR}/var/crossfire/${d}
.endfor

.for f in banish_file cflogger.db cfnewspaper.db clockdata highscore bookarch temp.maps
	${TOUCH} ${STAGEDIR}/var/crossfire/${f}
.endfor

.include <bsd.port.mk>
