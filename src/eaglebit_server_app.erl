%%%-------------------------------------------------------------------
%% @doc eaglebit_server public API
%% @end
%%%-------------------------------------------------------------------

-module(eaglebit_server_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    eaglebit_server_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================