
require "google-cloud-vision"



class SketchesController < ApplicationController

  def create
    encoded_sketch = params[:image]
    encoded_sketch = encoded_sketch.slice(22..-1)
    encoded_sketch = encoded_sketch.slice(0..-2)
    rc = params[:room_code]
    current_match = Match.find_or_create_by(room_code: rc)
    updated_sketch = Sketch.find_or_create_by(match_id: current_match.id)
    updated_sketch.data = encoded_sketch
    updated_sketch.save

    render json: updated_sketch

  end

  def create_for_Google

    encoded_sketch = params[:_json]
    encoded_sketch = encoded_sketch.slice(22..-1)
    encoded_sketch = encoded_sketch.slice(0..-2)
    Sketch.call_api(encoded_sketch)
    new_sketch = Sketch.create(data: encoded_sketch)

    render json: new_sketch
  end
end
