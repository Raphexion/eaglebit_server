-module(eaglebit_server).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

-export([start_link/0]).

-export([init/1,
	 handle_call/3,
	 handle_cast/2,
	 handle_info/2,
	 terminate/2,
	 code_change/3]).

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).


init(_) ->
    {ok, [], 0}.

handle_call(What, _From, State) ->
    {reply, {ok, What}, State}.

handle_cast(_What, State) ->
    {noreply, State}.

handle_info(timeout, State) ->
    Info = #{exchange => <<"eaglebit_file_server">>,
	     routing_key => <<"black">>},

    Payload = <<"Eaglebit Server: File Server">>,

    {ok, P} = kiks_producer_sup:add_child(Info),
    kiks_producer:send(P, Payload),

    io:fwrite("DOWNLOAD THIS: ~p~n", [Payload]),
    {noreply, State};

handle_info(_What, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_, _, State) ->
    {ok, State}.
