#
# - MACRO_INSTALL_MANPAGES
#        Find manpages in the given directory and install them
# structure:
#
# man/file.1
# man/es/file.5
# man/de/file.1
#
#  Copyright (c) Andreas Schneider <mail@cynapses.org>
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

MACRO(MACRO_INSTALL_MANPAGES _mandir)
	FILE(GLOB_RECURSE _manpages ${_mandir} *.[1-9])

	IF (_manpages)
		FOREACH(_man ${_manpages})
			FILE(RELATIVE_PATH _lang ${_mandir} ${_man})
			GET_FILENAME_COMPONENT(_lang ${_lang} PATH)
			GET_FILENAME_COMPONENT(_manext ${_man} EXT)
			STRING(REGEX MATCH "[1-9]" _manext ${_manext})
			INSTALL(FILES ${_man} DESTINATION ${MAN_INSTALL_DIR}/${_lang}/man${_manext})
			#MESSAGE("DEBUG: install ${_man} to ${MAN_INSTALL_DIR}/${_lang}/man${_manext}")
		ENDFOREACH(_man ${_manpages})
	ENDIF (_manpages)
ENDMACRO(MACRO_INSTALL_MANPAGES _mandir)

