###
# Page options, layouts, aliases and proxies
###

require 'time'
# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def upcoming_cafes
	raw = data.cafes
	now = Time.now.to_i
	upcoming = raw.reject {|cafe| Time.parse(cafe.date).to_i < now}

	return upcoming
  end

  def previous_cafes
    raw = data.cafes
	now = Time.now.to_i
	previous = raw.reject {|cafe| Time.parse(cafe.date).to_i > now}

	return previous
  end

  def order_cafes(cafes)
	sorted = cafes.sort_by {|cafe| Time.parse(cafe.date).to_i}

	sorted.each do |cafe|
      cafe.date = Time.parse(cafe.date).strftime("%A %d %B %Y")
	end

	return sorted
  end
end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
