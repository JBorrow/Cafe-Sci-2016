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
ignore '/cafes/template.html'
# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

def nice_date_cafes(cafes)
  cafes.each do |cafe|
	cafe.nicedate = Time.parse(cafe.date).strftime("%A %d %B %Y")
  end
end

nice_cafes = nice_date_cafes(data.cafes)

nice_cafes.each do |cafe|
	proxy "/cafes/#{cafe.date}.html", "/cafes/template.html", :locals => {:cafe => cafe}
end

# General configuration

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def nice_date_cafes(cafes)
    cafes.each do |cafe|
	  cafe.nicedate = Time.parse(cafe.date).strftime("%A %d %B %Y")
    end
  end

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

	return nice_date_cafes(sorted)
  end
end

# Build-specific configuration
#
set :relative_links, true
set :relative_assets, true

activate :relative_assets

configure :build do
  # Minify CSS on build
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
