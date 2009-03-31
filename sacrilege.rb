#!/usr/bin/env ruby
require 'rubygems'
require 'mechanize'

class Sacrilege

  def initialize
    @code_stack = Array.new
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = 'Linux Mozilla'
    page = @agent.get('http://shell.appspot.com/')
    @form = page.forms[0]
  end

  def eval(msg)
    @code_stack.push(msg) if ( msg =~ /:$/ || !(@code_stack.empty?))
    if msg == nil  && !(@code_stack.empty?)
      set(@code_stack.join("\n") + "\n")
      @code_stack.clear
      page = @agent.submit(@form)
    elsif @code_stack.empty?
      set(msg)
      page = @agent.submit(@form)
    end
    return page.body.split("\n").slice(0, 15) if page
    []
  end

  def set(val)
    @form.fields.find{|f| f.name == 'statement' }.value = val
  end

end
