# Homebrew formula for GeoEngine
# Usage: brew install NikaGeospatial/tap/geoengine

class Geoengine < Formula
  desc "Docker-based isolated runtime manager for geospatial workloads"
  homepage "https://github.com/NikaGeospatial/geoengine"
  version "0.6.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-darwin-x86_64.tar.gz"
      sha256 "01009bde9593d5020206a863ae6df5ec2c934e6756659a56dec8b51eefc4a484"
    end

    on_arm do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-darwin-aarch64.tar.gz"
      sha256 "ea43f241c1147de22bbb8ff75ec7b1d6c9b461455309e35d8b5aca664404abfc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-linux-x86_64.tar.gz"
      sha256 "a0a4817be0d092ca094103125279efbef7be4109fa4e41fd4527dceb2774bd8b"
    end

    on_arm do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-linux-aarch64.tar.gz"
      sha256 "18279fa69fac7bb111e4bf6dc0420517a05520d77e18dd17b7ea8203cc12c811"
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
