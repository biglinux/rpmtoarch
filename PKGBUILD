# Maintainer: Bruno Goncalves <bigbruno@gmail.com>

pkgname=rpmtoarch
pkgver=1.0.0_1big
pkgrel=3
arch=('any')
license=('GPL')
url="https://github.com/biglinux/rpmtoarch"
pkgdesc="Convert and install .rpm packages"
source=("git+https://github.com/biglinux/rpmtoarch.git")
md5sums=(SKIP)
depends=('yad' 'namcap' 'pamac-gtk' 'kate' 'zenity' 'fakeroot' 'ruby' 'rpm-tools' 'cpio')

package() {
    cp -r "${srcdir}/rpmtoarch/rpmtoarch/usr/" "${pkgdir}/"
}


