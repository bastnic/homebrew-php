require File.join(File.dirname(__FILE__), 'abstract-php-extension')

class Php54Pcntl < AbstractPhp54Extension
  homepage 'http://php.net/manual/en/book.pcntl.php'
  url 'http://www.php.net/get/php-5.4.7.tar.bz2/from/this/mirror'
  sha1 'e634fbbb63818438636bf83a5f6ea887d4569943'
  version '5.4.7'

  depends_on 'autoconf' => :build
  depends_on 'php54' unless build.include?('without-homebrew-php')

  def install
    Dir.chdir "ext/pcntl"

    # See https://github.com/mxcl/homebrew/pull/5947
    ENV.universal_binary

    safe_phpize
    system "./configure", "--prefix=#{prefix}",
                          phpconfig,
                          "--disable-dependency-tracking"
    system "make"
    prefix.install "modules/pcntl.so"
    write_config_file unless build.include? "without-config-file"
  end
end
