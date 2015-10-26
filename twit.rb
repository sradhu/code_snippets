require 'oauth'
require 'json'
require 'boilerpipe'

fil=File.open('/home/sradhu/log.html',"a")
# Exchange your oauth_token and oauth_token_secret for an AccessToken instance.
def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new("API_KEY", "API_SECRET", { :site => "https://api.twitter.com/", :scheme => :header})
     
    # now create the access token object from passed values
    token_hash = { :oauth_token => oauth_token, :oauth_token_secret => oauth_token_secret }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
    return access_token
end
 
# Exchange our oauth_token and oauth_token secret for the AccessToken instance.
access_token = prepare_access_token("ACCESS_TOKEN","ACCESS_TOKEN_SECRET")

#fil.puts access_token.class
# use the access token as an agent to get the home timeline
response = access_token.request(:get, "https://api.twitter.com/1.1/statuses/home_timeline.json")

def get_article(url)
opts = {:output => :htmlFragment,:extractor=>:ArticleExtractor}
article=Boilerpipe.extract(url,opts)
#resp=JSON.parse(article)
return article #resp["response"]["content"]
end

# get the url of the tweet.
JSON.parse(response.body).each do |tweet|
fil.puts "<p> #{tweet["user"]["name"] } </p>"
fil.puts "<p> #{tweet["text"] }</p>"
tweet_url= tweet["text"].match(/https?:\/\/[\S]+/).to_s   # working.
#fil.puts tweet_url
art_content=get_article(tweet_url)
fil.puts art_content
end


