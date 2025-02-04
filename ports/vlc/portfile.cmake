# vcpkg_download_distfile(ARCHIVE
#     URLS https://get.videolan.org/vlc/${VERSION}/vlc-${VERSION}.tar.xz
#     FILENAME "vlc-${VERSION}.tar.xz"
#     SHA512 cb1af76c8056648c331d7e6e0680d161ed1849eb635987504f45eae02531e9b432651034317fa7e02b0722905dfb9f0f5dad67b5924cc62edcaf0d173ac36aee
# )

# vcpkg_extract_source_archive(
#     SOURCE_PATH
#     ARCHIVE "${ARCHIVE}"
#     PATCHES
# )

vcpkg_from_gitlab(
    OUT_SOURCE_PATH SOURCE_PATH
    GITLAB_URL https://code.videolan.org/
    REPO videolan/vlc
    REF 96c80ec7803bdfb95c084f3f837a5dc645d444f4
    SHA512 e28966dd56db0f47b93ab72b952141190eb41e7665a64f2917852f4f86a01b6612534d58d6c24a64c515ac56918d7b0115ad55370a865252ee5193b0061e364c
)

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -Dvlc=false
        -Dtests=disabled
        -Dnls=disabled
        -Doptimize_memory=false
        -Dstream_outputs=false
        -Dvideolan_manager=false
        -Daddon_manager=false
        -Drun_as_root=false
        -Dbranch_protection=disabled
        -Dssp=disabled
        -Dextra_checks=false
        -Dwinstore_app=false
        -Dupdate-check=disabled
        -Drust=disabled
        -Dvendored_rust_deps="no"
        -Dsse=disabled
        -Davx=disabled
        -Dvcd_module=false
        -Dcss_engine=disabled
        -Dchromecast=disabled
        -Dqt=disabled
        -Dqt_gtk=disabled
        -Dqt_qml_debug=false
        -Dskins2=disabled
        -Ddbus=disabled
        -Dwayland=disabled
        -Dx11=disabled
        -Dxcb=disabled
        -Davcodec=disabled
        -Dmerge-ffmpeg=false
        -Dlibva=disabled
        -Domxil=false
        -Davformat=disabled
        -Dalsa=disabled
        -Dpulse=disabled
        -Doss=disabled
        -Dogg=disabled
        -Dmpg123=disabled
        -Dschroedinger=disabled
        -Drsvg=disabled
        -Dcairo=disabled
        -Dfreetype=disabled
        -Dflac=disabled
        -Dopus=disabled
        -Dtheoraenc=disabled
        -Dtheoradec=disabled
        -Ddaaladec=disabled
        -Ddaalaenc=disabled
        -Dvorbis=disabled
        -Dvsxu=disabled
        -Dx265=disabled
        -Dx264=disabled
        -Dx262=disabled
        -Dfdk-aac=disabled
        -Dvpx=disabled
        -Dshine=disabled
        -Daom=disabled
        -Drav1e=disabled
        -Ddav1d=disabled
        -Dtwolame=disabled
        -Dvpl=disabled
        -Dspatialaudio=disabled
        -Dsamplerate=disabled
        -Dsoxr=disabled
        -Dspeex=disabled
        -Dspeexdsp=disabled
        -Dcaca=disabled
        -Ddrm=disabled
        -Dgoom2=disabled
        -Davahi=disabled
        -Dupnp=disabled
        -Dlibxml2=disabled
        -Dmedialibrary=disabled
        -Dfaad=disabled
        -Dfluidsynth=disabled
        -Dmicrodns=disabled
        -Dgnutls=disabled
        -Dlibsecret=disabled
        -Dmatroska=disabled
        -Dlibdvbpsi=disabled
        -Ddvbcsa=disabled
        -Daribb24=disabled
        -Dlibmodplug=disabled
        -Dtaglib=disabled
        -Dlibcddb=disabled
        -Dlibass=disabled
        -Dlibchromaprint=disabled
        -Dmad=disabled
        -Dpng=disabled
        -Djpeg=disabled
        -Dbpg=disabled
        -Daribsub=disabled
        -Dtelx=disabled
        -Dzvbi=disabled
        -Dkate=disabled
        -Dtiger=disabled
        -Dlibplacebo=disabled
        -Dgles2=disabled
        -Dlua=disabled
        -Dsrt=disabled
        -Dvulkan=disabled
        -Dscreen=disabled
        -Dfreerdp=disabled
        -Dvnc=disabled
        -Dswscale=disabled
        -Dpostproc=disabled
        -Debur128=disabled
        -Drnnoise=disabled
        -Dmtp=disabled
        -Dwasapi=disabled
        -Dmacosx_avfoundation=disabled
        -Ddc1394=disabled
        -Ddv1394=disabled
        -Dlinsys=disabled
        -Ddvdnav=disabled
        -Ddvdread=disabled
        -Dbluray=disabled
        -Dshout=disabled
        -Dncurses=disabled
        -Dminimal_macosx=disabled
        -Dudev=disabled
        -Ddsm=disabled
        -Dlive555=disabled
        -Drist=disabled
        -Dlibgcrypt=disabled
        -Dfontconfig=disabled
        -Dfribidi=disabled
        -Dharfbuzz=disabled
        -Dd3d11va=disabled
        -Ddxva2=disabled
        -Damf_scaler=disabled
        -Damf_frc=disabled
        -Damf_vqenhancer=disabled
        -Ddirectx=disabled
        -Dprojectm=disabled
        -Dlibssh2=disabled
        -Dsftp=disabled
        -Darchive=disabled
        -Daribb25=disabled
        -Daribcaption=disabled
        -Dgme=disabled
        -Dmpc=disabled
        -Dsid=disabled
        -Dnvdec=disabled
        -Ddecklink=disabled
        -Dnfs=disabled
)

vcpkg_install_meson()

vcpkg_copy_pdbs()

vcpkg_fixup_pkgconfig()

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/COPYING")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
