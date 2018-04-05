require 'formula'

class I586ElfGdb < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/gdb/gdb-7.6.tar.bz2'
  sha256 'a410e8f35ee70cce83dbbf1da9e2a8373f271ac0e4b71db4336ae293fc7bdf1b'

  depends_on 'i586-elf-binutils'
  depends_on 'i586-elf-gcc'

  def install
    mkdir 'build' do
      system '../configure', '--target=i586-elf', "--prefix=#{prefix}", "--disable-werror"
      system 'make'
      system 'make install'
      FileUtils.rm_rf share/"locale"
      FileUtils.mv lib, libexec
    end
  end
end
