class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v3.5.1/gather-step-v3.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "9daf679f3c35739ced127c59842e7b304678076aa5abb8b1edbc9d1ba74f33ce"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v3.5.1/gather-step-v3.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "c6cefc736b421a8bc7f388d2a03bfb54d9dcb7cc5c46b648c38b100ffc55ed01"
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
