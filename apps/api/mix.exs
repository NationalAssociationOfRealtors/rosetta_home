defmodule Api.Mixfile do
  use Mix.Project

  def project do
    [app: :api,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger, :cowboy, :device_manager, :data_manager, :cpu_mon, :gen_stage, :poison],
      mod: {API, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:myapp, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:device_manager, in_umbrella: true},
      {:data_manager, in_umbrella: true},
      {:cpu_mon, in_umbrella: true},
      {:gen_stage, "~> 0.4"},
      {:poison, "~> 3.0", override: true},
      {:cowboy, "~> 1.0"},

    ]
  end
end
