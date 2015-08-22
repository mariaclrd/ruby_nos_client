require "spec_helper"

describe RubyNosClient::API do
  describe "api/v1.0" do
    
    def app 
      @app ||= RubyNosClient::API
    end
    
    let(:base_path) { "api/v1.0" }

    describe "/" do 

      let(:path)    { "#{base_path}" }
      
      context "200 - OK" do
        
        it "returns PONG" do
          get path
          expect(last_response.status).to eq 200
        end
      end
    end
  end
end
