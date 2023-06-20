name='xivlauncher-cn'
version='1.0.3.2'
release='1'
desc='Custom Launcher for Final Fantasy XIV Online CN (Crossplatform rewrite)'
desc_zh='XIVLauncher 的跨平台版本，附带一个为最终幻想14调整过的 WINE.'
homepage='https://github.com/ottercorp/XIVLauncher.Core.git'
maintainer="bamcat <bamdragonfly@gmail.com>"
architectures=('amd64')
license=('GPL-3.0-or-later')
provides=('xivlauncher-cn')
conflicts=('xivlauncher-cn-git')

build_deps_fedora=('dotnet-sdk-6.0' 'aria2' 'SDL2' 'libsecret' 'libattr' 'fontconfig' 'lcms2' 'libXcursor' 'libXrandr' 'libXdamage' 'libXi' 'gettext' 'freetype' 'mesa-libGLU' 'libSM' 'libgcc' 'libpcap' 'libFAudio' 'desktop-file-utils' 'jxrlib')

build_deps_opensuse=('dotnet-sdk-6.0' 'aria2' 'libSDL2-2_0-0' 'libsecret-1-0' 'libattr1' 'fontconfig' 'lcms2' 'libXcursor1' 'libXrandr2' 'libXdamage1' 'libXi6' 'gettext-runtime' 'freetype' 'libGLU1' 'libSM6' 'libgcc_s1' 'libpcap1' 'libFAudio0' 'desktop-file-utils' 'jxrlib')

build_deps_arch=('dotnet-sdk-6.0' 'python-yaml' 'git' 'aria2' 'sdl2' 'lib32-sdl2' 'libsecret' 'attr' 'lib32-attr' 'fontconfig' 'lib32-fontconfig' 'lcms2' 'lib32-lcms2' 'libxml2' 'lib32-libxml2' 'libxcursor' 'lib32-libxcursor' 'libxrandr' 'lib32-libxrandr' 'libxdamage' 'lib32-libxdamage' 'libxi' 'lib32-libxi' 'gettext' 'lib32-gettext' 'freetype2' 'lib32-freetype2' 'glu' 'lib32-glu' 'libsm' 'lib32-libsm' 'gcc-libs' 'lib32-gcc-libs' 'libpcap' 'lib32-libpcap' 'faudio' 'lib32-faudio' 'desktop-file-utils' 'jxrlib')

sources=("git+https://github.com/ottercorp/XIVLauncher.Core.git#commit=48bcc13256e538f0ae0a4b94891e57c9c5aa3250")
checksums=('SKIP')

prepare() {
	cd "${srcdir}/XIVLauncher.Core"
	git submodule update --init --recursive
	mkdir build
}

build() {
	cd "${srcdir}/XIVLauncher.Core/src/XIVLauncher.Core/"
	dotnet publish -r linux-x64 --sc -o "${srcdir}/build" --configuration Release
}

package() {
    install -d "${pkgdir}/usr/bin/"
    install -d "${pkgdir}/opt/XIVLauncherCN/"
    install -D -m644 "${srcdir}/XIVLauncher.Core/misc/linux_distrib/XIVLauncher.desktop" "${pkgdir}/usr/share/applications/XIVLauncherCN.desktop"
    install -D -m644 "${srcdir}/XIVLauncher.Core/misc/linux_distrib/512.png" "${pkgdir}/usr/share/pixmaps/xivlauncher.png"
    cp -r "${srcdir}/build/." "${pkgdir}/opt/XIVLauncherCN/"
    ln -s ../../opt/XIVLauncherCN/XIVLauncher.Core "${pkgdir}/usr/bin/xivlauncher"
}
