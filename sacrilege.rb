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
    msg = "" if msg == nil
    @code_stack.push(msg) if ( msg =~ /:$/ || !(@code_stack.empty?))
    if msg == "" && !(@code_stack.empty?)
      stack = @code_stack.join("\n") + "\n"
      debugger
      @form.fields.find{|f| f.name == 'statement' }.value = stack
      @code_stack.clear
    elsif @code_stack.empty?
      @form.fields.find{|f| f.name == 'statement' }.value = msg
    end
    page = @agent.submit(@form)
#     @form.fields.find{|f| f.name == 'statement' }.value = ""
    print page.body
    a  =  page.body.split("\n")
     return a
  end

  def colon_end(line)
    @level_stack ||= Array.new
    @level = ( line =~ /\S/ )
    @level_stack.push(level)
  end


end
