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
      stack = @code_stack.join("\n") + "\n"
      @form.fields.find{|f| f.name == 'statement' }.value = stack
      @code_stack.clear
    elsif @code_stack.empty?
      @form.fields.find{|f| f.name == 'statement' }.value = msg
    end
    page = @agent.submit(@form)
    @form.fields.find{|f| f.name == 'statement' }.value = ""
    print page.body
    return  page.body.split("\n").slice(0, 15)
  end

  def colon_end(line)
    @level_stack ||= Array.new
    @level = ( line =~ /\S/ )
    @level_stack.push(level)
  end


end
