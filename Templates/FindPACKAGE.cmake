#
# - Try to find the <PACKAGE>
# Once done this defines
#
#  <PACKAGE>_FOUND - The system has <PACKAGE>
#  <PACKAGE>_INCLUDE_DIRS - The <PACKAGE> include directory
#  <PACKAGE>_LIBRARIES - Link these to use <PACKAGE>
#
###################################################################
#
# Copyright (C) yyyy  name of author
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA  02110-1301, USA.
#
###################################################################
#
#  Copyright (c) <YEAR>, <OWNER>
#  All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in
#   the documentation and/or other materials provided with the
#   distribution.
#
# * Neither the name of the <ORGANIZATION> nor the names of its
#   contributors may be used to endorse or promote products derived
#   from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

IF (<PACKAGE>_INCLUDE_DIRS AND <PACKAGE>_LIBRARIES)
  # in cache already
  SET(<PACKAGE>_FOUND TRUE)
ELSE (<PACKAGE>_INCLUDE_DIRS AND <PACKAGE>_LIBRARIES)

  # use pkg-config to get the directories and then use these values
  # in the FIND_PATH() and FIND_LIBRARY() calls
  INCLUDE(UsePkgConfig)

  PKGCONFIG(<LIBRARY> _lib<PACKAGE>IncDir _lib<PACKAGE>LinkDir _lib<PACKAGE>LinkFlags _lib<PACKAGE>Cflags)

  FIND_PATH(<PACKAGE>_INCLUDE_DIR
    NAMES
      <FILENAME.h>
    PATHS
      ${_lib<PACKAGE>IncDir}
      /usr/include
      /usr/local/include
  )

  FIND_LIBRARY(<PACKAGE>_LIBRARY NAMES gdal
    PATHS
    ${_lib<PACKAGE>LinkDir}
    /usr/lib
    /usr/local/lib
  )

  SET(<PACKAGE>_INCLUDE_DIRS ${<PACKAGE>_INCLUDE_DIR})
  SET(<PACKAGE>_LIBRARIES ${<PACKAGE>_LIBRARY} CACHE INTERNAL "The libraries for <PACKAGE>")

  IF (<PACKAGE>_INCLUDE_DIRS AND <PACKAGE>_LIBRARIES)
    SET(<PACKAGE>_FOUND TRUE)
  ENDIF (<PACKAGE>_INCLUDE_DIRS AND <PACKAGE>_LIBRARIES)

  IF (<PACKAGE>_FOUND)
    IF (NOT lib<PACKAGE>_FIND_QUIETLY)
      MESSAGE(STATUS "Found <PACKAGE>: ${<PACKAGE>_LIBRARIES}")
    ENDIF (NOT lib<PACKAGE>_FIND_QUIETLY)
  ELSE (<PACKAGE>_FOUND)
    IF (lib<PACKAGE>_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could NOT find <PACKAGE>")
    ENDIF (lib<PACKAGE>_FIND_REQUIRED)
  ENDIF (<PACKAGE>_FOUND)

  MARK_AS_ADVANCED(
    <PACKAGE>_INCLUDE_DIRS
    <PACKAGE>_LIBRARIES
  )

ENDIF (<PACKAGE>_INCLUDE_DIRS AND <PACKAGE>_LIBRARIES)

# vim:et ts=2 sw=2 comments=\:\#

