class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.1.1/gather-step-v2.1.1-aarch64-apple-darwin.tar.gz"
      sha256 "b7125190c2233db4574f9497e41459eb456258bb1a3cc7e08f4a7dfa1aaa6c96"
    end

    on_intel do
      url "https://github.com/thedoublejay/gather-step/releases/download/v2.1.1/gather-step-v2.1.1-x86_64-apple-darwin.tar.gz"
      sha256 "184cf25859b21f17c0cd42f3ef7a0ff6ea7729a38fa2503f64b099af8dc319c1"
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
