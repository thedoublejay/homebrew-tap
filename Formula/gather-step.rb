class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.4.0/gather-step-v2.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "25e85bcd29994c44d60cd65bc5ec95d4a7637f44745fa516e96e511d348d7305"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.4.0/gather-step-v2.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "66257628694e3dd6845b6bd1dad604de05df46d40edeaf3bf0f67071f60afdbc"
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
