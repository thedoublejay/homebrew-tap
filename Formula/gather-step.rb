class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.2.0.tar.gz"
  sha256 "e76a096e5bf0540e95c73c94b3ba4e24d012ba925e8cf043c5cc31841da7e93e"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.2.0/gather-step-v4.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "73e0c0b9ce747efdbb203aee425a1b054d0563e502729d3b8ae1ed0e09dd550b"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.2.0/gather-step-v4.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "f230018dd1c3a1e9d9a911aad2311d5625b9a639cab0790e3eac8a347296b63c"
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
