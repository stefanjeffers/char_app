# Note: this "image_for" is being used even for formulas,
# so I had to use base, not pinyin for alt text. That's OK, but why?

module PinnamesHelper
     # Returns the Char Image for the given char.
  def image_for(pinname)
    # image_id = "sample1.png"
    # image_id = "sample#{pinname.id}.png"
        # Note: this will fail when we add examples with non-zero subindex:
    image_id = "#{pinname.base}_#{pinname.offset}_0_1.png"
    image_url = "#{image_id}"
    # image_tag(image_url, alt: pinname.pinyin, class: "char_image")
    image_tag(image_url, alt: pinname.base, class: "char_image")
  end

end

