require "spec_helper"

describe RubyNosClient::HttpServer do

  def app
    @app ||= RubyNosClient::HttpServer
  end

  describe "admin/healthcheck" do
    let(:path)    { "/admin/healthcheck" }

    context "200 - OK" do

      it "returns a healthier application" do
        get path
        expect(last_response.status).to eq 200
      end
    end

    context "500 - Internal server error" do

      it "returns Internal server error if an exception is raised" do
        expect(File).to receive(:exists?).and_raise(StandardError)
        get path
        expect(last_response.status).to eq 500
      end
    end
  end
end
