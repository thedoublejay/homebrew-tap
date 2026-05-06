class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v3.5.3/gather-step-v3.5.3-aarch64-apple-darwin.tar.gz"
      sha256 "cc687f3d2e1b25c51f810ec448ff7c1e8e1427ee0998ee46a456d661adf2c9c1"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v3.5.3/gather-step-v3.5.3-x86_64-apple-darwin.tar.gz"
      sha256 "206692e1ff89aadf5e363fe2cfe7269956b83d318d5d2ba81edcfa5c30c4e489"
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
