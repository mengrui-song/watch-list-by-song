class GenerateLowSaturationColorJob < ApplicationJob
  queue_as :default

  def perform
    random_color = generate_low_saturation_color
    # Do something with the random_color, such as store it in the database or use it for further processing
  end

  private

  def generate_low_saturation_color
    random_color = loop do
      color = '#' + SecureRandom.hex(3)
      rgb = color.scan(/../).map(&:hex)
      saturation = rgb.max - rgb.min
      break color if saturation < 10  # Adjust the threshold as needed for desired saturation level
    end
    random_color
  end
end