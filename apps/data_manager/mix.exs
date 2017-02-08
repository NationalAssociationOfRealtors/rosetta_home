defmodule DataManager.Mixfile do
  use Mix.Project

  def project do
    [app: :data_manager,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [
      applications: [:logger, :histogram, :device_manager, :cpu_mon],
      mod: {DataManager, []},
      env: [
        update_frequency: 1*60000,
        cloud_url: cloud_url
      ]
    ]
  end

  def cloud_url do
    System.get_env("CLOUD_URL")
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
      {:histogram, in_umbrella: true},
      {:httpoison, "~> 0.8.3"},
      {:poison, "~> 3.0", override: true},
      {:gen_stage, "~> 0.4"},
      {:device_manager, in_umbrella: true},
      {:cpu_mon, in_umbrella: true}
    ]
  end
end
