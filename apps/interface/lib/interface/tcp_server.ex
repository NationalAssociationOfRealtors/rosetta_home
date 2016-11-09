defmodule Interface.TCPServer do

  def start_link do
    port = Application.get_env(:interface, :tcp_port, 8080)
    dispatch = :cowboy_router.compile([
      { :_,
        [
          {"/", Interface.Index, []},
          {"/floorplan", Interface.Floorplan, []},
          {"/app.js", :cowboy_static, {:priv_file, :interface, "app.js"}},
          {"/static/[...]", :cowboy_static, {:priv_dir,  :interface, "static"}},

        ]}
      ])
      {:ok, _} = :cowboy.start_http(:interface_http,
        100,
        [{:ip, {0,0,0,0}}, {:port, port}],
        [{:env, [{:dispatch, dispatch}]}]
      )
  end


end
