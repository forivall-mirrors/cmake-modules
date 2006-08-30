#
# - Try to find the PACKAGE
# Once done this defines
#
#  PACKAGE_FOUND - The system has PACKAGE
#  PACKAGE_INCLUDE_DIR - The PACKAGE include directory
#  PACKAGE_LIBRARIES - Link these to use PACKAGE
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

IF (PACKAGE_INCLUDE_DIR AND PACKAGE_LIBRARIES)
  # in cache already
  SET(PACKAGE_FOUND TRUE)
ELSE (PACKAGE_INCLUDE_DIR AND PACKAGE_LIBRARIES)

  # use pkg-config to get the directories and then use these values
  # in the FIND_PATH() and FIND_LIBRARY() calls
  INCLUDE(UsePkgConfig)

  PKGCONFIG(libgdal _libPACKAGEIncDir _libPACKAGELinkDir _libPACKAGELinkFlags _libPACKAGECflags)

  FIND_PATH(PACKAGE_INCLUDE_DIR gdal.h
    /usr/include
    /usr/local/include
  )

  FIND_LIBRARY(PACKAGE_LIBRARY NAMES gdal
    PATHS
    ${_libPACKAGELinkDir}
    /usr/lib
    /usr/local/lib
  )

  SET(PACKAGE_LIBRARIES ${PACKAGE_LIBRARY} CACHE INTERNAL "The libraries for libgdal" )

  IF (PACKAGE_INCLUDE_DIR AND PACKAGE_LIBRARIES)
    SET(PACKAGE_FOUND TRUE)
  ENDIF (PACKAGE_INCLUDE_DIR AND PACKAGE_LIBRARIES)

  IF (PACKAGE_FOUND)
    if (NOT libPACKAGE_FIND_QUIETLY)
      message(STATUS "Found PACKAGE: ${PACKAGE_LIBRARIES}")
    ENDIF (NOT libPACKAGE_FIND_QUIETLY)
  ELSE (PACKAGE_FOUND)
    if (libPACKAGE_FIND_REQUIRED)
      message(FATAL_ERROR "Could NOT find PACKAGE")
    ENDIF (libPACKAGE_FIND_REQUIRED)
  ENDIF (PACKAGE_FOUND)

  MARK_AS_ADVANCED(
    PACKAGE_INCLUDE_DIR PACKAGE_LIBRARIES 
  )

ENDIF (PACKAGE_INCLUDE_DIR AND PACKAGE_LIBRARIES)

# vim:et ts=2 sw=2 comments=\:\#

