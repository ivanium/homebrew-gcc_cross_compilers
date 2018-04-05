require 'formula'

class I586ElfBinutils < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/binutils/binutils-2.23.tar.gz'
  sha256 '7909a08eabdbaac0f7a22e9ede82a66ba70acd50629b045e705af864eef10b65'

  depends_on 'apple-gcc42' => :build

  def install
    ENV['CC'] = '/usr/local/bin/gcc-4.2'
    ENV['CXX'] = '/usr/local/bin/g++-4.2'
    ENV['CPP'] = '/usr/local/bin/cpp-4.2'
    ENV['LD'] = '/usr/local/bin/gcc-4.2'

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=i586-elf',
                             '--enable-gold=yes',
                             '--disable-werror',
                             "--prefix=#{prefix}"
      system 'make all'
      system 'make install'
      FileUtils.mv lib, libexec
    end
  end

end
