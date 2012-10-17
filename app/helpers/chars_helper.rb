module CharsHelper
  # Returns the Char Image for the given char.
  def image_for(pinname)
    # image_id = "sample1.png"
    image_id = "sample#{pinname.id}.png"
    image_url = "#{image_id}"
    image_tag(image_url, alt: pinname.name_word_abbrev, class: "char_image")
  end

end
