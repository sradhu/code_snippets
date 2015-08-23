#export JRUBY_HOME=/home/sradhu/Documents/jruby-1.6.0
#export PATH=$JRUBY_HOME/bin:$PATH
#run as jruby jruby_art_extr.rb

require 'java'
require '/usr/share/java/boilerpipe.jar'
require '/usr/share/java/nekohtml.jar'
require '/usr/share/java/xerces.jar'

url = java.net.URL.new("http://t.co/EgTk5aX4gr")
fil=File.open('/home/sradhu/BRM/Ruby/log.html',"a")

extractor=Java::DeL3sBoilerpipeExtractors::CommonExtractors::ARTICLE_EXTRACTOR
hh=Java::DeL3sBoilerpipeSax::HTMLHighlighter.newExtractingInstance()
html_art_extr=hh.process(url,extractor)
fil.puts html_art_extr
