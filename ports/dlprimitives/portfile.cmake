vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO artyom-beilis/dlprimitives
    REF "b176c155d5e8f0fe4ccff9521ed5e50de52879b5"
    SHA512 f6b1a0f93be49fd50ae5c429cd962d79690fd004e786096b865fa4867ba9352900e4d2bd3c9964e4d2f5c9766fd68f34efabc35883dd4e33121e2f97c5970522
    HEAD_REF master
    PATCHES
)

vcpkg_find_acquire_program(PYTHON3)
get_filename_component(PYTHON3_DIR "${PYTHON3}" DIRECTORY)
vcpkg_add_to_path("${PYTHON3_DIR}")

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DUSE_CL_HPP=OFF
        -DUSE_HDF=OFF
        -DUSE_ONNX=OFF
        -DUSE_PYDLPRIM=OFF
)
vcpkg_cmake_install()
vcpkg_copy_pdbs()
vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/share"
    "${CURRENT_PACKAGES_DIR}/debug/include"
)

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYRIGHT.TXT")
