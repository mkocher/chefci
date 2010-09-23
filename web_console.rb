#!/usr/bin/env ruby

require 'environment'
require 'sinatra'
require 'erubis'

get '/' do
  @builds = Build.all
  erubis :index
end

get '/builds/:build' do
  @build = Build.find_by_id(params[:build])
  if @build.last_run
    erubis :build
  else
    "No Build Yet"
  end
end

get '/builds/:build/runs/:run' do
  @build = Build.find_by_id(params[:build])
  @run = @build.runs.find_by_id(params[:run])
  erubis :run
end

__END__

@@ index
<html>
  <h1>Welcome to Chef CI</h1>
  <ul>
    <% @builds.each do |build| %>
      <li><%= "<a href='builds/#{build.id}'>#{build.name}</a>"%>
    <% end %>
</html>

@@ build
<rss version="2.0">
  <channel>
    <title>CruiseControl RSS feed for <%= @build.name%></title>
    <link>http://not.implimented.yet/</link>
    <language>en-us</language>
    <ttl>10</ttl>
    <item>
      <title><%= @build.name %> build <%= @build.last_run.git_hash %> <%= @build.last_run.success ? "success" : "failure"%></title>
      <description></description>
      <pubDate><%= @build.last_run.updated_at%></pubDate>
      <guid>http://somewhere/<%= @build.last_run.git_hash %></guid>
      <link>http://not.implimented.yet/</link>
    </item>
  </channel>
</rss>

@@ run
<html>
<head>
  <title>Run Details</title>
</head>
<body>
  <h1>Run Details</h1>
  <pre>
<%= @run.output %>
  <pre>
</body>
</html>