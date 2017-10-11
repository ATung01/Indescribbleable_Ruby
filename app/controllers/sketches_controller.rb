
require "google-cloud-vision"



class SketchesController < ApplicationController

  def test_api
    render json:{value:"#{ENV['API_KEY']}"}
  end


end
