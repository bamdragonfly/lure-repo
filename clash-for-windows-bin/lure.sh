name='clash-for-windows-bin'
version=0.20.20
release=1
desc='A Windows/macOS/Linux GUI based on Clash and Electron.'
architectures=('amd64')
homepage='https://github.com/Fndroid/clash_for_windows_pkg'
license=('Unlicense')
maintainer='bamcat <bamdragonfly@gmail.com>'
provides=('clash-for-windows-bin')
conflicts=('clash-for-windows')
sources_amd64=("https://github.com/Fndroid/clash_for_windows_pkg/releases/download/$version/Clash.for.Windows-$version-x64-linux.tar.gz")
checksums_amd64=('SKIP')
deps_fedora=('libXss.so.1' 'gtk3' 'nftables' 'iproute')
deps_opensuse=('libXss1' 'gtk3' 'nftables' 'iproute2')

package() {
    local parch=$(echo ${CARCH} | sed "s/x86_64/x64/;s/aarch64/arm64/")
    cd "Clash for Windows-${pkgver}-${parch}-linux"
    echo "Packaging application files. Please wait."
    install -d "${pkgdir}/opt/${pkgname}"
    cp -r ./* "${pkgdir}/opt/${pkgname}"
    install -Dm 755 ../cfw ${pkgdir}/usr/bin/cfw
    install -Dm 644 ../clash.png ${pkgdir}/usr/share/pixmaps/clash.png
    install -Dm 644 ../clash-for-windows.desktop ${pkgdir}/usr/share/applications/clash-for-windows.desktop
    sed -e "s/VERSION_PLACEHOLDER/${pkgver}/g" -i ${pkgdir}/usr/share/applications/clash-for-windows.desktop
}
