require 'formula'

class I386JosElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.0/gcc-4.8.0.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.0/gcc-4.8.0.tar.bz2'
  sha256 'be10769d38c83d09387e55ae8b3f036973e420a76a234f381ba7684b7cd3a22e'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'i386-jos-elf-binutils'

  def install
    binutils = Formula.factory 'i386-jos-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-4.2'
    ENV['CXX'] = '/usr/local/bin/g++-4.2'
    ENV['CPP'] = '/usr/local/bin/cpp-4.2'
    ENV['LD'] = '/usr/local/bin/gcc-4.2'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i386-jos-elf', '--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"i386-jos-elf", prefix/"i386-elf-jos"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
