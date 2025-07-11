# vim:set et ts=4:
#
# ibus-pinyin - The Chinese PinYin engine for IBus
#
# Copyright (c) 2008-2010 Peng Huang <shawn.p.huang@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.

# if not 1, append datestamp to the version number.
m4_define([ibus_released], [1])
m4_define([ibus_major_version], [1])
m4_define([ibus_minor_version], [5])
m4_define([ibus_micro_version], [0])
m4_define(ibus_maybe_datestamp,
    m4_esyscmd([if test x]ibus_released[ != x1; then date +.%Y%m%d | tr -d '\n\r'; fi]))

m4_define([ibus_version],
    ibus_major_version.ibus_minor_version.ibus_micro_version[]ibus_maybe_datestamp)

AC_INIT([ibus-pinyin], [ibus_version], [http://code.google.com/p/ibus/issues/entry],[ibus-pinyin])
AM_INIT_AUTOMAKE([1.10])
AC_GNU_SOURCE

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])
m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])

# define PACKAGE_VERSION_* variables
AS_VERSION
AS_NANO
AM_SANITY_CHECK
AM_MAINTAINER_MODE
AM_DISABLE_STATIC
AC_PROG_CC
AC_PROG_CXX
AM_PROG_CC_C_O
AC_ISC_POSIX
AC_HEADER_STDC
IT_PROG_INTLTOOL([0.35.0])
AM_PROG_LIBTOOL

# check ibus
PKG_CHECK_MODULES(IBUS, [
    ibus-1.0 >= 1.3.99
])

# check pyzy
PKG_CHECK_MODULES(PYZY, [
    pyzy-1.0 >= 0.0.8
])
AC_PATH_PROG(PYZY, pyzy-1.0)

# check sqlite
PKG_CHECK_MODULES(SQLITE, [
    sqlite3
])
AC_PATH_PROG(SQLITE3, sqlite3)

# check if ibus_config_get_values, which is available in ibus-1.3.99+ (git master)
save_CFLAGS="$CFLAGS"
save_LIBS="$LIBS"
CFLAGS="$CFLAGS $IBUS_CFLAGS"
LIBS="$LIBS $IBUS_LIBS"
AC_CHECK_FUNCS([ibus_config_get_values])
CFLAGS="$save_CFLAGS"
LIBS="$save_LIBS"

# check env
AC_PATH_PROG(ENV, env)
AC_SUBST(ENV)

# Define python version
AC_ARG_WITH(python,
    AS_HELP_STRING([--with-python[=PATH]],
        [Select python2 or python3]),
    [PYTHON=$with_python], []
)

# check python
AM_PATH_PYTHON([2.5])

# --enable-boost
AC_ARG_ENABLE(boost,
    AC_HELP_STRING([--enable-boost],
        [Use boost to replace stdc++0x.]),
        [enable_boost=$enableval],
        [enable_boost=no]
)
if test x"$enable_boost" = x"yes"; then
    # check boost
    BOOST_REQUIRE([1.39])
    BOOST_FIND_HEADER([boost/bind.hpp])
    BOOST_FIND_HEADER([boost/signals2.hpp])
fi
AM_CONDITIONAL(HAVE_BOOST, test x"$enable_boost" = x"yes")

# define GETTEXT_* variables
GETTEXT_PACKAGE=ibus-pinyin
AC_SUBST(GETTEXT_PACKAGE)
AC_DEFINE_UNQUOTED(GETTEXT_PACKAGE,"$GETTEXT_PACKAGE", [Gettext package])

AM_GLIB_GNU_GETTEXT

# --disable-lua-extension
AC_ARG_ENABLE(lua-extension,
    AS_HELP_STRING([--disable-lua-extension],
         [do not build lua extension]),
    [enable_lua_extension=$enableval],
    [enable_lua_extension=yes]
)

# check lua
PKG_CHECK_MODULES(LUA, [
    lua >= 5.1
], [],
[has_lua_extension=no]
)

if test x"$has_lua_extension" = x"no";
then
    PKG_CHECK_MODULES(LUA, [
        lua5.1
    ], [],
    [enable_lua_extension=no]
    );
fi

AM_CONDITIONAL(IBUS_BUILD_LUA_EXTENSION, [test x"$enable_lua_extension" = x"yes"])

# --disable-english-input-mode
AC_ARG_ENABLE(english-input-mode,
    AS_HELP_STRING([--disable-english-input-mode],
    [do not build english input mode]),
    [enable_english_input_mode=$enableval],
    [enable_english_input_mode=yes]
)

AM_CONDITIONAL(IBUS_BUILD_ENGLISH_INPUT_MODE, [test x"$enable_english_input_mode" = x"yes"])

# OUTPUT files
AC_CONFIG_FILES([ po/Makefile.in
Makefile
ibus-pinyin.spec
lua/Makefile
src/Makefile
src/pinyin.xml.in
setup/Makefile
setup/ibus-setup-pinyin
setup/version.py
data/Makefile
data/db/Makefile
data/db/english/Makefile
data/icons/Makefile
m4/Makefile
])

AC_OUTPUT

AC_MSG_RESULT([
Build options:
    Version                     $VERSION
    Install prefix              $prefix
    Use boost                   $enable_boost
    python                      $PYTHON
    Build lua extension         $enable_lua_extension
    Build english input mode    $enable_english_input_mode
])

