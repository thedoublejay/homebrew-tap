class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://github.com/thedoublejay/gather-step"
  version "1.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v1.0.0/gather-step-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "ae8c047e4795d2eb0cd7abb8cbac8f7d900118bb49bb9ad065c91f7d0b979612"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v1.0.0/gather-step-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "4d4552d7b631f595cac5ad329f0c7ae51822c8952cb8cf9a9c8a901050edc509"
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
