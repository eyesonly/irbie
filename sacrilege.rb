#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'

class Sacrilege

  def initialize
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = 'Linux Mozilla'
    @page = @agent.get('http://shell.appspot.com/')
    @form = @page.forms[0]
  end

  def say(msg)
    @form.fields.find{|f| f.name == 'statement' }.value = msg
    @page = @agent.submit(@form)
    return  @page.body
  end

end
