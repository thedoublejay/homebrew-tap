class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v3.5.2/gather-step-v3.5.2-aarch64-apple-darwin.tar.gz"
      sha256 "efeac6fe0d98a7869794a18fadddca7f82b65525e74cc40dbb0a5b5065671986"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v3.5.2/gather-step-v3.5.2-x86_64-apple-darwin.tar.gz"
      sha256 "4676d8e5a7bc31a4ec20a9d5ecbd44b497ef4808f57dd24543440f668bccaa94"
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
