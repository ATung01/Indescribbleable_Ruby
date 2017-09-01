
require "google-cloud-vision"



class SketchesController < ApplicationController


  def create

    encoded_sketch = params[:_json]
    encoded_sketch = encoded_sketch.slice(22..-1)
    encoded_sketch = encoded_sketch.slice(0..-2)
    Sketch.call_api(encoded_sketch)
    new_sketch = Sketch.create(data: encoded_sketch)

    render json: new_sketch
  end
end
