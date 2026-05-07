class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.0/gather-step-v4.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "9a298b68153b67a92025e24058136762a6e4050c9d2dfd1f3addf2deb729d444"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.0/gather-step-v4.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "5a1767e8ebe6d5eda4769c2497cfe1da080e073dd476105166177a1bb6ce4bd1"
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
