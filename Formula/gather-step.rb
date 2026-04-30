class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.2.0/gather-step-v2.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "3dd8b667c882a9faacd6169f2e469783d4a1c1dc025efdffc990d16c574d2746"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.2.0/gather-step-v2.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "e48a755093ad682d66292186abd71f1ee74b54db685b0dc4fb56ca619c68bdb6"
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
