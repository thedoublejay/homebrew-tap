class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v3.5.0/gather-step-v3.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "e98a605ebd3efbe7d1458cb21cfbc340c0c6be2b3c552157cda48bb807730c89"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v3.5.0/gather-step-v3.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "c4fd0bdb878dcc09ed0b9b8deb9a3de57039878dc1e6961b2fb3841c4ed8ef71"
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
