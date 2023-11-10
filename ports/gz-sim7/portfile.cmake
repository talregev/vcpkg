set(PACKAGE_NAME gazebo)

set(FLGAS "")
if(VCPKG_TARGET_IS_WINDOWS)
   set(FLGAS "/bigobj")
endif()

ignition_modular_library(
   NAME ${PACKAGE_NAME}
   REF ${PORT}_${VERSION}
   VERSION ${VERSION}
   SHA512 699389d97ee52dd615528a008b4da08bfb7deef547a351d9d0d2a21436447eaf3488b16fd1a16d714ce009221553923d00ac59f544ed09104f3136b17a3d268e
   OPTIONS
      -DSKIP_PYBIND11=ON
      -DCMAKE_CXX_FLAGS=${FLGAS}
   PATCHES
      dependencies.patch
)

if(VCPKG_TARGET_IS_WINDOWS)   
   file(GLOB plugins "${CURRENT_PACKAGES_DIR}/lib/gz-sim-7/plugins/*.dll")
   if (NOT plugins STREQUAL "")
      file(COPY ${plugins} DESTINATION "${CURRENT_PACKAGES_DIR}/engine-plugins/")
      file(REMOVE ${plugins})
   endif()

   file(GLOB plugins_debug "${CURRENT_PACKAGES_DIR}/debug/lib/gz-sim-7/plugins/*.dll")
   if (NOT plugins_debug STREQUAL "")
      file(COPY ${plugins_debug} DESTINATION "${CURRENT_PACKAGES_DIR}/debug/engine-plugins/")
      file(REMOVE ${plugins_debug})
   endif()
endif()
