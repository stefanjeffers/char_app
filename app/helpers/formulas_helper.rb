# Note: this "image_for" is not being used for formulas,
# in favor of the one in _pinnames_helper. That's OK, but why?

module FormulasHelper
     # Returns the Char Image for the given char.
  def image_for(formula)
    # image_id = "sample1.png"
    # image_id = "sample#{formula.id}.png"
    image_id = "#{formula.base}_#{formula.offset}_#{formula.subindex}_1.png"
    image_url = "#{image_id}"
    image_tag(image_url, alt: formula.alpha, class: "char_image")
  end

end

