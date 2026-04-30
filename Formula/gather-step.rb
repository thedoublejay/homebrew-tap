class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.1.0/gather-step-v2.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "2bba92f3653de127fc76712cdd16ffdb150577f92cf201c3b1b2ff38c1953f35"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.1.0/gather-step-v2.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "05c0c6173a754239a4324b84fb029bb2d79f5d424e51bf55c7a35e91d89aad2a"
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
