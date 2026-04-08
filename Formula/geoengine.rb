# Homebrew formula for GeoEngine
# Usage: brew install NikaGeospatial/tap/geoengine

class Geoengine < Formula
  desc "Docker-based isolated runtime manager for geospatial workloads"
  homepage "https://github.com/NikaGeospatial/geoengine"
  version "0.6.5"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-darwin-x86_64.tar.gz"
      sha256 "e571fe42fe002361b3a083fe0b8c593e0172e30ffa827d7f3b584ba0cf9f6e3c"
    end

    on_arm do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-darwin-aarch64.tar.gz"
      sha256 "f93dd49e0f1a51d3268bddbd9b4f1a59efbaeee10a5d53b99de3eebc0d7361ce"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-linux-x86_64.tar.gz"
      sha256 "ef3d5e6e3412319e91f425a973a9c903237a73aef94d09f3f17115e97edd3873"
    end

    on_arm do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-linux-aarch64.tar.gz"
      sha256 "ef326136a9afdf44fee92690f43f7fbae754718e4b5e9743d7339c02be08e607"
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
