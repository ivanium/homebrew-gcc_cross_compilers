require 'formula'

class ArmElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.9.3/gcc-4.9.3.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.9.3/gcc-4.9.3.tar.bz2'
  sha256 '2332b2a5a321b57508b9031354a8503af6fdfb868b8c1748d33028d100a8b67e'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'arm-elf-binutils'

  def install
    binutils = Formulary.factory 'arm-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-4.9'
    ENV['CXX'] = '/usr/local/bin/g++-4.9'
    ENV['CPP'] = '/usr/local/bin/cpp-4.9'
    ENV['LD'] = '/usr/local/bin/gcc-4.9'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=arm-elf-eabi', '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"arm-elf-eabi", prefix/"arm-elf-eabi"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
