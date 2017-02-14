defmodule NetworkManager.Mixfile do
  use Mix.Project

  def project do
    [app: :network_manager,
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
      applications: [:logger, :nerves_interim_wifi, :nerves_network_interface, :gen_stage, :nerves_wpa_supplicant, :cipher],
      mod: {NetworkManager.Application, []},
      env: [
        cipher: [
          keyphrase: System.get_env("CIPHER_KEYPHRASE"),
          ivphrase: System.get_env("CIPHER_IV"),
          magic_token: System.get_env("CIPHER_TOKEN")
        ]
      ]
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
      {:nerves_network_interface, "~> 0.3.2"},
      {:nerves_wpa_supplicant, "~> 0.2.2"},
      {:nerves_interim_wifi, "~> 0.1.0"},
      {:gen_stage, "~> 0.11.0"},
      {:poison, "~> 3.0", override: true},
      {:cipher, ">= 1.3.0"}
    ]
  end
end
