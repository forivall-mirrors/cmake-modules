# - macro_copy_dir(_src _dst)
# Copies a directory to ${_dst} only if ${_src} is different (newer) than ${_dst}
#
# See macro_copy_file()
#
# Example:
# macro_copy_dir(${CMAKE_CURRENT_SOURCE_DIR}/*.png ${BUILD_DIR}/.)
# Copies all *.png files from ${CMAKE_CURRENT_SOURCE_DIR} to ${BUILD_DIR} directory
#
# Copyright (C) 2006-2007  Wengo
# Copyright (c) 2006-2008  Andreas Schneider <mail@cynapses.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING file.

include(MacroCopyFile.cmake)

macro (macro_copy_dir _src _dst)
  file(GLOB fileList ${_src})
  if (fileList)
    foreach (file ${fileList})
      macro_copy_file(${file} ${_dst})
    endforeach (file ${fileList})
  endif (fileList)
endmacro (macro_copy_dir)

