name='clash-for-windows-bin'
version=0.20.23
release=1
desc='A Windows/macOS/Linux GUI based on Clash and Electron.'
architectures=('amd64')
homepage='https://github.com/Fndroid/clash_for_windows_pkg'
license=('Unlicense')
maintainer='bamcat <bamdragonfly@gmail.com>'
provides=('clash-for-windows-bin')
conflicts=('clash-for-windows')
sources=(
	"git+https://github.com/bamdragonfly/clash_for_windows_pkg.git"
	"https://github.com/Fndroid/clash_for_windows_pkg/releases/download/$version/Clash.for.Windows-$version-x64-linux.tar.gz"
	)
checksums=(
	'SKIP'
	'SKIP'
          )
deps_fedora=('libXss.so.1' 'gtk3' 'nftables' 'iproute')
deps_opensuse=('libXss1' 'gtk3' 'nftables' 'iproute2')
deps_ubuntu=('libxss1' 'libgtk-3-0' 'nftables' 'iproute2')

package() {
    cd "Clash for Windows-$version-x64-linux"
    echo "Packaging application files. Please wait."
    install -d "$pkgdir/opt/$name"
    cp -r ./* "$pkgdir/opt/$name"
    install -Dm 755 $srcdir/clash_for_windows_pkg/cfw $pkgdir/usr/bin/cfw
    install -Dm 644 $srcdir/clash_for_windows_pkg/clash.png $pkgdir/usr/share/pixmaps/clash.png
    install -Dm 644 $srcdir/clash_for_windows_pkg/clash-for-windows.desktop $pkgdir/usr/share/applications/clash-for-windows.desktop
    sed -e "s/VERSION_PLACEHOLDER/$pkgver/g" -i $pkgdir/usr/share/applications/clash-for-windows.desktop
}
