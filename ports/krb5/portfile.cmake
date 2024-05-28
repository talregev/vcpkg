
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO krb5/krb5
    REF krb5-${VERSION}-final
    SHA512 184ef8645d7e17f30a8e3d4005364424d2095b3d0c96f26ecef0c2dd2f3a096a0dd40558ed113121483717e44f6af41e71be0e5e079c76a205535d0c11a2ea34
    HEAD_REF master
)

if (VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
    vcpkg_acquire_msys(MSYS_ROOT PACKAGES)
    vcpkg_add_to_path("${MSYS_ROOT}/usr/bin")
    vcpkg_find_acquire_program(PERL)
    get_filename_component(PERL_PATH "${PERL}" DIRECTORY)
    vcpkg_add_to_path("${PERL_PATH}")
    vcpkg_build_nmake(
        SOURCE_PATH "${SOURCE_PATH}/src"
        PROJECT_NAME Makefile.in
        TARGET prep-windows
    )
    file(REMOVE_RECURSE "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}")
    file(COPY "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/" DESTINATION "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}")
    file(MAKE_DIRECTORY "${CURRENT_PACKAGES_DIR}/debug")
    vcpkg_install_nmake(
        SOURCE_PATH "${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}"
        PROJECT_NAME "Makefile"
        OPTIONS
            "NO_LEASH=1"
        OPTIONS_RELEASE
            "KRB_INSTALL_DIR=${CURRENT_PACKAGES_DIR}"
        OPTIONS_DEBUG
            "KRB_INSTALL_DIR=${CURRENT_PACKAGES_DIR}/debug"
    )

    set(WINDOWS_PC_FILES
        krb5-gssapi
        krb5
        mit-krb5-gssapi
        mit-krb5
    )

    foreach (PC_FILE ${WINDOWS_PC_FILES})
        configure_file("${CURRENT_PORT_DIR}/windows_pc_files/${PC_FILE}.pc.in" "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/${PC_FILE}.pc" @ONLY)
    endforeach()

    if(NOT DEFINED VCPKG_BUILD_TYPE)
        foreach (PC_FILE ${WINDOWS_PC_FILES})
            configure_file("${CURRENT_PORT_DIR}/windows_pc_files/${PC_FILE}.pc.in" "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/${PC_FILE}.pc" @ONLY)
        endforeach()
    endif()
elseif(VCPKG_TARGET_IS_OSX AND "${VCPKG_LIBRARY_LINKAGE}" STREQUAL "static")
    vcpkg_replace_string("${SOURCE_PATH}/src/build-tools/mit-krb5.pc.in" "-lkrb5" "-framework Kerberos -lkrb5")
    set(OPTIONS_OSX "LDFLAGS=-framework Kerberos \$LDFLAGS")
endif()

vcpkg_configure_make(
    SOURCE_PATH "${SOURCE_PATH}/src"
    AUTOCONFIG
    DETERMINE_BUILD_TRIPLET
    OPTIONS
        "CFLAGS=-fcommon \$CFLAGS"
        ${OPTIONS_OSX}
)
vcpkg_install_make()
vcpkg_fixup_pkgconfig()

set(client_tools
    gss-client
    kadmin
    kdestroy
    kinit
    klist
    kpasswd
    kswitch
    ktutil
    kvno
    sclient
    sim_client
    uuclient
    compile_et
    k5srvutil
    krb5-config
)
set(server_tools
    gss-server
    kadmind
    kdb5_util
    kprop
    kpropd
    kproplog
    krb5kdc
    sim_server
    sserver
    uuserver
    kadmin.local
    krb5-send-pr
)

vcpkg_copy_tools(
    TOOL_NAMES ${client_tools}
    SEARCH_DIR "${CURRENT_PACKAGES_DIR}/bin"
    DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin"
    AUTO_CLEAN
)

vcpkg_copy_tools(
    TOOL_NAMES ${server_tools}
    SEARCH_DIR "${CURRENT_PACKAGES_DIR}/sbin"
    DESTINATION "${CURRENT_PACKAGES_DIR}/tools/${PORT}/sbin"
)

# Refer: https://github.com/microsoft/vcpkg/blob/5d2a0a9814db499f6ba2e847ca7ab5912badcdbf/ports/xapian/portfile.cmake#L37
vcpkg_replace_string(
	"${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin/krb5-config"
	"${CURRENT_INSTALLED_DIR}"
	"`dirname $0`/../../.."
)
vcpkg_replace_string(
	"${CURRENT_PACKAGES_DIR}/tools/${PORT}/bin/compile_et"
	"${CURRENT_INSTALLED_DIR}"
	"`dirname $0`/../../.."
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/krb5/")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/sbin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/var")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/krb5/")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/sbin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/var")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/NOTICE")
