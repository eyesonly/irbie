#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'

class Elbot

  def initialize(name)
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = 'Linux Mozilla'
    @page = @agent.get('http://www.elbot.com/cgi-bin/elbot.cgi')

    form = @page.forms[0]
    form.fields.find{|f| f.name == 'ENTRY' }.value = "My name is #{name}"
    @page = @agent.submit(form)
  end

  def say(msg)
    form = @page.forms[0]
    form.fields.find{|f| f.name == 'ENTRY' }.value = msg.to_s
    @page = @agent.submit(form)
    result = @page.body.match(/<!-- Begin Response !-->\n(.+)/)[1].gsub("<!-- Country: Australia  -->","")
  end

end
