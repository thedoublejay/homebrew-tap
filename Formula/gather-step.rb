class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.1/gather-step-v4.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "9cae185e619035fada821691d1b93952e47d46e0205f0d6d28b6456d22419099"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.1/gather-step-v4.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "8e93f5b0a8f24a58013a360d0bde4df7d2a4533381db70b46825d247cef9343d"
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
