class Blasr < Formula
  desc "PacBio long read aligner"
  homepage "https://github.com/PacificBiosciences/blasr"
  # doi "10.1186/1471-2105-13-238"
  # tag "bioinformatics"

  url "https://github.com/PacificBiosciences/blasr/archive/smrtanalysis-2.2.tar.gz"
  sha256 "bef789accf2662aed409b31227e029c61582d5dfe6a289043db4c1b27fd7ab12"

  head "https://github.com/PacificBiosciences/blasr.git"

  bottle do
    cellar :any
    sha256 "cd3242383848697bb8b2cb3e50098f34fbc3a775b0169b91145f053ed316583d" => :mountain_lion
    sha256 "6aad5177d90d352db768ebd322f357022d17c658d852051f0459d2f988b261ee" => :x86_64_linux
  end

  depends_on "hdf5"
  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "ccache" => :build

  def install
    hdf5 = Formula["hdf5"]
    mkdir "build" do
      system "cmake", "-GNinja", "-DHDF5_INCLUDE_DIRS=#{hdf5.opt_include}", "-DHDF5_LIBRARIES=#{hdf5.opt_lib}", "..", *std_cmake_args
      system "ninja", "install"
     end
  end

  test do
    system "#{bin}/blasr"
  end
end
