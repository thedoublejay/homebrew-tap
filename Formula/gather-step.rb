class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.5.0.tar.gz"
  sha256 "f390bc189fe4876560fe330feb9a5a51f9a4ef529976aa55c2a2cb41ddf8c08f"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.5.0/gather-step-v5.5.0-aarch64-apple-darwin.tar.gz"
    sha256 "a14222546cd331eb2f10759cf9b0caf2374f8d4fbcb70db1e0311f93276456a5"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.5.0/gather-step-v5.5.0-x86_64-apple-darwin.tar.gz"
    sha256 "a26c3b221ada8006574a06667feeff03855ead8ed247348917cae2441627f018"
  end

  def install
    if OS.mac?
      arch = Hardware::CPU.arm? ? "aarch64-apple-darwin" : "x86_64-apple-darwin"
      resource("gather-step-#{arch}").stage do
        bin.install "gather-step-#{arch}" => "gather-step"
      end
    else
      system "cargo", "install", *std_cargo_args(path: "crates/gather-step-cli")
    end
  end

  test do
    system "git", "init"
    system bin/"gather-step", "--workspace", testpath, "--no-banner", "--no-interactive", "init"

    assert_path_exists testpath/"gather-step.config.yaml"
  end
end
