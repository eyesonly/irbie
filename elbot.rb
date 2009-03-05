#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'
require 'ruby-debug'

class Elbot
   @agent
   @page

  def initialize(name)
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'
    @page = @agent.get('http://www.elbot.com/cgi-bin/elbot.cgi')

    form = @page.forms[0]
    form.fields.find{|f| f.name == 'ENTRY' }.value = "My name is #{name}"
    @page = @agent.submit(form)
  end

  def say(msg)
    form = @page.forms[0]
    form.fields.find{|f| f.name == 'ENTRY' }.value = msg.to_s
    @page = @agent.submit(form)
    return $1 if @page.body.match(/<!-- Begin Response !-->\n(.+)/)
    # debugger
    # return re[1]
  end

end
