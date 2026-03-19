class Grove < Formula
  desc "Zero-friction worktree management for developers"
  homepage "https://github.com/lost-in-the/grove"
  url "https://github.com/lost-in-the/grove/archive/refs/tags/v0.6.1.tar.gz"
  sha256 "0ff78be933d916738f776485daa9fd129981a7384d2e2a3e68c84b6739832805"
  license "MIT"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/lost-in-the/grove/internal/version.Version=#{version}
      -X github.com/lost-in-the/grove/internal/version.Commit=HEAD
      -X github.com/lost-in-the/grove/internal/version.BuildDate=#{time.iso8601}
    ]
    system "go", "build", *std_go_args(ldflags:), "./cmd/grove"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/grove version")
  end

  def caveats
    <<~EOS
      To enable grove, add this to your shell configuration:

      For zsh (~/.zshrc):
        eval "$(grove install zsh)"

      For bash (~/.bashrc):
        eval "$(grove install bash)"

      Then reload your shell:
        source ~/.zshrc  # or ~/.bashrc
    EOS
  end
end
