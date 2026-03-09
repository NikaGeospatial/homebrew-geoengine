# Homebrew formula for GeoEngine
# Usage: brew install NikaGeospatial/tap/geoengine

class Geoengine < Formula
  desc "Docker-based isolated runtime manager for geospatial workloads"
  homepage "https://github.com/NikaGeospatial/geoengine"
  version "0.4.5"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-darwin-x86_64.tar.gz"
      sha256 "aff8fb643c69eb6916752eaf125af1ae480db4046c62a837415cada8ca810609"
    end

    on_arm do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-darwin-aarch64.tar.gz"
      sha256 "aede8e9268a310bfb0ccc0e9f8d8e2114246c8417f414449adf2db8e1537f7b9"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-linux-x86_64.tar.gz"
      sha256 "633c36a48a01725aca5b08d651a3d7aa285b2f2e2ad2270721bd9cb55dd0b6f9"
    end

    on_arm do
      url "https://github.com/NikaGeospatial/geoengine/releases/download/v#{version}/geoengine-linux-aarch64.tar.gz"
      sha256 "d39325a8cd21ba4b6c8f9879e8578616cc324d134ea75b1970a2135700f5af45"
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
