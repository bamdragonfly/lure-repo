name='xivlauncher-cn'
version='1.1.0.3'
release='1'
desc='Custom Launcher for Final Fantasy XIV Online CN (Crossplatform rewrite)'
desc_zh='XIVLauncher 的跨平台版本，附带一个为最终幻想14调整过的 WINE.'
homepage='https://github.com/ottercorp/XIVLauncher.Core.git'
maintainer="bamcat <bamdragonfly@gmail.com>"
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('xivlauncher-cn')
conflicts=('xivlauncher-cn-git')

build_deps_fedora=('aria2' 'SDL2' 'libsecret' 'libattr' 'fontconfig' 'lcms2' 'libXcursor' 'libXrandr' 'libXdamage' 'libXi' 'gettext' 'freetype' 'mesa-libGLU' 'libSM' 'libgcc' 'libpcap' 'libFAudio' 'desktop-file-utils' 'jxrlib' 'git')

build_deps_opensuse=('aria2' 'libSDL2-2_0-0' 'libsecret-1-0' 'libattr1' 'fontconfig' 'lcms2' 'libXcursor1' 'libXrandr2' 'libXdamage1' 'libXi6' 'gettext-runtime' 'freetype' 'libGLU1' 'libSM6' 'libgcc_s1' 'libpcap1' 'libFAudio0' 'desktop-file-utils' 'jxrlib' 'git')

build_deps_arch=('aria2' 'sdl2' 'libsecret' 'attr' 'fontconfig' 'lcms2' 'libxml2' 'libxcursor' 'libxrandr' 'libxdamage' 'libxi' 'gettext' 'freetype2' 'glu' 'libsm' 'gcc-libs' 'libpcap' 'desktop-file-utils' 'jxrlib')

sources=("git+https://github.com/ottercorp/XIVLauncher.Core.git#commit=c1f389959d45e7a556aff0e73640b4ef0fa40f42"
         "https://download.visualstudio.microsoft.com/download/pr/db901b0a-3144-4d07-b8ab-6e7a43e7a791/4d9d1b39b879ad969c6c0ceb6d052381/dotnet-sdk-8.0.401-linux-x64.tar.gz?~archive=false"
	 "https://github.com/bamdragonfly/XIVLauncher.Core/raw/refs/heads/cn/misc/linux_distrib/XIVLauncher.desktop"
  	)
checksums=(
            'SKIP'
            'SKIP'
	    'SKIP'
          )

prepare() {
	cd "${srcdir}/XIVLauncher.Core" || exit
	git submodule update --init --recursive
	mkdir -p dotnet
	tar zxf "${srcdir}/dotnet-sdk-8.0.401-linux-x64.tar.gz" -C "${srcdir}/XIVLauncher.Core/dotnet"
	cp -r "${srcdir}/XIVLauncher.desktop" "${srcdir}/XIVLauncher.Core/misc/linux_distrib"
	mkdir -p build
}

build() {
	cd "${srcdir}/XIVLauncher.Core/src/XIVLauncher.Core/"
	"${srcdir}/XIVLauncher.Core/dotnet/dotnet" publish -r linux-x64 --sc -o "${srcdir}/build" --configuration Release
}

package() {
    install -d "${pkgdir}/usr/bin/"
    install -d "${pkgdir}/opt/XIVLauncherCN/"
    install -D -m644 "${srcdir}/XIVLauncher.Core/misc/linux_distrib/XIVLauncher.desktop" "${pkgdir}/usr/share/applications/XIVLauncherCN.desktop"
    install -D -m644 "${srcdir}/XIVLauncher.Core/misc/linux_distrib/512.png" "${pkgdir}/usr/share/pixmaps/xivlauncher.png"
    cp -r "${srcdir}/build/." "${pkgdir}/opt/XIVLauncherCN/"
    ln -s ../../opt/XIVLauncherCN/XIVLauncher.Core "${pkgdir}/usr/bin/xivlauncher"
}
