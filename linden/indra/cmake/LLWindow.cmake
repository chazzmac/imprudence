# -*- cmake -*-

include(OpenGL)
include(Prebuilt)

if (STANDALONE)
  include(FindSDL)

  # This should be done by FindSDL.  Sigh.
  mark_as_advanced(
      SDLMAIN_LIBRARY
      SDL_INCLUDE_DIR
      SDL_LIBRARY
      )
else (STANDALONE)
  use_prebuilt_binary(SDL)
  use_prebuilt_binary(mesa)
  if (LINUX AND VIEWER)
    set (SDL_FOUND TRUE)
#awfixme    set (SDL_INCLUDE_DIR ${LIBS_PREBUILT_DIR}/i686-linux)
#awfixme    set (SDL_INCLUDE_DIR ${LIBS_PREBUILT_DIR}/${ARCH}-linux)
    set (SDL_INCLUDE_DIR ${LIBS_PREBUILT_DIR}/x86_64-linux)
    set (SDL_LIBRARY SDL)
  endif (LINUX AND VIEWER)
endif (STANDALONE)

if (SDL_FOUND)
  add_definitions(-DLL_SDL=1)
  include_directories(${SDL_INCLUDE_DIR})
endif (SDL_FOUND)

set(LLWINDOW_INCLUDE_DIRS
    ${GLEXT_INCLUDE_DIR}
    ${LIBS_OPEN_DIR}/llwindow
    )

if (SERVER AND LINUX)
  set(LLWINDOW_LIBRARIES
      llwindowheadless
      )
else (SERVER AND LINUX)
  set(LLWINDOW_LIBRARIES
      llwindow
      )
  if (WINDOWS)
      list(APPEND LLWINDOW_LIBRARIES
          comdlg32
          )
  endif (WINDOWS)
endif (SERVER AND LINUX)
