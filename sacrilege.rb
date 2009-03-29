#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'

class Sacrilege

  def initialize
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = 'Linux Mozilla'
    page = @agent.get('http://shell.appspot.com/')
    @form = page.forms[0]
  end

  def eval(msg)
    @form.fields.find{|f| f.name == 'statement' }.value = msg
    page = @agent.submit(@form)
    print page.body
    a = page.body.split("\n")
    debugger
    return a
  end

end
