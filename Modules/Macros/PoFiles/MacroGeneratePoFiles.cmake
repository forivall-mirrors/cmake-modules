#
# This macro compiles the po files and sets the install dirs
#
# MACRO_GENERATE_PO_FILES($(PO_DIRECOTRY) $(APPLICATION_NAME) project_SRCS)
#
# - PO_DIRECTORY:     The path where cmake can find the PO files
# - APPLICATION_NAME: The name of our application. We need it to rename
#                     the [LANG].mo file to [APPLICATION_NAME].mo
#                     during the installation.
# - project_SRCS:     The name of the variable to add the .mo files,
#                     to get them generated
#
###################################################################
#
#  Copyright (c) 2006, Andreas Schneider <mail@cynapses.org>
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
#  Copyright (c) 2006 Andreas Schneider <mail@cynapses.org>
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
# * Neither the name of the cmake-modules nor the names of its
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

MACRO(MACRO_GENERATE_PO_FILES _podir _applicationname _sources)
  FIND_PACKAGE(Msgfmt REQUIRED)

  IF(MSGFMT_FOUND)
    FILE(GLOB _pofiles ${_podir}/*.po)

    FOREACH(_file ${_pofiles})

      GET_FILENAME_COMPONENT(_infile   ${_file} ABSOLUTE)
      GET_FILENAME_COMPONENT(_basename ${_file} NAME_WE)

      IF(UNIX)
        FILE(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/po)
        GET_FILENAME_COMPONENT(_outfile
          ${CMAKE_CURRENT_BINARY_DIR}/po/${_basename}.mo
          ABSOLUTE
        )
      #MESSAGE("DEBUG: ${MSGFMT_EXECUTABLE} -o ${_outfile} ${_infile}")

        ADD_CUSTOM_COMMAND(
          OUTPUT ${_outfile}
          COMMAND ${MSGFMT_EXECUTABLE}
            -o ${_outfile}
            ${_infile}
          DEPENDS ${_infile}
        )
      ENDIF(UNIX)

      SET(_mofiles ${_mofiles} ${_outfile})

      INSTALL(FILES
          ${_outfile}
        DESTINATION
          ${LOCALE_INSTALL_DIR}/${_basename}/LC_MESSAGES/
        RENAME
          ${_applicationname}.mo
      )
      #MESSAGE("DEBUG: install ${_outfile} to ${LOCALE_INSTALL_DIR}/${_basename}/LC_MESSAGES/")
    ENDFOREACH(_file ${_pofiles})

    SET(${_sources} ${${_sources}} ${_mofiles})

  ENDIF(MSGFMT_FOUND)
ENDMACRO(MACRO_GENERATE_PO_FILES _podir _applicationname)

# vim:et ts=2 sw=2 comments=\:\#

