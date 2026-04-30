class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_linux do
    disable! date: "2026-04-30", because: "only macOS binaries are provided"
  end

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.0.0/gather-step-v2.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "b6d5eaecac347e120918d8d7af755d703bbe56cf8f5dedaa60fc10e41e6f81fa"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.0.0/gather-step-v2.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "5a3b3abf98e86f810bfd8f36a2eb7afe74eaa3afb5badf4c93b9fb3f0bf94b0b"
    end
  end

  def install
    arch = Hardware::CPU.arm? ? "aarch64-apple-darwin" : "x86_64-apple-darwin"
    bin.install "gather-step-#{arch}" => "gather-step"
  end

  test do
    system "git", "init"
    system bin/"gather-step", "--workspace", testpath, "--no-banner", "init"

    assert_path_exists testpath/"gather-step.config.yaml"
  end
end
