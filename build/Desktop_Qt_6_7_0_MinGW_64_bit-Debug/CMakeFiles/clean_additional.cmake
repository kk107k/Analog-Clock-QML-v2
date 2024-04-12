# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles\\appAnalog-Clock-QML-v2_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appAnalog-Clock-QML-v2_autogen.dir\\ParseCache.txt"
  "appAnalog-Clock-QML-v2_autogen"
  )
endif()
