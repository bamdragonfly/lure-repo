name='xivlauncher-cn'
version='1.0.7.1'
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

build_deps_arch=('python-yaml' 'git' 'aria2' 'sdl2' 'lib32-sdl2' 'libsecret' 'attr' 'lib32-attr' 'fontconfig' 'lib32-fontconfig' 'lcms2' 'lib32-lcms2' 'libxml2' 'lib32-libxml2' 'libxcursor' 'lib32-libxcursor' 'libxrandr' 'lib32-libxrandr' 'libxdamage' 'lib32-libxdamage' 'libxi' 'lib32-libxi' 'gettext' 'lib32-gettext' 'freetype2' 'lib32-freetype2' 'glu' 'lib32-glu' 'libsm' 'lib32-libsm' 'gcc-libs' 'lib32-gcc-libs' 'libpcap' 'lib32-libpcap' 'faudio' 'lib32-faudio' 'desktop-file-utils' 'jxrlib')

sources=("git+https://github.com/ottercorp/XIVLauncher.Core.git#commit=d3c99fd50153af48a9462fb8807af462dd191155"
         "https://download.visualstudio.microsoft.com/download/pr/19144d78-6f95-4810-a9f6-3bf86035a244/23f4654fc5352e049b517937f94be839/dotnet-sdk-6.0.421-linux-x64.tar.gz?~archive=false")
checksums=(
            'SKIP'
            'SKIP'
          )

prepare() {
	cd "${srcdir}/XIVLauncher.Core"
	git submodule update --init --recursive
	mkdir dotnet
	tar zxf "${srcdir}/dotnet-sdk-6.0.421-linux-x64.tar.gz" -C "${srcdir}/XIVLauncher.Core/dotnet"
	mkdir build
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
