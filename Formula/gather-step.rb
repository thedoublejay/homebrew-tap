class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.3.0/gather-step-v2.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "722e652301c99ac6ef122a6b923fa854b335f266a0d6e7bb8abe05f9dece7f21"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.3.0/gather-step-v2.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "50d1a8fd2b683887ffe32c27c444c1a9aa82d6350a0e0bfeb2fbb650f60fa166"
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
