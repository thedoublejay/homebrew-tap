class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v4.4.2.tar.gz"
  sha256 "5e2c3a3de8267de7d15650cd95ed74c9b6386905c619eaff114cd9186dd4a6d4"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.2/gather-step-v4.4.2-aarch64-apple-darwin.tar.gz"
    sha256 "fd35f5f3722fe2d57ed38ac19fa54336fba26047ab130d5a75579adb3e82ab63"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v4.4.2/gather-step-v4.4.2-x86_64-apple-darwin.tar.gz"
    sha256 "36e60160de55692c2ff17b0dee6b1d748004b108ebe2358e61034d0774b6a324"
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
