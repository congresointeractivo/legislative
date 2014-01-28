require 'spec_helper'

describe PopitPerson do
  it "has a popit web url" do
    ppc = PopitPersonCollection.new
    ppc.get ENV['popit_persons'], 'application/json'
    pp = ppc.persons[0]
    pp.popit_api_uri.should_not be_nil
  end

  xit "has a valid web url" do
    #it should point to a web popit, currently we only include a popit api
    ppc = PopitPersonCollection.new
    ppc.get ENV['popit_persons'], 'application/json'
    pp = ppc.persons[0]
    response = RestClient.get pp.popit_web_url
    response.code.should equal 200
  end
  it "has a valid API URI" do
    ppc = PopitPersonCollection.new
    ppc.get ENV['popit_persons'], 'application/json'
    pp = ppc.persons[0]
    response = RestClient.get pp.popit_api_uri
    response.code.should equal 200
  end
end