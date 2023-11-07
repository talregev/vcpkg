set(PACKAGE_NAME gazebo)

set(FLGAS "")
if(VCPKG_TARGET_IS_WINDOWS)
   set(FLGAS "/bigobj")
# else()
#    set(FLGAS "-Wa,-mbig-obj")
endif()

ignition_modular_library(
   NAME ${PACKAGE_NAME}
   REF ${PORT}_${VERSION}
   VERSION ${VERSION}
   SHA512 699389d97ee52dd615528a008b4da08bfb7deef547a351d9d0d2a21436447eaf3488b16fd1a16d714ce009221553923d00ac59f544ed09104f3136b17a3d268e
   OPTIONS
      -DSKIP_PYBIND11=ON
      -DCMAKE_CXX_FLAGS=${FLGAS}
      # --help-policy=CMP0111
   PATCHES
      dependencies.patch
)
