# Homebrew formula for GeoEngine
# Usage: brew install NikaGeospatial/tap/geoengine

class Geoengine < Formula
  desc "Docker-based isolated runtime manager for geospatial workloads"
  homepage "https://github.com/NikaGeospatial/geoengine"
  version "0.4.2"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-darwin-x86_64.tar.gz"
      sha256 "038ab5070bbcfe449cf7628d8d83e68e630c02f517279e3ee44d39de797682c8"
    end

    on_arm do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-darwin-aarch64.tar.gz"
      sha256 "82de268ce34ea7c4e52323c12a5b55362d3aa460d160abcecf22ff210f9a510c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-linux-x86_64.tar.gz"
      sha256 "a69a2a9348602aa8ca1eabffd4b7a798e214829091a7ca5d4b1337f6286e5bb6"
    end

    on_arm do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-linux-aarch64.tar.gz"
      sha256 "e9b525b7e5ab72cc183f8020d7228834c99c8721e7c2c7494c382f77b15590de"
    end
  end

  depends_on "docker" => :recommended

  def install
    bin.install "geoengine"

    # Install shell completions
    # generate_completions_from_executable(bin/"geoengine", "completions")
  end

  def post_install
    # Create config directory
    (var/"geoengine").mkpath
  end

  def caveats
    <<~EOS
      GeoEngine has been installed!

      To get started:
        geoengine --help              Show all commands
        geoengine init                Generate GeoEngine artifacts within project directory

      Make sure Docker is running before using GeoEngine.

      For GPU support on macOS:
        - CUDA is not available on macOS
        - PyTorch will use MPS (Metal) backend automatically
    EOS
  end

  test do
    assert_match "geoengine #{version}", shell_output("#{bin}/geoengine --version")
  end
end
