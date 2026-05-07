class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.3/gather-step-v4.0.3-aarch64-apple-darwin.tar.gz"
      sha256 "3f444cff90afb4ad3ebf1231842bca4ee3f6c2ccd992db8906957ed19931bf90"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v4.0.3/gather-step-v4.0.3-x86_64-apple-darwin.tar.gz"
      sha256 "b7aa938393cb9873efdbaad778961985a1ae526003d85101e38ff7a86fa65aa0"
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
