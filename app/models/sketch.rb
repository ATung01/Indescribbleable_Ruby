require 'httparty'

class Sketch < ApplicationRecord
  belongs_to :match

  def self.call_api(encoded_sketch)
    url = "https://vision.googleapis.com/v1/images:annotate"
    response = HTTParty.post(url,
    :body => { requests: [
      {
        image: {
            content: encoded_sketch
        },
        features: [
          {
            type: "LABEL_DETECTION",
            maxResults: 10
          }
        ]
      }
    ]
             }.to_json,
    :headers => { 'Content-Type' => 'application/json',
                  'Authorization' => 'Bearer ya29.El-5BDZjd9n2XcAh2nkk6MXZAGfSKXLQQIr3TVWTeyptx6owYAZHDm_U-kl3lD30LED69aF_kNVet5M6IoPsxQkpisPciz-0mdiqDp8wi1AXjzZK-5h9GkbScu7o-Cu33Q'} )
    return response
  end

  def self.check_sketch(data)
    encoded_sketch = data['image']
    encoded_sketch = encoded_sketch.slice(22..-1)
    encoded_sketch = encoded_sketch.slice(0..-2)
    rc = data['room_code']

    current_match = Match.find_or_create_by(room_code: rc)
    updated_sketch = Sketch.find_or_create_by(match_id: current_match.id)
    updated_sketch.data = encoded_sketch
    updated_sketch.save
    return encoded_sketch
  end



end
