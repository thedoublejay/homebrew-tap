class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.4/gather-step-v4.0.4-aarch64-apple-darwin.tar.gz"
      sha256 "026fa30ac0cde6240ba4d4bc85f93208060c01ac42d8ad225fa0d41bb27e70c5"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.4/gather-step-v4.0.4-x86_64-apple-darwin.tar.gz"
      sha256 "fb7f056ccf47b5fa06c82cd4974fb155197d0e90aa3494b189de559662361e18"
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
