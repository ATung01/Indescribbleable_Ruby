require 'httparty'
require 'google/cloud/vision'
require 'googleauth'

class Sketch < ApplicationRecord
  belongs_to :match

  def self.call_robot(encoded_sketch)
    common_words = ["white", "black", "black and white", "line art", "line", "font", "cartoon", "drawing", "clip art", "logo", "graphics", "monochrome", "monochrome photography", "angle", "design", "text", "illustration"]
    url = "https://vision.googleapis.com/v1/images:annotate?key=#{ENV['API_KEY']}"
    response = HTTParty.post(url,
    :body => { requests: [
      {
        image: {
            content: encoded_sketch
        },
        features: [
          {
            "type": "LABEL_DETECTION",
            maxResults: 50
          }
        ],
        "imageContext": {
          "languageHints": [
            "en"
          ]
        }
      }
    ]
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
                  # 'Authorization' => 'Bearer ya29.El_DBAGONTWFsDFEgoD42GCcOZWcLfIRsmWv9gKaNVSFQ5NOTcxlV--4n7VIUEpmZNbM8HuSacfuSMQ8Ry3qoGwr1_-1Bo1rOmRxtT_K7Ph3KAQBTYXiGNulAVApl_pxUA'} )
    if response["responses"][0]["labelAnnotations"]
      descriptions = response["responses"][0]["labelAnnotations"].map do |x|
        if common_words.exclude?(x["description"])
          x["description"]
        end
      end.compact
    else
        descriptions = ["Beep Boop I have no idea what this is.."]
    end
    # byebug
    return descriptions
  end

  def self.check_sketch(data)
    # byebug
    encoded_sketch = data['image']
    encoded_sketch = encoded_sketch.slice(38..-1)
    encoded_sketch = encoded_sketch.slice(0..-2)
    rc = data['room_code']

    current_match = Match.find_or_create_by(room_code: rc)
    updated_sketch = Sketch.find_or_create_by(match_id: current_match.id)
    updated_sketch.data = encoded_sketch
    updated_sketch.save
    return encoded_sketch
  end
  #
  # def self.call_robot(encoded_sketch)
  #   # credentials = StringIO.new(ENV['Google_stuff'])
  #   # Google::Auth::ServiceAccountCredentials.make_creds(
  #   #   scope: 'https://www.googleapis.com/auth/cloud-platform',
  #   #   json_key_io: credentials
  #   # )
  #   project_id = ENV["project_id"]
  #   byebug
  #   vision = Google::Cloud::Vision.new
  #   image = vision.image.content encoded_sketch
  #   labels = image.labels
  #
  #
  # end



end
