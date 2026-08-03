class GatherStep < Formula
  desc "Local-first code graph for multi-repo workspaces and AI coding assistants"
  homepage "https://gatherstep.dev"
  url "https://github.com/thedoublejay/gather-step/archive/refs/tags/v5.16.2.tar.gz"
  sha256 "5d0950b800768da9be0960cfab9054946014ac7bfc2a2b5e0c4054b9e11273a4"
  license "MIT"

  on_linux do
    depends_on "rust" => :build
  end

  resource "gather-step-aarch64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.16.2/gather-step-v5.16.2-aarch64-apple-darwin.tar.gz"
    sha256 "b5c9c1f10bbdaeafecb74b682dbc0bef15e0207b69f3f0e631f25083bafe3c33"
  end

  resource "gather-step-x86_64-apple-darwin" do
    url "https://github.com/thedoublejay/gather-step/releases/download/v5.16.2/gather-step-v5.16.2-x86_64-apple-darwin.tar.gz"
    sha256 "94b730fc2b9fad4dbd049f8c7f0feccd58d1067b2473ff08801598a7b19b902f"
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
