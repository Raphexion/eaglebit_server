%%%-------------------------------------------------------------------
%% @doc eaglebit_server top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(eaglebit_server_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init(_) ->
    SupFlags = #{strategy => one_for_one,
                 intensity => 1,
                 period => 1},

    KiksAmqpSup = #{
      id => kiks_amqp_sup,
      start => {kiks_amqp_sup, start_link, []},
      shutdown => brutal_kill,
      type => supervisor
     },

    EaglebitServer = #{
      id => eaglebit_server,
      start => {eaglebit_server, start_link, []},
      shutdown => brutal_kill,
      type => worker
     },

    ChildSpecs = [KiksAmqpSup,
		  EaglebitServer],

    {ok, {SupFlags, ChildSpecs}}.

%%====================================================================
%% Internal functions
%%====================================================================
